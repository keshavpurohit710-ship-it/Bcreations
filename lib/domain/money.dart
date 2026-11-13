// Exact money and quantity arithmetic for Bcreations.
//
// Conventions used across the data layer (column and variable names end with
// the unit so mistakes are visible):
//   * money       -> integer paise        (₹12.50  == 1250)      suffix: Paise
//   * quantities  -> integer thousandths  (2.5 m   == 2500)      suffix: Milli
//   * percentages -> integer basis points (30 %    == 3000)      suffix: Bp
// Integers never drift the way doubles do (0.1 + 0.2 != 0.3).

import 'package:intl/intl.dart';

/// 1 unit of quantity == 1000 milli.
const int milliPerUnit = 1000;

/// 100 % == 10000 basis points.
const int bpPerWhole = 10000;

/// ₹ amount (as typed by a person) -> paise.
int paiseFromRupees(num rupees) => (rupees * 100).round();

/// Quantity (as typed, e.g. 2.5) -> milli.
int milliFromQty(num qty) => (qty * milliPerUnit).round();

/// Milli -> quantity for display / editing.
double qtyFromMilli(int milli) => milli / milliPerUnit;

/// Divides and rounds half away from zero (₹0.005 -> ₹0.01).
int divRound(int numerator, int denominator) {
  assert(denominator > 0);
  final q = numerator ~/ denominator;
  final r = numerator.remainder(denominator);
  if (r.abs() * 2 >= denominator) return numerator >= 0 ? q + 1 : q - 1;
  return q;
}

/// Price of [qtyMilli] at [unitPaise] per unit, rounded to the paisa.
int amountForQty(int qtyMilli, int unitPaise) => divRound(qtyMilli * unitPaise, milliPerUnit);

/// [paise] × [bp] / 10000, rounded. e.g. applyBp(10000, 3000) == 3000 (30 %).
int applyBp(int paise, int bp) => divRound(paise * bp, bpPerWhole);

final _inr = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2);
final _inrWhole = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

/// Indian grouping: 12345650 -> "₹1,23,456.50"; whole rupees drop the decimals.
String formatPaise(int paise) => paise % 100 == 0 ? _inrWhole.format(paise / 100) : _inr.format(paise / 100);

/// 2500 -> "2.5", 3000 -> "3".
String formatMilli(int milli) {
  final s = (milli / milliPerUnit).toStringAsFixed(3);
  return s.replaceFirst(RegExp(r'\.?0+$'), '');
}
