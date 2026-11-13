// Order lifecycle: Quote -> Confirmed -> Delivered (or Cancelled).
// Stock leaves on delivery; payment due date is set from the customer's terms.

import 'package:drift/drift.dart';

import '../data/database.dart';
import 'ledger_service.dart';
import 'money.dart';
import 'stock_service.dart';

class LineInput {
  const LineInput({
    this.productId,
    this.description,
    required this.qtyMilli,
    required this.unitPricePaise,
    this.listPricePaise,
    this.lineDiscountPaise = 0,
    this.unitCostPaise,
    this.specColour,
    this.specSize,
    this.specText,
    this.notes,
  }) : assert(productId != null || description != null, 'Custom items need a description');

  /// null = custom item.
  final String? productId;
  final String? description;
  final int qtyMilli;
  final int unitPricePaise;
  final int? listPricePaise;
  final int lineDiscountPaise;

  /// Leave null to snapshot the product's current full cost.
  final int? unitCostPaise;
  final String? specColour, specSize, specText, notes;
}

class OrderService {
  OrderService(this.db, this.stock, this.ledger);
  final AppDatabase db;
  final StockService stock;
  final LedgerService ledger;

  /// BC-0001, BC-0002 ... (prefix from Settings).
  Future<String> _takeNumber() async {
    final s = await db.getSettings();
    await (db.update(db.settings)..where((t) => t.id.equals(settingsRowId))).write(
        SettingsCompanion(nextOrderNumber: Value(s.nextOrderNumber + 1), updatedAt: Value(DateTime.now())));
    return '${s.orderPrefix}${s.nextOrderNumber.toString().padLeft(4, '0')}';
  }

  Future<Order> createOrder({
    required String partyId,
    required List<LineInput> lines,
    required DateTime orderDate,
    OrderStatus status = OrderStatus.confirmed,
    SalesChannel? channel,
    DateTime? promisedDate,
    int deliveryChargePaise = 0,
    int orderDiscountPaise = 0,
    String? discountReason,
    String? notes,
  }) {
    if (lines.isEmpty) throw ArgumentError('An order needs at least one item');
    if (status == OrderStatus.delivered || status == OrderStatus.cancelled) {
      throw ArgumentError('Create the order first, then deliver or cancel it');
    }
    return db.transaction(() async {
      final party = await (db.select(db.parties)..where((p) => p.id.equals(partyId))).getSingle();
      final order = await db.into(db.orders).insertReturning(OrdersCompanion.insert(
            number: await _takeNumber(),
            partyId: partyId,
            orderDate: orderDate,
            status: status,
            channel: Value(channel ?? party.defaultChannel),
            promisedDate: Value(promisedDate),
            deliveryChargePaise: Value(deliveryChargePaise),
            orderDiscountPaise: Value(orderDiscountPaise),
            discountReason: Value(discountReason),
            notes: Value(notes),
          ));
      await _insertLines(order.id, lines);
      return order;
    });
  }

  Future<void> _insertLines(String orderId, List<LineInput> lines) async {
    for (var i = 0; i < lines.length; i++) {
      final l = lines[i];
      final cost =
          l.unitCostPaise ?? (l.productId == null ? null : await stock.costPerPiecePaise(l.productId!));
      await db.into(db.orderLines).insert(OrderLinesCompanion.insert(
            orderId: orderId,
            productId: Value(l.productId),
            description: Value(l.description),
            position: Value(i),
            qtyMilli: l.qtyMilli,
            unitPricePaise: l.unitPricePaise,
            listPricePaise: Value(l.listPricePaise),
            lineDiscountPaise: Value(l.lineDiscountPaise),
            unitCostPaise: Value(cost),
            specColour: Value(l.specColour),
            specSize: Value(l.specSize),
            specText: Value(l.specText),
            notes: Value(l.notes),
          ));
    }
  }

