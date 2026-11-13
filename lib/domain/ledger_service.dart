// Money owed and paid: order totals, payments & advances, customer balances,
// dues with ageing, credit limits. The single source of truth for these numbers.

import 'package:drift/drift.dart';

import '../data/database.dart';
import 'pricing.dart';

class CustomerDue {
  const CustomerDue({
    required this.party,
    required this.balancePaise,
    required this.oldestDueDate,
    required this.daysOverdue,
  });
  final Party party;
  final int balancePaise;

  /// Earliest payment due date among unpaid deliveries (null = opening balance only).
  final DateTime? oldestDueDate;

  /// 0 when nothing is overdue yet.
  final int daysOverdue;
}

class CreditCheck {
  const CreditCheck({
    required this.balancePaise,
    required this.limitPaise,
    required this.exceedsLimit,
    required this.hasOverdue,
  });
  final int balancePaise;
  final int? limitPaise;
  final bool exceedsLimit;
  final bool hasOverdue;
  bool get shouldWarn => exceedsLimit || hasOverdue;
}

class LedgerService {
  LedgerService(this.db);
  final AppDatabase db;

  // ---------------------------------------------------------------- orders

  Future<List<OrderLine>> linesOf(String orderId) => (db.select(db.orderLines)
        ..where((l) => l.orderId.equals(orderId) & l.deletedAt.isNull())
        ..orderBy([(l) => OrderingTerm.asc(l.position)]))
      .get();

  int totalOf(Order order, List<OrderLine> lines) => orderTotalPaise(
        lineNetPaise: lines.map((l) => lineNetPaise(
              qtyMilli: l.qtyMilli,
              unitPricePaise: l.unitPricePaise,
              lineDiscountPaise: l.lineDiscountPaise,
            )),
        orderDiscountPaise: order.orderDiscountPaise,
        deliveryChargePaise: order.deliveryChargePaise,
      );

  Future<int> orderTotal(String orderId) async {
    final order = await (db.select(db.orders)..where((o) => o.id.equals(orderId))).getSingle();
    return totalOf(order, await linesOf(orderId));
  }

  /// Totals for many orders with two queries (no N+1).
  Future<Map<String, int>> orderTotals(List<Order> orders) async {
    if (orders.isEmpty) return {};
    final ids = orders.map((o) => o.id).toList();
    final lines = await (db.select(db.orderLines)..where((l) => l.orderId.isIn(ids) & l.deletedAt.isNull())).get();
    final byOrder = <String, List<OrderLine>>{};
    for (final l in lines) {
      byOrder.putIfAbsent(l.orderId, () => []).add(l);
    }
    return {for (final o in orders) o.id: totalOf(o, byOrder[o.id] ?? const [])};
  }

  Future<int> orderPaid(String orderId) async {
    final sum = db.paymentAllocations.amountPaise.sum();
    final q = db.selectOnly(db.paymentAllocations)
      ..addColumns([sum])
      ..where(db.paymentAllocations.orderId.equals(orderId) & db.paymentAllocations.deletedAt.isNull());
    return (await q.map((r) => r.read(sum)).getSingle()) ?? 0;
  }

  Future<int> orderBalance(String orderId) async => await orderTotal(orderId) - await orderPaid(orderId);

  // -------------------------------------------------------------- payments

  /// Money received from a customer.
  /// With [orderId]: pays that order first (before delivery this is an advance).
  /// Any remainder clears delivered orders oldest first; what's left stays as
  /// credit with the customer. Returns the payment id.
  Future<String> receivePayment({
    required String partyId,
    required int amountPaise,
    required PaymentMethod method,
    required DateTime date,
    String? orderId,
    String? reference,
    String? note,
  }) {
    if (amountPaise <= 0) throw ArgumentError('Amount must be more than zero');
    return db.transaction(() async {
      final payment = await db.into(db.payments).insertReturning(PaymentsCompanion.insert(
            partyId: Value(partyId),
            purpose: PaymentPurpose.customerPayment,
            amountPaise: amountPaise,
            method: method,
            paidOn: date,
            reference: Value(reference),
            note: Value(note),
          ));
      var remaining = amountPaise;

      Future<void> allocate(String toOrder, int max) async {
        final share = remaining < max ? remaining : max;
        if (share <= 0) return;
        await db.into(db.paymentAllocations).insert(PaymentAllocationsCompanion.insert(
              paymentId: payment.id,
              orderId: toOrder,
              amountPaise: share,
            ));
        remaining -= share;
      }

      if (orderId != null) {
        final order = await (db.select(db.orders)..where((o) => o.id.equals(orderId))).getSingle();
        if (order.status != OrderStatus.cancelled) {
          await allocate(orderId, await orderBalance(orderId));
        }
      }
      for (final o in await _unpaidDelivered(partyId)) {
        if (remaining <= 0) break;
        await allocate(o.id, await orderBalance(o.id));
      }
      return payment.id;
    });
  }

