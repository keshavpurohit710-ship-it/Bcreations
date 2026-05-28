import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/providers/core_providers.dart';

import '../../domain/models/transaction.dart';
import '../../domain/models/order.dart';
import '../../domain/models/order_line_item.dart';
import '../../domain/models/inventory_item.dart';

// 1. Calculate Total Revenue across the entire business
final totalRevenueProvider = FutureProvider<double>((ref) async {
  ref.watch(txWatcher); // Live heartbeat
  final isar = ref.read(isarProvider);

  final txs = await isar.transactions.filter().typeEqualTo('Income').findAll();

  // THE FIX: Standard loop instead of .fold()
  double total = 0.0;
  for (final tx in txs) {
    total += tx.amount;
  }
  return total;
});

// 2. Calculate Total Outstanding Market Dues (Unpaid Invoices)
final totalOutstandingProvider = FutureProvider<double>((ref) async {
  ref.watch(orderWatcher); // Live heartbeat
  ref.watch(txWatcher); // Live heartbeat
  final isar = ref.read(isarProvider);

  // Sum all billed from completed orders
  final completedOrders =
      await isar.orders.filter().statusEqualTo('Completed').findAll();
  double totalBilled = 0.0;
  for (final order in completedOrders) {
    final lineItems =
        await isar.orderLineItems.filter().orderIdEqualTo(order.id).findAll();
    for (final item in lineItems) {
      totalBilled += (item.pricePerUnit * item.quantity);
    }
  }

  // Sum all paid
  final txs = await isar.transactions.filter().typeEqualTo('Income').findAll();

  // THE FIX: Standard loop instead of .fold()
  double totalPaid = 0.0;
  for (final tx in txs) {
    totalPaid += tx.amount;
  }

  return totalBilled - totalPaid;
});

// 3. A structured class to hold our low stock alerts
class LowStockAlert {
  final InventoryItem item;
  final int currentStock;
  LowStockAlert(this.item, this.currentStock);
}

// 4. Find all items with stock <= 5
final lowStockProvider = FutureProvider<List<LowStockAlert>>((ref) async {
  ref.watch(stockWatcher); // Live heartbeat
  ref.watch(inventoryItemWatcher); // Live heartbeat

  final isar = ref.read(isarProvider);
  final inventoryService = ref.read(inventoryServiceProvider);

  final items = await isar.inventoryItems.where().findAll();
  final List<LowStockAlert> alerts = [];

  for (final item in items) {
    final stock = await inventoryService.getCurrentStock(item.id);
    if (stock <= 5) {
      alerts.add(LowStockAlert(item, stock));
    }
  }

  return alerts;
});
