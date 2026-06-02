import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/order.dart';
import '../../domain/models/order_line_item.dart';
import '../../domain/models/transaction.dart'; // <-- Needed for payments
import '../../domain/models/client.dart'; // <-- Needed for search joins

// --- THE FIX: Order Search State ---
final orderSearchQueryProvider = StateProvider<String>((ref) => '');

final activeOrderStatusFilterProvider = StateProvider<String>((ref) => 'All');
final historyOrderStatusFilterProvider = StateProvider<String>((ref) => 'All');

final activeOrdersProvider = FutureProvider<List<Order>>((ref) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  final filterStatus = ref.watch(activeOrderStatusFilterProvider);
  final query =
      ref.watch(orderSearchQueryProvider).toLowerCase(); // Watch search query

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

  // --- THE FIX: In-Memory Multi-Field Search ---
  if (query.isNotEmpty) {
    // Fetch clients to resolve names
    final clients = await isar.clients.where().findAll();
    final clientMap = {for (var c in clients) c.id: c};

    // Fetch line items to calculate total order value
    final lineItems = await isar.orderLineItems.where().findAll();
    final orderTotals = <int, double>{};
    for (var item in lineItems) {
      orderTotals[item.orderId] = (orderTotals[item.orderId] ?? 0.0) +
          (item.pricePerUnit * item.quantity);
    }

    orders = orders.where((o) {
      final clientName = (clientMap[o.clientId]?.name ?? '').toLowerCase();
      final bizName = (clientMap[o.clientId]?.businessName ?? '').toLowerCase();
      final status = (o.status ?? '').toLowerCase();
      final orderIdStr = o.id.toString();

      // Calculate total including valid delivery costs
      double total = orderTotals[o.id] ?? 0.0;
      double dCost = o.deliveryCost ?? 0.0;
      if (!dCost.isNaN) total += dCost;

      return clientName.contains(query) ||
          bizName.contains(query) ||
          status.contains(query) ||
          orderIdStr.contains(query) ||
          total.toStringAsFixed(0).contains(query) ||
          total.toStringAsFixed(2).contains(query);
    }).toList();
  }

  return orders;
});

final historyOrdersProvider = FutureProvider<List<Order>>((ref) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  final filterStatus = ref.watch(historyOrderStatusFilterProvider);
  final query =
      ref.watch(orderSearchQueryProvider).toLowerCase(); // Watch search query

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

  // --- THE FIX: In-Memory Multi-Field Search ---
  if (query.isNotEmpty) {
    final clients = await isar.clients.where().findAll();
    final clientMap = {for (var c in clients) c.id: c};

    final lineItems = await isar.orderLineItems.where().findAll();
    final orderTotals = <int, double>{};
    for (var item in lineItems) {
      orderTotals[item.orderId] = (orderTotals[item.orderId] ?? 0.0) +
          (item.pricePerUnit * item.quantity);
    }

    orders = orders.where((o) {
      final clientName = (clientMap[o.clientId]?.name ?? '').toLowerCase();
      final bizName = (clientMap[o.clientId]?.businessName ?? '').toLowerCase();
      final status = (o.status ?? '').toLowerCase();
      final orderIdStr = o.id.toString();

      // Calculate total including valid delivery costs
      double total = orderTotals[o.id] ?? 0.0;
      double dCost = o.deliveryCost ?? 0.0;
      if (!dCost.isNaN) total += dCost;

      return clientName.contains(query) ||
          bizName.contains(query) ||
          status.contains(query) ||
          orderIdStr.contains(query) ||
          total.toStringAsFixed(0).contains(query) ||
          total.toStringAsFixed(2).contains(query);
    }).toList();
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
// LIVE TRACKING PROVIDERS (Preserved)
// ==========================================

// 1. Watches the specific order so the screen updates instantly when payment hits
final singleOrderProvider =
    FutureProvider.family<Order?, int>((ref, orderId) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  return await isar.orders.get(orderId);
});

// 2. Calculates exact balance remaining for a specific order
final orderBalanceProvider =
    FutureProvider.family<double, int>((ref, orderId) async {
  ref.watch(orderWatcher);
  ref.watch(txWatcher);
  final isar = ref.read(isarProvider);

  final order = await isar.orders.get(orderId);
  double deliveryCost = order?.deliveryCost ?? 0.0;

  // --- Sanitize old Isar records ---
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
// ==========================================
// THE FIX: N+1 Performance Optimization
// ==========================================
// Turns dozens of concurrent per-order Isar reads into a single batch query.
final globalOrderTotalsProvider = FutureProvider<Map<int, double>>((ref) async {
  ref.watch(orderWatcher); // Rebuilds map automatically if orders change
  final isar = ref.read(isarProvider);

  // One blazing-fast batch read for all line items
  final items = await isar.orderLineItems.where().findAll();

  final totals = <int, double>{};
  for (final item in items) {
    totals[item.orderId] =
        (totals[item.orderId] ?? 0.0) + (item.quantity * item.pricePerUnit);
  }

  return totals;
});
