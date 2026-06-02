import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart'; // Needed for queries
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/client.dart';
import '../../domain/models/stock_movement.dart'; // Needed for unassigned movements
import '../inventory/inventory_provider.dart';
import 'crm_provider.dart';

// --- THE FIX: Query for orphaned, positive stock restocks ---
final unassignedPurchasesProvider =
    FutureProvider.autoDispose<List<StockMovement>>((ref) async {
  ref.watch(stockWatcher); // Keep UI synced
  final isar = ref.read(isarProvider);
  return await isar.stockMovements
      .filter()
      .vendorIdIsNull()
      .and()
      .quantityChangeGreaterThan(0) // Only look at additions/purchases
      .sortByDateDesc()
      .findAll();
});

class VendorProfileScreen extends ConsumerWidget {
  final Client vendor;
  const VendorProfileScreen({super.key, required this.vendor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Bind the screen to the live database record
    final liveVendorAsync = ref.watch(singleClientProvider(vendor.id));

    return liveVendorAsync.when(
        loading: () => const Scaffold(
            backgroundColor: AppTheme.backgroundDark,
            body: Center(child: CircularProgressIndicator())),
        error: (e, _) => Scaffold(
            backgroundColor: AppTheme.backgroundDark,
            body: Center(
                child: Text('Error: $e',
                    style: const TextStyle(color: Colors.red)))),
        data: (liveVendor) {
          if (liveVendor == null) {
            return const Scaffold(
                backgroundColor: AppTheme.backgroundDark,
                body: Center(
                    child: Text('Vendor not found.',
                        style: TextStyle(color: Colors.white))));
          }

          final movementsAsync =
              ref.watch(vendorStockMovementsProvider(liveVendor.id));
          final txAsync = ref.watch(clientTransactionsProvider(liveVendor.id));
          final inventoryAsync = ref.watch(inventoryItemsProvider);

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(liveVendor.businessName ??
                    liveVendor.name ??
                    'Vendor Details'),
                backgroundColor: AppTheme.surfaceDark,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.archive_outlined,
                        color: Colors.orangeAccent),
                    tooltip: 'Archive Vendor',
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                backgroundColor: AppTheme.surfaceDark,
                                title: const Text('Archive Vendor?',
                                    style: TextStyle(color: Colors.white)),
                                content: const Text(
                                    'This will hide the vendor from your active CRM and inventory dropdowns. Their historical supply and expense data will remain intact.',
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
                        liveVendor.isArchived = true;
                        await ref
                            .read(clientRepositoryProvider)
                            .saveClient(liveVendor);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Vendor archived successfully.'),
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
                        _showEditDialog(context, ref, liveVendor);
                      } else if (value == 'delete') {
                        try {
                          await ref
                              .read(clientRepositoryProvider)
                              .deleteClient(liveVendor.id);
                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Vendor deleted.'),
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
                          child: Text('Delete Vendor',
                              style: TextStyle(color: Colors.redAccent))),
                    ],
                  )
                ],
                bottom: const TabBar(
                  indicatorColor: Colors.orangeAccent,
                  labelColor: Colors.orangeAccent,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Icon(Icons.inventory_2), text: 'Supply History'),
                    Tab(
                        icon: Icon(Icons.history_toggle_off),
                        text: 'Expense Ledger'),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(liveVendor.name ?? 'No Contact Name',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text('SUPPLIER',
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),

                        if (liveVendor.location != null &&
                            liveVendor.location!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('📍 ${liveVendor.location}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14)),
                            ),
                          ),

                        const SizedBox(height: 24),

                        // QUICK ACTIONS ROW
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (liveVendor.phone != null &&
                                liveVendor.phone!.isNotEmpty) ...[
                              _buildActionIcon(
                                  icon: Icons.phone,
                                  color: Colors.blueAccent,
                                  label: 'Call',
                                  onTap: () async {
                                    final uri =
                                        Uri.parse('tel:${liveVendor.phone}');
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
                                  color: const Color(0xFF25D366),
                                  label: 'WhatsApp',
                                  onTap: () async {
                                    final cleanPhone = liveVendor.phone!
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
                            if (liveVendor.email != null &&
                                liveVendor.email!.isNotEmpty)
                              _buildActionIcon(
                                  icon: Icons.email,
                                  color: Colors.orangeAccent,
                                  label: 'Email',
                                  onTap: () async {
                                    final uri =
                                        Uri.parse('mailto:${liveVendor.email}');
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // --- THE FIX: Embedded Unassigned Orders View ---
                        movementsAsync.when(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (e, _) =>
                              Center(child: Text('Error loading history: $e')),
                          data: (movements) {
                            final inventory = inventoryAsync.value ?? [];
                            final unassignedAsync =
                                ref.watch(unassignedPurchasesProvider);

                            return Column(
                              children: [
                                // Unassigned Section
                                unassignedAsync.when(
                                  data: (unassigned) {
                                    if (unassigned.isEmpty)
                                      return const SizedBox.shrink();
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        collapsedIconColor: Colors.orangeAccent,
                                        iconColor: Colors.orangeAccent,
                                        title: Text(
                                          '${unassigned.length} Unassigned Purchases Available',
                                          style: const TextStyle(
                                              color: Colors.orangeAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        children: unassigned.map((m) {
                                          final item = inventory
                                              .where((i) =>
                                                  i.id == m.inventoryItemId)
                                              .firstOrNull;
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: AppTheme.surfaceDark
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.help_outline,
                                                  color: Colors.orangeAccent),
                                              title: Text(
                                                  item?.name ?? 'Unknown Item',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              subtitle: Text(
                                                '+${m.quantityChange} ${item?.unit ?? "pcs"} • ${m.date?.toString().split(' ')[0]}',
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              trailing: TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .orangeAccent
                                                      .withOpacity(0.15),
                                                  foregroundColor:
                                                      Colors.orangeAccent,
                                                ),
                                                onPressed: () async {
                                                  await ref
                                                      .read(
                                                          inventoryServiceProvider)
                                                      .assignVendorToMovement(
                                                          m.id, liveVendor.id);
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Supply claimed successfully.'),
                                                          backgroundColor:
                                                              Colors.green),
                                                    );
                                                  }
                                                },
                                                child: const Text('Claim'),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                  loading: () => const SizedBox.shrink(),
                                  error: (_, __) => const SizedBox.shrink(),
                                ),

                                // Vendor's Actual History
                                if (movements.isEmpty)
                                  const Expanded(
                                      child: Center(
                                    child: Text('No supplies logged yet.',
                                        style: TextStyle(color: Colors.grey)),
                                  ))
                                else
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: movements.length,
                                      itemBuilder: (context, index) {
                                        final movement = movements[index];
                                        final item = inventory
                                            .where((i) =>
                                                i.id ==
                                                movement.inventoryItemId)
                                            .firstOrNull;
                                        return Card(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 4),
                                          color: AppTheme.backgroundDark,
                                          child: ListTile(
                                            leading: const Icon(
                                                Icons.add_shopping_cart,
                                                color: Colors.blueAccent),
                                            title: Text(
                                                item?.name ?? 'Deleted Item',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle: Text(
                                                '${movement.date?.toString().split(' ')[0]} • ${movement.reason}',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12)),
                                            trailing: Text(
                                                '+${movement.quantityChange} ${item?.unit ?? "pcs"}',
                                                style: const TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
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
                                        backgroundColor: Colors.redAccent,
                                        child: Icon(Icons.arrow_upward,
                                            color: Colors.white, size: 16)),
                                    title: Text(
                                        tx.paymentMethod ?? 'Expense Paid',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    subtitle: Text(
                                        tx.date?.toString().split(' ')[0] ?? '',
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                    trailing: Text(
                                        '- ₹${tx.amount.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                            color: Colors.redAccent,
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

// --- THE FIX: Edit dialog updated with Phone prefix checks ---
  void _showEditDialog(BuildContext context, WidgetRef ref, Client liveVendor) {
    final nameCtrl = TextEditingController(text: liveVendor.name);
    final bizCtrl = TextEditingController(text: liveVendor.businessName);
    final locCtrl = TextEditingController(text: liveVendor.location);
    final emailCtrl = TextEditingController(text: liveVendor.email);

    // Check if the stored number already starts with '+' or '+91' before prepending
    final rawPhone = liveVendor.phone?.trim() ?? '';
    String initialPhone = rawPhone;
    if (rawPhone.isEmpty) {
      initialPhone = '+91 ';
    } else if (!rawPhone.startsWith('+')) {
      initialPhone = '+91 $rawPhone';
    }
    final phoneCtrl = TextEditingController(text: initialPhone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: const Text('Edit Vendor', style: TextStyle(color: Colors.white)),
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
              // Prevent saving junk strings
              String finalPhone = phoneCtrl.text.trim();
              if (finalPhone == '+91') finalPhone = '';

              liveVendor.name = nameCtrl.text;
              liveVendor.businessName = bizCtrl.text;
              liveVendor.phone = finalPhone;
              liveVendor.email = emailCtrl.text.trim();
              liveVendor.location = locCtrl.text;

              await ref.read(clientRepositoryProvider).saveClient(liveVendor);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          )
        ],
      ),
    );
  }
}