  /// Replace the items of a quote or confirmed order. Payments already made
  /// stay attached to the order.
  Future<void> replaceLines(String orderId, List<LineInput> lines) {
    if (lines.isEmpty) throw ArgumentError('An order needs at least one item');
    return db.transaction(() async {
      final order = await _get(orderId);
      if (order.status == OrderStatus.delivered || order.status == OrderStatus.cancelled) {
        throw StateError('Only quotes and confirmed orders can be edited');
      }
      await (db.update(db.orderLines)..where((l) => l.orderId.equals(orderId) & l.deletedAt.isNull()))
          .write(OrderLinesCompanion(deletedAt: Value(DateTime.now())));
      await _insertLines(orderId, lines);
      await _touch(orderId);
    });
  }

  Future<Order> _get(String id) => (db.select(db.orders)..where((o) => o.id.equals(id))).getSingle();

  Future<void> _touch(String id, [OrdersCompanion c = const OrdersCompanion()]) =>
      (db.update(db.orders)..where((o) => o.id.equals(id)))
          .write(c.copyWith(updatedAt: Value(DateTime.now())));

  Future<void> confirm(String orderId) async {
    final o = await _get(orderId);
    if (o.status != OrderStatus.quote) throw StateError('Only a quote can be confirmed');
    await _touch(orderId, const OrdersCompanion(status: Value(OrderStatus.confirmed)));
  }

  /// Handed over: stock goes out at material value, payment due date is set
  /// from the customer's terms (unless already set), and any advance or credit
  /// the customer has is applied.
  Future<void> deliver(String orderId, {required DateTime date, int? deliveryChargePaise}) =>
      db.transaction(() async {
        final o = await _get(orderId);
        if (o.status == OrderStatus.delivered) throw StateError('Already delivered');
        if (o.status == OrderStatus.cancelled) throw StateError('This order was cancelled');

        for (final l in await ledger.linesOf(orderId)) {
          if (l.productId == null) continue; // custom item: no catalogue stock
          final avg = await stock.averageCostPaise(l.productId!);
          await db.into(db.stockMoves).insert(StockMovesCompanion.insert(
                productId: l.productId!,
                qtyMilli: -l.qtyMilli,
                type: StockMoveType.sale,
                valuePaise: Value(-amountForQty(l.qtyMilli, avg)),
                movedAt: date,
                orderId: Value(orderId),
              ));
        }
        final party = await (db.select(db.parties)..where((p) => p.id.equals(o.partyId))).getSingle();
        final settings = await db.getSettings();
        final terms = party.paymentTermsDays ??
            (party.priceType == PriceType.wholesale ? settings.wholesaleTermsDays : settings.retailTermsDays);
        await _touch(
          orderId,
          OrdersCompanion(
            status: const Value(OrderStatus.delivered),
            deliveredAt: Value(date),
            dueDate: Value(o.dueDate ?? DateTime(date.year, date.month, date.day + terms)),
            deliveryChargePaise:
                deliveryChargePaise == null ? const Value.absent() : Value(deliveryChargePaise),
          ),
        );
        await ledger.applyCredit(o.partyId);
      });

  /// Cancels the order. If it was delivered, the stock comes back.
  /// Any advance paid becomes credit with the customer (use it or refund it).
  Future<void> cancel(String orderId, {required DateTime date}) => db.transaction(() async {
        final o = await _get(orderId);
        if (o.status == OrderStatus.cancelled) return;
        if (o.status == OrderStatus.delivered) {
          final sales = await (db.select(db.stockMoves)
                ..where((m) =>
                    m.orderId.equals(orderId) &
                    m.type.equalsValue(StockMoveType.sale) &
                    m.deletedAt.isNull()))
              .get();
          for (final m in sales) {
            await db.into(db.stockMoves).insert(StockMovesCompanion.insert(
                  productId: m.productId,
                  qtyMilli: -m.qtyMilli,
                  type: StockMoveType.saleReversal,
                  valuePaise: Value(-m.valuePaise),
                  movedAt: date,
                  orderId: Value(orderId),
                ));
          }
        }
        await (db.update(db.paymentAllocations)
              ..where((a) => a.orderId.equals(orderId) & a.deletedAt.isNull()))
            .write(PaymentAllocationsCompanion(deletedAt: Value(DateTime.now())));
        await _touch(orderId, const OrdersCompanion(status: Value(OrderStatus.cancelled)));
        await ledger.applyCredit(o.partyId);
      });
}