  Future<List<Order>> _unpaidDelivered(String partyId) async {
    final delivered = await (db.select(db.orders)
          ..where((o) => o.partyId.equals(partyId) & o.status.equalsValue(OrderStatus.delivered) & o.deletedAt.isNull())
          ..orderBy([(o) => OrderingTerm.asc(o.deliveredAt), (o) => OrderingTerm.asc(o.orderDate)]))
        .get();
    final unpaid = <Order>[];
    for (final o in delivered) {
      if (await orderBalance(o.id) > 0) unpaid.add(o);
    }
    return unpaid;
  }

  /// Uses a customer's unallocated credit (e.g. an overpayment, or an advance
  /// freed by a cancelled order) against their unpaid deliveries, oldest first.
  Future<void> applyCredit(String partyId) => db.transaction(() async {
        for (final p in await _paymentsWithCredit(partyId)) {
          var free = p.amountPaise - await _allocatedFrom(p.id);
          for (final o in await _unpaidDelivered(partyId)) {
            if (free <= 0) break;
            final bal = await orderBalance(o.id);
            final share = free < bal ? free : bal;
            await db.into(db.paymentAllocations).insert(PaymentAllocationsCompanion.insert(
                  paymentId: p.id,
                  orderId: o.id,
                  amountPaise: share,
                ));
            free -= share;
          }
        }
      });

  Future<List<Payment>> _paymentsWithCredit(String partyId) async {
    final payments = await (db.select(db.payments)
          ..where((p) =>
              p.partyId.equals(partyId) & p.purpose.equalsValue(PaymentPurpose.customerPayment) & p.deletedAt.isNull())
          ..orderBy([(p) => OrderingTerm.asc(p.paidOn)]))
        .get();
    final withCredit = <Payment>[];
    for (final p in payments) {
      if (p.amountPaise > await _allocatedFrom(p.id)) withCredit.add(p);
    }
    return withCredit;
  }

  Future<int> _allocatedFrom(String paymentId) async {
    final sum = db.paymentAllocations.amountPaise.sum();
    final q = db.selectOnly(db.paymentAllocations)
      ..addColumns([sum])
      ..where(db.paymentAllocations.paymentId.equals(paymentId) & db.paymentAllocations.deletedAt.isNull());
    return (await q.map((r) => r.read(sum)).getSingle()) ?? 0;
  }

  /// Money given back to a customer (reduces the credit she holds for them).
  Future<void> refund({
    required String partyId,
    required int amountPaise,
    required PaymentMethod method,
    required DateTime date,
    String? note,
  }) =>
      db.into(db.payments).insert(PaymentsCompanion.insert(
            partyId: Value(partyId),
            purpose: PaymentPurpose.customerRefund,
            amountPaise: amountPaise,
            method: method,
            paidOn: date,
            note: Value(note),
          ));

  /// Removes a payment (and where it was applied). Returns a stamp for [restorePayment].
  Future<DateTime> deletePayment(String paymentId) => db.transaction(() async {
        final stamp = DateTime.now();
        await (db.update(db.payments)..where((p) => p.id.equals(paymentId)))
            .write(PaymentsCompanion(deletedAt: Value(stamp), updatedAt: Value(stamp)));
        await (db.update(db.paymentAllocations)..where((a) => a.paymentId.equals(paymentId) & a.deletedAt.isNull()))
            .write(PaymentAllocationsCompanion(deletedAt: Value(stamp), updatedAt: Value(stamp)));
        return stamp;
      });

  /// Undo for [deletePayment].
  Future<void> restorePayment(String paymentId, DateTime stamp) => db.transaction(() async {
        await (db.update(db.payments)..where((p) => p.id.equals(paymentId)))
            .write(PaymentsCompanion(deletedAt: const Value(null), updatedAt: Value(DateTime.now())));
        await (db.update(db.paymentAllocations)
              ..where((a) => a.paymentId.equals(paymentId) & a.deletedAt.equals(stamp)))
            .write(PaymentAllocationsCompanion(deletedAt: const Value(null), updatedAt: Value(DateTime.now())));
      });

  /// Payments received from / given to a customer, newest first.
  Future<List<Payment>> paymentsOf(String partyId) => (db.select(db.payments)
        ..where((p) => p.partyId.equals(partyId) & p.deletedAt.isNull())
        ..orderBy([(p) => OrderingTerm.desc(p.paidOn)]))
      .get();

  /// Payments applied to an order (advance or after delivery), newest first.
  Future<List<(Payment, int)>> paymentsForOrder(String orderId) async {
    final q = db.select(db.paymentAllocations).join([
      innerJoin(db.payments, db.payments.id.equalsExp(db.paymentAllocations.paymentId)),
    ])
      ..where(db.paymentAllocations.orderId.equals(orderId) &
          db.paymentAllocations.deletedAt.isNull() &
          db.payments.deletedAt.isNull())
      ..orderBy([OrderingTerm.desc(db.payments.paidOn)]);
    return [
      for (final r in await q.get()) (r.readTable(db.payments), r.readTable(db.paymentAllocations).amountPaise),
    ];
  }

