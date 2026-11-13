// Riverpod wiring: the database, services, and live read-models for screens.
// Every read-model watches [dbTickProvider], so any write anywhere refreshes
// the screens that show it. Screens never do money or stock arithmetic.

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../domain/catalog_service.dart';
import '../domain/entry_service.dart';
import '../domain/ledger_service.dart';
import '../domain/order_service.dart';
import '../domain/pricing.dart';
import '../domain/report_service.dart';
import '../domain/stock_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) => throw UnimplementedError('Override in main()'));

final stockProvider = Provider((ref) => StockService(ref.watch(databaseProvider)));
final ledgerProvider = Provider((ref) => LedgerService(ref.watch(databaseProvider)));
final ordersServiceProvider =
    Provider((ref) => OrderService(ref.watch(databaseProvider), ref.watch(stockProvider), ref.watch(ledgerProvider)));
final reportsProvider =
    Provider((ref) => ReportService(ref.watch(databaseProvider), ref.watch(ledgerProvider), ref.watch(stockProvider)));
final catalogProvider = Provider((ref) => CatalogService(ref.watch(databaseProvider), ref.watch(stockProvider)));
final entriesProvider = Provider((ref) => EntryService(ref.watch(databaseProvider)));

/// Increments on every database write.
final dbTickProvider = StreamProvider<int>((ref) {
  var tick = 0;
  return ref.watch(databaseProvider).tableUpdates().map((_) => ++tick);
});

final settingsProvider = StreamProvider<Setting>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.settings)..where((s) => s.id.equals(settingsRowId))).watchSingle();
});

DateTime today() => DateTime.now();

// ------------------------------------------------------------------- people

class PartyRow {
  PartyRow(this.party, this.balancePaise, this.daysLate);
  final Party party;
  final int balancePaise;
  final int daysLate;
}

final partiesProvider = FutureProvider<List<PartyRow>>((ref) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  final ledger = ref.watch(ledgerProvider);
  final parties = await (db.select(db.parties)
        ..where((p) => p.deletedAt.isNull() & p.archived.equals(false))
        ..orderBy([(p) => OrderingTerm.asc(p.name)]))
      .get();
  final dues = {for (final d in await ledger.customerDues(today: today())) d.party.id: d};
  return [
    for (final p in parties)
      PartyRow(
        p,
        p.role == PartyRole.supplier ? 0 : await ledger.customerBalance(p.id),
        dues[p.id]?.daysOverdue ?? 0,
      ),
  ];
});

class PartyDetail {
  PartyDetail(this.party, this.balancePaise, this.daysLate, this.orders, this.payments, this.credit);
  final Party party;
  final int balancePaise;
  final int daysLate;
  final List<OrderRow> orders;
  final List<Payment> payments;
  final CreditCheck credit;
}

final partyDetailProvider = FutureProvider.family<PartyDetail, String>((ref, id) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  final ledger = ref.watch(ledgerProvider);
  final party = await (db.select(db.parties)..where((p) => p.id.equals(id))).getSingle();
  final dues = await ledger.customerDues(today: today());
  final due = dues.where((d) => d.party.id == id).firstOrNull;
  final orders = await (db.select(db.orders)
        ..where((o) => o.partyId.equals(id) & o.deletedAt.isNull())
        ..orderBy([(o) => OrderingTerm.desc(o.orderDate)]))
      .get();
  return PartyDetail(
    party,
    await ledger.customerBalance(id),
    due?.daysOverdue ?? 0,
    await _orderRows(ref, orders),
    await ledger.paymentsOf(id),
    await ledger.creditCheck(id, today: today()),
  );
});

// ------------------------------------------------------------------- orders

enum PayState { unpaid, partly, paid }

class OrderRow {
  OrderRow(this.order, this.party, this.totalPaise, this.paidPaise);
  final Order order;
  final Party party;
  final int totalPaise;
  final int paidPaise;
  int get balancePaise => totalPaise - paidPaise;
  PayState get payState =>
      paidPaise <= 0 ? PayState.unpaid : (paidPaise >= totalPaise ? PayState.paid : PayState.partly);
}

Future<List<OrderRow>> _orderRows(Ref ref, List<Order> orders) async {
  final db = ref.read(databaseProvider);
  final ledger = ref.read(ledgerProvider);
  final totals = await ledger.orderTotals(orders);
  final partyIds = orders.map((o) => o.partyId).toSet().toList();
  final parties = {
    for (final p in await (db.select(db.parties)..where((p) => p.id.isIn(partyIds))).get()) p.id: p,
  };
  return [
    for (final o in orders) OrderRow(o, parties[o.partyId]!, totals[o.id] ?? 0, await ledger.orderPaid(o.id)),
  ];
}

