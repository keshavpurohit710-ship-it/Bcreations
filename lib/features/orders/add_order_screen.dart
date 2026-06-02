import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../crm/crm_provider.dart';
import '../inventory/inventory_provider.dart';

class AddOrderScreen extends ConsumerStatefulWidget {
  const AddOrderScreen({super.key});

  @override
  ConsumerState<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends ConsumerState<AddOrderScreen> {
  int? _selectedClientId;
  final List<Map<String, dynamic>> _orderItems = [];
  bool _isLoading = false;

  final _notesController = TextEditingController();

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

  void _submitOrder() async {
    if (_selectedClientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a client.'),
          backgroundColor: Colors.red));
      return;
    }

    if (_orderItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please add at least one item to the order.'),
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

      await orderService.createOrder(
        _selectedClientId!,
        _orderItems,
        notes: cleanNotes.isNotEmpty ? cleanNotes : null,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Order drafted successfully!'),
            backgroundColor: Colors.green));
        Navigator.pop(context);
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
    final clientsAsync = ref.watch(activeClientsProvider);
    final invAsync = ref.watch(inventoryItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Draft New Order'),
        backgroundColor: AppTheme.surfaceDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- CLIENT SELECTION ---
            clientsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
              data: (clients) {
                return DropdownButtonFormField<int>(
                  value: _selectedClientId,
                  dropdownColor: AppTheme.surfaceDark,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Select Customer / Lead',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                  ),
                  items: clients
                      .map((c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(c.businessName ?? c.name ?? 'Unknown')))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedClientId = val),
                );
              },
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
                  icon: const Icon(Icons.add, color: Colors.blueAccent),
                  label: const Text('Add Item',
                      style: TextStyle(color: Colors.blueAccent)),
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
                hintText: 'e.g., Deliver before 5 PM, Handle with care...',
                hintStyle: TextStyle(color: Colors.white30),
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
              ),
            ),

            // ==========================================
            // THE FIX: Massive Bottom Spacer
            // This pushes the text field up so the hovering FAB
            // no longer obscures the user's typing area!
            // ==========================================
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: _isLoading ? null : _submitOrder,
        icon: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : const Icon(Icons.check, color: Colors.white),
        label: const Text('Save Order Draft',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
