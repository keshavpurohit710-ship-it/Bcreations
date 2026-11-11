import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/order.dart';
import '../../domain/models/inventory_item.dart';
import '../orders/order_provider.dart';

// Data blueprint for the monthly P&L view
class MonthlyPerformance {
  final String monthYear;
  final double revenue;
  final double expenses;
  final double netProfit;
  MonthlyPerformance(
      {required this.monthYear,
      required this.revenue,
      required this.expenses,
      required this.netProfit});
}

// 1. Calculate Total Revenue Across Ledger
final totalRevenueProvider = FutureProvider<double>((ref) async {
  ref.watch(txWatcher);
  final isar = ref.read(isarProvider);
  final txs = await isar.transactions.filter().typeEqualTo('Income').findAll();

  double total = 0.0;
  for (final tx in txs) {
    total += tx.amount;
  }
  return total;
});

// 2. NEW: Calculate Total Expenses Across Ledger
final totalExpensesProvider = FutureProvider<double>((ref) async {
  ref.watch(txWatcher);
  final isar = ref.read(isarProvider);
  final txs = await isar.transactions.filter().typeEqualTo('Expense').findAll();

  double total = 0.0;
  for (final tx in txs) {
    total += tx.amount;
  }
  return total;
});

// 3. Calculate Consolidated Net Profit (P&L Balance)
final netProfitProvider = FutureProvider<double>((ref) async {
  // --- THE FIX: Await the futures so the loading state correctly cascades to the UI ---
  final revenue = await ref.watch(totalRevenueProvider.future);
  final expenses = await ref.watch(totalExpensesProvider.future);

  return revenue - expenses;
});

// 4. Analytical Monthly Aggregations
final monthlyAnalyticsProvider =
    FutureProvider<List<MonthlyPerformance>>((ref) async {
  ref.watch(txWatcher);
  final isar = ref.read(isarProvider);

  // Transactions are fetched newest first
  final txs = await isar.transactions.where().sortByDateDesc().findAll();

  final Map<String, List<Transaction>> grouped = {};
  final List<String> monthsList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  // Group by "Month Year" (e.g., "May 2025")
  for (final tx in txs) {
    final date = tx.date;
    final monthStr = monthsList[date.month - 1];
    final key = '$monthStr ${date.year}';

    if (!grouped.containsKey(key)) {
      grouped[key] = [];
    }
    grouped[key]!.add(tx);
  }

  // Calculate totals
  final List<MonthlyPerformance> performances = [];
  grouped.forEach((monthYear, list) {
    double rev = 0.0;
    double exp = 0.0;
    for (final tx in list) {
      if (tx.type == 'Income') rev += tx.amount;
      if (tx.type == 'Expense') exp += tx.amount;
    }
    performances.add(MonthlyPerformance(
        monthYear: monthYear,
        revenue: rev,
        expenses: exp,
        netProfit: rev - exp));
  });

  // --- THE FIX: Clean Chronological Sort (Newest to Oldest) ---
  int parseMonthYear(String my) {
    final parts = my.split(' ');
    if (parts.length != 2) return 0;
    final mIndex = monthsList.indexOf(parts[0]) + 1;
    final year = int.tryParse(parts[1]) ?? 0;
    return (year * 100) + mIndex; // e.g. "Dec 2024" becomes 202412
  }

  performances.sort((a, b) =>
      parseMonthYear(b.monthYear).compareTo(parseMonthYear(a.monthYear)));

  return performances;
});

// 5. Calculate Total Outstanding Market Dues (Optimized Batch Query)
final totalOutstandingProvider = FutureProvider<double>((ref) async {
  ref.watch(orderWatcher);
  ref.watch(txWatcher);

  // Use the new, centralized math engine
  return await ref.read(financeServiceProvider).getGlobalOutstandingBalance();
});

class LowStockAlert {
  final InventoryItem item;
  final int currentStock;
  LowStockAlert(this.item, this.currentStock);
}

final lowStockProvider = FutureProvider<List<LowStockAlert>>((ref) async {
  ref.watch(stockWatcher);
  ref.watch(inventoryItemWatcher);

  final isar = ref.read(isarProvider);
  final inventoryService = ref.read(inventoryServiceProvider);

  final items = await isar.inventoryItems.where().findAll();
  final List<LowStockAlert> alerts = [];

  for (final item in items) {
    final stock = await inventoryService.getCurrentStock(item.id);

    // THE FIX: Check against the item's specific threshold, not a hardcoded number
    if (stock <= item.minStockLevel) {
      alerts.add(LowStockAlert(item, stock));
    }
  }

  return alerts;
});

// --- NEW: Badge Notification Provider ---
// Counts how many orders are delivered but unpaid
final pendingActionCountProvider = FutureProvider<int>((ref) async {
  ref.watch(orderWatcher); // Instantly updates when an order status changes
  final isar = ref.read(isarProvider);

  final count = await isar.orders.filter().statusEqualTo('Delivered').count();
  return count;
});
// ==========================================
// PENDING ACTIONS PROVIDERS
// ==========================================

// 1. Awaiting Dispatch (Confirmed Orders)
final awaitingDispatchCountProvider = FutureProvider<int>((ref) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  return await isar.orders.filter().statusEqualTo('Confirmed').count();
});

// 2. Delivered but Unpaid (Count & Total Value)
class DeliveredUnpaidMetrics {
  final int count;
  final double totalValue;
  DeliveredUnpaidMetrics(this.count, this.totalValue);
}

final deliveredUnpaidProvider =
    FutureProvider<DeliveredUnpaidMetrics>((ref) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);

  final deliveredOrders =
      await isar.orders.filter().statusEqualTo('Delivered').findAll();
  if (deliveredOrders.isEmpty) return DeliveredUnpaidMetrics(0, 0.0);

  // Utilize our previously built batch provider to get totals instantly
  final totalsMap = await ref.watch(globalOrderTotalsProvider.future);

  double total = 0.0;
  for (final order in deliveredOrders) {
    double orderTotal = totalsMap[order.id] ?? 0.0;
    double dCost = order.deliveryCost;
    if (!dCost.isNaN) orderTotal += dCost;
    total += orderTotal;
  }

  return DeliveredUnpaidMetrics(deliveredOrders.length, total);
});
