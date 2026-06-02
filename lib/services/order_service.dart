import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/client.dart';
import '../domain/models/inventory_item.dart';
import '../domain/models/stock_movement.dart';

class OrderService {
  final Isar _isar;
  OrderService(this._isar);

  // --- THE FIX: Added optional notes parameter ---
  Future<void> createOrder(int clientId, List<Map<String, dynamic>> itemsData,
      {String? notes}) async {
    final order = Order()
      ..clientId = clientId
      ..date = DateTime.now()
      ..status = 'Draft'
      ..notes = notes; // <-- Permanently attach notes to the record

    await _isar.writeTxn(() async {
      await _isar.orders.put(order);

      for (var itemData in itemsData) {
        final invId = itemData['inventoryItemId'] as int;

        // Fetch the master item to snapshot its current unit
        final invItem = await _isar.inventoryItems.get(invId);

        final lineItem = OrderLineItem()
          ..orderId = order.id
          ..inventoryItemId = invId
          ..quantity = itemData['quantity'] as int
          ..pricePerUnit = (itemData['pricePerUnit'] as num).toDouble()
          ..unit = invItem?.unit ?? 'units'; // Snapshot saved permanently

        await _isar.orderLineItems.put(lineItem);
      }

      // Auto-promote Lead to Client
      final client = await _isar.clients.get(clientId);
      if (client != null && client.type == 'Lead') {
        client.type = 'Client';
        await _isar.clients.put(client);
      }
    });
  }

  Future<void> confirmOrder(int orderId) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order != null) {
        order.status = 'Confirmed';
        await _isar.orders.put(order);
      }
    });
  }

  Future<void> dispatchOrder(int orderId, {double deliveryCost = 0.0}) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order != null) {
        order.status = 'Dispatched';
        order.deliveryCost = deliveryCost; // Save the logistics cost
        await _isar.orders.put(order);
      }
    });
  }

  Future<void> deliverOrder(int orderId) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order != null) {
        // 1. Update order status
        order.status = 'Delivered';
        await _isar.orders.put(order);

        // 2. Fetch all line items associated with this order
        final lineItems = await _isar.orderLineItems
            .filter()
            .orderIdEqualTo(orderId)
            .findAll();

        // 3. Create negative stock movements for fulfillment deduction
        for (final item in lineItems) {
          final movement = StockMovement()
            ..inventoryItemId = item.inventoryItemId
            ..quantityChange = -item.quantity // Negative to deduct stock
            ..reason = 'Order Delivered (#$orderId)'
            ..date = DateTime.now();

          await _isar.stockMovements.put(movement);
        }
      }
    });
  }

  Future<void> cancelOrder(int orderId) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order != null) {
        order.status = 'Cancelled';
        await _isar.orders.put(order);
      }
    });
  }

  // ==========================================
  // THE FIX: Order Editing Support
  // ==========================================
  Future<void> updateOrder(int orderId, List<Map<String, dynamic>> itemsData,
      {String? notes, double? deliveryCost}) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);

      if (order == null) throw Exception('Order not found.');
      if (order.status != 'Draft' && order.status != 'Confirmed') {
        throw Exception('Only Draft or Confirmed orders can be edited.');
      }

      // 1. Update core order details
      order.notes = notes;
      if (deliveryCost != null) order.deliveryCost = deliveryCost;
      await _isar.orders.put(order);

      // 2. Nuke the old line items to prevent orphaned records
      await _isar.orderLineItems.filter().orderIdEqualTo(orderId).deleteAll();

      // 3. Insert the newly modified line items
      for (var itemData in itemsData) {
        final invId = itemData['inventoryItemId'] as int;
        final invItem = await _isar.inventoryItems.get(invId);

        final lineItem = OrderLineItem()
          ..orderId = order.id
          ..inventoryItemId = invId
          ..quantity = itemData['quantity'] as int
          ..pricePerUnit = (itemData['pricePerUnit'] as num).toDouble()
          ..unit = invItem?.unit ?? 'units';

        await _isar.orderLineItems.put(lineItem);
      }
    });
  }
}
