import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/client.dart';
import '../orders/order_detail_screen.dart';
import '../orders/add_order_screen.dart'; // <-- Imported to support direct redirection
import 'crm_provider.dart';

class ClientProfileScreen extends ConsumerWidget {
  final Client client;
  const ClientProfileScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(clientBalanceProvider(client.id));
    final ordersAsync = ref.watch(clientOrdersProvider(client.id));
    final txAsync = ref.watch(clientTransactionsProvider(client.id));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(client.businessName ?? client.name ?? 'Profile Details'),
          backgroundColor: AppTheme.surfaceDark,
          actions: [
            PopupMenuButton<String>(
              color: AppTheme.backgroundDark,
              onSelected: (value) async {
                if (value == 'edit') {
                  _showEditDialog(context, ref, client);
                } else if (value == 'delete') {
                  try {
                    await ref
                        .read(clientRepositoryProvider)
                        .deleteClient(client.id);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Record removed successfully.'),
                          backgroundColor: Colors.green));
                    }
                  } catch (e) {
                    if (context.mounted)
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.red));
                  }
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit Profile',
                        style: TextStyle(color: Colors.white))),
                const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete Account',
                        style: TextStyle(color: Colors.redAccent))),
              ],
            )
          ],
          bottom: const TabBar(
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.receipt_long), text: 'Order History'),
              Tab(icon: Icon(Icons.history_toggle_off), text: 'Payment Ledger'),
            ],
          ),
        ),
        body: Column(
          children: [
            // --- 1. CORE RELATIONSHIP DASHBOARD ---
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(client.name ?? 'No Contact Name',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: client.type == 'Lead'
                              ? Colors.orange.withOpacity(0.15)
                              : Colors.blue.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          client.type?.toUpperCase() ?? 'CLIENT',
                          style: TextStyle(
                            color: client.type == 'Lead'
                                ? Colors.orangeAccent
                                : Colors.blueAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (client.location != null) ...[
                    const SizedBox(height: 4),
                    Text('📍 ${client.location}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                  const Divider(color: Colors.grey, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Outstanding Dues:',
                          style: TextStyle(color: Colors.grey)),
                      balanceAsync.when(
                        loading: () => const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2)),
                        error: (_, __) => const Text('Error',
                            style: TextStyle(color: Colors.red)),
                        data: (balance) => Text(
                          balance > 0
                              ? 'Owes ₹${balance.toStringAsFixed(0)}'
                              : 'No Balance',
                          style: TextStyle(
                            color: balance > 0
                                ? Colors.redAccent
                                : Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- 2. NEW: CONVERSION ACTION PIPELINE BANNER ---
            if (client.type == 'Lead')
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome,
                        color: Colors.orangeAccent, size: 20),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Prospect Ready for Conversion',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                          Text('Promote to Client by logging an order.',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.shopping_cart, size: 14),
                      label: const Text('Convert',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        // Execute database transformation
                        await ref
                            .read(clientRepositoryProvider)
                            .promoteLeadToClient(client.id);

                        // Instantly notify global listeners to force a repaint of status badges
                        ref.invalidate(activeClientsProvider);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  '${client.businessName ?? client.name} promoted to Client!'),
                              backgroundColor: Colors.green));

                          // Seamless handover to the order logging terminal
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddOrderScreen()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),

            // --- 3. LOGISTICAL AUDIT LOGS ---
            Expanded(
              child: TabBarView(
                children: [
                  ordersAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) =>
                        Center(child: Text('Error loading orders: $e')),
                    data: (orders) {
                      if (orders.isEmpty)
                        return const Center(
                            child: Text('No orders recorded.',
                                style: TextStyle(color: Colors.grey)));
                      return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            color: AppTheme.backgroundDark,
                            child: ListTile(
                              title: Text('Order #${order.id}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text('Status: ${order.status}',
                                  style: const TextStyle(color: Colors.grey)),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 16, color: Colors.grey),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          OrderDetailScreen(order: order))),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  txAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) =>
                        Center(child: Text('Error loading payments: $e')),
                    data: (transactions) {
                      if (transactions.isEmpty)
                        return const Center(
                            child: Text('No payments recorded.',
                                style: TextStyle(color: Colors.grey)));
                      return ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            color: AppTheme.backgroundDark,
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(Icons.arrow_downward,
                                    color: Colors.white, size: 16),
                              ),
                              title: Text(
                                  tx.paymentMethod ?? 'Payment Received',
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Text(
                                  tx.date?.toString().split(' ')[0] ?? '',
                                  style: const TextStyle(color: Colors.grey)),
                              trailing: Text(
                                  '+ ₹${tx.amount.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Client client) {
    final nameCtrl = TextEditingController(text: client.name);
    final bizCtrl = TextEditingController(text: client.businessName);
    final locCtrl = TextEditingController(text: client.location);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title:
            const Text('Edit Profile', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Contact Name',
                      labelStyle: TextStyle(color: Colors.grey))),
              TextField(
                  controller: bizCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Business Name',
                      labelStyle: TextStyle(color: Colors.grey))),
              TextField(
                  controller: locCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(color: Colors.grey))),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              client.name = nameCtrl.text;
              client.businessName = bizCtrl.text;
              client.location = locCtrl.text;

              await ref.read(clientRepositoryProvider).saveClient(client);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          )
        ],
      ),
    );
  }
}
