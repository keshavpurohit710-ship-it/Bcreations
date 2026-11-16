// P2 loses track of inventory · P19 runs out of material mid-order ·
// P13 custom requests misunderstood · P8 undercharges · P22 material prices rise.

import 'package:bcreations/app/providers.dart';
import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/catalog_service.dart';
import 'package:bcreations/domain/pricing.dart';
import 'package:bcreations/domain/stock_service.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'goal_world.dart';

void main() {
  late Shop s;
  late String lace, beads, potli;
  setUp(() async {
    s = Shop();
    lace = await s.product('Lace', ProductKind.rawMaterial, unit: 'm');
    beads = await s.product('Beads', ProductKind.rawMaterial, unit: 'g');
    potli = await s.product('Potli bag', ProductKind.made, retailPaise: rs(450));
    await s.recipe(potli, lace, 800); // 0.8 m lace per bag
    await s.recipe(potli, beads, 25000); // 25 g beads per bag
  });
  tearDown(() => s.close());

  group('P2 · Stock on the app matches the shelf', () {
    test('a whole week: buy, make, sell, break one, count — stock is right at every step', () async {
      await s.buy(lace, 10000, rs(500), d(4, 1)); // 10 m at ₹50
      await s.buy(beads, 500000, rs(1000), d(4, 1)); // 500 g at ₹2
      expect(await s.stock.onHandMilli(lace), 10000);

      await s.stock.produce(productId: potli, qtyMilli: 10000, date: d(4, 2), batchMinutes: 300);
      expect(await s.stock.onHandMilli(potli), 10000);
      expect(await s.stock.onHandMilli(lace), 2000); // 10 − 8
      expect(await s.stock.onHandMilli(beads), 250000); // 500 − 250

      final asha = await s.customer('Asha');
      await s.sell(asha, potli, 4, rs(450), d(4, 3));
      expect(await s.stock.onHandMilli(potli), 6000);

      await s.stock.adjust(productId: potli, deltaMilli: -1000, reason: 'Damaged', date: d(4, 4));
      expect(await s.stock.onHandMilli(potli), 5000);

      expect(await s.stock.recordCount(productId: potli, countedMilli: 5000, date: d(4, 7)), 0,
          reason: 'the shelf count agrees with the app');
      // Material value left: 2 m lace (₹100) + 250 g beads (₹500) + 5 bags × ₹90 materials (₹450)
      expect(await s.stock.stockValuePaise(), rs(100 + 500 + 450));
    });

    test('quotes and confirmed orders do not take stock; delivery does; cancelling gives it back', () async {
      final box = await s.product('Gift box', ProductKind.bought, retailPaise: rs(100));
      await s.stock.addOpeningStock(productId: box, qtyMilli: 20000, unitCostPaise: rs(40), date: d(4, 1));
      final asha = await s.customer('Asha');
      final quote = await s.order(asha, box, 5, rs(100), d(4, 2), status: OrderStatus.quote);
      final confirmed = await s.order(asha, box, 3, rs(100), d(4, 2));
      expect(await s.stock.onHandMilli(box), 20000);
      await s.orders.confirm(quote.id);
      await s.orders.deliver(quote.id, date: d(4, 3));
      await s.orders.deliver(confirmed.id, date: d(4, 3));
      expect(await s.stock.onHandMilli(box), 12000);
      await s.orders.cancel(quote.id, date: d(4, 4));
      expect(await s.stock.onHandMilli(box), 17000);
    });

    test('decimal materials never drift, even over many batches', () async {
      await s.buy(lace, 100000, rs(5000), d(4, 1)); // 100 m
      await s.buy(beads, 10000000, rs(20000), d(4, 1));
      final tiny = await s.product('Bookmark', ProductKind.made);
      await s.recipe(tiny, lace, 333); // 0.333 m each
      for (var i = 0; i < 7; i++) {
        await s.stock.produce(productId: tiny, qtyMilli: 3000, date: d(4, 2 + i));
      }
      // 7 batches × 3 × 0.333 m = 6.993 m
      expect(await s.stock.onHandMilli(lace), 100000 - 6993);
    });

    test('items at or below their warning level are flagged as running low', () async {
      await (s.db.update(s.db.products)..where((p) => p.id.equals(lace)))
          .write(const ProductsCompanion(minStockMilli: Value(5000)));
      await s.buy(lace, 5000, rs(250), d(4, 1));
      final container = ProviderContainer(overrides: [databaseProvider.overrideWithValue(s.db)]);
      addTearDown(container.dispose);
      var rows = await container.read(productsProvider.future);
      expect(rows.firstWhere((r) => r.product.id == lace).isLow, isTrue);

      await s.buy(lace, 1000, rs(50), d(4, 2));
      container.invalidate(productsProvider);
      rows = await container.read(productsProvider.future);
      expect(rows.firstWhere((r) => r.product.id == lace).isLow, isFalse);
    });
  });

  group('P19 · She finds out about missing material BEFORE starting', () {
    test('the shortage list says exactly what and how much is missing', () async {
      await s.buy(lace, 3000, rs(150), d(4, 1)); // 3 m, enough for 3 bags
      await s.buy(beads, 500000, rs(1000), d(4, 1));
      final needs = await s.stock.materialNeeds(potli, 5000);
      final laceNeed = needs.firstWhere((n) => n.material.id == lace);
      expect(laceNeed.needMilli, 4000);
      expect(laceNeed.shortMilli, 1000);
      expect(needs.firstWhere((n) => n.material.id == beads).shortMilli, 0);
    });

    test('making is blocked until she buys more; then it works', () async {
      await s.buy(lace, 3000, rs(150), d(4, 1));
      await s.buy(beads, 500000, rs(1000), d(4, 1));
      await expectLater(
          s.stock.produce(productId: potli, qtyMilli: 5000, date: d(4, 2)), throwsA(isA<ShortageException>()));
      expect(await s.stock.onHandMilli(lace), 3000, reason: 'nothing was used up');
      await s.buy(lace, 1000, rs(50), d(4, 2));
      await s.stock.produce(productId: potli, qtyMilli: 5000, date: d(4, 2));
      expect(await s.stock.onHandMilli(potli), 5000);
      expect(await s.stock.onHandMilli(lace), 0);
    });
  });

  group('P13 · Custom requests are recorded exactly', () {
    test('colour, size, name text and reference photos stay with the order through edits', () async {
      final priya = await s.customer('Priya');
      final o = await s.orders.createOrder(partyId: priya, orderDate: d(4, 1), lines: const [
        LineInput(
          description: 'Wedding potli',
          qtyMilli: 25000,
          unitPricePaise: 55000,
          specColour: 'Maroon with gold',
          specSize: '8 x 10 in',
          specText: 'Riya weds Karan',
        ),
      ]);
      await s.db.into(s.db.orderPhotos).insert(OrderPhotosCompanion.insert(orderId: o.id, path: '/photos/ref1.jpg'));

      final container = ProviderContainer(overrides: [databaseProvider.overrideWithValue(s.db)]);
      addTearDown(container.dispose);
      var detail = await container.read(orderDetailProvider(o.id).future);
      expect(detail.lines.single.line.specText, 'Riya weds Karan');
      expect(detail.lines.single.line.specColour, 'Maroon with gold');
      expect(detail.photos.single.path, '/photos/ref1.jpg');

      // She changes the quantity; the specs come along unchanged
      final l = detail.lines.single.line;
      await s.orders.replaceLines(o.id, [
        LineInput(
          description: l.description,
          qtyMilli: 30000,
          unitPricePaise: l.unitPricePaise,
          specColour: l.specColour,
          specSize: l.specSize,
          specText: l.specText,
        ),
      ]);
      container.invalidate(orderDetailProvider(o.id));
      detail = await container.read(orderDetailProvider(o.id).future);
      expect(detail.lines.single.line.qtyMilli, 30000);
      expect(detail.lines.single.line.specText, 'Riya weds Karan');
      expect(detail.photos, hasLength(1));
    });
  });

  group('P8 · She can see when she is undercharging', () {
    Future<int> madeBatch({required int lacePerMetre}) async {
      await s.buy(lace, 8000, lacePerMetre * 8, d(4, 1));
      await s.buy(beads, 250000, rs(500), d(4, 1));
      await s.stock.produce(productId: potli, qtyMilli: 10000, date: d(4, 2), batchMinutes: 600);
      return (await s.stock.costPerPiecePaise(potli))!;
    }

    test('cost of one includes materials, her time and overhead', () async {
      // Materials per bag: 0.8 m × ₹50 + 25 g × ₹2 = ₹90; time: 10 h × ₹100 / 10 bags = ₹100;
      // overhead 10 % of ₹190 = ₹19  ->  ₹209
      expect(await madeBatch(lacePerMetre: rs(50)), rs(209));
    });

    test('a price below cost is red, a fair price is green', () async {
      final cost = await madeBatch(lacePerMetre: rs(50));
      MarginBand band(int price) => marginBand(unitPricePaise: price, unitCostPaise: cost, targetMarginBp: 4000);
      expect(band(rs(200)), MarginBand.loss, reason: 'her old "gut" price would lose money');
      expect(band(rs(300)), MarginBand.thin);
      expect(band(rs(450)), MarginBand.healthy);
    });

    test('suggested prices come from the real cost', () async {
      final cost = await madeBatch(lacePerMetre: rs(50));
      final p = suggestPrices(fullCostPaise: cost, retailMarkupBp: 25000, wholesaleMarkupBp: 18000);
      expect(p.retailPaise, rs(523)); // ₹522.50 rounded up
      expect(p.wholesalePaise, rs(377)); // ₹376.20 rounded up
    });

    test('an old order keeps the cost it was priced at, even if costs change later', () async {
      await madeBatch(lacePerMetre: rs(50));
      final asha = await s.customer('Asha');
      final o = await s.order(asha, potli, 1, rs(450), d(4, 3));
      await madeBatch(lacePerMetre: rs(150)); // lace triples
      final line = (await s.ledger.linesOf(o.id)).single;
      expect(line.unitCostPaise, rs(209));
    });
  });

  group('P22 · Material price rises are noticed', () {
    test('"prices to review" appears only when cost rises more than 10 %', () async {
      final catalog = CatalogService(s.db, s.stock);
      await s.buy(lace, 8000, rs(400), d(4, 1));
      await s.buy(beads, 250000, rs(500), d(4, 1));
      await s.stock.produce(productId: potli, qtyMilli: 10000, date: d(4, 2), batchMinutes: 600);
      await catalog.markPriceSet(potli); // she sets her price at today's cost (₹209)

      Future<bool> review() async {
        final p = await (s.db.select(s.db.products)..where((x) => x.id.equals(potli))).getSingle();
        return needsPriceReview(
            priceSetCostPaise: p.priceSetCostPaise,
            currentCostPaise: (await s.stock.costPerPiecePaise(potli))!,
            thresholdBp: 1000);
      }

      expect(await review(), isFalse);

      // Lace ₹50 -> ₹60/m: cost goes ₹209 -> ₹217.80 (+4 %), no alarm
      await s.buy(lace, 8000, rs(480), d(5, 1));
      await s.buy(beads, 250000, rs(500), d(5, 1));
      await s.stock.produce(productId: potli, qtyMilli: 10000, date: d(5, 2), batchMinutes: 600);
      expect(await review(), isFalse);

      // Lace -> ₹100/m: well over 10 %
      await s.buy(lace, 8000, rs(800), d(6, 1));
      await s.buy(beads, 250000, rs(500), d(6, 1));
      await s.stock.produce(productId: potli, qtyMilli: 10000, date: d(6, 2), batchMinutes: 600);
      expect(await review(), isTrue);
    });
  });
}
