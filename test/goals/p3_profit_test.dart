// P3 "it feels like no profit gets banked" · P5 family and business money mixed ·
// P10 small expenses leak · P4 best sellers unknown.

import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/report_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'goal_world.dart';

void main() {
  late Shop s;
  late String earrings, hamper;
  setUp(() async {
    s = Shop();
    earrings = await s.product('Earrings', ProductKind.bought, retailPaise: rs(300));
    hamper = await s.product('Hamper', ProductKind.bought, retailPaise: rs(1500));
    await s.stock.addOpeningStock(productId: earrings, qtyMilli: 100000, unitCostPaise: rs(100), date: d(1, 1));
    await s.stock.addOpeningStock(productId: hamper, qtyMilli: 20000, unitCostPaise: rs(1000), date: d(1, 1));
  });
  tearDown(() => s.close());

  group('P3 · "Where did my profit go?" explains the gap between profit and cash', () {
    test('a big unpaid sale is profit, but shows as "still with customers", not cash', () async {
      final shop = await s.customer('Shop', priceType: PriceType.wholesale);
      await s.sell(shop, earrings, 50, rs(200), d(5, 5)); // ₹10,000 sale, ₹5,000 cost
      final m = await s.month(5);
      expect(m.netProfitPaise, rs(5000));
      expect(m.receivablesChangePaise, rs(10000));
      expect(m.stockValueChangePaise, -rs(5000), reason: 'sold from stock bought before this month');
      expect(m.cashAddedPaise, 0, reason: 'no cash came in, and no cash went out this month');
      expect(m.cashAddedPaise, m.actualCashChangePaise);
    });

    test('buying lots of material is "spent on extra stock", not a loss', () async {
      final lace = await s.product('Lace', ProductKind.rawMaterial, unit: 'm');
      await s.buy(lace, 100000, rs(8000), d(5, 2));
      final m = await s.month(5);
      expect(m.netProfitPaise, 0, reason: 'buying stock is not an expense');
      expect(m.stockValueChangePaise, rs(8000));
      expect(m.cashAddedPaise, -rs(8000));
      expect(m.cashAddedPaise, m.actualCashChangePaise);
    });

    test('collecting old dues brings cash in without new profit', () async {
      final shop = await s.customer('Shop', openingBalancePaise: rs(4000));
      await s.pay(shop, rs(4000), d(5, 3));
      final m = await s.month(5);
      expect(m.netProfitPaise, 0);
      expect(m.receivablesChangePaise, -rs(4000));
      expect(m.cashAddedPaise, rs(4000));
    });

    test('her time is shown as "value of your time", never taken out of profit', () async {
      final wax = await s.product('Wax', ProductKind.rawMaterial, unit: 'kg');
      final candle = await s.product('Candle', ProductKind.made, retailPaise: rs(250));
      await s.recipe(candle, wax, 200);
      await s.buy(wax, 5000, rs(1000), d(5, 1)); // ₹200/kg -> ₹40 per candle
      await s.stock.produce(productId: candle, qtyMilli: 20000, date: d(5, 2), batchMinutes: 480);
      final asha = await s.customer('Asha');
      final o = await s.sell(asha, candle, 10, rs(250), d(5, 10));
      await s.pay(asha, rs(2500), d(5, 10), orderId: o.id);
      final m = await s.month(5);
      expect(m.netProfitPaise, rs(2500 - 400));
      expect(m.timeValuePaise, rs(800)); // 8 h × ₹100
    });
  });

  group('P5 · Money taken for home is visible and separate', () {
    test('it reduces cash, not profit, and is never counted as a business expense', () async {
      final asha = await s.customer('Asha');
      final o = await s.sell(asha, earrings, 10, rs(300), d(5, 5));
      await s.pay(asha, rs(3000), d(5, 5), orderId: o.id);
      await s.entries.addWithdrawal(amountPaise: rs(2000), method: PaymentMethod.upi, date: d(5, 20));

      final m = await s.month(5);
      expect(m.netProfitPaise, rs(2000));
      expect(m.expensesPaise, 0);
      expect(m.withdrawalsPaise, rs(2000));
      // ₹3,000 came in, ₹2,000 went home; the earrings were paid for in January (bridge: 'sold from older stock').
      expect(m.stockValueChangePaise, -rs(1000));
      expect(m.cashAddedPaise, rs(1000));
      expect(m.cashAddedPaise, m.actualCashChangePaise);
    });

    test('taking out more than the profit is visible', () async {
      final asha = await s.customer('Asha');
      final o = await s.sell(asha, hamper, 4, rs(1500), d(5, 5)); // profit ₹2,000
      await s.pay(asha, rs(6000), d(5, 5), orderId: o.id);
      await s.entries.addWithdrawal(amountPaise: rs(5000), method: PaymentMethod.cash, date: d(5, 15));
      final m = await s.month(5);
      expect(m.netProfitPaise, rs(2000));
      expect(m.withdrawalsPaise, greaterThan(m.netProfitPaise), reason: 'she took out more than the business earned');
      expect(m.cashAddedPaise, rs(1000), reason: '₹6,000 in − ₹5,000 home; the hampers were paid for earlier');
      expect(m.cashAddedPaise, m.actualCashChangePaise);
    });
  });

  group('P10 · Small expenses add up and are counted', () {
    test('every small expense in the month is in the total; deleted ones and other months are not', () async {
      for (final (cat, amt, day) in [
        ('Packaging', 120, 2),
        ('Courier', 80, 3),
        ('Travel', 40, 9),
        ('Phone', 399, 15)
      ]) {
        await s.entries.addExpense(category: cat, amountPaise: rs(amt), method: PaymentMethod.cash, date: d(5, day));
      }
      final mistake = await s.entries
          .addExpense(category: 'Courier', amountPaise: rs(800), method: PaymentMethod.cash, date: d(5, 4));
      await s.entries.setExpenseDeleted(mistake, true);
      await s.entries.addExpense(category: 'Rent', amountPaise: rs(3000), method: PaymentMethod.bank, date: d(6, 1));

      final m = await s.month(5);
      expect(m.expensesPaise, rs(120 + 80 + 40 + 399));
      expect(m.netProfitPaise, -rs(639));
    });
  });

  group('P4 · She knows her best sellers', () {
    test('by quantity and by profit can differ, and cancelled orders or quotes never count', () async {
      final asha = await s.customer('Asha');
      await s.sell(asha, earrings, 20, rs(300), d(5, 2)); // 20 sold, profit ₹4,000
      await s.sell(asha, hamper, 5, rs(1500), d(5, 3)); // 5 sold, profit ₹2,500
      await s.sell(asha, hamper, 6, rs(1800), d(5, 4)); // 6 more, profit ₹4,800
      final cancelled = await s.sell(asha, earrings, 30, rs(300), d(5, 5));
      await s.orders.cancel(cancelled.id, date: d(5, 6));
      await s.order(asha, earrings, 99, rs(300), d(5, 7), status: OrderStatus.quote);

      final (from, to) = ReportService.monthBounds(d(5, 1));
      final byQty = await s.reports.bestSellers(from: from, to: to);
      final byProfit = await s.reports.bestSellers(from: from, to: to, byProfit: true);
      expect(byQty.first.product.name, 'Earrings');
      expect(byQty.first.qtyMilli, 20000);
      expect(byProfit.first.product.name, 'Hamper');
      expect(byProfit.first.profitPaise, rs(2500 + 4800));
    });
  });
}
