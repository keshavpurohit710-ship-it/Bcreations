import 'package:isar/isar.dart';
import '../domain/models/stock_movement.dart';
import '../domain/models/inventory_item.dart';
import '../domain/models/transaction.dart';
import '../domain/models/order_line_item.dart';

class InventoryService {
  final Isar _isar;
  InventoryService(this._isar);

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

  Future<void> adjustStock(int itemId, int quantityChange, String reason,
      {double? totalCost, int? vendorId}) async {
    double? calculatedUnitCost;
    if (quantityChange > 0 && totalCost != null && totalCost > 0) {
      calculatedUnitCost = totalCost / quantityChange;
    }

    final movement = StockMovement()
      ..inventoryItemId = itemId
      ..vendorId = vendorId
      ..quantityChange = quantityChange
      ..reason = reason
      ..date = DateTime.now()
      ..totalCost = totalCost
      ..unitCost = calculatedUnitCost;

    await _isar.writeTxn(() async {
      await _isar.stockMovements.put(movement);

      if (quantityChange > 0 && totalCost != null && totalCost > 0) {
        final tx = Transaction()
          ..clientId = vendorId
          ..amount = totalCost
          ..type = 'Expense'
          ..paymentMethod = 'Inventory Purchase ($reason)'
          ..date = DateTime.now();
        await _isar.transactions.put(tx);
      }
    });
  }

  // --- THE FIX: Double Guard (Name + SKU) for Adding Items ---
  Future<void> addItem({
    required String name,
    required String category,
    required String sku,
    required String unit,
    required String itemType,
    required int minStockLevel,
    required double costPrice,
  }) async {
    // 1. Guard against duplicate Names (Case-insensitive)
    final existingName = await _isar.inventoryItems
        .filter()
        .nameEqualTo(name, caseSensitive: false)
        .findFirst();

    if (existingName != null) {
      throw Exception('An item with the name "$name" already exists.');
    }

    // 2. Guard against duplicate SKUs
    final existingSku = await _isar.inventoryItems
        .filter()
        .skuEqualTo(sku, caseSensitive: false)
        .findFirst();

    if (existingSku != null) {
      throw Exception(
          'An item with the SKU "$sku" already exists in the warehouse.');
    }

    final newItem = InventoryItem()
      ..name = name
      ..category = category
      ..sku = sku.toUpperCase()
      ..unit = unit
      ..itemType = itemType
      ..minStockLevel = minStockLevel
      ..costPrice = costPrice;

    await _isar.writeTxn(() async {
      await _isar.inventoryItems.put(newItem);
    });
  }

  // --- THE FIX: Double Guard (Name + SKU) for Updating Items ---
  Future<void> updateItem(InventoryItem item) async {
    // 1. Check for Name conflicts (ignoring the item's own ID)
    final existingName = await _isar.inventoryItems
        .filter()
        .nameEqualTo(item.name, caseSensitive: false)
        .findFirst();

    if (existingName != null && existingName.id != item.id) {
      throw Exception(
          'Another item with the name "${item.name}" already exists.');
    }

    // 2. Check for SKU conflicts (ignoring the item's own ID)
    final existingSku = await _isar.inventoryItems
        .filter()
        .skuEqualTo(item.sku, caseSensitive: false)
        .findFirst();

    if (existingSku != null && existingSku.id != item.id) {
      throw Exception(
          'Another item with the SKU "${item.sku}" already exists.');
    }

    await _isar.writeTxn(() async {
      await _isar.inventoryItems.put(item);
    });
  }

  Future<void> deleteItem(int itemId) async {
    final hasMovements = await _isar.stockMovements
        .filter()
        .inventoryItemIdEqualTo(itemId)
        .isNotEmpty();
    final hasOrders = await _isar.orderLineItems
        .filter()
        .inventoryItemIdEqualTo(itemId)
        .isNotEmpty();

    if (hasMovements || hasOrders) {
      throw Exception(
          'Cannot delete this item. It has historical stock movements or is attached to an order. Please edit the item instead.');
    }

    await _isar.writeTxn(() async => await _isar.inventoryItems.delete(itemId));
  }
}
