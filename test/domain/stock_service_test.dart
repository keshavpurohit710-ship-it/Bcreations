import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/stock_service.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late World w;
  setUp(() => w = World());
  tearDown(() => w.close());

  test('purchases add stock, value and a supplier payment', () async {
    final lace = await w.product('Lace', ProductKind.rawMaterial, unit: 'm');
    final sup = await w.supplier('Sharma Traders');
    await w.stock.recordPurchase(
        productId: lace,
        qtyMilli: 10000,
        totalCostPaise: 50000,
        date: d(1, 5),
        paidWith: PaymentMethod.upi,
        supplierId: sup);

    expect(await w.stock.onHandMilli(lace), 10000);
    expect(await w.stock.averageCostPaise(lace), 5000); // ₹50 per metre
    expect(await w.stock.stockValuePaise(), 50000);
    final payments = await w.db.select(w.db.payments).get();
    expect(payments.single.purpose, PaymentPurpose.supplierPayment);
    expect(payments.single.amountPaise, 50000);
  });

  test('average cost blends purchases at different prices', () async {
    final beads = await w.product('Beads', ProductKind.rawMaterial, unit: 'g');
    await w.stock.recordPurchase(
        productId: beads,
        qtyMilli: 100000,
        totalCostPaise: 20000,
        date: d(1, 1),
        paidWith: PaymentMethod.cash);
    await w.stock.recordPurchase(
        productId: beads,
        qtyMilli: 100000,
        totalCostPaise: 30000,
        date: d(1, 2),
        paidWith: PaymentMethod.cash);
    expect(await w.stock.averageCostPaise(beads), 250); // ₹2.50 per gram
  });

  group('production', () {
    late String lace, beads, earrings;
    setUp(() async {
      lace = await w.product('Lace', ProductKind.rawMaterial, unit: 'm');
      beads = await w.product('Beads', ProductKind.rawMaterial, unit: 'g');
      earrings = await w.product('Earrings', ProductKind.made);
      await w.recipe(earrings, lace, 500); // 0.5 m per pair
      await w.recipe(earrings, beads, 20000); // 20 g per pair
      await w.stock.recordPurchase(
          productId: lace,
          qtyMilli: 2000,
          totalCostPaise: 10000,
          date: d(1, 1),
          paidWith: PaymentMethod.cash);
      await w.stock.recordPurchase(
          productId: beads,
          qtyMilli: 100000,
          totalCostPaise: 20000,
          date: d(1, 1),
          paidWith: PaymentMethod.cash);
    });

    test('uses decimal quantities exactly (no rounding to whole units)', () async {
      await w.stock.produce(productId: earrings, qtyMilli: 3000, date: d(1, 3), batchMinutes: 90);
      expect(await w.stock.onHandMilli(lace), 500); // 2 − 1.5 m
      expect(await w.stock.onHandMilli(beads), 40000); // 100 − 60 g
      expect(await w.stock.onHandMilli(earrings), 3000);
    });

    test('pieces carry exactly the material value used; stock value is unchanged', () async {
      final before = await w.stock.stockValuePaise();
      final run = await w.stock.produce(productId: earrings, qtyMilli: 3000, date: d(1, 3), batchMinutes: 90);
      expect(run.materialCostPaise, 7500 + 12000); // 1.5 m × ₹50 + 60 g × ₹2
      expect(run.labourCostPaise, 15000); // 90 min × ₹100/h
      expect(run.overheadCostPaise, 3450); // 10 % of ₹345
      expect(await w.stock.stockValuePaise(), before);
    });

    test('full cost per piece includes her time and overhead', () async {
      await w.stock.produce(productId: earrings, qtyMilli: 3000, date: d(1, 3), batchMinutes: 90);
      // (195 + 150 + 34.50) / 3 = ₹126.50
      expect(await w.stock.costPerPiecePaise(earrings), 12650);
    });

    test('blocks production when material is short, listing what is missing', () async {
      final needs = await w.stock.materialNeeds(earrings, 5000);
      expect(needs.firstWhere((n) => n.material.id == lace).shortMilli, 500); // need 2.5 m, have 2
      await expectLater(
        w.stock.produce(productId: earrings, qtyMilli: 5000, date: d(1, 3)),
        throwsA(isA<ShortageException>()),
      );
      expect(await w.stock.onHandMilli(earrings), 0, reason: 'nothing recorded');
    });

    test('can go ahead anyway when she chooses to', () async {
      await w.stock.produce(productId: earrings, qtyMilli: 5000, date: d(1, 3), allowShortage: true);
      expect(await w.stock.onHandMilli(lace), -500);
    });
  });

  test('shelf count records only the difference', () async {
    final thread = await w.product('Thread', ProductKind.rawMaterial, unit: 'rolls');
    await w.stock.recordPurchase(
        productId: thread,
        qtyMilli: 10000,
        totalCostPaise: 20000,
        date: d(1, 1),
        paidWith: PaymentMethod.cash);
    expect(await w.stock.recordCount(productId: thread, countedMilli: 10000, date: d(2, 1)), 0);
    expect(await w.stock.recordCount(productId: thread, countedMilli: 8000, date: d(2, 1)), -2000);
    expect(await w.stock.onHandMilli(thread), 8000);
    expect(await w.stock.stockValuePaise(), 16000);
  });

  test('opening stock counts in value at any date', () async {
    final box = await w.product('Gift box', ProductKind.bought);
    await w.stock.addOpeningStock(productId: box, qtyMilli: 20000, unitCostPaise: 1500, date: d(3, 1));
    expect(await w.stock.stockValuePaise(asOf: d(1, 1)), 30000);
  });
}
