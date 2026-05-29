import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';

class OrderService {
  final Isar _isar;
  OrderService(this._isar);

  /// STAGE 1: Safely creates a new order
  Future<void> createOrder(
      int clientId, String notes, List<OrderLineItem> items) async {
    final newOrder = Order()
      ..clientId = clientId
      ..status = 'Draft'
      ..date = DateTime.now()
      ..notes = notes;

    await _isar.writeTxn(() async {
      await _isar.orders.put(newOrder);
      for (var item in items) {
        item.orderId = newOrder.id;
        await _isar.orderLineItems.put(item);
      }
    });
  }

  /// STAGE 2: Confirm Order (Client approved it)
  Future<void> confirmOrder(int orderId) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order != null && order.status == 'Draft') {
        order.status = 'Confirmed';
        order.confirmedAt = DateTime.now();
        await _isar.orders.put(order);
      }
    });
  }

  /// STAGE 3: Dispatch Order (Leaves the warehouse)
  Future<void> dispatchOrder(int orderId) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order != null && order.status == 'Confirmed') {
        order.status = 'Dispatched';
        order.dispatchedAt = DateTime.now();
        await _isar.orders.put(order);
      }
    });
  }

  /// ACTION: Safely cancel an order
  Future<void> cancelOrder(int orderId) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order == null) throw Exception('Order not found');

      // Protect the Single Source of Truth
      if (order.status == 'Delivered' || order.status == 'Dispatched') {
        throw Exception(
            'Cannot cancel an order that has already shipped. Process a return instead.');
      }

      order.status = 'Cancelled';
      await _isar.orders.put(order);
    });
  }
}
