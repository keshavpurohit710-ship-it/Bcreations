import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'dashboard_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Command Center',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.backgroundDark, // Blend with background
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Riverpod automatically refreshes via streams, but this gives the user a tactile pull-to-refresh feel if they want it.
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            Text('Financial Overview',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),

            // --- TOP METRICS ROW ---
            Row(
              children: [
                Expanded(child: _RevenueCard()),
                SizedBox(width: 16),
                Expanded(child: _OutstandingCard()),
              ],
            ),

            SizedBox(height: 32),
            Text('Action Items & Alerts',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),

            // --- ALERTS LIST ---
            _LowStockList(),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// WIDGET: REVENUE CARD
// ==========================================
class _RevenueCard extends ConsumerWidget {
  const _RevenueCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenueAsync = ref.watch(totalRevenueProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.account_balance_wallet,
              color: Colors.greenAccent, size: 28),
          const SizedBox(height: 12),
          const Text('Total Revenue',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          revenueAsync.when(
            loading: () => const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2)),
            error: (e, _) =>
                const Text('Error', style: TextStyle(color: Colors.red)),
            data: (revenue) => Text(
              '₹${revenue.toStringAsFixed(0)}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// WIDGET: OUTSTANDING DUES CARD
// ==========================================
class _OutstandingCard extends ConsumerWidget {
  const _OutstandingCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outstandingAsync = ref.watch(totalOutstandingProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: Colors.redAccent, size: 28),
          const SizedBox(height: 12),
          const Text('Market Dues',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          outstandingAsync.when(
            loading: () => const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2)),
            error: (e, _) =>
                const Text('Error', style: TextStyle(color: Colors.red)),
            data: (dues) => Text(
              '₹${dues.toStringAsFixed(0)}',
              style: TextStyle(
                  color: dues > 0 ? Colors.redAccent : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// WIDGET: LOW STOCK ALERTS
// ==========================================
class _LowStockList extends ConsumerWidget {
  const _LowStockList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lowStockAsync = ref.watch(lowStockProvider);

    return lowStockAsync.when(
      loading: () => const Center(
          child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator())),
      error: (e, _) => Center(
          child: Text('Error loading alerts: $e',
              style: const TextStyle(color: Colors.red))),
      data: (alerts) {
        if (alerts.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.greenAccent),
                SizedBox(width: 12),
                Text('All inventory levels are healthy.',
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          );
        }

        return Column(
          children: alerts.map((alert) {
            return Card(
              color: AppTheme.surfaceDark,
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.orangeAccent.withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.inventory_2, color: Colors.white, size: 20),
                ),
                title: Text(alert.item.name ?? 'Unknown',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text('SKU: ${alert.item.sku}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Current Stock',
                        style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text(
                      '${alert.currentStock} ${alert.item.unit}',
                      style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
