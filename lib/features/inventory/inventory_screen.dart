import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'inventory_provider.dart';
import '../../models/inventory_item.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  // --- NEW: MANUFACTURE FORM ---
  void _showManufactureForm(
      BuildContext context, WidgetRef ref, List<InventoryItem> items) {
    // Filter items to only show Raw and Unassigned lists
    final rawItems = items.where((i) => i.category == 'Raw').toList();
    final finishedItems =
        items.where((i) => i.category == 'Unassigned').toList();

    // Safety check
    if (rawItems.isEmpty || finishedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppTheme.statusDanger,
          content: Text(
              'You need at least 1 Raw Material and 1 Unassigned item saved in the database first!',
              style: TextStyle(color: Colors.white)),
        ),
      );
      return;
    }

    int selectedRawId = rawItems.first.id;
    int selectedFinishedId = finishedItems.first.id;
    final consumeController = TextEditingController();
    final produceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Production Engine',
                      style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const Text('Convert raw materials into finished goods.',
                      style: TextStyle(
                          color: AppTheme.textSecondary, fontSize: 14)),
                  const SizedBox(height: 20),

                  // Step 1: Consume Raw Material
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppTheme.statusDanger.withOpacity(0.5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('1. Consume (Subtract)',
                            style: TextStyle(
                                color: AppTheme.statusDanger,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<int>(
                          dropdownColor: AppTheme.surfaceColor,
                          initialValue: selectedRawId,
                          style: const TextStyle(color: AppTheme.textPrimary),
                          decoration: const InputDecoration(
                              labelText: 'Raw Material',
                              labelStyle:
                                  TextStyle(color: AppTheme.textSecondary)),
                          items: rawItems
                              .map((item) => DropdownMenuItem(
                                  value: item.id,
                                  child: Text(
                                      '${item.name} (${item.quantity} ${item.unit} available)')))
                              .toList(),
                          onChanged: (val) =>
                              setModalState(() => selectedRawId = val!),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: consumeController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: AppTheme.textPrimary),
                          decoration: const InputDecoration(
                              labelText: 'Quantity to use',
                              labelStyle:
                                  TextStyle(color: AppTheme.textSecondary)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Step 2: Produce Finished Good
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppTheme.statusSuccess.withOpacity(0.5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('2. Produce (Add)',
                            style: TextStyle(
                                color: AppTheme.statusSuccess,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<int>(
                          dropdownColor: AppTheme.surfaceColor,
                          initialValue: selectedFinishedId,
                          style: const TextStyle(color: AppTheme.textPrimary),
                          decoration: const InputDecoration(
                              labelText: 'Finished Good',
                              labelStyle:
                                  TextStyle(color: AppTheme.textSecondary)),
                          items: finishedItems
                              .map((item) => DropdownMenuItem(
                                  value: item.id, child: Text(item.name ?? '')))
                              .toList(),
                          onChanged: (val) =>
                              setModalState(() => selectedFinishedId = val!),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: produceController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: AppTheme.textPrimary),
                          decoration: const InputDecoration(
                              labelText: 'Quantity produced',
                              labelStyle:
                                  TextStyle(color: AppTheme.textSecondary)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentBlue,
                        foregroundColor: AppTheme.textPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (consumeController.text.isNotEmpty &&
                            produceController.text.isNotEmpty) {
                          ref.read(inventoryProvider.notifier).produceGoods(
                                selectedRawId,
                                int.tryParse(consumeController.text) ?? 0,
                                selectedFinishedId,
                                int.tryParse(produceController.text) ?? 0,
                              );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Execute Production',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // --- EXISTING ADD ITEM FORM ---
  void _showAddItemForm(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final qtyController = TextEditingController();
    final costController = TextEditingController();
    final unitController = TextEditingController(text: 'units');
    String selectedCategory = 'Raw';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Add Inventory Item',
                      style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Item Name',
                      labelStyle:
                          const TextStyle(color: AppTheme.textSecondary),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppTheme.textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppTheme.accentAmber),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppTheme.cardColor,
                    initialValue: selectedCategory,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle:
                          const TextStyle(color: AppTheme.textSecondary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    items: ['Raw', 'Unassigned', 'Assigned']
                        .map((String value) =>
                            DropdownMenuItem(value: value, child: Text(value)))
                        .toList(),
                    onChanged: (newValue) =>
                        setModalState(() => selectedCategory = newValue!),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: qtyController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: AppTheme.textPrimary),
                          decoration: InputDecoration(
                            labelText: 'Initial Qty',
                            labelStyle:
                                const TextStyle(color: AppTheme.textSecondary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: unitController,
                          style: const TextStyle(color: AppTheme.textPrimary),
                          decoration: InputDecoration(
                            labelText: 'Unit (kg, m)',
                            labelStyle:
                                const TextStyle(color: AppTheme.textSecondary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: costController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: AppTheme.textPrimary),
                          decoration: InputDecoration(
                            labelText: 'Cost/Unit',
                            labelStyle:
                                const TextStyle(color: AppTheme.textSecondary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentAmber,
                        foregroundColor: AppTheme.bgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            qtyController.text.isNotEmpty) {
                          ref.read(inventoryProvider.notifier).addItem(
                                nameController.text,
                                selectedCategory,
                                int.tryParse(qtyController.text) ?? 0,
                                unitController.text,
                                double.tryParse(costController.text) ?? 0.0,
                              );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save Item',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryItems = ref.watch(inventoryProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inventory Control'),
          actions: [
            // --- NEW: MANUFACTURE BUTTON ---
            IconButton(
              icon: const Icon(Icons.precision_manufacturing,
                  color: AppTheme.accentBlue),
              tooltip: 'Manufacture Goods',
              onPressed: () =>
                  _showManufactureForm(context, ref, inventoryItems),
            ),
            IconButton(
              icon: const Icon(Icons.add_box, color: AppTheme.accentAmber),
              onPressed: () => _showAddItemForm(context, ref),
            ),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            indicatorColor: AppTheme.accentAmber,
            labelColor: AppTheme.accentAmber,
            unselectedLabelColor: AppTheme.textSecondary,
            tabs: [
              Tab(text: 'Raw Materials'),
              Tab(text: 'Unassigned'),
              Tab(text: 'Assigned'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInventoryList(context, ref, inventoryItems, 'Raw'),
            _buildInventoryList(context, ref, inventoryItems, 'Unassigned'),
            _buildInventoryList(context, ref, inventoryItems, 'Assigned'),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryList(BuildContext context, WidgetRef ref,
      List<InventoryItem> items, String category) {
    final filteredList =
        items.where((item) => item.category == category).toList();

    if (filteredList.isEmpty) {
      return Center(
          child: Text('No $category items in database.',
              style: const TextStyle(color: AppTheme.textSecondary)));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final item = filteredList[index];
        final isLowStock = item.quantity < 20;

        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isLowStock
                ? const BorderSide(color: AppTheme.statusDanger, width: 1)
                : BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(item.name ?? 'Unknown',
                              style: const TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          if (isLowStock) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.warning,
                                color: AppTheme.statusDanger, size: 16),
                          ]
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('₹${item.costPerUnit} / ${item.unit}',
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove,
                            color: AppTheme.textPrimary, size: 20),
                        onPressed: () => ref
                            .read(inventoryProvider.notifier)
                            .updateQuantity(item.id, -1),
                        constraints:
                            const BoxConstraints(minWidth: 40, minHeight: 40),
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          '${item.quantity}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isLowStock
                                ? AppTheme.statusDanger
                                : AppTheme.accentAmber,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add,
                            color: AppTheme.textPrimary, size: 20),
                        onPressed: () => ref
                            .read(inventoryProvider.notifier)
                            .updateQuantity(item.id, 1),
                        constraints:
                            const BoxConstraints(minWidth: 40, minHeight: 40),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
