import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/order_line_item.dart';
import '../crm/crm_provider.dart';
import '../inventory/inventory_provider.dart';

// A simple temporary class to hold user input before we save it to Isar
class _DraftLineItem {
  int? inventoryItemId;
  int quantity = 1;
  double pricePerUnit = 0.0;
}

class AddOrderScreen extends ConsumerStatefulWidget {
  const AddOrderScreen({super.key});

  @override
  ConsumerState<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends ConsumerState<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  int? _selectedClientId;
  final List<_DraftLineItem> _lineItems = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _lineItems.add(_DraftLineItem()); // Start with one empty item row
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedClientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a client.'),
          backgroundColor: Colors.red));
      return;
    }

    // Ensure all line items have an inventory item selected
    if (_lineItems.any((item) => item.inventoryItemId == null)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select an item for all rows.'),
          backgroundColor: Colors.red));
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Convert our UI draft items into real Database objects
      final dbLineItems = _lineItems.map((draft) {
        return OrderLineItem()
          ..inventoryItemId = draft.inventoryItemId
          ..quantity = draft.quantity
          ..pricePerUnit = draft.pricePerUnit;
      }).toList();

      // 2. Hand it to the Service Layer (Built in Phase 4)
      final orderService = ref.read(orderServiceProvider);
      await orderService.createOrder(
          _selectedClientId!, _notesController.text.trim(), dbLineItems);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Order Created Successfully!'),
            backgroundColor: Colors.green));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch our live database streams to populate the dropdowns
    final clientsAsync = ref.watch(activeClientsProvider);
    final inventoryAsync = ref.watch(inventoryItemsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Create New Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // --- CLIENT SELECTION ---
              clientsAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Error loading clients: $e'),
                data: (clients) {
                  return DropdownButtonFormField<int>(
                    value: _selectedClientId,
                    dropdownColor: AppTheme.surfaceDark,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Select Client',
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
              const SizedBox(height: 16),

              // --- ORDER NOTES ---
              TextFormField(
                controller: _notesController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Order Notes (Optional)',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent)),
                ),
              ),
              const SizedBox(height: 24),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Line Items',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
              const Divider(color: Colors.grey),

              // --- DYNAMIC LINE ITEMS LIST ---
              Expanded(
                child: ListView.builder(
                  itemCount: _lineItems.length,
                  itemBuilder: (context, index) {
                    final itemDraft = _lineItems[index];

                    return Card(
                      color: AppTheme.backgroundDark,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Item #${index + 1}',
                                    style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold)),
                                if (_lineItems.length >
                                    1) // Only show delete if there's more than 1 item
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () => setState(
                                        () => _lineItems.removeAt(index)),
                                  )
                              ],
                            ),

                            // INVENTORY DROPDOWN
                            inventoryAsync.when(
                              loading: () => const SizedBox(),
                              error: (e, _) => const SizedBox(),
                              data: (items) {
                                return DropdownButtonFormField<int>(
                                  value: itemDraft.inventoryItemId,
                                  dropdownColor: AppTheme.surfaceDark,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      labelText: 'Select Product/Material',
                                      labelStyle:
                                          TextStyle(color: Colors.grey)),
                                  items: items
                                      .map((i) => DropdownMenuItem(
                                          value: i.id,
                                          child: Text('${i.name} (${i.sku})')))
                                      .toList(),
                                  onChanged: (val) => setState(
                                      () => itemDraft.inventoryItemId = val),
                                );
                              },
                            ),
                            const SizedBox(height: 8),

                            // QUANTITY & PRICE ROW
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: itemDraft.quantity.toString(),
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        labelText: 'Qty',
                                        labelStyle:
                                            TextStyle(color: Colors.grey)),
                                    onChanged: (val) => itemDraft.quantity =
                                        int.tryParse(val) ?? 1,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    initialValue:
                                        itemDraft.pricePerUnit.toString(),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        labelText: 'Price per Unit (₹)',
                                        labelStyle:
                                            TextStyle(color: Colors.grey)),
                                    onChanged: (val) => itemDraft.pricePerUnit =
                                        double.tryParse(val) ?? 0.0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // --- ADD ITEM & SUBMIT BUTTONS ---
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () =>
                        setState(() => _lineItems.add(_DraftLineItem())),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Another Item'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12)),
                    onPressed: _isLoading ? null : _submitOrder,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : const Text('Save Order',
                            style: TextStyle(fontSize: 16)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
