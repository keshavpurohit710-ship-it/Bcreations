// Which filter each tab shows. Home sets these before switching tab, so every
// "needs attention" card opens exactly the list it talks about.

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CustomerFilter { all, owe, suppliers }

enum ItemFilter { all, low, review, products, materials }

/// Within the "Open" orders tab.
enum OpenOrderFilter { all, toDeliver, quotes, withAdvance }

final customerFilterProvider = StateProvider<CustomerFilter>((ref) => CustomerFilter.all);
final itemFilterProvider = StateProvider<ItemFilter>((ref) => ItemFilter.all);

/// 0 = Open, 1 = Delivered, 2 = All.
final ordersTabProvider = StateProvider<int>((ref) => 0);
final openOrderFilterProvider = StateProvider<OpenOrderFilter>((ref) => OpenOrderFilter.all);

/// Month shown on the Money tab (first day of the month).
final moneyMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month);
});
