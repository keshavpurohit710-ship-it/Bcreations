import 'package:isar/isar.dart';
part 'inventory_item.g.dart';

@collection
class InventoryItem {
  Id id = Isar.autoIncrement;

  @Index()
  String? sku;

  String? name;
  String? category; // e.g., "Wood", "Metal", "Packaging" (Flexible sub-group)
  String? unit;

  // --- NEW FIELDS ---
  @Index()
  String? itemType; // Strict Classification: 'RawMaterial' or 'FinishedGood'

  int minStockLevel = 5; // Dynamic threshold for alerts

  double costPrice = 0.0; // Baseline cost for valuation
}
