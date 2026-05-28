import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../main.dart'; // Gives us access to the global 'isar' database
import '../../models/inventory_item.dart';

// This is the global Provider we will use in our UI to read the inventory
final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, List<InventoryItem>>((ref) {
  return InventoryNotifier();
});

class InventoryNotifier extends StateNotifier<List<InventoryItem>> {
  // When this starts up, it starts with an empty list [], then loads from the database
  InventoryNotifier() : super([]) {
    loadItems();
  }

  // Read: Fetch all items from the database
  Future<void> loadItems() async {
    final items = await isar.inventoryItems.where().findAll();
    state = items; // This magically updates the UI!
  }

  // Create: Add a new item to the database
  Future<void> addItem(
      String name, String category, int qty, String unit, double cost) async {
    final newItem = InventoryItem()
      ..name = name
      ..category = category
      ..quantity = qty
      ..unit = unit
      ..costPerUnit = cost;

    // writeTxn safely writes to the database
    await isar.writeTxn(() async {
      await isar.inventoryItems.put(newItem);
    });

    await loadItems(); // Refresh the screen
  }

  // Update: Change the quantity (+1 or -1)
  Future<void> updateQuantity(int id, int change) async {
    await isar.writeTxn(() async {
      final item = await isar.inventoryItems.get(id);
      if (item != null) {
        item.quantity += change;
        if (item.quantity < 0) item.quantity = 0; // Prevent negative stock
        await isar.inventoryItems.put(item);
      }
    });

    await loadItems(); // Refresh the screen
  }

  // --- NEW: THE PRODUCTION ENGINE ---
  // Subtracts from Raw Materials and adds to Finished Goods simultaneously
  Future<void> produceGoods(
      int rawId, int consumeQty, int finishedId, int produceQty) async {
    await isar.writeTxn(() async {
      // Find both items in the database
      final rawItem = await isar.inventoryItems.get(rawId);
      final finishedItem = await isar.inventoryItems.get(finishedId);

      if (rawItem != null && finishedItem != null) {
        // Deduct raw materials (preventing negative stock)
        rawItem.quantity -= consumeQty;
        if (rawItem.quantity < 0) rawItem.quantity = 0;

        // Add to finished goods
        finishedItem.quantity += produceQty;

        // Save both back to the database at the exact same time
        await isar.inventoryItems.putAll([rawItem, finishedItem]);
      }
    });

    await loadItems(); // Refresh the screen
  }
}
