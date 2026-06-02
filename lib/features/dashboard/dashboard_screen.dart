import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import 'dashboard_provider.dart';
import 'package:file_picker/file_picker.dart';

// --- THE FIX: Add these two imports ---
import '../orders/orders_screen.dart';
import '../inventory/inventory_screen.dart';

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
            SizedBox(height: 24),

            // --- THE FIX: Insert the new Pending Actions Section here ---
            _PendingActionsSection(),
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
// ==========================================
// WIDGET: PENDING ACTIONS SECTION
// ==========================================
class _PendingActionsSection extends ConsumerWidget {
  const _PendingActionsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dispatchAsync = ref.watch(awaitingDispatchCountProvider);
    final unpaidAsync = ref.watch(deliveredUnpaidProvider);
    final stockAsync = ref.watch(lowStockProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Action Required',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),

        // --- TILE 1: Awaiting Dispatch ---
        dispatchAsync.when(
          data: (count) => _ActionTile(
            title: '$count Orders Awaiting Dispatch',
            subtitle: 'Ready to be shipped',
            icon: Icons.local_shipping,
            iconColor: Colors.blueAccent,
            onTap: () => _navigateTo(context, const OrdersScreen()),
          ),
          loading: () => const _LoadingTile(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        const SizedBox(height: 10),

        // --- TILE 2: Delivered & Unpaid ---
        unpaidAsync.when(
          data: (metrics) => _ActionTile(
            title: '${metrics.count} Delivered (Unpaid)',
            subtitle:
                '₹${metrics.totalValue.toStringAsFixed(0)} pending collection',
            icon: Icons.account_balance_wallet,
            iconColor: Colors.orangeAccent,
            isCritical: metrics.count > 0,
            onTap: () => _navigateTo(context, const OrdersScreen()),
          ),
          loading: () => const _LoadingTile(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        const SizedBox(height: 10),

        // --- TILE 3: Low Stock ---
        stockAsync.when(
          data: (alerts) => _ActionTile(
            title: '${alerts.length} Items Below Min Stock',
            subtitle: 'Requires immediate restock',
            icon: Icons.inventory_2,
            iconColor: Colors.redAccent,
            isCritical: alerts.isNotEmpty,
            onTap: () => _navigateTo(context, const InventoryScreen()),
          ),
          loading: () => const _LoadingTile(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}

// ==========================================
// REUSABLE TILE WIDGET
// ==========================================
class _ActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final bool isCritical;

  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.isCritical = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCritical
                ? iconColor.withOpacity(0.4)
                : Colors.grey.withOpacity(0.1),
            width: isCritical ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
          ],
        ),
      ),
    );
  }
}

class _LoadingTile extends StatelessWidget {
  const _LoadingTile();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2)),
      ),
    );
  }
}
