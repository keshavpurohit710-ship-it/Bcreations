// Pure pricing rules (plan §5.4). No database access, so they're easy to test.

import '../data/tables.dart' show PriceType;
import 'money.dart';

/// Line amount after its own discount.
int lineNetPaise({
  required int qtyMilli,
  required int unitPricePaise,
  int lineDiscountPaise = 0,
}) =>
    amountForQty(qtyMilli, unitPricePaise) - lineDiscountPaise;

/// Bill total = sum of lines − order discount + delivery charge.
int orderTotalPaise({
  required Iterable<int> lineNetPaise,
  int orderDiscountPaise = 0,
  int deliveryChargePaise = 0,
}) =>
    lineNetPaise.fold(0, (a, b) => a + b) - orderDiscountPaise + deliveryChargePaise;

/// Her time for a batch, at her hourly rate.
int labourCostPaise({required int minutes, required int hourlyRatePaise}) => divRound(minutes * hourlyRatePaise, 60);

/// Full cost of one piece = (materials + her time) × (1 + overhead %).
/// Used for suggested prices and margin colours, not for "profit banked".
int fullCostPerPiecePaise({
  required int materialPerPiecePaise,
  required int labourPerPiecePaise,
  required int overheadBp,
}) {
  final base = materialPerPiecePaise + labourPerPiecePaise;
  return base + applyBp(base, overheadBp);
}

class SuggestedPrices {
  const SuggestedPrices({required this.retailPaise, required this.wholesalePaise});
  final int retailPaise;
  final int wholesalePaise;
}

/// Cost × markup, rounded UP to the next whole rupee (nobody prices at ₹218.37).
SuggestedPrices suggestPrices({
  required int fullCostPaise,
  required int retailMarkupBp,
  required int wholesaleMarkupBp,
}) =>
    SuggestedPrices(
      retailPaise: _ceilToRupee(applyBp(fullCostPaise, retailMarkupBp)),
      wholesalePaise: _ceilToRupee(applyBp(fullCostPaise, wholesaleMarkupBp)),
    );

int _ceilToRupee(int paise) => paise % 100 == 0 ? paise : (paise ~/ 100 + 1) * 100;

/// List price for a customer's price type. A missing wholesale price falls back
/// to retail minus the default wholesale discount. null = no price set yet.
int? listPricePaise({
  required PriceType priceType,
  required int? retailPricePaise,
  required int? wholesalePricePaise,
  required int defaultWholesaleDiscountBp,
}) {
  if (priceType == PriceType.retail) return retailPricePaise;
  if (wholesalePricePaise != null) return wholesalePricePaise;
  if (retailPricePaise == null) return null;
  return retailPricePaise - applyBp(retailPricePaise, defaultWholesaleDiscountBp);
}

class DiscountRule {
  const DiscountRule({
    required this.minQtyMilli,
    required this.discountBp,
    this.productId,
    this.wholesaleOnly = true,
  });
  final String? productId; // null = all products
  final int minQtyMilli;
  final int discountBp;
  final bool wholesaleOnly;
}

/// Best quantity discount for this line. Product-specific rules replace the
/// global ones for that product.
int bulkDiscountBp({
  required List<DiscountRule> rules,
  required String? productId,
  required int qtyMilli,
  required PriceType priceType,
}) {
  final specific = rules.where((r) => productId != null && r.productId == productId).toList();
  final applicable = specific.isNotEmpty ? specific : rules.where((r) => r.productId == null);
  var best = 0;
  for (final r in applicable) {
    if (r.wholesaleOnly && priceType != PriceType.wholesale) continue;
    if (qtyMilli >= r.minQtyMilli && r.discountBp > best) best = r.discountBp;
  }
  return best;
}

enum MarginBand { healthy, thin, loss, unknown }

/// Green / amber / red for the price she's charging versus full cost.
MarginBand marginBand({
  required int unitPricePaise,
  required int? unitCostPaise,
  required int targetMarginBp,
}) {
  if (unitCostPaise == null || unitCostPaise <= 0 || unitPricePaise <= 0) {
    return MarginBand.unknown;
  }
  if (unitPricePaise < unitCostPaise) return MarginBand.loss;
  final marginBp = divRound((unitPricePaise - unitCostPaise) * bpPerWhole, unitPricePaise);
  return marginBp >= targetMarginBp ? MarginBand.healthy : MarginBand.thin;
}

/// True when cost has risen more than the threshold since the price was set.
bool needsPriceReview({
  required int? priceSetCostPaise,
  required int currentCostPaise,
  required int thresholdBp,
}) {
  if (priceSetCostPaise == null || priceSetCostPaise <= 0) return false;
  return currentCostPaise > priceSetCostPaise + applyBp(priceSetCostPaise, thresholdBp);
}
