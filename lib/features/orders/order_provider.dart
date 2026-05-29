import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/order.dart';
import '../../domain/models/order_line_item.dart';

// --- NEW: Status Filter States ---
final activeOrderStatusFilterProvider = StateProvider<String>((ref) => 'All');
final historyOrderStatusFilterProvider = StateProvider<String>((ref) => 'All');

final activeOrdersProvider = FutureProvider<List<Order>>((ref) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  final filterStatus = ref
      .watch(activeOrderStatusFilterProvider); // Watch the active filter chips!

  var orders = await isar.orders
      .filter()
      .statusEqualTo('Draft')
      .or()
      .statusEqualTo('Confirmed')
      .or()
      .statusEqualTo('Dispatched')
      .findAll();

  if (filterStatus != 'All') {
    orders = orders.where((o) => o.status == filterStatus).toList();
  }
  return orders;
});

final historyOrdersProvider = FutureProvider<List<Order>>((ref) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  final filterStatus = ref.watch(
      historyOrderStatusFilterProvider); // Watch the history filter chips!

  var orders = await isar.orders
      .filter()
      .statusEqualTo('Delivered')
      .or()
      .statusEqualTo('Cancelled')
      .sortByDateDesc()
      .findAll();

  if (filterStatus != 'All') {
    orders = orders.where((o) => o.status == filterStatus).toList();
  }
  return orders;
});

final orderLineItemsProvider =
    FutureProvider.family<List<OrderLineItem>, int>((ref, orderId) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  return await isar.orderLineItems.filter().orderIdEqualTo(orderId).findAll();
});
