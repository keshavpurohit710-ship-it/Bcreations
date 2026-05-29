import 'package:isar/isar.dart';
part 'stock_movement.g.dart';

@collection
class StockMovement {
  Id id = Isar.autoIncrement;

  @Index()
  int? inventoryItemId;

  // --- NEW: Link to the Supplier (Client where type = 'Vendor') ---
  @Index()
  int? vendorId;

  int quantityChange = 0;
  String? reason;
  DateTime? date;

  double? totalCost;
  double? unitCost;
}
