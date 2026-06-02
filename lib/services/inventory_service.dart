import 'package:isar/isar.dart';
import '../domain/models/stock_movement.dart';
import '../domain/models/inventory_item.dart';
import '../domain/models/transaction.dart';
import '../domain/models/order_line_item.dart';

class InventoryService {
  final Isar _isar;
  InventoryService(this._isar);

  Future<String> generateNextSku() async {
    final count = await _isar.inventoryItems.count();
    if (count == 0) return 'SKU-0001';

    final lastItems =
        await _isar.inventoryItems.where().offset(count - 1).limit(1).findAll();

    final nextId =
        lastItems.isNotEmpty ? (lastItems.first.id + 1) : (count + 1);
    return 'SKU-${nextId.toString().padLeft(4, '0')}';
  }

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

  // --- THE FIX: Manufacturing Logic (Deducts raw materials based on BOM) ---
  Future<void> manufactureItem(
      int finishedGoodId, int quantityProduced, String reason) async {
    final fg = await _isar.inventoryItems.get(finishedGoodId);
    if (fg == null || fg.recipe == null || fg.recipe!.isEmpty) {
      throw Exception(
          "Invalid Finished Good or missing recipe. Cannot manufacture.");
    }

    await _isar.writeTxn(() async {
      // 1. Add Finished Goods to Stock
      final fgMovement = StockMovement()
        ..inventoryItemId = finishedGoodId
        ..quantityChange = quantityProduced
        ..reason = reason
        ..date = DateTime.now();
      await _isar.stockMovements.put(fgMovement);

      // 2. Deduct Raw Materials based on the recipe
      for (final component in fg.recipe!) {
        if (component.rawMaterialId != null &&
            component.quantity != null &&
            component.quantity! > 0) {
          // Calculate total required and round to nearest integer for stock movement
          final deductionQty = (component.quantity! * quantityProduced).round();

          final rmMovement = StockMovement()
            ..inventoryItemId = component.rawMaterialId!
            ..quantityChange = -deductionQty
            ..reason = 'Used in manufacturing ($reason) for ${fg.name}'
            ..date = DateTime.now();

          await _isar.stockMovements.put(rmMovement);
        }
      }
    });
  }

  Future<void> assignVendorToMovement(int movementId, int vendorId) async {
    await _isar.writeTxn(() async {
      final m = await _isar.stockMovements.get(movementId);
      if (m != null) {
        m.vendorId = vendorId;
        await _isar.stockMovements.put(m);
      }
    });
  }

  Future<void> addItem({
    required String name,
    required String category,
    required String sku,
    required String unit,
    required String itemType,
    required int minStockLevel,
    required double costPrice,
    String? imagePath,
    List<RecipeComponent>? recipe,
  }) async {
    final existingName = await _isar.inventoryItems
        .filter()
        .nameEqualTo(name, caseSensitive: false)
        .findFirst();

    if (existingName != null)
      throw Exception('An item with the name "$name" already exists.');

    final existingSku = await _isar.inventoryItems
        .filter()
        .skuEqualTo(sku, caseSensitive: false)
        .findFirst();

    if (existingSku != null)
      throw Exception(
          'An item with the SKU "$sku" already exists in the warehouse.');

    final newItem = InventoryItem()
      ..name = name
      ..category = category
      ..sku = sku.toUpperCase()
      ..unit = unit
      ..itemType = itemType
      ..minStockLevel = minStockLevel
      ..costPrice = costPrice
      ..imagePath = imagePath
      ..recipe = recipe;

    await _isar.writeTxn(() async => await _isar.inventoryItems.put(newItem));
  }

  Future<void> updateItem(InventoryItem item) async {
    final existingName = await _isar.inventoryItems
        .filter()
        .nameEqualTo(item.name, caseSensitive: false)
        .findFirst();

    if (existingName != null && existingName.id != item.id) {
      throw Exception(
          'Another item with the name "${item.name}" already exists.');
    }

    final existingSku = await _isar.inventoryItems
        .filter()
        .skuEqualTo(item.sku, caseSensitive: false)
        .findFirst();

    if (existingSku != null && existingSku.id != item.id) {
      throw Exception(
          'Another item with the SKU "${item.sku}" already exists.');
    }

    await _isar.writeTxn(() async => await _isar.inventoryItems.put(item));
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
