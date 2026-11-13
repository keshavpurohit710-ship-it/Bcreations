import 'package:bcreations/data/tables.dart';
import 'package:bcreations/domain/money.dart';
import 'package:bcreations/domain/pricing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('money', () {
    test('quantities and rupees convert exactly', () {
      expect(milliFromQty(2.5), 2500);
      expect(paiseFromRupees(12.5), 1250);
      expect(paiseFromRupees(0.1 + 0.2), 30); // the classic float trap
    });

    test('decimal quantity × price rounds to the nearest paisa', () {
      expect(amountForQty(2500, 3333), 8333); // 2.5 m × ₹33.33 = ₹83.325 -> ₹83.33
      expect(amountForQty(1500, 1000), 1500); // 1.5 × ₹10
      expect(amountForQty(333, 300), 100); // 0.333 × ₹3 = ₹0.999 -> ₹1.00
    });

    test('rounding is symmetric for negative values', () {
      expect(divRound(-8332500, 1000), -8333);
      expect(divRound(-1499, 1000), -1);
    });

    test('percentages in basis points', () {
      expect(applyBp(10000, 3000), 3000); // 30 % of ₹100
      expect(applyBp(12100, 18000), 21780); // ₹121 × 1.8
    });

    test('Indian number formatting', () {
      expect(formatPaise(12345650), '₹1,23,456.50');
      expect(formatPaise(30000), '₹300');
      expect(formatMilli(2500), '2.5');
      expect(formatMilli(3000), '3');
    });
  });

  group('pricing', () {
    test('worked example from the plan: earrings', () {
      // materials ₹60 + 30 min at ₹100/h (₹50) + 10 % overhead = ₹121
      final labour = labourCostPaise(minutes: 30, hourlyRatePaise: 10000);
      expect(labour, 5000);
      final cost =
          fullCostPerPiecePaise(materialPerPiecePaise: 6000, labourPerPiecePaise: labour, overheadBp: 1000);
      expect(cost, 12100);
      final p = suggestPrices(fullCostPaise: cost, retailMarkupBp: 25000, wholesaleMarkupBp: 18000);
      expect(p.retailPaise, 30300); // ₹302.50 rounded up to ₹303
      expect(p.wholesalePaise, 21800); // ₹217.80 rounded up to ₹218
    });

    test('order total = lines − discounts + delivery', () {
      final line1 = lineNetPaise(qtyMilli: 3000, unitPricePaise: 30000, lineDiscountPaise: 3000); // 900 − 30
      final line2 = lineNetPaise(qtyMilli: 2500, unitPricePaise: 4000); // 2.5 m × ₹40
      expect(
          orderTotalPaise(lineNetPaise: [line1, line2], orderDiscountPaise: 2000, deliveryChargePaise: 6000),
          87000 + 10000 - 2000 + 6000);
    });

    test('wholesale price falls back to retail minus default discount', () {
      expect(
          listPricePaise(
              priceType: PriceType.wholesale,
              retailPricePaise: 30000,
              wholesalePricePaise: null,
              defaultWholesaleDiscountBp: 3000),
          21000);
      expect(
          listPricePaise(
              priceType: PriceType.wholesale,
              retailPricePaise: 30000,
              wholesalePricePaise: 20000,
              defaultWholesaleDiscountBp: 3000),
          20000);
      expect(
          listPricePaise(
              priceType: PriceType.retail,
              retailPricePaise: 30000,
              wholesalePricePaise: 20000,
              defaultWholesaleDiscountBp: 3000),
          30000);
    });

    test('bulk discounts: best global rule, product rules override, retail excluded', () {
      const rules = [
        BulkRule(minQtyMilli: 10000, discountBp: 500),
        BulkRule(minQtyMilli: 25000, discountBp: 1000),
        BulkRule(productId: 'diya', minQtyMilli: 50000, discountBp: 1500),
      ];
      int bp(String? id, int qty, [PriceType t = PriceType.wholesale]) =>
          bulkDiscountBp(rules: rules, productId: id, qtyMilli: qty, priceType: t);
      expect(bp('earring', 9000), 0);
      expect(bp('earring', 10000), 500);
      expect(bp('earring', 30000), 1000);
      expect(bp('diya', 30000), 0); // its own rule needs 50
      expect(bp('diya', 50000), 1500);
      expect(bp('earring', 30000, PriceType.retail), 0);
    });

    test('margin colours', () {
      MarginBand band(int price, int? cost) =>
          marginBand(unitPricePaise: price, unitCostPaise: cost, targetMarginBp: 4000);
      expect(band(30000, 12100), MarginBand.healthy); // 59.7 %
      expect(band(15000, 12100), MarginBand.thin); // 19 %
      expect(band(11000, 12100), MarginBand.loss);
      expect(band(30000, null), MarginBand.unknown);
    });

    test('price review only when cost rose more than the threshold', () {
      expect(needsPriceReview(priceSetCostPaise: 10000, currentCostPaise: 11000, thresholdBp: 1000), isFalse);
      expect(needsPriceReview(priceSetCostPaise: 10000, currentCostPaise: 11001, thresholdBp: 1000), isTrue);
      expect(needsPriceReview(priceSetCostPaise: null, currentCostPaise: 99999, thresholdBp: 1000), isFalse);
    });
  });
}
