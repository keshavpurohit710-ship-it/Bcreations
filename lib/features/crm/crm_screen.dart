import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'crm_provider.dart';
import 'add_client_screen.dart';
import 'client_profile_screen.dart';
import 'vendor_profile_screen.dart'; // <-- Needed for the new screen

class CRMScreen extends ConsumerWidget {
  const CRMScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contact Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          backgroundColor: AppTheme.surfaceDark,
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(116), // Height for Search + Tabs
            child: Column(
              children: [
                // --- STICKY SEARCH BAR ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search by name or business...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: AppTheme.backgroundDark,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (value) =>
                        ref.read(crmSearchQueryProvider.notifier).state = value,
                  ),
                ),
                // --- TABS ---
                const TabBar(
                  indicatorColor: Colors.blueAccent,
                  labelColor: Colors.blueAccent,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Icon(Icons.people), text: 'Clients & Leads'),
                    Tab(icon: Icon(Icons.local_shipping), text: 'Suppliers'),
                  ],
                )
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            _ClientList(),
            _VendorList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddClientScreen())),
          child: const Icon(Icons.person_add, color: Colors.white),
        ),
      ),
    );
  }
}

// ==========================================
// WIDGET: CLIENT LIST
// ==========================================
class _ClientList extends ConsumerWidget {
  const _ClientList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(activeClientsProvider);

    return clientsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (clients) {
        if (clients.isEmpty)
          return const Center(
              child: Text('No clients found.',
                  style: TextStyle(color: Colors.grey)));

        return ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            final client = clients[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: AppTheme.surfaceDark,
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClientProfileScreen(client: client))),
                child: ListTile(
                  title: Text(client.businessName ?? client.name ?? 'Unnamed',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text(
                      '${client.type} • ${client.location ?? "No location"}',
                      style: const TextStyle(color: Colors.grey)),
                  trailing: _ClientBalanceBadge(clientId: client.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ==========================================
// WIDGET: VENDOR LIST
// ==========================================
class _VendorList extends ConsumerWidget {
  const _VendorList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendorsAsync = ref.watch(activeVendorsProvider);

    return vendorsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (vendors) {
        if (vendors.isEmpty)
          return const Center(
              child: Text('No suppliers found.',
                  style: TextStyle(color: Colors.grey)));

        return ListView.builder(
          itemCount: vendors.length,
          itemBuilder: (context, index) {
            final vendor = vendors[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: AppTheme.backgroundDark,
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            VendorProfileScreen(vendor: vendor))),
                child: ListTile(
                  leading: const CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child:
                          Icon(Icons.factory, color: Colors.white, size: 20)),
                  title: Text(vendor.businessName ?? vendor.name ?? 'Unnamed',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text(vendor.location ?? "No location",
                      style: const TextStyle(color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 16),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ==========================================
// WIDGET: CLIENT BALANCE BADGE
// ==========================================
class _ClientBalanceBadge extends ConsumerWidget {
  final int clientId;
  const _ClientBalanceBadge({required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(clientBalanceProvider(clientId));
    return balanceAsync.when(
      loading: () => const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2)),
      error: (_, __) => const Icon(Icons.error, color: Colors.red),
      data: (balance) {
        if (balance <= 0)
          return const Text('Settled',
              style: TextStyle(
                  color: Colors.greenAccent, fontWeight: FontWeight.bold));
        return Text('₹${balance.toStringAsFixed(0)}',
            style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16));
      },
    );
  }
}
