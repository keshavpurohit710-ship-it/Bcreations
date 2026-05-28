import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';

class OrderService {
  final Isar _isar;
  OrderService(this._isar);

  /// ACTION: Safely creates a new order and attaches all its line items
  Future<void> createOrder(
      int clientId, String notes, List<OrderLineItem> items) async {
    final newOrder = Order()
      ..clientId = clientId
      ..status = 'Draft'
      ..date = DateTime.now()
      ..notes = notes;

    await _isar.writeTxn(() async {
      // 1. Save the order first so Isar generates an ID for it
      await _isar.orders.put(newOrder);

      // 2. Assign that new ID to every line item, then save them
      for (var item in items) {
        item.orderId = newOrder.id;
        await _isar.orderLineItems.put(item);
      }
    });
  }

  /// ACTION: Safely cancel an order (with business logic protection)
  Future<void> cancelOrder(int orderId) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order == null) throw Exception('Order not found');

      // Protect the Single Source of Truth:
      // If it's already completed, inventory was deducted. We can't just cancel it without a refund flow!
      if (order.status == 'Completed') {
        throw Exception(
            'Cannot cancel an order that is already completed. Please issue a return instead.');
      }

      order.status = 'Cancelled';
      await _isar.orders.put(order);
    });
  }
}