  // -------------------------------------------------------------- balances

  /// What a customer owes her (positive) or she holds for them (negative):
  /// opening balance + delivered bills − payments received + refunds given.
  /// Advances on undelivered orders show as credit until the order is delivered.
  Future<int> customerBalance(String partyId, {DateTime? asOf}) async {
    final party = await (db.select(db.parties)..where((p) => p.id.equals(partyId))).getSingle();
    final delivered = await (db.select(db.orders)
          ..where((o) {
            var c = o.partyId.equals(partyId) & o.status.equalsValue(OrderStatus.delivered) & o.deletedAt.isNull();
            if (asOf != null) c = c & o.deliveredAt.isSmallerOrEqualValue(asOf);
            return c;
          }))
        .get();
    final billed = (await orderTotals(delivered)).values.fold(0, (a, b) => a + b);
    return party.openingBalancePaise +
        billed -
        await _paymentSum(partyId, PaymentPurpose.customerPayment, asOf) +
        await _paymentSum(partyId, PaymentPurpose.customerRefund, asOf);
  }

  Future<int> _paymentSum(String? partyId, PaymentPurpose purpose, DateTime? asOf, {DateTime? from}) async {
    final sum = db.payments.amountPaise.sum();
    final q = db.selectOnly(db.payments)
      ..addColumns([sum])
      ..where(db.payments.purpose.equalsValue(purpose) & db.payments.deletedAt.isNull());
    if (partyId != null) q.where(db.payments.partyId.equals(partyId));
    if (asOf != null) q.where(db.payments.paidOn.isSmallerOrEqualValue(asOf));
    if (from != null) q.where(db.payments.paidOn.isBiggerThanValue(from));
    return (await q.map((r) => r.read(sum)).getSingle()) ?? 0;
  }

  /// Sum of payments of [purpose] in (from, to].
  Future<int> paymentsBetween(PaymentPurpose purpose, DateTime from, DateTime to) =>
      _paymentSum(null, purpose, to, from: from);

  Future<List<Party>> customers() => (db.select(db.parties)
        ..where((p) => p.role.isInValues([PartyRole.customer, PartyRole.both]) & p.deletedAt.isNull()))
      .get();

  /// Everything customers owe, net of credits (receivables), optionally as of a date.
  Future<int> totalReceivables({DateTime? asOf}) async {
    var total = 0;
    for (final c in await customers()) {
      total += await customerBalance(c.id, asOf: asOf);
    }
    return total;
  }

  /// Customers who owe money, most overdue first.
  Future<List<CustomerDue>> customerDues({required DateTime today}) async {
    final dues = <CustomerDue>[];
    for (final c in await customers()) {
      final balance = await customerBalance(c.id);
      if (balance <= 0) continue;
      DateTime? oldest;
      for (final o in await _unpaidDelivered(c.id)) {
        final due = o.dueDate ?? o.deliveredAt;
        if (due != null && (oldest == null || due.isBefore(oldest))) oldest = due;
      }
      final overdue = oldest == null ? 0 : _days(oldest, today);
      dues.add(CustomerDue(
        party: c,
        balancePaise: balance,
        oldestDueDate: oldest,
        daysOverdue: overdue > 0 ? overdue : 0,
      ));
    }
    dues.sort((a, b) {
      final byDays = b.daysOverdue.compareTo(a.daysOverdue);
      return byDays != 0 ? byDays : b.balancePaise.compareTo(a.balancePaise);
    });
    return dues;
  }

  /// Advances held: paid towards orders not delivered yet.
  Future<int> advancesHeld({String? partyId}) async {
    final open = await (db.select(db.orders)
          ..where((o) {
            var c = o.status.isInValues([OrderStatus.quote, OrderStatus.confirmed]) & o.deletedAt.isNull();
            if (partyId != null) c = c & o.partyId.equals(partyId);
            return c;
          }))
        .get();
    var total = 0;
    for (final o in open) {
      total += await orderPaid(o.id);
    }
    return total;
  }

  /// Should she think twice before giving this customer more on credit?
  Future<CreditCheck> creditCheck(String partyId, {int newOrderPaise = 0, required DateTime today}) async {
    final party = await (db.select(db.parties)..where((p) => p.id.equals(partyId))).getSingle();
    final balance = await customerBalance(partyId);
    final limit = party.creditLimitPaise;
    var overdue = false;
    for (final o in await _unpaidDelivered(partyId)) {
      final due = o.dueDate ?? o.deliveredAt;
      if (due != null && _days(due, today) > 0) overdue = true;
    }
    return CreditCheck(
      balancePaise: balance,
      limitPaise: limit,
      exceedsLimit: limit != null && balance + newOrderPaise > limit,
      hasOverdue: overdue,
    );
  }

  static int _days(DateTime from, DateTime to) =>
      DateTime(to.year, to.month, to.day).difference(DateTime(from.year, from.month, from.day)).inDays;
}
