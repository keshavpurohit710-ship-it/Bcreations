import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import 'inventory_provider.dart';
import 'add_inventory_item_screen.dart'; // <-- 1. Import the new form

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(inventoryItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Master'),
        backgroundColor: AppTheme.surfaceDark,
      ),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
                child: Text('No items in inventory.',
                    style: TextStyle(color: Colors.grey)));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: AppTheme.surfaceDark,
                child: ListTile(
                  title: Text(item.name ?? 'Unknown Item',
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text(
                      'Category: ${item.category} • SKU: ${item.sku ?? "N/A"}',
                      style: const TextStyle(color: Colors.grey)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _CurrentStockBadge(
                          itemId: item.id, unit: item.unit ?? 'pcs'),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline,
                            color: Colors.blue),
                        onPressed: () async {
                          // ACTION: Simulating a manual stock adjustment
                          final service = ref.read(inventoryServiceProvider);
                          await service.adjustStock(
                              item.id, 10, 'Manual Restock');
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // <-- 2. The new Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddInventoryItemScreen()),
          );
        },
        child: const Icon(Icons.add_box, color: Colors.white),
      ),
    );
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
      data: (stock) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: stock <= 0
                ? Colors.red.withOpacity(0.2)
                : Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$stock $unit',
            style: TextStyle(
              color: stock <= 0 ? Colors.redAccent : Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
