import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../crm/crm_provider.dart';
import '../inventory/inventory_provider.dart';

// --- THE FIX 1: Track 'unit' natively in the draft state ---
class _DraftLineItem {
  int? inventoryItemId;
  int quantity;
  double pricePerUnit;
  String? unit;

  _DraftLineItem(
      {this.inventoryItemId,
      this.quantity = 1,
      this.pricePerUnit = 0.0,
      this.unit});
}

class AddOrderScreen extends ConsumerStatefulWidget {
  const AddOrderScreen({super.key});

  @override
  ConsumerState<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends ConsumerState<AddOrderScreen> {
  int? _selectedClientId;
  final List<_DraftLineItem> _lineItems = [_DraftLineItem()];
  bool _isLoading = false;

  void _addLineItem() => setState(() => _lineItems.add(_DraftLineItem()));
  void _removeLineItem(int index) => setState(() => _lineItems.removeAt(index));

  double _calculateTotal() {
    return _lineItems.fold(
        0.0, (total, item) => total + (item.quantity * item.pricePerUnit));
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(activeClientsProvider);
    final inventoryAsync = ref.watch(inventoryItemsProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Create New Order'),
          backgroundColor: AppTheme.surfaceDark),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            clientsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
              data: (clients) {
                if (clients.isEmpty)
                  return const Text('No clients found. Add one in CRM.',
                      style: TextStyle(color: Colors.orangeAccent));
                return DropdownButtonFormField<int>(
                  value: _selectedClientId,
                  dropdownColor: AppTheme.surfaceDark,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Select Client',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
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
            const Text('Order Items',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const Divider(color: Colors.grey),
            inventoryAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
              data: (inventory) {
                return Column(
                  children: _lineItems.asMap().entries.map((entry) {
                    int idx = entry.key;
                    _DraftLineItem itemDraft = entry.value;

                    return Card(
                      color: AppTheme.surfaceDark,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    value: itemDraft.inventoryItemId,
                                    dropdownColor: AppTheme.backgroundDark,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        labelText: 'Select Product',
                                        labelStyle:
                                            TextStyle(color: Colors.grey)),
                                    items: inventory
                                        .map((i) => DropdownMenuItem(
                                            value: i.id,
                                            child:
                                                Text('${i.name} (${i.sku})')))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        // --- THE FIX 2: Fetch the unit from the database and store it ---
                                        final matchedItem = inventory
                                            .where((i) => i.id == val)
                                            .first;
                                        itemDraft.inventoryItemId = val;
                                        itemDraft.unit = matchedItem.unit;
                                        itemDraft.pricePerUnit =
                                            matchedItem.costPrice;
                                      });
                                    },
                                  ),
                                ),
                                if (_lineItems.length > 1)
                                  IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      onPressed: () => _removeLineItem(idx)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: itemDraft.quantity.toString(),
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.white),
                                    // --- THE FIX 3: Dynamic Quantity Label ---
                                    decoration: InputDecoration(
                                        labelText:
                                            'Qty (${itemDraft.unit ?? "pcs"})',
                                        labelStyle: const TextStyle(
                                            color: Colors.grey)),
                                    onChanged: (val) => setState(() => itemDraft
                                        .quantity = int.tryParse(val) ?? 1),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    key: ValueKey(
                                        '${idx}_${itemDraft.inventoryItemId}'),
                                    initialValue:
                                        itemDraft.pricePerUnit.toString(),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    style: const TextStyle(color: Colors.white),
                                    // --- THE FIX 4: Dynamic Price Label ---
                                    decoration: InputDecoration(
                                        labelText:
                                            'Price per ${itemDraft.unit ?? "unit"} (₹)',
                                        labelStyle: const TextStyle(
                                            color: Colors.grey)),
                                    onChanged: (val) => setState(() =>
                                        itemDraft.pricePerUnit =
                                            double.tryParse(val) ?? 0.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            TextButton.icon(
                onPressed: _addLineItem,
                icon: const Icon(Icons.add, color: Colors.blueAccent),
                label: const Text('Add Another Item',
                    style: TextStyle(color: Colors.blueAccent))),
            const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Estimated Total:',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              Text('₹${_calculateTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold))
            ]),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: _isLoading || _selectedClientId == null
                  ? null
                  : () async {
                      bool isValid = _lineItems.every((item) =>
                          item.inventoryItemId != null &&
                          item.quantity > 0 &&
                          item.pricePerUnit >= 0);
                      if (!isValid) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Please select valid products and quantities.'),
                            backgroundColor: Colors.red));
                        return;
                      }

                      setState(() => _isLoading = true);
                      try {
                        // --- THE FIX: Explicitly map as <String, dynamic> ---
                        final mappedItems = _lineItems
                            .map((d) => <String, dynamic>{
                                  'inventoryItemId': d.inventoryItemId!,
                                  'quantity': d.quantity,
                                  'pricePerUnit': d.pricePerUnit
                                })
                            .toList();

                        await ref
                            .read(orderServiceProvider)
                            .createOrder(_selectedClientId!, mappedItems);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Order created successfully!'),
                                  backgroundColor: Colors.green));
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        if (context.mounted)
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: Colors.red));
                      } finally {
                        if (context.mounted) setState(() => _isLoading = false);
                      }
                    },
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Confirm & Save Order',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
