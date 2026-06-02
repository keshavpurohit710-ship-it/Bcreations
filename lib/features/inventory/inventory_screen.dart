import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/inventory_item.dart';
import '../crm/crm_provider.dart';
import 'inventory_provider.dart';
import 'add_inventory_item_screen.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  Widget _buildItemCard(
      BuildContext context, WidgetRef ref, InventoryItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: AppTheme.surfaceDark,
      child: ListTile(
        // ==========================================
        // THE FIX: Added onLongPress directly to ListTile
        // ==========================================
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => _StockHistoryBottomSheet(item: item),
          );
        },
        leading: CircleAvatar(
          backgroundColor: AppTheme.backgroundDark,
          backgroundImage:
              item.imagePath != null ? FileImage(File(item.imagePath!)) : null,
          child: item.imagePath == null
              ? const Icon(Icons.inventory_2_outlined, color: Colors.blueAccent)
              : null,
        ),
        title: Text(item.name ?? 'Unknown Item',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text('SKU: ${item.sku ?? "N/A"} • ${item.category}',
            style: const TextStyle(color: Colors.grey)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CurrentStockBadge(
              itemId: item.id,
              unit: item.unit ?? 'units',
              minStockLevel: item.minStockLevel ?? 5,
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline,
                  color: Colors.blueAccent),
              tooltip: 'Restock Materials',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => _RestockBottomSheet(item: item),
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
                          builder: (_) =>
                              AddInventoryItemScreen(existingItem: item)));
                } else if (value == 'delete') {
                  try {
                    await ref
                        .read(inventoryServiceProvider)
                        .deleteItem(item.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Item deleted.'),
                          backgroundColor: Colors.green));
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.red));
                    }
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
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(inventoryItemsProvider);
    final isGroupedView = ref.watch(inventoryGroupedViewProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Master'),
        backgroundColor: AppTheme.surfaceDark,
        actions: [
          IconButton(
            icon: Icon(isGroupedView ? Icons.list : Icons.category_outlined),
            tooltip: isGroupedView ? 'Show as List' : 'Group by Category',
            onPressed: () {
              ref.read(inventoryGroupedViewProvider.notifier).state =
                  !isGroupedView;
            },
          )
        ],
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
          if (items.isEmpty) {
            return const Center(
                child: Text('No matching items found.',
                    style: TextStyle(color: Colors.grey)));
          }

          if (isGroupedView) {
            final groupedItems = <String, List<InventoryItem>>{};
            for (final item in items) {
              final cat =
                  (item.category == null || item.category!.trim().isEmpty)
                      ? 'General / Uncategorized'
                      : item.category!;
              if (!groupedItems.containsKey(cat)) {
                groupedItems[cat] = [];
              }
              groupedItems[cat]!.add(item);
            }

            final sortedKeys = groupedItems.keys.toList()..sort();

            return ListView.builder(
              itemCount: sortedKeys.length,
              itemBuilder: (context, index) {
                final category = sortedKeys[index];
                final categoryItems = groupedItems[category]!;

                return Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    iconColor: Colors.blueAccent,
                    collapsedIconColor: Colors.grey,
                    title: Text(
                      '$category (${categoryItems.length})',
                      style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    children: categoryItems
                        .map((item) => _buildItemCard(context, ref, item))
                        .toList(),
                  ),
                );
              },
            );
          } else {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildItemCard(context, ref, items[index]);
              },
            );
          }
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

// ===============================================
// DYNAMIC BOTTOM SHEET
// ===============================================
class _RestockBottomSheet extends ConsumerStatefulWidget {
  final InventoryItem item;
  const _RestockBottomSheet({required this.item});

  @override
  ConsumerState<_RestockBottomSheet> createState() =>
      _RestockBottomSheetState();
}

class _RestockBottomSheetState extends ConsumerState<_RestockBottomSheet> {
  final _qtyController = TextEditingController(text: '10');
  late TextEditingController _costController;
  late TextEditingController _reasonController;

  int? _selectedVendorId;
  bool _isLoading = false;
  late bool _isManufacturing;

  @override
  void initState() {
    super.initState();
    // Default to Manufacturing if it's a Finished Good. Otherwise, false.
    _isManufacturing = widget.item.itemType == 'FinishedGood';

    _reasonController = TextEditingController(
        text: _isManufacturing ? 'Internal Production' : 'Routine Restock');

    // Auto-calculate initial cost price based on standard cost
    final initialCost = (10 * widget.item.costPrice).toStringAsFixed(2);
    _costController = TextEditingController(text: initialCost);
  }

