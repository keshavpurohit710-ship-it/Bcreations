// Her problem P1: customers pay late and she loses track of who owes what.
// Also P7 (advances on custom orders) and P9 (credit piling up).

import 'package:bcreations/data/database.dart';
import 'package:bcreations/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'goal_world.dart';

void main() {
  late Shop s;
  late String rakhi;
  setUp(() async {
    s = Shop();
    rakhi = await s.product('Rakhi', ProductKind.bought, retailPaise: rs(150));
    await s.stock.addOpeningStock(productId: rakhi, qtyMilli: 500000, unitCostPaise: rs(60), date: d(1, 1));
  });
  tearDown(() => s.close());

  group('P1 · She always knows who owes what', () {
    test('the dues list adds up exactly, with the latest payer first', () async {
      final shop = await s.customer('Kala Gift Shop', priceType: PriceType.wholesale); // 15-day terms
      final asha = await s.customer('Asha'); // pays on delivery
      final old = await s.customer('Old customer', openingBalancePaise: rs(800)); // owed before the app
      final paid = await s.customer('Meera');

      await s.sell(shop, rakhi, 20, rs(90), d(2, 1)); // ₹1,800, due 16 Feb
      await s.sell(asha, rakhi, 2, rs(150), d(2, 20)); // ₹300, due 20 Feb
      await s.sell(paid, rakhi, 1, rs(150), d(2, 20));
      await s.pay(paid, rs(150), d(2, 20));

      final dues = await s.ledger.customerDues(today: d(3, 1));
      expect(dues.map((x) => x.party.name), ['Kala Gift Shop', 'Asha', 'Old customer']);
      expect(dues.map((x) => x.daysOverdue), [13, 9, 0]);
      expect(dues.fold<int>(0, (a, x) => a + x.balancePaise), rs(1800 + 300 + 800));
      expect(await s.dueOf(old), rs(800));
      expect(dues.any((x) => x.party.name == 'Meera'), isFalse, reason: 'fully paid customers are not chased');
    });

    test('a part payment reduces the dues but keeps her on the list', () async {
      final shop = await s.customer('Kala Gift Shop', priceType: PriceType.wholesale);
      await s.sell(shop, rakhi, 20, rs(90), d(2, 1));
      await s.pay(shop, rs(1000), d(2, 10));
      final dues = await s.ledger.customerDues(today: d(2, 12));
      expect(dues.single.balancePaise, rs(800));
      expect(dues.single.daysOverdue, 0, reason: 'not late until 16 Feb');
    });

    test('lateness counts from the payment due date, not the order date', () async {
      final shop = await s.customer('Shop', priceType: PriceType.wholesale);
      final o = await s.order(shop, rakhi, 10, rs(90), d(1, 10)); // ordered 10 Jan
      await s.orders.deliver(o.id, date: d(2, 1)); // delivered 1 Feb -> due 16 Feb
      expect((await s.ledger.customerDues(today: d(2, 16))).single.daysOverdue, 0);
      expect((await s.ledger.customerDues(today: d(2, 21))).single.daysOverdue, 5);
    });

    test('a customer\'s own payment terms override the default', () async {
      final shop = await s.customer('Shop', priceType: PriceType.wholesale, termsDays: 30);
      final o = await s.sell(shop, rakhi, 10, rs(90), d(2, 1));
      expect((await s.getOrder(o.id)).dueDate, DateTime(2026, 3, 3));
    });

    test('a payment entered twice by mistake can be undone', () async {
      final asha = await s.customer('Asha');
      await s.sell(asha, rakhi, 2, rs(150), d(2, 1));
      await s.pay(asha, rs(300), d(2, 2));
      final duplicate = await s.pay(asha, rs(300), d(2, 2));
      expect(await s.dueOf(asha), -rs(300), reason: 'looks like she holds ₹300 extra');
      await s.ledger.deletePayment(duplicate);
      expect(await s.dueOf(asha), 0);
    });

    for (final lang in ['hi', 'en']) {
      test('the WhatsApp reminder has the name, amount, business and UPI ($lang)', () {
        final t = lookupS(Locale(lang));
        final msg = t.reminderText('Asha', 'Bcreations', '₹1,800', t.reminderUpiLine('bcreations@upi'));
        expect(msg, allOf(contains('Asha'), contains('Bcreations'), contains('₹1,800'), contains('bcreations@upi')));
        expect(t.reminderText('Asha', 'Bcreations', '₹1,800', ''), isNot(contains('UPI')),
            reason: 'no UPI line when she has not set a UPI ID');
      });
    }
  });

  group('P7 · Advances on custom orders are never forgotten', () {
    test('advance is held, shown, and deducted from the bill on delivery', () async {
      final priya = await s.customer('Priya');
      final o = await s.order(priya, rakhi, 10, rs(150), d(3, 1), deliveryPaise: rs(50)); // ₹1,550
      await s.pay(priya, rs(500), d(3, 1), orderId: o.id);

      expect(await s.ledger.advancesHeld(), rs(500));
      expect(await s.ledger.orderBalance(o.id), rs(1050));
      expect(await s.dueOf(priya), -rs(500), reason: 'before delivery she holds the advance');

      await s.orders.deliver(o.id, date: d(3, 10));
      expect(await s.ledger.advancesHeld(), 0);
      expect(await s.dueOf(priya), rs(1050), reason: 'bill minus advance');
    });

    test('an advance bigger than the bill becomes credit used on the next order', () async {
      final priya = await s.customer('Priya');
      final o1 = await s.order(priya, rakhi, 2, rs(150), d(3, 1)); // ₹300
      await s.pay(priya, rs(500), d(3, 1), orderId: o1.id);
      await s.orders.deliver(o1.id, date: d(3, 2));
      expect(await s.dueOf(priya), -rs(200));

      final o2 = await s.sell(priya, rakhi, 2, rs(150), d(3, 15));
      expect(await s.ledger.orderPaid(o2.id), rs(200));
      expect(await s.dueOf(priya), rs(100));
    });

    test('a cancelled order\'s advance is kept as credit, and a refund clears it', () async {
      final priya = await s.customer('Priya');
      final o = await s.order(priya, rakhi, 10, rs(150), d(3, 1));
      await s.pay(priya, rs(500), d(3, 1), orderId: o.id);
      await s.orders.cancel(o.id, date: d(3, 5));
      expect(await s.dueOf(priya), -rs(500));
      expect(await s.ledger.advancesHeld(), 0);

      await s.ledger.refund(partyId: priya, amountPaise: rs(500), method: PaymentMethod.upi, date: d(3, 6));
      expect(await s.dueOf(priya), 0);
    });

    test('editing an order keeps its advance attached', () async {
      final priya = await s.customer('Priya');
      final o = await s.order(priya, rakhi, 10, rs(150), d(3, 1));
      await s.pay(priya, rs(500), d(3, 1), orderId: o.id);
      await s.orders.replaceLines(o.id, [LineInput(productId: rakhi, qtyMilli: 12000, unitPricePaise: rs(150))]);
      expect(await s.ledger.orderPaid(o.id), rs(500));
      expect(await s.ledger.orderBalance(o.id), rs(1300));
    });
  });

  group('P9 · Credit does not pile up unnoticed', () {
    test('warns only when a new order would cross the limit', () async {
      final shop = await s.customer('Shop', priceType: PriceType.wholesale, creditLimitPaise: rs(2000));
      await s.sell(shop, rakhi, 10, rs(90), d(2, 1)); // owes ₹900
      final today = d(2, 5);
      expect((await s.ledger.creditCheck(shop, newOrderPaise: rs(1000), today: today)).exceedsLimit, isFalse);
      expect((await s.ledger.creditCheck(shop, newOrderPaise: rs(1100), today: today)).exceedsLimit, isFalse,
          reason: 'exactly at the limit is allowed');
      expect((await s.ledger.creditCheck(shop, newOrderPaise: rs(1101), today: today)).exceedsLimit, isTrue);
    });

    test('warns about late payments even within the limit', () async {
      final shop = await s.customer('Shop', priceType: PriceType.wholesale, creditLimitPaise: rs(50000));
      await s.sell(shop, rakhi, 10, rs(90), d(2, 1));
      final check = await s.ledger.creditCheck(shop, today: d(3, 1));
      expect(check.exceedsLimit, isFalse);
      expect(check.hasOverdue, isTrue);
      expect(check.shouldWarn, isTrue);
    });

    test('no limit set means no limit warning', () async {
      final asha = await s.customer('Asha');
      await s.sell(asha, rakhi, 100, rs(150), d(2, 1));
      expect((await s.ledger.creditCheck(asha, newOrderPaise: rs(100000), today: d(2, 1))).exceedsLimit, isFalse);
    });
  });
}
