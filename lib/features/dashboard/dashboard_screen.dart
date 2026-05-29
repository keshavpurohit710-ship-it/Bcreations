import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import 'dashboard_provider.dart';

// --- THE MISSING LINK: This tells the file what FilePicker is! ---
import 'package:file_picker/file_picker.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Run the intelligent boot check as soon as the dashboard renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runStartupChecks();
    });
  }

  Future<void> _runStartupChecks() async {
    final notifier = ref.read(notificationServiceProvider);
    await notifier.initialize();
    await notifier.checkPendingPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Command Center',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.backgroundDark,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.blueAccent),
            color: AppTheme.backgroundDark,
            onSelected: (value) async {
              if (value == 'export') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Compiling database...'),
                    duration: Duration(seconds: 1)));
                try {
                  await ref.read(backupServiceProvider).exportDatabaseToJson();
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red));
                  }
                }
              } else if (value == 'import') {
                _showRestoreWarningDialog(context, ref);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'export',
                  child: ListTile(
                      leading:
                          Icon(Icons.cloud_upload, color: Colors.blueAccent),
                      title: Text('Backup to Drive',
                          style: TextStyle(color: Colors.white)))),
              const PopupMenuItem(
                  value: 'import',
                  child: ListTile(
                      leading: Icon(Icons.cloud_download,
                          color: Colors.orangeAccent),
                      title: Text('Restore from JSON',
                          style: TextStyle(color: Colors.white)))),
            ],
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _runStartupChecks();
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
            _LowStockList(),
          ],
        ),
      ),
    );
  }

  void _showRestoreWarningDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: const Text('⚠️ DANGER: WIPE DATA?',
            style: TextStyle(
                color: Colors.redAccent, fontWeight: FontWeight.bold)),
        content: const Text(
          'Restoring from a backup will permanently delete all current data on this device and replace it with the backup file.\n\nAre you sure you want to proceed?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              Navigator.pop(context); // Close the dialog

              // --- V11 SYNTAX: No .platform prefix needed ---
              FilePickerResult? result = await FilePicker.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['json'],
              );

              if (result != null && result.files.single.path != null) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Restoring Database... Do not close app.'),
                      backgroundColor: Colors.orange));
                }

                try {
                  await ref
                      .read(backupServiceProvider)
                      .importDatabaseFromJson(result.files.single.path!);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Restore Complete!'),
                        backgroundColor: Colors.green));
                    await _runStartupChecks();
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Restore Failed: Invalid File ($e)'),
                        backgroundColor: Colors.red));
                  }
                }
              }
            },
            child: const Text('Yes, Wipe & Restore',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
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
