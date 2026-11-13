import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/order_service.dart';
import 'package:bcreations/domain/report_service.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

/// A realistic March for a craft business, used to check "Where did my profit go?".
void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late World w;
  late String lace, earrings, diya, shop, asha;

  setUp(() async {
    w = World();
    lace = await w.product('Lace', ProductKind.rawMaterial, unit: 'm');
    earrings = await w.product('Earrings', ProductKind.made, retailPaise: 30000);
    diya = await w.product('Diya set', ProductKind.bought, retailPaise: 50000);
    await w.recipe(earrings, lace, 500);
    shop = await w.customer('Gift Shop', priceType: PriceType.wholesale, openingBalancePaise: 100000);
    asha = await w.customer('Asha');
    await w.stock.addOpeningStock(productId: diya, qtyMilli: 10000, unitCostPaise: 20000, date: d(2, 15));

    // March
    await w.stock.recordPurchase(
        productId: lace, qtyMilli: 10000, totalCostPaise: 60000, date: d(3, 2), paidWith: PaymentMethod.upi);
    await w.stock.produce(productId: earrings, qtyMilli: 10000, date: d(3, 3), batchMinutes: 240);

    final o1 = await w.orders.createOrder(partyId: shop, orderDate: d(3, 5), lines: [
      LineInput(productId: earrings, qtyMilli: 6000, unitPricePaise: 20000), // ₹1,200
      LineInput(productId: diya, qtyMilli: 2000, unitPricePaise: 35000, lineDiscountPaise: 5000), // ₹650
    ]);
    await w.orders.deliver(o1.id, date: d(3, 8));

    final o2 = await w.orders.createOrder(
      partyId: asha,
      orderDate: d(3, 10),
      deliveryChargePaise: 5000,
      lines: [LineInput(productId: earrings, qtyMilli: 2000, unitPricePaise: 30000)], // ₹600 + ₹50
    );
    await w.ledger
        .receivePayment(partyId: asha, amountPaise: 30000, method: PaymentMethod.upi, date: d(3, 10), orderId: o2.id);
    await w.orders.deliver(o2.id, date: d(3, 12));

    await w.ledger.receivePayment(partyId: shop, amountPaise: 150000, method: PaymentMethod.bank, date: d(3, 20));
    await w.expense('Courier', 12000, d(3, 12));
    await w.expense('Packaging', 8000, d(3, 15));
    await w.stock.adjust(productId: earrings, deltaMilli: -1000, reason: 'Broken', date: d(3, 18));
    await w.withdraw(50000, d(3, 25));
  });
  tearDown(() => w.close());

  test('profit for the month', () async {
    final (from, to) = ReportService.monthBounds(d(3, 1));
    final s = await w.reports.summary(from: from, to: to);

    expect(s.salesPaise, 120000 + 65000 + 65000); // ₹2,500
    // Material value sold: lace ₹60/m × 0.5 m = ₹30 per pair, 8 pairs = ₹240;
    // 2 diya sets × ₹200 = ₹400.
    expect(s.costOfGoodsSoldPaise, 24000 + 40000);
    expect(s.stockLossesPaise, 3000); // one broken pair
    expect(s.expensesPaise, 20000);
    expect(s.grossProfitPaise, 250000 - 64000);
    expect(s.netProfitPaise, 250000 - 64000 - 3000 - 20000); // ₹1,630
    expect(s.timeValuePaise, 40000); // 4 h at ₹100
    expect(s.discountsGivenPaise, 5000);
  });

  test('"Where did my profit go?" reconciles exactly with cash', () async {
    final (from, to) = ReportService.monthBounds(d(3, 1));
    final s = await w.reports.summary(from: from, to: to);

    // still with customers: shop owed ₹1,000 + ₹1,850 − ₹1,500 paid; Asha owes ₹350
    expect(s.receivablesChangePaise, (185000 - 150000) + 35000);
    // stock: bought ₹600 lace − sold ₹640 − broken ₹30
    expect(s.stockValueChangePaise, 60000 - 64000 - 3000);
    expect(s.withdrawalsPaise, 50000);

    expect(s.cashAddedPaise, s.actualCashChangePaise);
    expect(s.actualCashChangePaise, (30000 + 150000) - 60000 - 20000 - 50000); // ₹500
  });

  test('best sellers by quantity and by profit', () async {
    final (from, to) = ReportService.monthBounds(d(3, 1));
    final byQty = await w.reports.bestSellers(from: from, to: to);
    expect(byQty.map((i) => i.product.name), ['Earrings', 'Diya set']);
    expect(byQty.first.qtyMilli, 8000);
    expect(byQty.first.revenuePaise, 180000);
    expect(byQty.first.profitPaise, 180000 - 24000);

    final byProfit = await w.reports.bestSellers(from: from, to: to, byProfit: true);
    expect(byProfit.first.product.name, 'Earrings');
    expect(byProfit.last.profitPaise, 65000 - 40000);
  });
}
