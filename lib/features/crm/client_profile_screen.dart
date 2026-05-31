import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/client.dart';
import '../orders/order_detail_screen.dart';
import '../orders/add_order_screen.dart';
import 'crm_provider.dart';

class ClientProfileScreen extends ConsumerWidget {
  final Client client;
  const ClientProfileScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveClientAsync = ref.watch(singleClientProvider(client.id));

    return liveClientAsync.when(
        loading: () => const Scaffold(
            backgroundColor: AppTheme.backgroundDark,
            body: Center(child: CircularProgressIndicator())),
        error: (e, _) => Scaffold(
            backgroundColor: AppTheme.backgroundDark,
            body: Center(
                child: Text('Error: $e',
                    style: const TextStyle(color: Colors.red)))),
        data: (liveClient) {
          if (liveClient == null) {
            return const Scaffold(
                backgroundColor: AppTheme.backgroundDark,
                body: Center(
                    child: Text('Client not found.',
                        style: TextStyle(color: Colors.white))));
          }

          final balanceAsync = ref.watch(clientBalanceProvider(liveClient.id));
          final ordersAsync = ref.watch(clientOrdersProvider(liveClient.id));
          final txAsync = ref.watch(clientTransactionsProvider(liveClient.id));

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(liveClient.businessName ??
                    liveClient.name ??
                    'Profile Details'),
                backgroundColor: AppTheme.surfaceDark,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.archive_outlined,
                        color: Colors.orangeAccent),
                    tooltip: 'Archive Client',
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                backgroundColor: AppTheme.surfaceDark,
                                title: const Text('Archive Client?',
                                    style: TextStyle(color: Colors.white)),
                                content: const Text(
                                    'This will hide the client from your active CRM and dropdowns. Their historical data will remain intact.',
                                    style: TextStyle(color: Colors.grey)),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancel',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orangeAccent),
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Archive',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ));

                      if (confirm == true) {
                        liveClient.isArchived = true;
                        await ref
                            .read(clientRepositoryProvider)
                            .saveClient(liveClient);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Client archived successfully.'),
                                  backgroundColor: Colors.orange));
                          Navigator.pop(context);
                        }
                      }
                    },
                  ),
                  PopupMenuButton<String>(
                    color: AppTheme.backgroundDark,
                    onSelected: (value) async {
                      if (value == 'edit') {
                        _showEditDialog(context, ref, liveClient);
                      } else if (value == 'delete') {
                        try {
                          await ref
                              .read(clientRepositoryProvider)
                              .deleteClient(liveClient.id);
                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Record removed successfully.'),
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
                    Tab(
                        icon: Icon(Icons.history_toggle_off),
                        text: 'Payment Ledger'),
                  ],
                ),
              ),
              body: Column(
                children: [
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
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Center aligned for better aesthetics
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(liveClient.name ?? 'No Contact Name',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: liveClient.type == 'Lead'
                                    ? Colors.orange.withOpacity(0.15)
                                    : Colors.blue.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                liveClient.type?.toUpperCase() ?? 'CLIENT',
                                style: TextStyle(
                                  color: liveClient.type == 'Lead'
                                      ? Colors.orangeAccent
                                      : Colors.blueAccent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        if (liveClient.location != null &&
                            liveClient.location!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('📍 ${liveClient.location}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14)),
                            ),
                          ),

                        const SizedBox(height: 24),

                        // ==========================================
                        // THE FIX: QUICK ACTIONS ROW
                        // ==========================================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (liveClient.phone != null &&
                                liveClient.phone!.isNotEmpty) ...[
                              _buildActionIcon(
                                  icon: Icons.phone,
                                  color: Colors.blueAccent,
                                  label: 'Call',
                                  onTap: () async {
                                    final uri =
                                        Uri.parse('tel:${liveClient.phone}');
                                    try {
                                      await launchUrl(uri);
                                    } catch (e) {
                                      if (context.mounted)
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Cannot open phone dialer.'),
                                                backgroundColor:
                                                    Colors.redAccent));
                                    }
                                  }),
                              _buildActionIcon(
                                  icon: Icons.chat, // Represents WhatsApp
                                  color: const Color(
                                      0xFF25D366), // Official WhatsApp Teal
                                  label: 'WhatsApp',
                                  onTap: () async {
                                    // Strip out spaces, dashes, brackets to create a clean number
                                    final cleanPhone = liveClient.phone!
                                        .replaceAll(RegExp(r'[^0-9+]'), '');
                                    final uri =
                                        Uri.parse('https://wa.me/$cleanPhone');
                                    try {
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    } catch (e) {
                                      if (context.mounted)
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Cannot open WhatsApp.'),
                                                backgroundColor:
                                                    Colors.redAccent));
                                    }
                                  }),
                            ],
                            if (liveClient.email != null &&
                                liveClient.email!.isNotEmpty)
                              _buildActionIcon(
                                  icon: Icons.email,
                                  color: Colors.orangeAccent,
                                  label: 'Email',
                                  onTap: () async {
                                    final uri =
                                        Uri.parse('mailto:${liveClient.email}');
                                    try {
                                      await launchUrl(uri);
                                    } catch (e) {
                                      if (context.mounted)
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Cannot open email app.'),
                                                backgroundColor:
                                                    Colors.redAccent));
                                    }
                                  }),
                          ],
                        ),
                        // ==========================================

                        const Divider(color: Colors.grey, height: 32),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Outstanding Dues:',
                                style: TextStyle(color: Colors.grey)),
                            balanceAsync.when(
                              loading: () => const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2)),
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
                  if (liveClient.type == 'Lead')
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.orangeAccent.withOpacity(0.3)),
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
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11)),
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
                              await ref
                                  .read(clientRepositoryProvider)
                                  .promoteLeadToClient(liveClient.id);
                              ref.invalidate(activeClientsProvider);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        '${liveClient.businessName ?? liveClient.name} promoted to Client!'),
                                    backgroundColor: Colors.green));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddOrderScreen()));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
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
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Colors.grey),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => OrderDetailScreen(
                                                order: order))),
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
                                            color: Colors.white, size: 16)),
                                    title: Text(
                                        tx.paymentMethod ?? 'Payment Received',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    subtitle: Text(
                                        tx.date?.toString().split(' ')[0] ?? '',
                                        style: const TextStyle(
                                            color: Colors.grey)),
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
        });
  }

  // Helper widget to build beautiful circular icon buttons
  Widget _buildActionIcon(
      {required IconData icon,
      required Color color,
      required String label,
      required VoidCallback onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 22),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Client liveClient) {
    final nameCtrl = TextEditingController(text: liveClient.name);
    final bizCtrl = TextEditingController(text: liveClient.businessName);
    final phoneCtrl = TextEditingController(text: liveClient.phone);
    final emailCtrl = TextEditingController(text: liveClient.email);
    final locCtrl = TextEditingController(text: liveClient.location);

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
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.grey))),
              TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Email Address',
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
              liveClient.name = nameCtrl.text;
              liveClient.businessName = bizCtrl.text;
              liveClient.phone = phoneCtrl.text;
              liveClient.email = emailCtrl.text;
              liveClient.location = locCtrl.text;

              await ref.read(clientRepositoryProvider).saveClient(liveClient);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          )
        ],
      ),
    );
  }
}