  // --- THE FIX: Auto-update cost when quantity changes ---
  void _onQtyChanged(String val) {
    if (!_isManufacturing) {
      final qty = int.tryParse(val) ?? 0;
      _costController.text = (qty * widget.item.costPrice).toStringAsFixed(2);
    }
  }

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
            Text('Update Stock: ${widget.item.name}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // --- THE FIX: Conditional Toggle for Finished Goods ---
            if (widget.item.itemType == 'FinishedGood') ...[
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Manufactured')),
                      selected: _isManufacturing,
                      selectedColor: Colors.orangeAccent.withOpacity(0.3),
                      labelStyle: TextStyle(
                          color: _isManufacturing
                              ? Colors.orangeAccent
                              : Colors.grey),
                      onSelected: (selected) {
                        setState(() {
                          _isManufacturing = true;
                          _reasonController.text = 'Internal Production';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Bought Outright')),
                      selected: !_isManufacturing,
                      selectedColor: Colors.blueAccent.withOpacity(0.3),
                      labelStyle: TextStyle(
                          color: !_isManufacturing
                              ? Colors.blueAccent
                              : Colors.grey),
                      onSelected: (selected) {
                        setState(() {
                          _isManufacturing = false;
                          _reasonController.text = 'Routine Restock';
                          _onQtyChanged(
                              _qtyController.text); // Recalculate cost
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            Row(children: [
              Expanded(
                  child: TextField(
                      controller: _qtyController,
                      keyboardType: TextInputType.number,
                      onChanged: _onQtyChanged,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: _isManufacturing
                              ? 'Units Produced'
                              : 'Quantity Bought',
                          labelStyle: const TextStyle(color: Colors.grey)))),

              // Only show Cost Field if we are buying outright
              if (!_isManufacturing) ...[
                const SizedBox(width: 16),
                Expanded(
                    child: TextField(
                        controller: _costController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            labelText: 'Total Cost (₹)',
                            labelStyle: TextStyle(color: Colors.grey)))),
              ]
            ]),
            const SizedBox(height: 16),

            TextField(
                controller: _reasonController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Reason / Batch Info',
                    labelStyle: TextStyle(color: Colors.grey))),
            const SizedBox(height: 16),

            // Only show Vendors if we are buying outright
            if (!_isManufacturing)
              vendorsAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => const Text('Error loading vendors',
                    style: TextStyle(color: Colors.red)),
                data: (vendors) {
                  if (vendors.isEmpty) {
                    return const Text('No vendors found.',
                        style: TextStyle(
                            color: Colors.orangeAccent, fontSize: 12));
                  }
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
                  backgroundColor: _isManufacturing
                      ? Colors.orangeAccent
                      : Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: _isLoading
                  ? null
                  : () async {
                      final qty = int.tryParse(_qtyController.text) ?? 0;
                      if (qty <= 0) return;

                      setState(() => _isLoading = true);

                      try {
                        if (_isManufacturing) {
                          // Trigger the Manufacturing logic
                          final reason = _reasonController.text.trim().isEmpty
                              ? 'Internal Production'
                              : _reasonController.text.trim();

                          await ref
                              .read(inventoryServiceProvider)
                              .manufactureItem(widget.item.id, qty, reason);
                        } else {
                          // Trigger the Buying/Adjustment logic
                          final cost =
                              double.tryParse(_costController.text) ?? 0.0;
                          final reason = _reasonController.text.trim().isEmpty
                              ? 'Routine Restock'
                              : _reasonController.text.trim();

                          await ref.read(inventoryServiceProvider).adjustStock(
                              widget.item.id, qty, reason,
                              totalCost: cost, vendorId: _selectedVendorId);
                        }

                        if (context.mounted) Navigator.pop(context);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: Colors.red));
                        }
                      } finally {
                        if (mounted) setState(() => _isLoading = false);
                      }
                    },
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                  : Text(
                      _isManufacturing
                          ? 'Confirm Production'
                          : 'Confirm Purchase',
                      style: TextStyle(
                          color: _isManufacturing ? Colors.black : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
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

// ===============================================
// BADGE
// ===============================================
class _CurrentStockBadge extends ConsumerWidget {
  final int itemId;
  final String unit;
  final int
      minStockLevel; // <-- THE FIX: Added minStockLevel to the constructor

  const _CurrentStockBadge({
    required this.itemId,
    required this.unit,
    required this.minStockLevel, // <-- Required parameter
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockAsync = ref.watch(currentStockProvider(itemId));

    return stockAsync.when(
      loading: () => const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2)),
      error: (_, __) => const Icon(Icons.error, color: Colors.red),
      data: (stock) {
        // --- THE FIX: 3-Tier Color Logic ---
        Color bgColor;
        Color textColor;

        if (stock <= 0) {
          bgColor = Colors.red.withOpacity(0.2);
          textColor = Colors.redAccent;
        } else if (stock <= minStockLevel) {
          bgColor = Colors.orange.withOpacity(0.2);
          textColor = Colors.orangeAccent;
        } else {
          bgColor = Colors.green.withOpacity(0.2);
          textColor = Colors.greenAccent;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(12)),
          child: Text('$stock $unit',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}

// Add to the bottom of lib/features/inventory/inventory_screen.dart
class _StockHistoryBottomSheet extends ConsumerWidget {
  final InventoryItem item;

  const _StockHistoryBottomSheet({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(itemStockHistoryProvider(item.id));

    return Container(
      // Take up 70% of the screen height
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Text('${item.name} - Stock Ledger',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          Expanded(
            child: historyAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                  child: Text('Error: $e',
                      style: const TextStyle(color: Colors.red))),
              data: (movements) {
                if (movements.isEmpty) {
                  return const Center(
                    child: Text('No stock movements recorded yet.',
                        style: TextStyle(
                            color: Colors.grey, fontStyle: FontStyle.italic)),
                  );
                }

                return ListView.separated(
                  itemCount: movements.length,
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.white10),
                  itemBuilder: (context, index) {
                    final movement = movements[index];
                    final isAddition = movement.quantityChange > 0;

                    // Format date nicely, stripping milliseconds
                    final dateStr = movement.date?.toString().split('.')[0] ??
                        'Unknown Date';

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: isAddition
                            ? Colors.green.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.2),
                        child: Icon(
                          isAddition
                              ? Icons.add_shopping_cart
                              : Icons.local_shipping,
                          color: isAddition
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        movement.reason ?? 'Manual Adjustment',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        dateStr,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      trailing: Text(
                        '${isAddition ? '+' : ''}${movement.quantityChange} ${item.unit ?? ''}',
                        style: TextStyle(
                          color: isAddition
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
