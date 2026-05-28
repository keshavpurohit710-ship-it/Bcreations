import 'package:isar/isar.dart';

part 'inventory_item.g.dart'; // Wait for the red line, we'll fix it in Step 2!

@collection
class InventoryItem {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value) // Indexed for fast searching
  String? name;

  String? category; // 'Raw', 'Unassigned', 'Assigned'
  int quantity = 0;
  String? unit; // e.g., 'm', 'kg', 'pcs', 'units'
  double costPerUnit = 0.0;
}
