import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/order.dart';
import '../crm/crm_provider.dart';
import 'order_provider.dart';
import 'add_order_screen.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders Pipeline'),
          backgroundColor: AppTheme.surfaceDark,
          bottom: const TabBar(
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.local_shipping), text: 'Active Pipeline'),
              Tab(icon: Icon(Icons.history), text: 'History'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ActiveOrdersList(),
            _HistoryOrdersList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddOrderScreen())),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

// ==========================================
// WIDGET: ACTIVE PIPELINE LIST
// ==========================================
class _ActiveOrdersList extends ConsumerWidget {
  const _ActiveOrdersList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(activeOrdersProvider);
    final clientsAsync = ref.watch(activeClientsProvider);
    final currentFilter =
        ref.watch(activeOrderStatusFilterProvider); // Watch current chip state

    return Column(
      children: [
        // --- NEW: Horizontal Filter Chips ---
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: ['All', 'Draft', 'Confirmed', 'Dispatched'].map((status) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(status),
                  selected: currentFilter == status,
                  selectedColor: Colors.blueAccent.withOpacity(0.3),
                  backgroundColor: AppTheme.surfaceDark,
                  labelStyle: TextStyle(
                      color: currentFilter == status
                          ? Colors.blueAccent
                          : Colors.grey),
                  onSelected: (_) => ref
                      .read(activeOrderStatusFilterProvider.notifier)
                      .state = status,
                ),
              );
            }).toList(),
          ),
        ),

        // --- EXISTING: The List ---
        Expanded(
          child: ordersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (orders) {
              if (orders.isEmpty)
                return const Center(
                    child: Text('No active orders.',
                        style: TextStyle(color: Colors.grey)));
              final clients = clientsAsync.value ?? [];

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final client =
                      clients.where((c) => c.id == order.clientId).firstOrNull;
                  final clientName =
                      client?.businessName ?? client?.name ?? 'Unknown Client';

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    color: AppTheme.surfaceDark,
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OrderDetailScreen(order: order))),
                      child: ListTile(
                        title: Text(clientName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        subtitle: Text('Order #${order.id}  •  ${order.status}',
                            style: TextStyle(
                                color: _getStatusColor(order.status),
                                fontWeight: FontWeight.bold)),
                        trailing: _buildPipelineAction(context, ref, order),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Draft':
        return Colors.grey;
      case 'Confirmed':
        return Colors.blueAccent;
      case 'Dispatched':
        return Colors.orangeAccent;
      default:
        return Colors.white;
    }
  }

  Widget _buildPipelineAction(
      BuildContext context, WidgetRef ref, Order order) {
    IconData icon;
    Color color;
    String tooltip;
    Future<void> Function() action;
    if (order.status == 'Draft') {
      icon = Icons.thumb_up;
      color = Colors.blueAccent;
      tooltip = 'Confirm';
      action = () => ref.read(orderServiceProvider).confirmOrder(order.id);
    } else if (order.status == 'Confirmed') {
      icon = Icons.local_shipping;
      color = Colors.orangeAccent;
      tooltip = 'Dispatch';
      action = () => ref.read(orderServiceProvider).dispatchOrder(order.id);
    } else if (order.status == 'Dispatched') {
      icon = Icons.check_circle;
      color = Colors.greenAccent;
      tooltip = 'Deliver';
      action =
          () => ref.read(fulfillmentServiceProvider).deliverOrder(order.id);
    } else {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: Icon(icon, color: color),
      tooltip: tooltip,
      onPressed: () async {
        await action();
        if (context.mounted)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Order advanced: $tooltip!'),
              backgroundColor: Colors.green));
      },
    );
  }
}

// ==========================================
// WIDGET: HISTORY LIST
// ==========================================
class _HistoryOrdersList extends ConsumerWidget {
  const _HistoryOrdersList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyOrdersProvider);
    final clientsAsync = ref.watch(activeClientsProvider);
    final currentFilter = ref.watch(historyOrderStatusFilterProvider);

    return Column(
      children: [
        // --- NEW: Horizontal Filter Chips ---
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: ['All', 'Delivered', 'Cancelled'].map((status) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(status),
                  selected: currentFilter == status,
                  selectedColor: Colors.blueAccent.withOpacity(0.3),
                  backgroundColor: AppTheme.backgroundDark,
                  labelStyle: TextStyle(
                      color: currentFilter == status
                          ? Colors.blueAccent
                          : Colors.grey),
                  onSelected: (_) => ref
                      .read(historyOrderStatusFilterProvider.notifier)
                      .state = status,
                ),
              );
            }).toList(),
          ),
        ),

        // --- EXISTING: The List ---
        Expanded(
          child: historyAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (orders) {
              if (orders.isEmpty)
                return const Center(
                    child: Text('No historical orders.',
                        style: TextStyle(color: Colors.grey)));
              final clients = clientsAsync.value ?? [];

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final client =
                      clients.where((c) => c.id == order.clientId).firstOrNull;
                  final clientName =
                      client?.businessName ?? client?.name ?? 'Unknown Client';

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    color: AppTheme.backgroundDark,
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OrderDetailScreen(order: order))),
                      child: ListTile(
                        leading: Icon(
                            order.status == 'Delivered'
                                ? Icons.check_box
                                : Icons.cancel_presentation,
                            color: order.status == 'Delivered'
                                ? Colors.green
                                : Colors.redAccent),
                        title: Text(clientName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text('Order #${order.id}  •  ${order.status}',
                            style: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
