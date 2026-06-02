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
          // --- THE FIX: Replaced TabBar with PreferredSize Sticky Search ---
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(116),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search by client, status, or amount...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: AppTheme.backgroundDark,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (value) => ref
                        .read(orderSearchQueryProvider.notifier)
                        .state = value,
                  ),
                ),
                const TabBar(
                  indicatorColor: Colors.blueAccent,
                  labelColor: Colors.blueAccent,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                        icon: Icon(Icons.local_shipping),
                        text: 'Active Pipeline'),
                    Tab(icon: Icon(Icons.history), text: 'History'),
                  ],
                ),
              ],
            ),
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

// ... NOTE: Keep _ActiveOrdersList and _HistoryOrdersList exactly as they are currently.
// They will automatically inherit the new filtered lists from the FutureProvider!
// (I have omitted them to keep the snippet brief, you don't need to change them)
class _ActiveOrdersList extends ConsumerWidget {
  const _ActiveOrdersList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(activeOrdersProvider);
    final clientsAsync = ref.watch(activeClientsProvider);
    final currentFilter = ref.watch(activeOrderStatusFilterProvider);

    return Column(
      children: [
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
                          .state = status));
            }).toList(),
          ),
        ),
        Expanded(
          child: ordersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (orders) {
              if (orders.isEmpty) {
                return const Center(
                    child: Text('No active orders.',
                        style: TextStyle(color: Colors.grey)));
              }
              final clients = clientsAsync.value ?? [];
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final client =
                      clients.where((c) => c.id == order.clientId).firstOrNull;
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
                        title: Text(
                            client?.businessName ??
                                client?.name ??
                                'Unknown Client',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              Text(order.status ?? 'Unknown',
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(width: 8),
                              const Text('•',
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(width: 8),
                              const Icon(Icons.calendar_today,
                                  size: 12, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                order.date?.toString().split(' ')[0] ??
                                    'Unknown',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),

                              // Render Overdue Badge ONLY if Delivered
                              if (order.status == 'Delivered' &&
                                  order.date != null) ...[
                                Builder(builder: (context) {
                                  final daysOverdue = DateTime.now()
                                      .difference(order.date!)
                                      .inDays;
                                  if (daysOverdue > 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.orangeAccent
                                                  .withOpacity(0.5)),
                                        ),
                                        child: Text(
                                          '$daysOverdue Days Overdue',
                                          style: const TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                              ],
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _OrderValueBadge(order: order),
                            _buildPipelineAction(context, ref, order),
                          ],
                        ),
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

  Future<bool> _showDispatchDialog(
      BuildContext context, WidgetRef ref, Order order) async {
    final costController = TextEditingController();
    bool isSubmitting = false;
    bool wasDispatched = false;

    await showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                backgroundColor: AppTheme.surfaceDark,
                title: const Text('Dispatch Order',
                    style: TextStyle(color: Colors.white)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        'Enter logistics/delivery cost (if any). Leave blank for free delivery.',
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: costController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Delivery Cost (₹)',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.grey))),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    onPressed: isSubmitting
                        ? null
                        : () async {
                            setState(() => isSubmitting = true);
                            final cost =
                                double.tryParse(costController.text) ?? 0.0;
                            await ref
                                .read(orderServiceProvider)
                                .dispatchOrder(order.id, deliveryCost: cost);
                            wasDispatched = true;
                            if (context.mounted) Navigator.pop(context);
                          },
                    child: isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Confirm Dispatch',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                  ),
                ],
              );
            }));

    return wasDispatched;
  }

  Widget _buildPipelineAction(
      BuildContext context, WidgetRef ref, Order order) {
    if (order.status == 'Draft') {
      return IconButton(
          icon: const Icon(Icons.thumb_up, color: Colors.blueAccent),
          tooltip: 'Confirm',
          onPressed: () async {
            // --- THE FIX: Protective Confirm Dialog ---
            final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                      backgroundColor: AppTheme.surfaceDark,
                      title: const Text('Confirm Order?',
                          style: TextStyle(color: Colors.white)),
                      content: const Text(
                          'Are you sure you want to finalize this draft? It will be moved to the active dispatch queue.',
                          style: TextStyle(color: Colors.grey)),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.grey))),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent),
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('Confirm Order',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ));

            if (confirm == true) {
              await ref.read(orderServiceProvider).confirmOrder(order.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Order advanced: Confirmed!'),
                    backgroundColor: Colors.green));
              }
            }
          });
    } else if (order.status == 'Confirmed') {
      return IconButton(
          icon: const Icon(Icons.local_shipping, color: Colors.orangeAccent),
          tooltip: 'Dispatch',
          onPressed: () async {
            final dispatched = await _showDispatchDialog(context, ref, order);
            if (dispatched && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Order advanced: Dispatched!'),
                  backgroundColor: Colors.green));
            }
          });
    } else if (order.status == 'Dispatched') {
      return IconButton(
          icon: const Icon(Icons.check_circle, color: Colors.greenAccent),
          tooltip: 'Deliver',
          onPressed: () async {
            // --- THE FIX: Protective Deliver Dialog ---
            final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                      backgroundColor: AppTheme.surfaceDark,
                      title: const Text('Mark as Delivered?',
                          style: TextStyle(color: Colors.white)),
                      content: const Text(
                          'Has this order been successfully delivered to the client?',
                          style: TextStyle(color: Colors.grey)),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.grey))),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent),
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('Mark Delivered',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ));

            if (confirm == true) {
              await ref.read(orderServiceProvider).deliverOrder(order.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Order advanced: Delivered!'),
                    backgroundColor: Colors.green));
              }
            }
          });
    }
    return const SizedBox.shrink();
  }
}

