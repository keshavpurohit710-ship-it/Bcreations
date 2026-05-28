import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/stock_movement.dart';

class FulfillmentService {
  final Isar _isar;
  FulfillmentService(this._isar);

  /// WORKFLOW: Complete an order and automatically deduct inventory
  Future<void> completeOrder(int orderId) async {
    await _isar.writeTxn(() async {
      // 1. Fetch the Order
      final order = await _isar.orders.get(orderId);
      if (order == null) throw Exception('Order not found');
      if (order.status == 'Completed') return; // Prevent double-deduction

      // 2. Update Order Status
      order.status = 'Completed';
      await _isar.orders.put(order);

      // 3. Fetch Line Items and Deduct Inventory Automatically
      final lineItems =
          await _isar.orderLineItems.filter().orderIdEqualTo(orderId).findAll();

      for (final item in lineItems) {
        if (item.inventoryItemId != null) {
          final movement = StockMovement()
            ..inventoryItemId = item.inventoryItemId
            ..relatedOrderId = order.id
            ..quantityChange =
                -item.quantity // Negative because it's leaving the warehouse
            ..reason = 'Order Fulfillment #${order.id}'
            ..date = DateTime.now();

          await _isar.stockMovements.put(movement);
        }
      }
    });
  }
}