enum OrderFilter { open, delivered, all }

final ordersListProvider = FutureProvider.family<List<OrderRow>, OrderFilter>((ref, filter) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  final q = db.select(db.orders)..where((o) => o.deletedAt.isNull());
  switch (filter) {
    case OrderFilter.open:
      q.where((o) => o.status.isInValues([OrderStatus.quote, OrderStatus.confirmed]));
      q.orderBy([(o) => OrderingTerm.asc(o.promisedDate), (o) => OrderingTerm.desc(o.orderDate)]);
    case OrderFilter.delivered:
      q.where((o) => o.status.equalsValue(OrderStatus.delivered));
      q.orderBy([(o) => OrderingTerm.desc(o.deliveredAt)]);
    case OrderFilter.all:
      q.orderBy([(o) => OrderingTerm.desc(o.orderDate)]);
  }
  return _orderRows(ref, await q.get());
});

class LineView {
  LineView(this.line, this.product);
  final OrderLine line;
  final Product? product;
  String get name => product?.name ?? line.description ?? '';
  int get netPaise => lineNetPaise(
      qtyMilli: line.qtyMilli, unitPricePaise: line.unitPricePaise, lineDiscountPaise: line.lineDiscountPaise);
}

class OrderDetail {
  OrderDetail(this.row, this.lines, this.photos, this.payments);
  final OrderRow row;
  final List<LineView> lines;
  final List<OrderPhoto> photos;
  final List<(Payment, int)> payments;
  int get itemsTotalPaise => lines.fold(0, (a, l) => a + l.netPaise);
}

final orderDetailProvider = FutureProvider.family<OrderDetail, String>((ref, id) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  final ledger = ref.watch(ledgerProvider);
  final order = await (db.select(db.orders)..where((o) => o.id.equals(id))).getSingle();
  final row = (await _orderRows(ref, [order])).single;
  final lines = await ledger.linesOf(id);
  final productIds = lines.map((l) => l.productId).whereType<String>().toList();
  final products = {
    for (final p in await (db.select(db.products)..where((p) => p.id.isIn(productIds))).get()) p.id: p,
  };
  final photos = await (db.select(db.orderPhotos)..where((p) => p.orderId.equals(id) & p.deletedAt.isNull())).get();
  return OrderDetail(
    row,
    [for (final l in lines) LineView(l, products[l.productId])],
    photos,
    await ledger.paymentsForOrder(id),
  );
});

// -------------------------------------------------------------------- items

class ProductRow {
  ProductRow(this.product, this.onHandMilli);
  final Product product;
  final int onHandMilli;
  bool get isLow => product.minStockMilli > 0 && onHandMilli <= product.minStockMilli;
}

final productsProvider = FutureProvider<List<ProductRow>>((ref) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  final onHand = await ref.watch(stockProvider).onHandAll();
  final products = await (db.select(db.products)
        ..where((p) => p.deletedAt.isNull() & p.archived.equals(false))
        ..orderBy([(p) => OrderingTerm.asc(p.name)]))
      .get();
  return [for (final p in products) ProductRow(p, onHand[p.id] ?? 0)];
});

class ProductDetail {
  ProductDetail(this.row, this.costPerPiecePaise, this.stockValuePaise, this.moves, this.recipe, this.needsReview);
  final ProductRow row;
  final int? costPerPiecePaise;
  final int stockValuePaise;
  final List<StockMove> moves;
  final List<(RecipeLine, Product)> recipe;
  final bool needsReview;
}

final productDetailProvider = FutureProvider.family<ProductDetail, String>((ref, id) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  final stock = ref.watch(stockProvider);
  final settings = await db.getSettings();
  final product = await (db.select(db.products)..where((p) => p.id.equals(id))).getSingle();
  final moves = await (db.select(db.stockMoves)
        ..where((m) => m.productId.equals(id) & m.deletedAt.isNull())
        ..orderBy([(m) => OrderingTerm.desc(m.movedAt)]))
      .get();
  final recipe = <(RecipeLine, Product)>[];
  for (final r in await stock.recipe(id)) {
    recipe.add((r, await (db.select(db.products)..where((p) => p.id.equals(r.materialId))).getSingle()));
  }
  final cost = await stock.costPerPiecePaise(id);
  return ProductDetail(
    ProductRow(product, await stock.onHandMilli(id)),
    cost,
    moves.fold(0, (a, m) => a + m.valuePaise),
    moves,
    recipe,
    cost != null &&
        needsPriceReview(
            priceSetCostPaise: product.priceSetCostPaise,
            currentCostPaise: cost,
            thresholdBp: settings.priceReviewThresholdBp),
  );
});

