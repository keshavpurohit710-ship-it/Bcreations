// Monthly money picture: profit, and "Where did my profit go?" — a bridge from
// profit earned to cash actually added — plus best sellers.
//
// Profit here is what the business earned in money terms (sales − material
// cost of what was sold − stock losses − expenses). Her own time is NOT
// deducted: it's shown separately as "value of your time", so she can see both
// what the business banked and whether that pays her fairly.

import 'package:drift/drift.dart';

import '../data/database.dart';
import 'ledger_service.dart';
import 'pricing.dart';
import 'stock_service.dart';

class PeriodSummary {
  const PeriodSummary({
    required this.from,
    required this.to,
    required this.salesPaise,
    required this.costOfGoodsSoldPaise,
    required this.stockLossesPaise,
    required this.expensesPaise,
    required this.collectedPaise,
    required this.refundsPaise,
    required this.supplierPaymentsPaise,
    required this.withdrawalsPaise,
    required this.receivablesChangePaise,
    required this.stockValueChangePaise,
    required this.timeValuePaise,
    required this.discountsGivenPaise,
  });

  final DateTime from, to;

  /// Bills for orders delivered in the period.
  final int salesPaise;

  /// Material value of what was sold.
  final int costOfGoodsSoldPaise;

  /// Material written off (damaged, count differences); negative = found extra.
  final int stockLossesPaise;
  final int expensesPaise;

  final int collectedPaise;
  final int refundsPaise;
  final int supplierPaymentsPaise;
  final int withdrawalsPaise;

  /// + = customers owe more than at the start of the period.
  final int receivablesChangePaise;

  /// + = more money sitting on the shelf as materials/stock.
  final int stockValueChangePaise;

  /// Her hours on production batches, at her hourly rate (information only).
  final int timeValuePaise;
  final int discountsGivenPaise;

  int get grossProfitPaise => salesPaise - costOfGoodsSoldPaise;
  int get netProfitPaise => grossProfitPaise - stockLossesPaise - expensesPaise;

  /// The bridge: profit − still with customers − extra stock − taken for home.
  int get cashAddedPaise =>
      netProfitPaise - receivablesChangePaise - stockValueChangePaise - withdrawalsPaise;

  /// Same number computed straight from cash in and out. Always equals
  /// [cashAddedPaise]; a test guards that.
  int get actualCashChangePaise =>
      collectedPaise - refundsPaise - supplierPaymentsPaise - expensesPaise - withdrawalsPaise;
}

class ItemSales {
  ItemSales(this.product);
  final Product product;
  int qtyMilli = 0;
  int revenuePaise = 0;
  int materialCostPaise = 0;
  int get profitPaise => revenuePaise - materialCostPaise;
}

class ReportService {
  ReportService(this.db, this.ledger, this.stock);
  final AppDatabase db;
  final LedgerService ledger;
  final StockService stock;

  /// Calendar month containing [day]: (end of previous month, end of this month].
  static (DateTime, DateTime) monthBounds(DateTime day) {
    final start = DateTime(day.year, day.month);
    final end = DateTime(day.year, day.month + 1);
    return (start.subtract(const Duration(microseconds: 1)), end.subtract(const Duration(microseconds: 1)));
  }

