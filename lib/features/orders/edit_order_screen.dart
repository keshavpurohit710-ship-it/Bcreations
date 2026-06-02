import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/order.dart';
import '../../domain/models/order_line_item.dart';
import '../crm/crm_provider.dart';
import '../inventory/inventory_provider.dart';

class EditOrderScreen extends ConsumerStatefulWidget {
  final Order order;
  final List<OrderLineItem> initialItems;

  const EditOrderScreen({
    super.key,
    required this.order,
    required this.initialItems,
  });

  @override
  ConsumerState<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends ConsumerState<EditOrderScreen> {
  final List<Map<String, dynamic>> _orderItems = [];
  late TextEditingController _notesController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.order.notes ?? '');

    // Pre-fill the state with existing items
    for (final item in widget.initialItems) {
      _orderItems.add({
        'inventoryItemId': item.inventoryItemId,
        'quantity': item.quantity,
        'pricePerUnit': item.pricePerUnit,
      });
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _addItemRow() {
    setState(() {
      _orderItems.add({
        'inventoryItemId': null,
        'quantity': 1,
        'pricePerUnit': 0.0,
      });
    });
  }

  void _removeItemRow(int index) {
    setState(() {
      _orderItems.removeAt(index);
    });
  }

  void _submitUpdate() async {
    if (_orderItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('An order must have at least one item.'),
          backgroundColor: Colors.red));
      return;
    }

    for (var item in _orderItems) {
      if (item['inventoryItemId'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select an item for all rows.'),
            backgroundColor: Colors.red));
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      final orderService = ref.read(orderServiceProvider);
      final cleanNotes = _notesController.text.trim();

      await orderService.updateOrder(
        widget.order.id,
        _orderItems,
        notes: cleanNotes.isNotEmpty ? cleanNotes : null,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Order updated successfully!'),
            backgroundColor: Colors.green));
        Navigator.pop(context); // Go back to Order Details
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final invAsync = ref.watch(inventoryItemsProvider);
    final clientAsync =
        ref.watch(singleClientProvider(widget.order.clientId ?? -1));

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Order #${widget.order.id}'),
        backgroundColor: AppTheme.surfaceDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- READ-ONLY CLIENT DISPLAY ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.backgroundDark,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: clientAsync.when(
                  loading: () => const Text('Loading client...',
                      style: TextStyle(color: Colors.grey)),
                  error: (_, __) => const Text('Client Error',
                      style: TextStyle(color: Colors.red)),
                  data: (client) => Row(
                        children: [
                          const Icon(Icons.person, color: Colors.blueAccent),
                          const SizedBox(width: 12),
                          Text(
                            client?.businessName ??
                                client?.name ??
                                'Unknown Client',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
            ),
            const SizedBox(height: 24),

            // --- ITEMS HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Order Line Items',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: _addItemRow,
                  icon: const Icon(Icons.add, color: Colors.orangeAccent),
                  label: const Text('Add Item',
                      style: TextStyle(color: Colors.orangeAccent)),
                )
              ],
            ),
            const Divider(color: Colors.grey),

            // --- ITEMS LIST ---
            Expanded(
              child: invAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (inventoryItems) {
                  if (_orderItems.isEmpty) {
                    return const Center(
                        child: Text('No items added yet.',
                            style: TextStyle(color: Colors.grey)));
                  }

                  return ListView.builder(
                    itemCount: _orderItems.length,
                    itemBuilder: (context, index) {
                      final itemState = _orderItems[index];

                      return Card(
                        color: AppTheme.backgroundDark,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: itemState['inventoryItemId'],
                                      dropdownColor: AppTheme.surfaceDark,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          labelText: 'Product',
                                          isDense: true,
                                          labelStyle:
                                              TextStyle(color: Colors.grey)),
                                      items: inventoryItems
                                          .map((inv) => DropdownMenuItem(
                                              value: inv.id,
                                              child:
                                                  Text(inv.name ?? 'Unknown')))
                                          .toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          itemState['inventoryItemId'] = val;
                                          final selectedItem = inventoryItems
                                              .firstWhere((i) => i.id == val);
                                          itemState['pricePerUnit'] =
                                              selectedItem.costPrice;
                                        });
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () => _removeItemRow(index),
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          itemState['quantity'].toString(),
                                      keyboardType: TextInputType.number,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          labelText: 'Quantity',
                                          isDense: true,
                                          labelStyle:
                                              TextStyle(color: Colors.grey)),
                                      onChanged: (val) {
                                        itemState['quantity'] =
                                            int.tryParse(val) ?? 1;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      key: ValueKey(
                                          itemState['inventoryItemId']),
                                      initialValue:
                                          itemState['pricePerUnit'].toString(),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          labelText: 'Unit Price (₹)',
                                          isDense: true,
                                          labelStyle:
                                              TextStyle(color: Colors.grey)),
                                      onChanged: (val) {
                                        itemState['pricePerUnit'] =
                                            double.tryParse(val) ?? 0.0;
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // --- Order Notes Field ---
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Order Notes / Instructions (Optional)',
                hintStyle: TextStyle(color: Colors.white30),
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,
        onPressed: _isLoading ? null : _submitUpdate,
        icon: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: Colors.black, strokeWidth: 2))
            : const Icon(Icons.save, color: Colors.black),
        label: const Text('Update Order',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
