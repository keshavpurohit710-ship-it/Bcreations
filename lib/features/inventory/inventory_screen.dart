import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../crm/crm_provider.dart';
import 'inventory_provider.dart';
import 'add_inventory_item_screen.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(inventoryItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Master'),
        backgroundColor: AppTheme.surfaceDark,
        // --- NEW: Sticky Search Bar in the AppBar ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search by item name or SKU...',
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
                  ref.read(inventorySearchQueryProvider.notifier).state = value,
            ),
          ),
        ),
      ),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (items) {
          if (items.isEmpty)
            return const Center(
                child: Text('No matching items found.',
                    style: TextStyle(color: Colors.grey)));

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                color: AppTheme.surfaceDark,
                child: ListTile(
                  title: Text(item.name ?? 'Unknown Item',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text('SKU: ${item.sku ?? "N/A"} • ${item.category}',
                      style: const TextStyle(color: Colors.grey)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _CurrentStockBadge(
                          itemId: item.id, unit: item.unit ?? 'pcs'),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline,
                            color: Colors.blueAccent),
                        tooltip: 'Restock Materials',
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => _RestockBottomSheet(
                                itemId: item.id, itemName: item.name ?? 'Item'),
                          );
                        },
                      ),
                      PopupMenuButton<String>(
                        color: AppTheme.backgroundDark,
                        icon: const Icon(Icons.more_vert, color: Colors.grey),
                        onSelected: (value) async {
                          if (value == 'edit') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AddInventoryItemScreen(
                                        existingItem: item)));
                          } else if (value == 'delete') {
                            try {
                              await ref
                                  .read(inventoryServiceProvider)
                                  .deleteItem(item.id);
                              if (context.mounted)
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Item deleted.'),
                                        backgroundColor: Colors.green));
                            } catch (e) {
                              if (context.mounted)
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(e.toString()),
                                        backgroundColor: Colors.red));
                            }
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit Item',
                                  style: TextStyle(color: Colors.white))),
                          const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete Item',
                                  style: TextStyle(color: Colors.redAccent))),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddInventoryItemScreen())),
        child: const Icon(Icons.add_box, color: Colors.white),
      ),
    );
  }
}

// ... NOTE: Keep the rest of the file exactly as it is from here down (_RestockBottomSheet, _CurrentStockBadge, etc.)
// (I am providing the rest of the file below just to be 100% safe for copy-pasting!)
class _RestockBottomSheet extends ConsumerStatefulWidget {
  final int itemId;
  final String itemName;
  const _RestockBottomSheet({required this.itemId, required this.itemName});
  @override
  ConsumerState<_RestockBottomSheet> createState() =>
      _RestockBottomSheetState();
}

class _RestockBottomSheetState extends ConsumerState<_RestockBottomSheet> {
  final _qtyController = TextEditingController(text: '10');
  final _costController = TextEditingController(text: '0');
  final _reasonController = TextEditingController(text: 'Routine Restock');
  int? _selectedVendorId;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final vendorsAsync = ref.watch(activeVendorsProvider);
    return Container(
      decoration: const BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Restock: ${widget.itemName}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(
                  child: TextField(
                      controller: _qtyController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: TextStyle(color: Colors.grey)))),
              const SizedBox(width: 16),
              Expanded(
                  child: TextField(
                      controller: _costController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: 'Total Cost (₹)',
                          labelStyle: TextStyle(color: Colors.grey)))),
            ]),
            const SizedBox(height: 16),
            TextField(
                controller: _reasonController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Reason / Source',
                    labelStyle: TextStyle(color: Colors.grey))),
            const SizedBox(height: 16),
            vendorsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => const Text('Error loading vendors',
                  style: TextStyle(color: Colors.red)),
              data: (vendors) {
                if (vendors.isEmpty)
                  return const Text('No vendors found.',
                      style:
                          TextStyle(color: Colors.orangeAccent, fontSize: 12));
                return DropdownButtonFormField<int>(
                  value: _selectedVendorId,
                  dropdownColor: AppTheme.backgroundDark,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Select Supplier/Vendor (Optional)',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                  items: vendors
                      .map((v) => DropdownMenuItem(
                          value: v.id,
                          child: Text(v.businessName ?? v.name ?? 'Unknown')))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedVendorId = val),
                );
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: _isLoading
                  ? null
                  : () async {
                      final qty = int.tryParse(_qtyController.text) ?? 0;
                      final cost = double.tryParse(_costController.text) ?? 0.0;
                      final reason = _reasonController.text.trim().isEmpty
                          ? 'Manual Adjustment'
                          : _reasonController.text.trim();
                      if (qty != 0) {
                        setState(() => _isLoading = true);
                        await ref.read(inventoryServiceProvider).adjustStock(
                            widget.itemId, qty, reason,
                            totalCost: cost, vendorId: _selectedVendorId);
                        if (context.mounted) Navigator.pop(context);
                      }
                    },
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                  : const Text('Confirm Adjustment',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _qtyController.dispose();
    _costController.dispose();
    _reasonController.dispose();
    super.dispose();
  }
}

class _CurrentStockBadge extends ConsumerWidget {
  final int itemId;
  final String unit;
  const _CurrentStockBadge({required this.itemId, required this.unit});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockAsync = ref.watch(currentStockProvider(itemId));
    return stockAsync.when(
      loading: () => const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2)),
      error: (_, __) => const Icon(Icons.error, color: Colors.red),
      data: (stock) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: stock <= 0
                ? Colors.red.withOpacity(0.2)
                : Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)),
        child: Text('$stock $unit',
            style: TextStyle(
                color: stock <= 0 ? Colors.redAccent : Colors.greenAccent,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
