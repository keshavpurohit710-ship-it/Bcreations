import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/order.dart';
import '../../domain/models/client.dart';
import '../../domain/models/order_line_item.dart';
import '../../domain/models/inventory_item.dart';
import '../crm/crm_provider.dart';
import '../inventory/inventory_provider.dart';
import '../finance/add_payment_screen.dart';
import 'order_provider.dart';

class OrderDetailScreen extends ConsumerWidget {
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveOrderAsync = ref.watch(singleOrderProvider(order.id));

    return liveOrderAsync.when(
        loading: () => const Scaffold(
            backgroundColor: AppTheme.backgroundDark,
            body: Center(child: CircularProgressIndicator())),
        error: (e, _) => Scaffold(
            backgroundColor: AppTheme.backgroundDark,
            body: Center(
                child: Text('Error: $e',
                    style: const TextStyle(color: Colors.red)))),
        data: (liveOrder) {
          if (liveOrder == null)
            return const Scaffold(
                backgroundColor: AppTheme.backgroundDark,
                body: Center(
                    child: Text('Order not found.',
                        style: TextStyle(color: Colors.white))));

          // --- THE FIX: Sanitize the NaN cost for the UI so it doesn't crash ---
          final safeDeliveryCost =
              liveOrder.deliveryCost.isNaN ? 0.0 : liveOrder.deliveryCost;

          final clientAsync = ref.watch(activeClientsProvider);
          final itemsAsync = ref.watch(orderLineItemsProvider(liveOrder.id));
          final inventoryAsync = ref.watch(inventoryItemsProvider);
          final balanceAsync = ref.watch(orderBalanceProvider(liveOrder.id));

          final clientOrdersAsync =
              ref.watch(clientOrdersProvider(liveOrder.clientId!));
          final unpaidClientOrders = clientOrdersAsync.value
                  ?.where((o) => o.status == 'Delivered')
                  .toList() ??
              [];

          return Scaffold(
            appBar: AppBar(
              title: Text('Order #${liveOrder.id} Details'),
              backgroundColor: AppTheme.surfaceDark,
              actions: [
                if (liveOrder.status != 'Delivered' &&
                    liveOrder.status != 'Paid' &&
                    liveOrder.status != 'Cancelled')
                  IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.redAccent),
                      tooltip: 'Cancel Order',
                      onPressed: () async {
                        await ref
                            .read(orderServiceProvider)
                            .cancelOrder(liveOrder.id);
                        if (context.mounted) Navigator.pop(context);
                      })
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStage('Draft', liveOrder.status),
                      _buildLine(liveOrder.status, 'Confirmed'),
                      _buildStage('Confirmed', liveOrder.status),
                      _buildLine(liveOrder.status, 'Dispatched'),
                      _buildStage('Dispatched', liveOrder.status),
                      _buildLine(liveOrder.status, 'Delivered'),
                      _buildStage('Delivered', liveOrder.status),
                      _buildLine(liveOrder.status, 'Paid'),
                      _buildStage('Paid', liveOrder.status),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Client Details',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                clientAsync.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const Text('Error loading client'),
                  data: (clients) {
                    final client = clients
                        .where((c) => c.id == liveOrder.clientId)
                        .firstOrNull;
                    if (client == null) return const SizedBox.shrink();
                    return Card(
                        color: AppTheme.surfaceDark,
                        child: ListTile(
                            leading: const Icon(Icons.business,
                                color: Colors.blueAccent),
                            title: Text(
                                client.businessName ?? client.name ?? 'Unknown',
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text(
                                'Location: ${client.location ?? "N/A"}',
                                style: const TextStyle(color: Colors.grey))));
                  },
                ),
                const SizedBox(height: 24),
                const Text('Order Items',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                itemsAsync.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const Text('Error loading items'),
                  data: (lineItems) {
                    return inventoryAsync.when(
                        loading: () => const CircularProgressIndicator(),
                        error: (_, __) => const SizedBox(),
                        data: (inventoryItems) {
                          double orderTotal = 0;
                          final clients = clientAsync.value ?? [];
                          final client = clients
                              .where((c) => c.id == liveOrder.clientId)
                              .firstOrNull;

                          return Column(
                            children: [
                              ...lineItems.map((lineItem) {
                                final invItem = inventoryItems
                                    .where(
                                        (i) => i.id == lineItem.inventoryItemId)
                                    .firstOrNull;
                                if (invItem == null)
                                  return const SizedBox.shrink();
                                final itemTotal =
                                    lineItem.quantity * lineItem.pricePerUnit;
                                orderTotal += itemTotal;
                                return Card(
                                    color: AppTheme.backgroundDark,
                                    child: ListTile(
                                        title: Text(
                                            invItem.name ?? 'Unknown Item',
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        subtitle: Text(
                                            '${lineItem.quantity} ${lineItem.unit ?? invItem.unit ?? ""} @ ₹${lineItem.pricePerUnit}',
                                            style: const TextStyle(
                                                color: Colors.grey)),
                                        trailing: Text(
                                            '₹${itemTotal.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                color: Colors.greenAccent,
                                                fontWeight: FontWeight.bold))));
                              }),
                              if (safeDeliveryCost > 0) ...[
                                const SizedBox(height: 8),
                                ListTile(
                                  title: const Text('Logistics / Delivery',
                                      style: TextStyle(color: Colors.white70)),
                                  trailing: Text(
                                      '+ ₹${safeDeliveryCost.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          color: Colors.white70)),
                                ),
                              ],
                              const Divider(color: Colors.grey, height: 32),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total Invoice Value:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        '₹${(orderTotal + safeDeliveryCost).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold))
                                  ]),
                              const SizedBox(height: 32),
                              if (liveOrder.status == 'Draft')
                                SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16)),
                                        icon: const Icon(Icons.check_circle,
                                            color: Colors.white),
                                        label: const Text('Confirm Order',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                        onPressed: () => ref
                                            .read(orderServiceProvider)
                                            .confirmOrder(liveOrder.id))),
                              if (liveOrder.status == 'Confirmed')
                                SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.orangeAccent,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16)),
                                        icon: const Icon(Icons.local_shipping,
                                            color: Colors.black),
                                        label: const Text('Dispatch Order',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () => _showDispatchDialog(
                                            context, ref, liveOrder))),
                              if (liveOrder.status == 'Dispatched')
                                SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16)),
                                        icon: const Icon(Icons.inventory,
                                            color: Colors.white),
                                        label: const Text('Mark as Delivered',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                        onPressed: () => ref
                                            .read(orderServiceProvider)
                                            .deliverOrder(liveOrder.id))),
                              const SizedBox(height: 12),
                              // --- THE FIX: Button stays visible at all active stages ---
                              if (client != null &&
                                  liveOrder.status != 'Cancelled')
                                SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Colors.blueAccent),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16)),
                                        icon: const Icon(Icons.share,
                                            color: Colors.blueAccent),
                                        label: const Text(
                                            'Share Quote / Proforma',
                                            style: TextStyle(fontSize: 16)),
                                        onPressed: () => _shareQuote(
                                            liveOrder,
                                            client,
                                            lineItems,
                                            inventoryItems,
                                            orderTotal,
                                            safeDeliveryCost))),
                              const SizedBox(height: 12),
                              if (liveOrder.status == 'Delivered' ||
                                  liveOrder.status == 'Paid')
                                balanceAsync.when(
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (_, __) => const SizedBox(),
                                    data: (balance) {
                                      if (balance <= 0 ||
                                          liveOrder.status == 'Paid') {
                                        return Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                color: Colors.green
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.greenAccent
                                                        .withOpacity(0.3))),
                                            child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.verified,
                                                      color: Colors.greenAccent,
                                                      size: 28),
                                                  SizedBox(width: 12),
                                                  Text('Order Fully Paid',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .greenAccent,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]));
                                      } else {
                                        return Column(
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: AppTheme.surfaceDark,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors
                                                            .orangeAccent
                                                            .withOpacity(0.3))),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                          'Pending Balance:',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16)),
                                                      Text(
                                                          '₹${balance.toStringAsFixed(2)}',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .orangeAccent,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ])),
                                            const SizedBox(height: 16),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 16)),
                                                icon: const Icon(Icons.payment,
                                                    color: Colors.white),
                                                label: const Text(
                                                    'Record Payment (This Order)',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddPaymentScreen(
                                                                prefilledClientId:
                                                                    liveOrder
                                                                        .clientId,
                                                                prefilledOrderId:
                                                                    liveOrder
                                                                        .id,
                                                              )));
                                                },
                                              ),
                                            ),
                                            if (unpaidClientOrders.length >
                                                1) ...[
                                              const SizedBox(height: 12),
                                              SizedBox(
                                                width: double.infinity,
                                                child: OutlinedButton.icon(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors
                                                                  .greenAccent,
                                                          side: const BorderSide(
                                                              color: Colors
                                                                  .greenAccent),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      16)),
                                                  icon:
                                                      const Icon(Icons.layers),
                                                  label: Text(
                                                      'Pay All ${unpaidClientOrders.length} Unpaid Orders',
                                                      style: const TextStyle(
                                                          fontSize: 16)),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddPaymentScreen(
                                                                  prefilledClientId:
                                                                      liveOrder
                                                                          .clientId,
                                                                  prefillPayAll:
                                                                      true,
                                                                )));
                                                  },
                                                ),
                                              ),
                                            ]
                                          ],
                                        );
                                      }
                                    })
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _showDispatchDialog(
      BuildContext context, WidgetRef ref, Order order) async {
    final costController = TextEditingController();
    bool isSubmitting = false;

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
  }

  void _shareQuote(Order order, Client client, List<OrderLineItem> items,
      List<InventoryItem> inventory, double total, double safeDeliveryCost) {
    final buffer = StringBuffer();
    buffer.writeln('📄 *PROFORMA INVOICE / QUOTE*');
    buffer.writeln('-----------------------------------');
    buffer.writeln('*To:* ${client.businessName ?? client.name ?? 'Customer'}');
    buffer.writeln('*Quote Ref:* #${order.id}');
    buffer.writeln('*Status:* ${order.status}');
    buffer.writeln('');
    buffer.writeln('*Items:*');

    for (int i = 0; i < items.length; i++) {
      final line = items[i];
      final invItem =
          inventory.where((inv) => inv.id == line.inventoryItemId).firstOrNull;
      if (invItem != null) {
        final itemTotal = line.quantity * line.pricePerUnit;
        buffer.writeln('${i + 1}. ${invItem.name}');
        buffer.writeln(
            '   ${line.quantity} ${line.unit ?? invItem.unit ?? ""} @ ₹${line.pricePerUnit} = *₹${itemTotal.toStringAsFixed(2)}*');
      }
    }

    buffer.writeln('-----------------------------------');
    if (safeDeliveryCost > 0) {
      buffer.writeln('*Subtotal: ₹${total.toStringAsFixed(2)}*');
      buffer.writeln('*Delivery: ₹${safeDeliveryCost.toStringAsFixed(2)}*');
    }
    buffer.writeln(
        '*Total Amount: ₹${(total + safeDeliveryCost).toStringAsFixed(2)}*');
    buffer.writeln('-----------------------------------');
    buffer.writeln('Thank you for your business!');

    Share.share(buffer.toString());
  }

  Widget _buildStage(String targetStage, String? currentStatus) {
    final stages = ['Draft', 'Confirmed', 'Dispatched', 'Delivered', 'Paid'];
    final targetIndex = stages.indexOf(targetStage);
    int currentIndex = stages.indexOf(currentStatus ?? 'Draft');
    if (currentStatus == 'Cancelled') currentIndex = -1;
    final isCompleted = currentIndex >= targetIndex;
    final isCancelled = currentStatus == 'Cancelled';
    return Column(children: [
      Icon(isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCancelled
              ? Colors.red
              : (isCompleted ? Colors.greenAccent : Colors.grey)),
      const SizedBox(height: 4),
      Text(targetStage,
          style: TextStyle(
              color: isCompleted ? Colors.white : Colors.grey, fontSize: 10))
    ]);
  }

  Widget _buildLine(String? currentStatus, String targetStage) {
    final stages = ['Draft', 'Confirmed', 'Dispatched', 'Delivered', 'Paid'];
    final targetIndex = stages.indexOf(targetStage);
    int currentIndex = stages.indexOf(currentStatus ?? 'Draft');
    final isCompleted = currentIndex >= targetIndex;
    return Expanded(
        child: Container(
            height: 2,
            color: currentStatus == 'Cancelled'
                ? Colors.red
                : (isCompleted
                    ? Colors.greenAccent
                    : Colors.grey.withOpacity(0.3))));
  }
}
