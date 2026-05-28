import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/inventory_item.dart';

final inventoryItemsProvider = FutureProvider<List<InventoryItem>>((ref) async {
  ref.watch(inventoryItemWatcher); // <--- THE FIX: Now it listens!
  final isar = ref.read(isarProvider);
  return await isar.inventoryItems.where().findAll();
});

final currentStockProvider =
    FutureProvider.family<int, int>((ref, itemId) async {
  ref.watch(stockWatcher);
  final inventoryService = ref.read(inventoryServiceProvider);
  return await inventoryService.getCurrentStock(itemId);
});
