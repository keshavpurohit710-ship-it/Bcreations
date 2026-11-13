// Display helpers: money, quantities, dates, and labels for stored enums.

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../data/tables.dart';
import '../domain/money.dart';
import '../l10n/app_localizations.dart';

export '../domain/money.dart' show formatPaise, formatMilli;

extension L10nX on BuildContext {
  S get t => S.of(this);
  String get lang => Localizations.localeOf(this).languageCode;
}

/// "2.5 m", "3 pcs"
String qtyLabel(int milli, String unit) => '${formatMilli(milli)} $unit';

/// "12 Nov" (Hindi: "12 नव॰")
String shortDate(BuildContext context, DateTime d) => DateFormat('d MMM', context.lang).format(d);

/// "12 Nov 2026"
String longDate(BuildContext context, DateTime d) => DateFormat('d MMM y', context.lang).format(d);

/// "November 2026"
String monthLabel(BuildContext context, DateTime d) => DateFormat('MMMM y', context.lang).format(d);

/// Parses "1,250.50" / "1250" -> paise. null if empty or invalid.
int? parseRupees(String text) {
  final clean = text.replaceAll(',', '').trim();
  if (clean.isEmpty) return null;
  final v = double.tryParse(clean);
  return v == null ? null : paiseFromRupees(v);
}

/// Parses "2.5" -> 2500 milli. null if empty or invalid.
int? parseQty(String text) {
  final clean = text.replaceAll(',', '').trim();
  if (clean.isEmpty) return null;
  final v = double.tryParse(clean);
  return v == null ? null : milliFromQty(v);
}

/// Paise -> text for an input field ("1250.5" -> "1250.50", whole rupees without decimals).
String rupeesText(int? paise) {
  if (paise == null) return '';
  return paise % 100 == 0 ? '${paise ~/ 100}' : (paise / 100).toStringAsFixed(2);
}

String qtyText(int? milli) => milli == null ? '' : formatMilli(milli);

extension EnumLabels on S {
  String method(PaymentMethod m) => switch (m) {
        PaymentMethod.cash => methodCash,
        PaymentMethod.upi => methodUpi,
        PaymentMethod.bank => methodBank,
        PaymentMethod.cheque => methodCheque,
        PaymentMethod.other => methodOther,
      };

  String status(OrderStatus s) => switch (s) {
        OrderStatus.quote => statusQuote,
        OrderStatus.confirmed => statusConfirmed,
        OrderStatus.delivered => statusDelivered,
        OrderStatus.cancelled => statusCancelled,
      };

  String channel(SalesChannel c) => switch (c) {
        SalesChannel.shop => channelShop,
        SalesChannel.individual => channelIndividual,
        SalesChannel.exhibition => channelExhibition,
        SalesChannel.online => channelOnline,
      };

  String kind(ProductKind k) => switch (k) {
        ProductKind.rawMaterial => kindRaw,
        ProductKind.made => kindMade,
        ProductKind.bought => kindBought,
      };

  String role(PartyRole r) => switch (r) {
        PartyRole.customer => roleCustomer,
        PartyRole.supplier => roleSupplier,
        PartyRole.both => roleBoth,
      };

  String move(StockMoveType m) => switch (m) {
        StockMoveType.opening => moveOpening,
        StockMoveType.purchase => movePurchase,
        StockMoveType.productionIn => moveProductionIn,
        StockMoveType.productionUse => moveProductionUse,
        StockMoveType.sale => moveSale,
        StockMoveType.saleReversal => moveSaleReversal,
        StockMoveType.adjustment => moveAdjustment,
        StockMoveType.count => moveCount,
      };

  /// Expense categories are stored in English; shown in her language.
  String categoryName(String stored) => switch (stored) {
        'Packaging' => catPackaging,
        'Courier' => catCourier,
        'Travel' => catTravel,
        'Phone' => catPhone,
        'Rent' => catRent,
        'Electricity' => catElectricity,
        'Helper' => catHelper,
        'Other' => catOther,
        _ => stored,
      };
}