  Future<PeriodSummary> summary({required DateTime from, required DateTime to}) async {
    // Sales: orders delivered in (from, to]
    final delivered = await (db.select(db.orders)
          ..where((o) =>
              o.status.equalsValue(OrderStatus.delivered) &
              o.deletedAt.isNull() &
              o.deliveredAt.isBiggerThanValue(from) &
              o.deliveredAt.isSmallerOrEqualValue(to)))
        .get();
    final totals = await ledger.orderTotals(delivered);
    final sales = totals.values.fold(0, (a, b) => a + b);

    var discounts = 0;
    for (final o in delivered) {
      discounts += o.orderDiscountPaise;
      for (final l in await ledger.linesOf(o.id)) {
        discounts += l.lineDiscountPaise;
      }
    }

    final cogs = -await _moveValue([StockMoveType.sale, StockMoveType.saleReversal], from, to);
    final losses = -await _moveValue([StockMoveType.adjustment, StockMoveType.count], from, to);

    final expenses = await _sum(db.expenses, db.expenses.amountPaise, db.expenses.spentOn, from, to);
    final withdrawals = await _sum(
        db.ownerWithdrawals, db.ownerWithdrawals.amountPaise, db.ownerWithdrawals.takenOn, from, to);

    final runs = await (db.select(db.productionRuns)
          ..where((r) =>
              r.deletedAt.isNull() & r.madeOn.isBiggerThanValue(from) & r.madeOn.isSmallerOrEqualValue(to)))
        .get();

    return PeriodSummary(
      from: from,
      to: to,
      salesPaise: sales,
      costOfGoodsSoldPaise: cogs,
      stockLossesPaise: losses,
      expensesPaise: expenses,
      collectedPaise: await ledger.paymentsBetween(PaymentPurpose.customerPayment, from, to),
      refundsPaise: await ledger.paymentsBetween(PaymentPurpose.customerRefund, from, to),
      supplierPaymentsPaise: await ledger.paymentsBetween(PaymentPurpose.supplierPayment, from, to),
      withdrawalsPaise: withdrawals,
      receivablesChangePaise:
          await ledger.totalReceivables(asOf: to) - await ledger.totalReceivables(asOf: from),
      stockValueChangePaise: await stock.stockValuePaise(asOf: to) - await stock.stockValuePaise(asOf: from),
      timeValuePaise: runs.fold(0, (a, r) => a + r.labourCostPaise),
      discountsGivenPaise: discounts,
    );
  }

  Future<int> _moveValue(List<StockMoveType> types, DateTime from, DateTime to) async {
    final sum = db.stockMoves.valuePaise.sum();
    final q = db.selectOnly(db.stockMoves)
      ..addColumns([sum])
      ..where(db.stockMoves.type.isInValues(types) &
          db.stockMoves.deletedAt.isNull() &
          db.stockMoves.movedAt.isBiggerThanValue(from) &
          db.stockMoves.movedAt.isSmallerOrEqualValue(to));
    return (await q.map((r) => r.read(sum)).getSingle()) ?? 0;
  }

  Future<int> _sum<T extends Table, D>(
    TableInfo<T, D> table,
    GeneratedColumn<int> amount,
    GeneratedColumn<DateTime> date,
    DateTime from,
    DateTime to,
  ) async {
    final sum = amount.sum();
    final deleted = table.columnsByName['deleted_at']! as GeneratedColumn<DateTime>;
    final q = db.selectOnly(table)
      ..addColumns([sum])
      ..where(deleted.isNull() & date.isBiggerThanValue(from) & date.isSmallerOrEqualValue(to));
    return (await q.map((r) => r.read(sum)).getSingle()) ?? 0;
  }

  /// Catalogue items delivered in the period, best first by [byProfit] or quantity.
  Future<List<ItemSales>> bestSellers({
    required DateTime from,
    required DateTime to,
    bool byProfit = false,
  }) async {
    final delivered = await (db.select(db.orders)
          ..where((o) =>
              o.status.equalsValue(OrderStatus.delivered) &
              o.deletedAt.isNull() &
              o.deliveredAt.isBiggerThanValue(from) &
              o.deliveredAt.isSmallerOrEqualValue(to)))
        .get();
    final byProduct = <String, ItemSales>{};
    for (final o in delivered) {
      final moves = await (db.select(db.stockMoves)
            ..where((m) =>
                m.orderId.equals(o.id) & m.type.equalsValue(StockMoveType.sale) & m.deletedAt.isNull()))
          .get();
      final costByProduct = <String, int>{};
      for (final m in moves) {
        costByProduct[m.productId] = (costByProduct[m.productId] ?? 0) - m.valuePaise;
      }
      for (final l in await ledger.linesOf(o.id)) {
        final pid = l.productId;
        if (pid == null) continue;
        final item = byProduct[pid] ??=
            ItemSales(await (db.select(db.products)..where((p) => p.id.equals(pid))).getSingle());
        item.qtyMilli += l.qtyMilli;
        item.revenuePaise += lineNetPaise(
            qtyMilli: l.qtyMilli, unitPricePaise: l.unitPricePaise, lineDiscountPaise: l.lineDiscountPaise);
        item.materialCostPaise += costByProduct.remove(pid) ?? 0;
      }
    }
    final list = byProduct.values.toList()
      ..sort((a, b) => byProfit ? b.profitPaise.compareTo(a.profitPaise) : b.qtyMilli.compareTo(a.qtyMilli));
    return list;
  }
}
