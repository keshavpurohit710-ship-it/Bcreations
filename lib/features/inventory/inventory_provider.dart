import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/inventory_item.dart';
import 'package:isar/isar.dart';
import '../../domain/models/stock_movement.dart';

// Search Query State
final inventorySearchQueryProvider = StateProvider<String>((ref) => '');

// --- THE FIX: State for Category Grouping Toggle ---
final inventoryGroupedViewProvider = StateProvider<bool>((ref) => false);

final inventoryItemsProvider = FutureProvider<List<InventoryItem>>((ref) async {
  ref.watch(inventoryItemWatcher);
  final isar = ref.read(isarProvider);
  final query = ref.watch(inventorySearchQueryProvider).toLowerCase();

  final items = await isar.inventoryItems.where().findAll();

  if (query.isEmpty) return items;

  return items.where((i) {
    final name = i.name?.toLowerCase() ?? '';
    final sku = i.sku?.toLowerCase() ?? '';
    return name.contains(query) || sku.contains(query);
  }).toList();
});

final currentStockProvider =
    FutureProvider.family<int, int>((ref, itemId) async {
  ref.watch(stockWatcher);
  final service = ref.read(inventoryServiceProvider);
  return await service.getCurrentStock(itemId);
});
// ==========================================
// THE FIX: Item-Specific Stock Ledger Provider
// ==========================================
final itemStockHistoryProvider =
    FutureProvider.family<List<StockMovement>, int>((ref, itemId) async {
  ref.watch(stockWatcher); // Auto-refreshes when new movements occur
  final isar = ref.read(isarProvider);

  return await isar.stockMovements
      .filter()
      .inventoryItemIdEqualTo(itemId)
      .sortByDateDesc() // Show newest transactions at the top
      .findAll();
});
