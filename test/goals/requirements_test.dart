// The decisions we made at the start (plan §0 and §5.4), each checked against
// the real services. Things that were agreed but are not built yet are listed
// at the bottom as skipped tests, so `flutter test` shows them every run.

import 'package:bcreations/app/insights/insights.dart';
import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/money.dart';
import 'package:bcreations/domain/pricing.dart';
import 'package:bcreations/domain/report_service.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';

import 'goal_world.dart';

void main() {
  late Shop shop;
  setUp(() => shop = Shop());
  tearDown(() => shop.close());

  Future<OrderLine> lineOf(String orderId) async =>
      (await (shop.db.select(shop.db.orderLines)..where((l) => l.orderId.equals(orderId))).get()).single;

  group('Decision: the app starts the way she needs it', () {
    test('Hindi, light theme, and the agreed pricing defaults', () async {
      final s = await shop.db.getSettings();
      expect(s.languageCode, 'hi');
      expect(s.themeMode, 'light');
      expect(s.overheadBp, 1000, reason: 'overhead 10 %');
      expect(s.retailMarkupBp, 25000, reason: 'retail ×2.5');
      expect(s.wholesaleMarkupBp, 18000, reason: 'wholesale ×1.8');
      expect(s.defaultWholesaleDiscountBp, 3000, reason: 'wholesale = retail − 30 % when not set');
      expect(s.priceReviewThresholdBp, 1000, reason: 'review prices when cost rises > 10 %');
      expect(s.wholesaleTermsDays, 15, reason: 'shops pay within 15 days');
      expect(s.retailTermsDays, 0, reason: 'individuals pay on delivery');
      expect(s.startDate, isNull, reason: 'starts from today, nothing from the past is needed');
      expect(s.insightsConsent, isNull, reason: 'help from afar is asked, never assumed');
    });
  });

  group('Decision: decimal quantities (metres of lace, 0.5 kg of beads)', () {
    test('selling 2.5 m bills, takes stock and costs exactly', () async {
      final ribbon = await shop.product('Satin ribbon', ProductKind.bought, unit: 'm');
      final asha = await shop.customer('Asha');
      await shop.buy(ribbon, 10500, rs(420), d(3, 1)); // 10.5 m for ₹420 = ₹40/m
      final order = await shop.orders.createOrder(
        partyId: asha,
        orderDate: d(3, 3),
        lines: [LineInput(productId: ribbon, qtyMilli: 2500, unitPricePaise: rs(60))],
      );
      await shop.orders.deliver(order.id, date: d(3, 3));
      expect(await shop.ledger.orderTotal(order.id), rs(150));
      expect(await shop.dueOf(asha), rs(150));
      expect(await shop.stock.onHandMilli(ribbon), 8000, reason: '10.5 − 2.5 = 8 m, no rounding');
      final march = await shop.month(3);
      expect(march.costOfGoodsSoldPaise, rs(100), reason: '2.5 m × ₹40');
    });

    test('a third of a unit rounds to the nearest paisa, once, at the end', () {
      expect(amountForQty(333, rs(100)), rs(33.30));
      expect(amountForQty(1, rs(1)), 0, reason: '0.001 × ₹1 = 0.1 paisa → 0');
      expect(amountForQty(5, rs(1)), 1, reason: '0.5 paisa rounds up');
    });
  });

  group('Decision: delivery charge is billed to the customer', () {
    test('it is on the bill and in what she is owed, but not in the item\'s sales', () async {
      final box = await shop.product('Gift box', ProductKind.bought, retailPaise: rs(200));
      final asha = await shop.customer('Asha');
      await shop.buy(box, 5000, rs(500), d(4, 1));
      final o = await shop.order(asha, box, 2, rs(200), d(4, 2), deliveryPaise: rs(80));
      await shop.orders.deliver(o.id, date: d(4, 2));
      await shop.expense('Courier', rs(60), d(4, 2)); // what the courier actually cost her

      expect(await shop.ledger.orderTotal(o.id), rs(480));
      expect(await shop.dueOf(asha), rs(480));
      final april = await shop.month(4);
      expect(april.salesPaise, rs(480), reason: 'the bill total, delivery included');
      expect(april.expensesPaise, rs(60));
      final (from, to) = ReportService.monthBounds(d(4, 1));
      final best = await shop.reports.bestSellers(from: from, to: to);
      expect(best.single.revenuePaise, rs(400), reason: 'delivery is not part of what the box earned');
    });
  });

  group('Pricing model (B + C + D + custom line)', () {
    test('B · retail and wholesale price lists; wholesale falls back to retail − 30 %', () async {
      final s = await shop.db.getSettings();
      int? price(PriceType t, int? retail, int? wholesale) => listPricePaise(
          priceType: t,
          retailPricePaise: retail,
          wholesalePricePaise: wholesale,
          defaultWholesaleDiscountBp: s.defaultWholesaleDiscountBp);
      expect(price(PriceType.retail, rs(300), rs(180)), rs(300));
      expect(price(PriceType.wholesale, rs(300), rs(180)), rs(180));
      expect(price(PriceType.wholesale, rs(300), null), rs(210));
      expect(price(PriceType.wholesale, null, null), isNull, reason: 'no price yet → she types one');
    });

    test('B · bulk breaks from Settings apply to wholesale buyers only', () async {
      await shop.db.into(shop.db.bulkRules).insert(BulkRulesCompanion.insert(minQtyMilli: 10000, discountBp: 500));
      await shop.db.into(shop.db.bulkRules).insert(BulkRulesCompanion.insert(minQtyMilli: 25000, discountBp: 1000));
      final rules = [
        for (final r in await shop.db.select(shop.db.bulkRules).get())
          DiscountRule(minQtyMilli: r.minQtyMilli, discountBp: r.discountBp, productId: r.productId)
      ];
      int bp(int qty, PriceType t) => bulkDiscountBp(rules: rules, productId: 'x', qtyMilli: qty * 1000, priceType: t);
      expect(bp(9, PriceType.wholesale), 0);
      expect(bp(10, PriceType.wholesale), 500);
      expect(bp(30, PriceType.wholesale), 1000, reason: 'best break wins');
      expect(bp(30, PriceType.retail), 0, reason: 'retail customers are not given bulk breaks');
    });

    test('C · cost per piece = (materials + her batch time + overhead) ÷ pieces', () async {
      final beads = await shop.product('Beads', ProductKind.rawMaterial);
      final earrings = await shop.product('Earrings', ProductKind.made);
      await shop.buy(beads, 100000, rs(200), d(5, 1)); // ₹2 a bead
      await shop.recipe(earrings, beads, 10000); // 10 beads a pair
      // Labour is entered once for the batch: 2 hours for 10 pairs at ₹100/h
      await shop.stock.produce(productId: earrings, qtyMilli: 10000, date: d(5, 2), batchMinutes: 120);
      // materials 200 + time 200 = 400, + 10 % overhead = 440 → ₹44 a pair
      expect(await shop.stock.costPerPiecePaise(earrings), rs(44));
      final may = await shop.month(5);
      expect(may.timeValuePaise, rs(200), reason: 'her time is shown, not taken out of profit');
      expect(await shop.stock.stockValuePaise(asOf: d(5, 3)), rs(200),
          reason: 'stock is worth what the materials cost; nothing appears from thin air');
    });

    test('C · suggested prices come from that cost and are rounded up to a rupee', () async {
      final s = await shop.db.getSettings();
      final p = suggestPrices(
          fullCostPaise: rs(44), retailMarkupBp: s.retailMarkupBp, wholesaleMarkupBp: s.wholesaleMarkupBp);
      expect(p.retailPaise, rs(110));
      expect(p.wholesalePaise, rs(80)); // 44 × 1.8 = 79.2 → ₹80
    });

    test('C · after a new batch, pricing follows the latest batch (see note in TEST_PLAN)', () async {
      final beads = await shop.product('Beads', ProductKind.rawMaterial);
      final earrings = await shop.product('Earrings', ProductKind.made);
      await shop.buy(beads, 200000, rs(400), d(5, 1));
      await shop.recipe(earrings, beads, 10000);
      await shop.stock.produce(productId: earrings, qtyMilli: 10000, date: d(5, 2), batchMinutes: 120); // ₹44
      await shop.stock.produce(productId: earrings, qtyMilli: 10000, date: d(5, 9), batchMinutes: 60);
      // second batch: 200 + 100 = 300, + 10 % = 330 → ₹33
      expect(await shop.stock.costPerPiecePaise(earrings), rs(33));
    });

    test('D · the price charged, the list price and the cost are all kept on the line', () async {
      final box = await shop.product('Gift box', ProductKind.bought, retailPaise: rs(300));
      final shopCustomer = await shop.customer('Gupta Stores', priceType: PriceType.wholesale);
      await shop.buy(box, 10000, rs(1500), d(6, 1)); // ₹150 each
      final o = await shop.orders.createOrder(
        partyId: shopCustomer,
        orderDate: d(6, 2),
        lines: [LineInput(productId: box, qtyMilli: 4000, unitPricePaise: rs(200), listPricePaise: rs(210))],
      );
      final line = await lineOf(o.id);
      expect(line.unitPricePaise, rs(200), reason: 'what she agreed (bargained down)');
      expect(line.listPricePaise, rs(210), reason: 'what the price list said');
      expect(line.unitCostPaise, rs(165), reason: 'cost at the time: ₹150 + 10 % overhead');

      // Costs change later — the old order keeps its numbers
      await shop.buy(box, 10000, rs(3000), d(6, 10));
      expect((await lineOf(o.id)).unitCostPaise, rs(165));
    });

    test('D · discounts per line and on the whole order, with a reason, counted separately', () async {
      final box = await shop.product('Gift box', ProductKind.bought, retailPaise: rs(200));
      final asha = await shop.customer('Asha');
      await shop.buy(box, 10000, rs(1000), d(7, 1));
      final o = await shop.orders.createOrder(
        partyId: asha,
        orderDate: d(7, 2),
        orderDiscountPaise: rs(30),
        discountReason: 'Exhibition offer',
        lines: [LineInput(productId: box, qtyMilli: 2000, unitPricePaise: rs(200), lineDiscountPaise: rs(20))],
      );
      // An open quote with a discount must not count yet
      await shop.orders.createOrder(
        partyId: asha,
        orderDate: d(7, 3),
        status: OrderStatus.quote,
        orderDiscountPaise: rs(99),
        lines: [LineInput(productId: box, qtyMilli: 1000, unitPricePaise: rs(200))],
      );
      await shop.orders.deliver(o.id, date: d(7, 4));

      expect(await shop.ledger.orderTotal(o.id), rs(350), reason: '400 − 20 − 30');
      expect((await shop.getOrder(o.id)).discountReason, 'Exhibition offer');
      final july = await shop.month(7);
      expect(july.salesPaise, rs(350));
      expect(july.discountsGivenPaise, rs(50));
    });

    test('Sales channel: comes from the customer, can be changed per order', () async {
      final box = await shop.product('Gift box', ProductKind.bought);
      final gupta = await shop.db.into(shop.db.parties).insertReturning(PartiesCompanion.insert(
          name: 'Gupta Stores', priceType: const Value(PriceType.wholesale), defaultChannel: const Value(SalesChannel.shop)));
      final usual = await shop.order(gupta.id, box, 1, rs(100), d(8, 1));
      expect(usual.channel, SalesChannel.shop);
      final fair = await shop.orders.createOrder(
        partyId: gupta.id,
        orderDate: d(8, 2),
        channel: SalesChannel.exhibition,
        lines: [LineInput(productId: box, qtyMilli: 1000, unitPricePaise: rs(100))],
      );
      expect(fair.channel, SalesChannel.exhibition);
    });

    test('Custom line: billed with its own description and estimated cost, never in best sellers or stock',
        () async {
      final box = await shop.product('Gift box', ProductKind.bought);
      final asha = await shop.customer('Asha');
      await shop.buy(box, 5000, rs(500), d(9, 1));
      final o = await shop.orders.createOrder(
        partyId: asha,
        orderDate: d(9, 2),
        lines: [
          LineInput(productId: box, qtyMilli: 1000, unitPricePaise: rs(150)),
          const LineInput(
              description: 'Wedding tray with names', qtyMilli: 1000, unitPricePaise: 120000, unitCostPaise: 60000),
        ],
      );
      await shop.orders.deliver(o.id, date: d(9, 3));
      expect(await shop.ledger.orderTotal(o.id), rs(1350));
      final lines = await shop.ledger.linesOf(o.id);
      final custom = lines.firstWhere((l) => l.productId == null);
      expect(custom.description, 'Wedding tray with names');
      expect(custom.unitCostPaise, rs(600));
      final (from, to) = ReportService.monthBounds(d(9, 1));
      final best = await shop.reports.bestSellers(from: from, to: to);
      expect(best.map((b) => b.product.name), ['Gift box']);
      expect(await shop.stock.onHandMilli(box), 4000);
    });
  });

  group('Smaller agreed details', () {
    test('P10b · the UPI reference / sender name is kept with the payment', () async {
      final asha = await shop.customer('Asha', openingBalancePaise: rs(500));
      final id = await shop.ledger.receivePayment(
          partyId: asha, amountPaise: rs(500), method: PaymentMethod.upi, date: d(10, 1), reference: 'UPI 4411 / A Mehta');
      final p = await (shop.db.select(shop.db.payments)..where((x) => x.id.equals(id))).getSingle();
      expect(p.reference, 'UPI 4411 / A Mehta');
      expect(await shop.dueOf(asha), 0);
    });

    test('P11 · the promised delivery date is kept, separate from the payment due date', () async {
      final box = await shop.product('Gift box', ProductKind.bought);
      final gupta = await shop.customer('Gupta Stores', priceType: PriceType.wholesale, termsDays: 15);
      await shop.buy(box, 5000, rs(500), d(10, 1));
      final o = await shop.orders.createOrder(
        partyId: gupta,
        orderDate: d(10, 2),
        promisedDate: d(10, 20),
        lines: [LineInput(productId: box, qtyMilli: 1000, unitPricePaise: rs(150))],
      );
      expect((await shop.getOrder(o.id)).promisedDate, d(10, 20));
      await shop.orders.deliver(o.id, date: d(10, 18));
      final after = await shop.getOrder(o.id);
      expect(after.deliveredAt, d(10, 18), reason: 'the real delivery day is stored');
      expect(after.dueDate, DateTime(2026, 11, 2), reason: 'payment due = delivery day + 15 days');
    });

    test('Every record can sync later: ids, created/updated/deleted stamps on every table', () {
      for (final t in shop.db.allTables) {
        final cols = t.$columns.map((c) => c.name).toSet();
        expect(cols, containsAll(['id', 'created_at', 'updated_at', 'deleted_at']), reason: t.actualTableName);
      }
    });
  });

  group('Help from afar: what is recorded (the real recorder, not a copy)', () {
    test('nothing is kept until she says yes; then screens, taps, saves and events', () {
      final r = _Recorder();
      r.screen('Home');
      r.tap('Home', 0.5, 0.5);
      r.save('real.orders', 'insert');
      expect(r.buffer.length, 0);

      r.enabled = true;
      r.screen('OrderFormScreen');
      r.tap('OrderFormScreen', 0.123, 1.7);
      r.save('real.orders', 'insert');
      r.event('app_open', {'language': 'hi'});
      final events = r.buffer.drain().expand((b) => b).toList();
      expect(events.map((e) => e.kind), ['screen', 'tap', 'save', 'event']);
      expect(events[1].screen, 'OrderFormScreen');
      expect(events[1].data, {'x': 12, 'y': 100}, reason: 'whole percent, kept on screen');
      expect(events[2].name, 'real.orders');
    });

    test('a tap carries no text she typed — only where on the screen', () {
      final r = _Recorder()..enabled = true;
      r.tap('CustomerFormScreen', 0.4, 0.6);
      final json = r.buffer.drain().single.single.toJson();
      expect(json.keys.toSet(), {'t', 'k', 'n', 's', 'd'});
      expect((json['d']! as Map).keys.toSet(), {'x', 'y'});
    });
  });

  group('Agreed, not built yet (shown as skipped until they are)', () {
    test('Supplier credit "sometimes": buy now, pay the supplier later', () {},
        skip: 'R2 — recordPurchase always pays at once; there is no supplier due yet');
    test('Simple PDF bill to share on WhatsApp', () {}, skip: 'Phase 6 — not built');
    test('Automatic Google Drive backup (before her real data goes in)', () {}, skip: 'R1 — next to build');
    test('"Last charged to this customer: ₹X" hint on order lines', () {}, skip: 'Plan §5.4 — not built');
    test('Day-one setup step "Do you owe any supplier?"', () {}, skip: 'Plan §5.5 step 5 — not built');
    test('Pick customers from phone contacts', () {}, skip: 'Plan §5.5 — not built');
    test('Repeat last order', () {}, skip: 'Plan §5.5 — not built');
    test('Receipt photo on an expense', () {}, skip: 'Column exists; no button to add a photo yet');
  });
}

class _Recorder with InsightRecorder {
  @override
  final buffer = InsightBuffer();
  @override
  bool enabled = false;
  @override
  Future<void> setEnabled(bool on) async => enabled = on;
  @override
  Future<void> flush() async {}
  @override
  Future<bool> sendSnapshot({required String reason}) async => false;
}
