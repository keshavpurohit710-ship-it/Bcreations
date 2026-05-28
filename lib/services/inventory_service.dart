import 'package:isar/isar.dart';
import '../domain/models/stock_movement.dart';
import '../domain/models/inventory_item.dart'; // <-- New import needed for the item model

class InventoryService {
  final Isar _isar;
  InventoryService(this._isar);

  /// DERIVED DATA: Calculates exactly how much stock we have right now
  Future<int> getCurrentStock(int itemId) async {
    final movements = await _isar.stockMovements
        .filter()
        .inventoryItemIdEqualTo(itemId)
        .findAll();

    int totalStock = 0;
    for (final movement in movements) {
      totalStock += movement.quantityChange;
    }

    return totalStock;
  }

  /// ACTION: Safely adds a stock movement record
  Future<void> adjustStock(
      int itemId, int quantityChange, String reason) async {
    final movement = StockMovement()
      ..inventoryItemId = itemId
      ..quantityChange = quantityChange
      ..reason = reason
      ..date = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.stockMovements.put(movement);
    });
  }

  /// ACTION: Add a new Master Item (with SKU duplication guard)
  Future<void> addItem({
    required String name,
    required String category,
    required String sku,
    required String unit,
  }) async {
    // 1. THE DUPLICATION GUARD: Check if the SKU already exists
    final existingItem = await _isar.inventoryItems
        .filter()
        .skuEqualTo(sku,
            caseSensitive: false) // 'stl-001' is the same as 'STL-001'
        .findFirst();

    if (existingItem != null) {
      throw Exception(
          'An item with the SKU "$sku" already exists in the warehouse.');
    }

    // 2. If it is unique, create the record
    final newItem = InventoryItem()
      ..name = name
      ..category = category
      ..sku = sku.toUpperCase() // Force uppercase for clean, consistent data
      ..unit = unit;

    // 3. Save to Database
    await _isar.writeTxn(() async {
      await _isar.inventoryItems.put(newItem);
    });
  }
}
