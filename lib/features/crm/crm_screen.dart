import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'crm_provider.dart';
import 'add_client_screen.dart';
import 'client_profile_screen.dart';
import 'vendor_profile_screen.dart';

class CRMScreen extends ConsumerStatefulWidget {
  const CRMScreen({super.key});

  @override
  ConsumerState<CRMScreen> createState() => _CRMScreenState();
}

class _CRMScreenState extends ConsumerState<CRMScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  // --- THE FIX: Added TextEditingController to manage search text ---
  final _searchController = TextEditingController();
  int _currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);

    _tabCtrl.addListener(() {
      // Check if the tab has genuinely changed (works for both taps AND swipes)
      if (_tabCtrl.index != _currentTabIndex) {
        _currentTabIndex = _tabCtrl.index;

        // 1. Wipe the text field visually
        _searchController.clear();

        // 2. Reset the background Riverpod states
        ref.read(clientSearchQueryProvider.notifier).state = '';
        ref.read(vendorSearchQueryProvider.notifier).state = '';

        // 3. Force the screen to rebuild to update Hint Text and FAB
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _searchController.dispose(); // --- THE FIX: Dispose the controller ---
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Management',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.surfaceDark,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(116),
          child: Column(
            children: [
              // --- STICKY SEARCH BAR ---
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    // --- THE FIX: Use our manually tracked index ---
                    hintText: _currentTabIndex == 0
                        ? 'Search Clients & Leads...'
                        : 'Search Suppliers...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: AppTheme.backgroundDark,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    // --- THE FIX: Route input based on the manual index ---
                    if (_currentTabIndex == 0) {
                      ref.read(clientSearchQueryProvider.notifier).state =
                          value;
                    } else {
                      ref.read(vendorSearchQueryProvider.notifier).state =
                          value;
                    }
                  },
                ),
              ),
              // --- TABS ---
              TabBar(
                controller: _tabCtrl,
                indicatorColor: Colors.blueAccent,
                labelColor: Colors.blueAccent,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(icon: Icon(Icons.people), text: 'Clients & Leads'),
                  Tab(icon: Icon(Icons.local_shipping), text: 'Suppliers'),
                ],
              )
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ClientList(),
          _VendorList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddClientScreen(
                      initialType: _tabCtrl.index == 1 ? 'Vendor' : 'Client',
                    ))),
        child: const Icon(Icons.person_add, color: Colors.white),
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
