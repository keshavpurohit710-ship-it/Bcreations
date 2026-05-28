import 'package:isar/isar.dart';
part 'inventory_item.g.dart';

@collection
class InventoryItem {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  String? name;

  @Index()
  String? category;

  String? sku; // <-- This is the line your app is looking for!
  String? unit; // e.g., 'kg', 'pcs', 'm'
}
