// P22: material price rises must stay visible until she actually re-prices.

import 'package:bcreations/data/database.dart';
import 'package:bcreations/data/demo_seed.dart';
import 'package:bcreations/domain/pricing.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';

import 'goal_world.dart';

void main() {
  late Shop s;
  late String lace, potli;

  Future<bool> needsReview(String id) async {
    final p = await (s.db.select(s.db.products)..where((x) => x.id.equals(id))).getSingle();
    final cost = await s.stock.costPerPiecePaise(id);
    return cost != null &&
        needsPriceReview(priceSetCostPaise: p.priceSetCostPaise, currentCostPaise: cost, thresholdBp: 1000);
  }

  Future<void> batchAtLacePrice(int perMetre, DateTime on) async {
    await s.buy(lace, 10000, perMetre * 10, on);
    await s.stock.produce(productId: potli, qtyMilli: 10000, date: on, batchMinutes: 300);
  }

  setUp(() async {
    s = Shop();
    lace = await s.product('Lace', ProductKind.rawMaterial, unit: 'm');
    potli = await s.catalog.saveProduct(
      const ProductsCompanion(name: Value('Potli'), kind: Value(ProductKind.made)),
      recipe: [RecipeInput(lace, 1000)],
      today: d(4, 1),
    );
    await batchAtLacePrice(rs(50), d(4, 1));
    // She sets her price now: the app remembers today's cost
    await s.catalog.saveProduct(
      const ProductsCompanion(name: Value('Potli'), kind: Value(ProductKind.made), retailPricePaise: Value(45000)),
      id: potli,
      today: d(4, 2),
    );
    await batchAtLacePrice(rs(150), d(4, 3)); // lace triples
  });
  tearDown(() => s.close());

  test('a big material price rise asks her to review the price', () async {
    expect(await needsReview(potli), isTrue);
  });

  test('editing only the name or photo does NOT hide the warning', () async {
    await s.catalog.saveProduct(
      const ProductsCompanion(
          name: Value('Silk potli'), kind: Value(ProductKind.made), retailPricePaise: Value(45000), photoPath: Value('/p.jpg')),
      id: potli,
      today: d(4, 4),
    );
    expect(await needsReview(potli), isTrue);
  });

  test('changing the price clears the warning (she has re-priced)', () async {
    await s.catalog.saveProduct(
      const ProductsCompanion(name: Value('Potli'), kind: Value(ProductKind.made), retailPricePaise: Value(60000)),
      id: potli,
      today: d(4, 4),
    );
    expect(await needsReview(potli), isFalse);
  });

  test('sample data remembers costs, so the warning can be tried in the demo (checklist B4.4)', () async {
    final demo = Shop();
    addTearDown(demo.close);
    await seedDemoData(demo.db, today: DateTime(2026, 11, 16));
    final products = await demo.db.select(demo.db.products).get();
    final priced = products.where((p) => p.retailPricePaise != null);
    expect(priced.every((p) => p.priceSetCostPaise != null), isTrue);

    // B4.4: buy silk at ₹600/m instead of ₹120, make 10 potli bags
    final silk = products.firstWhere((p) => p.name == 'Silk cloth').id;
    final bag = products.firstWhere((p) => p.name == 'Silk potli bag').id;
    await demo.stock.recordPurchase(
        productId: silk, qtyMilli: 10000, totalCostPaise: rs(6000), date: DateTime(2026, 11, 16), paidWith: PaymentMethod.cash);
    await demo.stock.produce(productId: bag, qtyMilli: 10000, date: DateTime(2026, 11, 16), batchMinutes: 240);
    final p = await (demo.db.select(demo.db.products)..where((x) => x.id.equals(bag))).getSingle();
    final cost = (await demo.stock.costPerPiecePaise(bag))!;
    expect(needsPriceReview(priceSetCostPaise: p.priceSetCostPaise, currentCostPaise: cost, thresholdBp: 1000), isTrue);
  });
}
