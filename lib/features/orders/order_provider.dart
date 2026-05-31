import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/order.dart';
import '../../domain/models/order_line_item.dart';
import '../../domain/models/transaction.dart'; // <-- Needed for payments

final activeOrderStatusFilterProvider = StateProvider<String>((ref) => 'All');
final historyOrderStatusFilterProvider = StateProvider<String>((ref) => 'All');

final activeOrdersProvider = FutureProvider<List<Order>>((ref) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  final filterStatus = ref.watch(activeOrderStatusFilterProvider);

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
  final filterStatus = ref.watch(historyOrderStatusFilterProvider);

  var orders = await isar.orders
      .filter()
      .statusEqualTo('Delivered')
      .or()
      .statusEqualTo('Paid')
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

// ==========================================
// THE FIX: LIVE TRACKING PROVIDERS
// ==========================================

// 1. Watches the specific order so the screen updates instantly when payment hits
final singleOrderProvider =
    FutureProvider.family<Order?, int>((ref, orderId) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  return await isar.orders.get(orderId);
});

// 2. Calculates exact balance remaining for a specific order
// 2. Calculates exact balance remaining for a specific order
// 2. Calculates exact balance remaining for a specific order
final orderBalanceProvider =
    FutureProvider.family<double, int>((ref, orderId) async {
  ref.watch(orderWatcher);
  ref.watch(txWatcher);
  final isar = ref.read(isarProvider);

  final order = await isar.orders.get(orderId);
  double deliveryCost = order?.deliveryCost ?? 0.0;

  // --- THE FIX: Sanitize old Isar records ---
  if (deliveryCost.isNaN) deliveryCost = 0.0;

  final items =
      await isar.orderLineItems.filter().orderIdEqualTo(orderId).findAll();
  double totalValue =
      items.fold(0.0, (sum, item) => sum + (item.quantity * item.pricePerUnit));

  totalValue += deliveryCost;

  final payments =
      await isar.transactions.filter().relatedOrderIdEqualTo(orderId).findAll();
  double totalPaid = payments.fold(0.0, (sum, tx) => sum + tx.amount);

  return totalValue - totalPaid;
});