class _HistoryOrdersList extends ConsumerWidget {
  const _HistoryOrdersList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyOrdersProvider);
    final clientsAsync = ref.watch(activeClientsProvider);
    final currentFilter = ref.watch(historyOrderStatusFilterProvider);

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: ['All', 'Delivered', 'Paid', 'Cancelled'].map((status) {
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
                          .state = status));
            }).toList(),
          ),
        ),
        Expanded(
          child: historyAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (orders) {
              if (orders.isEmpty) {
                return const Center(
                    child: Text('No historical orders.',
                        style: TextStyle(color: Colors.grey)));
              }
              final clients = clientsAsync.value ?? [];
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final client =
                      clients.where((c) => c.id == order.clientId).firstOrNull;
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
                            order.status == 'Paid'
                                ? Icons.verified
                                : (order.status == 'Delivered'
                                    ? Icons.check_box
                                    : Icons.cancel_presentation),
                            color: order.status == 'Paid'
                                ? Colors.greenAccent
                                : (order.status == 'Delivered'
                                    ? Colors.green
                                    : Colors.redAccent)),
                        title: Text(
                            client?.businessName ??
                                client?.name ??
                                'Unknown Client',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              Text(order.status ?? 'Unknown',
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(width: 8),
                              const Text('•',
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(width: 8),
                              const Icon(Icons.calendar_today,
                                  size: 12, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                order.date?.toString().split(' ')[0] ??
                                    'Unknown',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),

                              // Render Overdue Badge ONLY if Delivered
                              if (order.status == 'Delivered' &&
                                  order.date != null) ...[
                                Builder(builder: (context) {
                                  final daysOverdue = DateTime.now()
                                      .difference(order.date!)
                                      .inDays;
                                  if (daysOverdue > 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.orangeAccent
                                                  .withOpacity(0.5)),
                                        ),
                                        child: Text(
                                          '$daysOverdue Days Overdue',
                                          style: const TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                              ],
                            ],
                          ),
                        ),
                        trailing: _OrderValueBadge(order: order),
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

// ==========================================
// ASYNCHRONOUS VALUE BADGE
// ==========================================
class _OrderValueBadge extends ConsumerWidget {
  final Order order;
  const _OrderValueBadge({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- THE FIX: Watch the batch provider instead of a per-order query ---
    final totalsAsync = ref.watch(globalOrderTotalsProvider);

    return totalsAsync.when(
      loading: () => const SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(strokeWidth: 2)),
      error: (_, __) => const Icon(Icons.error, size: 16, color: Colors.red),
      data: (totalsMap) {
        // Look up this specific order's total from the pre-computed map in O(1) time
        double total = totalsMap[order.id] ?? 0.0;

        // Add delivery cost if applicable, sanitizing for legacy NaN records
        double dCost = order.deliveryCost ?? 0.0;
        if (!dCost.isNaN) total += dCost;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '₹${total.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        );
      },
    );
  }
}
