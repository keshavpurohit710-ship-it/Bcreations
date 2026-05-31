import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/client.dart';
import '../domain/models/inventory_item.dart'; // <--- THE FIX: Added this import!

class OrderService {
  final Isar _isar;
  OrderService(this._isar);

  Future<void> createOrder(
      int clientId, List<Map<String, dynamic>> itemsData) async {
    final order = Order()
      ..clientId = clientId
      ..date = DateTime.now()
      ..status = 'Draft';

    await _isar.writeTxn(() async {
      await _isar.orders.put(order);

      for (var itemData in itemsData) {
        final invId = itemData['inventoryItemId'] as int;

        // --- THE FIX: Fetch the master item to snapshot its current unit ---
        final invItem = await _isar.inventoryItems.get(invId);

        final lineItem = OrderLineItem()
          ..orderId = order.id
          ..inventoryItemId = invId
          ..quantity = itemData['quantity'] as int
          ..pricePerUnit = (itemData['pricePerUnit'] as num).toDouble()
          ..unit = invItem?.unit ?? 'units'; // <-- Snapshot saved permanently!

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

  // --- UPGRADED DISPATCH METHOD (Replaces the old one) ---
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

  // --- NEW DELIVER METHOD ---
  Future<void> deliverOrder(int orderId) async {
    await _isar.writeTxn(() async {
      final order = await _isar.orders.get(orderId);
      if (order != null) {
        order.status = 'Delivered';
        await _isar.orders.put(order);
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
}
