import 'package:isar/isar.dart';
part 'inventory_item.g.dart';

// --- THE FIX: Embedded Sub-Collection for Bill of Materials ---
@embedded
class RecipeComponent {
  int? rawMaterialId;
  double? quantity;
}

@collection
class InventoryItem {
  Id id = Isar.autoIncrement;

  @Index()
  String? sku;

  String? name;
  String? category;
  String? unit;

  @Index()
  String? itemType;

  int minStockLevel = 5;

  double costPrice = 0.0;

  String? imagePath;

  // --- THE FIX: Store the manufacturing formula ---
  List<RecipeComponent>? recipe;
}
