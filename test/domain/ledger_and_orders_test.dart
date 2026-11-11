import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/order_service.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late World w;
  late String earrings;
  setUp(() async {
    w = World();
    earrings = await w.product('Earrings', ProductKind.bought, retailPaise: 30000);
    await w.stock.addOpeningStock(productId: earrings, qtyMilli: 50000, unitCostPaise: 10000, date: d(1, 1));
  });
  tearDown(() => w.close());

  Future<Order> order(String party, {int qty = 2, int price = 30000, int delivery = 0}) =>
      w.orders.createOrder(
        partyId: party,
        orderDate: d(2, 1),
        deliveryChargePaise: delivery,
        lines: [LineInput(productId: earrings, qtyMilli: qty * 1000, unitPricePaise: price)],
      );

  test('order numbers run in sequence', () async {
    final c = await w.customer('Asha');
    expect((await order(c)).number, 'BC-0001');
    expect((await order(c)).number, 'BC-0002');
  });

  test('advance: held before delivery, deducted from the bill after', () async {
    final c = await w.customer('Asha');
    final o = await order(c, delivery: 5000); // ₹600 + ₹50 delivery
    await w.ledger.receivePayment(
        partyId: c, amountPaise: 20000, method: PaymentMethod.upi, date: d(2, 1), orderId: o.id);

    expect(await w.ledger.advancesHeld(), 20000);
    expect(await w.ledger.customerBalance(c), -20000, reason: 'nothing billed yet; she holds ₹200');
    expect(await w.ledger.orderBalance(o.id), 45000);

    await w.orders.deliver(o.id, date: d(2, 5));
    expect(await w.ledger.advancesHeld(), 0);
    expect(await w.ledger.customerBalance(c), 45000);
  });

  test('a general payment clears delivered orders oldest first', () async {
    final c = await w.customer('Shop A', priceType: PriceType.wholesale);
    final o1 = await order(c); // ₹600
    final o2 = await order(c); // ₹600
    await w.orders.deliver(o1.id, date: d(2, 2));
    await w.orders.deliver(o2.id, date: d(2, 3));
    await w.ledger.receivePayment(partyId: c, amountPaise: 80000, method: PaymentMethod.cash, date: d(2, 10));
    expect(await w.ledger.orderBalance(o1.id), 0);
    expect(await w.ledger.orderBalance(o2.id), 40000);
  });

  test('overpayment becomes credit and is used on the next delivery', () async {
    final c = await w.customer('Asha');
    final o1 = await order(c);
    await w.orders.deliver(o1.id, date: d(2, 2));
    await w.ledger.receivePayment(partyId: c, amountPaise: 70000, method: PaymentMethod.cash, date: d(2, 3));
    expect(await w.ledger.customerBalance(c), -10000);

    final o2 = await order(c);
    await w.orders.deliver(o2.id, date: d(2, 6));
    expect(await w.ledger.orderPaid(o2.id), 10000);
    expect(await w.ledger.customerBalance(c), 50000);
  });

  test('delivery takes stock out and sets the due date from payment terms', () async {
    final shop = await w.customer('Shop A', priceType: PriceType.wholesale); // default 15 days
    final o = await order(shop, qty: 3);
    await w.orders.deliver(o.id, date: d(2, 1));
    expect(await w.stock.onHandMilli(earrings), 47000);
    final delivered = await w.getOrder(o.id);
    expect(delivered.status, OrderStatus.delivered);
    expect(delivered.dueDate, DateTime(2026, 2, 16));
  });

  test('cancelling a delivered order returns stock and frees the advance as credit', () async {
    final c = await w.customer('Asha');
    final o = await order(c);
    await w.ledger.receivePayment(
        partyId: c, amountPaise: 20000, method: PaymentMethod.cash, date: d(2, 1), orderId: o.id);
    await w.orders.deliver(o.id, date: d(2, 2));
    await w.orders.cancel(o.id, date: d(2, 3));

    expect(await w.stock.onHandMilli(earrings), 50000);
    expect(await w.ledger.orderPaid(o.id), 0);
    expect(await w.ledger.customerBalance(c), -20000, reason: 'she now holds ₹200 for Asha');
  });

  test('only quotes and confirmed orders can be edited', () async {
    final c = await w.customer('Asha');
    final o = await order(c);
    await w.orders
        .replaceLines(o.id, [LineInput(productId: earrings, qtyMilli: 1000, unitPricePaise: 28000)]);
    expect(await w.ledger.orderTotal(o.id), 28000);
    await w.orders.deliver(o.id, date: d(2, 2));
    expect(
      () => w.orders.replaceLines(o.id, [LineInput(productId: earrings, qtyMilli: 1000, unitPricePaise: 1)]),
      throwsStateError,
    );
  });

  test('custom items are billed but do not touch catalogue stock', () async {
    final c = await w.customer('Meera');
    final o = await w.orders.createOrder(partyId: c, orderDate: d(2, 1), lines: const [
      LineInput(description: 'Name plate "Meera"', qtyMilli: 1000, unitPricePaise: 120000, specText: 'Meera'),
    ]);
    await w.orders.deliver(o.id, date: d(2, 4));
    expect(await w.ledger.customerBalance(c), 120000);
    expect(await w.stock.onHandMilli(earrings), 50000);
  });

  group('dues and credit limits', () {
    test('dues list shows the most overdue customer first', () async {
      final late = await w.customer('Late Shop', priceType: PriceType.wholesale);
      final fresh = await w.customer('Fresh', termsDays: 30);
      final o1 = await order(late);
      final o2 = await order(fresh);
      await w.orders.deliver(o1.id, date: d(2, 1)); // due 16 Feb
      await w.orders.deliver(o2.id, date: d(2, 20)); // due 22 Mar
      final dues = await w.ledger.customerDues(today: d(3, 1));
      expect(dues.map((e) => e.party.name), ['Late Shop', 'Fresh']);
      expect(dues.first.daysOverdue, 13);
      expect(dues.last.daysOverdue, 0);
    });

    test('opening balances count as dues', () async {
      await w.customer('Old customer', openingBalancePaise: 150000);
      final dues = await w.ledger.customerDues(today: d(3, 1));
      expect(dues.single.balancePaise, 150000);
    });

    test('warns when a new order would cross the credit limit, or dues are overdue', () async {
      final c = await w.customer('Shop B', priceType: PriceType.wholesale, creditLimitPaise: 100000);
      final o = await order(c); // ₹600
      await w.orders.deliver(o.id, date: d(2, 1));

      final fine = await w.ledger.creditCheck(c, newOrderPaise: 30000, today: d(2, 5));
      expect(fine.shouldWarn, isFalse);
      final over = await w.ledger.creditCheck(c, newOrderPaise: 50000, today: d(2, 5));
      expect(over.exceedsLimit, isTrue);
      final overdue = await w.ledger.creditCheck(c, today: d(3, 1));
      expect(overdue.hasOverdue, isTrue);
    });
  });
}
