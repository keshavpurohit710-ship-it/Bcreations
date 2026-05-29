import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/stock_movement.dart';

class FulfillmentService {
  final Isar _isar;
  FulfillmentService(this._isar);

  /// STAGE 4: Deliver Order & Deduct Inventory
  Future<void> deliverOrder(int orderId) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order == null) throw Exception('Order not found');

      if (order.status == 'Delivered') {
        throw Exception('Order is already delivered.');
      }

      // 1. Get all line items for this order
      final items =
          await _isar.orderLineItems.filter().orderIdEqualTo(orderId).findAll();

      // 2. Deduct inventory for each item
      for (final item in items) {
        if (item.inventoryItemId != null) {
          final movement = StockMovement()
            ..inventoryItemId = item.inventoryItemId
            ..quantityChange =
                -(item.quantity) // Negative because it's leaving stock
            ..reason = 'Order #$orderId Delivered'
            ..date = DateTime.now();

          await _isar.stockMovements.put(movement);
        }
      }

      // 3. Mark the order as Delivered and stamp the time
      order.status = 'Delivered';
      order.deliveredAt = DateTime.now();
      await _isar.orders.put(order);
    });
  }
}
