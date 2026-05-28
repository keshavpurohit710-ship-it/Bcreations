import 'package:isar/isar.dart';
part 'order_line_item.g.dart';

@collection
class OrderLineItem {
  Id id = Isar.autoIncrement;

  @Index()
  int? orderId; // Links back to the Order

  @Index()
  int? inventoryItemId; // Links to the specific raw material/product

  int quantity = 1;
  double pricePerUnit =
      0.0; // The price locked in at the time of this specific sale
}