// --------------------------------------------------------------------- home

class HomeData {
  HomeData({
    required this.dues,
    required this.toDeliver,
    required this.quotes,
    required this.advancesPaise,
    required this.lowStock,
    required this.priceReviewCount,
    required this.month,
    required this.productCount,
    required this.customerCount,
    required this.orderCount,
  });
  final List<CustomerDue> dues;
  final List<OrderRow> toDeliver;
  final int quotes;
  final int advancesPaise;
  final List<ProductRow> lowStock;
  final int priceReviewCount;
  final PeriodSummary month;
  final int productCount, customerCount, orderCount;

  int get toCollectPaise => dues.fold(0, (a, d) => a + d.balancePaise);
  int get lateCount => dues.where((d) => d.daysOverdue > 0).length;
}

final homeProvider = FutureProvider<HomeData>((ref) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  final ledger = ref.watch(ledgerProvider);
  final stock = ref.watch(stockProvider);
  final settings = await db.getSettings();
  final open = await ref.watch(ordersListProvider(OrderFilter.open).future);
  final products = await ref.watch(productsProvider.future);
  final parties = await ref.watch(partiesProvider.future);
  var review = 0;
  for (final p in products.where((p) => p.product.priceSetCostPaise != null)) {
    final cost = await stock.costPerPiecePaise(p.product.id);
    if (cost != null &&
        needsPriceReview(
            priceSetCostPaise: p.product.priceSetCostPaise,
            currentCostPaise: cost,
            thresholdBp: settings.priceReviewThresholdBp)) {
      review++;
    }
  }
  final (from, to) = ReportService.monthBounds(today());
  return HomeData(
    dues: await ledger.customerDues(today: today()),
    toDeliver: open.where((o) => o.order.status == OrderStatus.confirmed).toList(),
    quotes: open.where((o) => o.order.status == OrderStatus.quote).length,
    advancesPaise: await ledger.advancesHeld(),
    lowStock: products.where((p) => p.isLow).toList(),
    priceReviewCount: review,
    month: await ref.watch(reportsProvider).summary(from: from, to: to),
    productCount: products.length,
    customerCount: parties.where((p) => p.party.role != PartyRole.supplier).length,
    orderCount: await (db.select(db.orders)..where((o) => o.deletedAt.isNull())).get().then((l) => l.length),
  );
});

// -------------------------------------------------------------------- money

class MoneyEntry {
  MoneyEntry.expense(Expense e)
      : id = e.id,
        isWithdrawal = false,
        label = e.category,
        note = e.note,
        amountPaise = e.amountPaise,
        date = e.spentOn;
  MoneyEntry.withdrawal(OwnerWithdrawal w)
      : id = w.id,
        isWithdrawal = true,
        label = '',
        note = w.note,
        amountPaise = w.amountPaise,
        date = w.takenOn;
  final String id;
  final bool isWithdrawal;
  final String label;
  final String? note;
  final int amountPaise;
  final DateTime date;
}

class MoneyData {
  MoneyData(this.summary, this.bestByQty, this.bestByProfit, this.entries, this.toCollectPaise, this.advancesPaise);
  final PeriodSummary summary;
  final List<ItemSales> bestByQty;
  final List<ItemSales> bestByProfit;
  final List<MoneyEntry> entries;
  final int toCollectPaise;
  final int advancesPaise;
}

/// [month] is any day in the month to show.
final moneyProvider = FutureProvider.family<MoneyData, DateTime>((ref, month) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  final reports = ref.watch(reportsProvider);
  final ledger = ref.watch(ledgerProvider);
  final (from, to) = ReportService.monthBounds(month);
  final expenses = await (db.select(db.expenses)
        ..where((e) => e.deletedAt.isNull() & e.spentOn.isBiggerThanValue(from) & e.spentOn.isSmallerOrEqualValue(to)))
      .get();
  final withdrawals = await (db.select(db.ownerWithdrawals)
        ..where((e) => e.deletedAt.isNull() & e.takenOn.isBiggerThanValue(from) & e.takenOn.isSmallerOrEqualValue(to)))
      .get();
  final entries = [...expenses.map(MoneyEntry.expense), ...withdrawals.map(MoneyEntry.withdrawal)]
    ..sort((a, b) => b.date.compareTo(a.date));
  final dues = await ledger.customerDues(today: today());
  return MoneyData(
    await reports.summary(from: from, to: to),
    await reports.bestSellers(from: from, to: to),
    await reports.bestSellers(from: from, to: to, byProfit: true),
    entries,
    dues.fold(0, (a, d) => a + d.balancePaise),
    await ledger.advancesHeld(),
  );
});
