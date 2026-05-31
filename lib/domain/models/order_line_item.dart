import 'package:isar/isar.dart';
part 'order_line_item.g.dart';

@collection
class OrderLineItem {
  Id id = Isar.autoIncrement;
  late int orderId;
  late int inventoryItemId;
  late int quantity;
  late double pricePerUnit;

  // --- THE FIX: Denormalize the unit to protect historical invoices ---
  String? unit;
}
