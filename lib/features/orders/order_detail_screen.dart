import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart'; // <-- NEW: Import the share package
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
    final clientAsync = ref.watch(activeClientsProvider);
    final itemsAsync = ref.watch(orderLineItemsProvider(order.id));
    final inventoryAsync = ref.watch(inventoryItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.id} Details'),
        backgroundColor: AppTheme.surfaceDark,
        actions: [
          if (order.status != 'Delivered' && order.status != 'Cancelled')
            IconButton(
              icon: const Icon(Icons.cancel, color: Colors.redAccent),
              tooltip: 'Cancel Order',
              onPressed: () async {
                await ref.read(orderServiceProvider).cancelOrder(order.id);
                if (context.mounted) Navigator.pop(context);
              },
            )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- 1. VISUAL STAGE STEPPER ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStage('Draft', order.status),
                _buildLine(order.status, 'Confirmed'),
                _buildStage('Confirmed', order.status),
                _buildLine(order.status, 'Dispatched'),
                _buildStage('Dispatched', order.status),
                _buildLine(order.status, 'Delivered'),
                _buildStage('Delivered', order.status),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // --- 2. CLIENT INFO ---
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
              final client =
                  clients.where((c) => c.id == order.clientId).firstOrNull;
              if (client == null) return const SizedBox.shrink();

              return Card(
                color: AppTheme.surfaceDark,
                child: ListTile(
                  leading: const Icon(Icons.business, color: Colors.blueAccent),
                  title: Text(client.businessName ?? client.name ?? 'Unknown',
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text('Location: ${client.location ?? "N/A"}',
                      style: const TextStyle(color: Colors.grey)),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // --- 3. LINE ITEMS & MATH ---
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
                        .where((c) => c.id == order.clientId)
                        .firstOrNull;

                    return Column(
                      children: [
                        ...lineItems.map((lineItem) {
                          final invItem = inventoryItems
                              .where((i) => i.id == lineItem.inventoryItemId)
                              .firstOrNull;
                          if (invItem == null) return const SizedBox.shrink();

                          final itemTotal =
                              lineItem.quantity * lineItem.pricePerUnit;
                          orderTotal += itemTotal;

                          return Card(
                            color: AppTheme.backgroundDark,
                            child: ListTile(
                              title: Text(invItem.name ?? 'Unknown Item',
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Text(
                                  '${lineItem.quantity} ${invItem.unit} @ ₹${lineItem.pricePerUnit}',
                                  style: const TextStyle(color: Colors.grey)),
                              trailing: Text('₹${itemTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );
                        }),

                        // TOTAL ROW
                        const Divider(color: Colors.grey, height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Value:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text('₹${orderTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // --- 4. NEW: SHARE PROFORMA / QUOTE ---
                        if (client != null)
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side:
                                    const BorderSide(color: Colors.blueAccent),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              icon: const Icon(Icons.share,
                                  color: Colors.blueAccent),
                              label: const Text('Share Quote / Proforma',
                                  style: TextStyle(fontSize: 16)),
                              onPressed: () => _shareQuote(order, client,
                                  lineItems, inventoryItems, orderTotal),
                            ),
                          ),

                        const SizedBox(height: 12),

                        // --- 5. DEEP LINK: LOG PAYMENT ---
                        if (order.status == 'Delivered')
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              icon: const Icon(Icons.payment,
                                  color: Colors.white),
                              label: const Text(
                                  'Record Payment for this Client',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddPaymentScreen()));
                              },
                            ),
                          )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  // --- THE WHATSAPP FORMATTER ---
  void _shareQuote(Order order, Client client, List<OrderLineItem> items,
      List<InventoryItem> inventory, double total) {
    final buffer = StringBuffer();

    // Using *asterisks* to trigger bold text in WhatsApp natively
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
            '   ${line.quantity} ${invItem.unit} @ ₹${line.pricePerUnit} = *₹${itemTotal.toStringAsFixed(2)}*');
      }
    }

    buffer.writeln('-----------------------------------');
    buffer.writeln('*Total Amount: ₹${total.toStringAsFixed(2)}*');
    buffer.writeln('-----------------------------------');
    buffer.writeln('Thank you for your business!');

    // Trigger the native share sheet
    Share.share(buffer.toString());
  }

  Widget _buildStage(String targetStage, String? currentStatus) {
    final stages = ['Draft', 'Confirmed', 'Dispatched', 'Delivered'];
    final targetIndex = stages.indexOf(targetStage);
    int currentIndex = stages.indexOf(currentStatus ?? 'Draft');
    if (currentStatus == 'Cancelled') currentIndex = -1;

    final isCompleted = currentIndex >= targetIndex;
    final isCancelled = currentStatus == 'Cancelled';

    return Column(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCancelled
              ? Colors.red
              : (isCompleted ? Colors.greenAccent : Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(targetStage,
            style: TextStyle(
                color: isCompleted ? Colors.white : Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildLine(String? currentStatus, String targetStage) {
    final stages = ['Draft', 'Confirmed', 'Dispatched', 'Delivered'];
    final targetIndex = stages.indexOf(targetStage);
    int currentIndex = stages.indexOf(currentStatus ?? 'Draft');

    final isCompleted = currentIndex >= targetIndex;

    return Expanded(
      child: Container(
        height: 2,
        color: currentStatus == 'Cancelled'
            ? Colors.red
            : (isCompleted ? Colors.greenAccent : Colors.grey.withOpacity(0.3)),
      ),
    );
  }
}
