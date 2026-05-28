import 'package:isar/isar.dart';
part 'stock_movement.g.dart';

@collection
class StockMovement {
  Id id = Isar.autoIncrement;

  @Index()
  int? inventoryItemId;

  @Index()
  int? relatedOrderId; // If this stock moved because of a specific order

  int quantityChange =
      0; // Positive (+) for restock/purchase, Negative (-) for sale/use

  String? reason; // e.g., 'Restock', 'Order Fulfillment', 'Damage'
  DateTime? date;
}
