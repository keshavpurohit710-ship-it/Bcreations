import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/client.dart'; // <-- 1. Import the Client model

class OrderRepository {
  final Isar _isar;

  OrderRepository(this._isar);

  Future<List<Order>> getAllOrders() async {
    return await _isar.orders.where().sortByDateDesc().findAll();
  }

  Future<void> saveOrder(Order order) async {
    await _isar.writeTxn(() async {
      // 1. Save the order exactly as before
      await _isar.orders.put(order);

      // 2. THE FIX: Autonomous Lead Promotion
      // If the client attached to this order is still marked as a 'Lead',
      // automatically upgrade them to a 'Client' in the same transaction.
      if (order.clientId != null) {
        final client = await _isar.clients.get(order.clientId!);
        if (client != null && client.type == 'Lead') {
          client.type = 'Client';
          await _isar.clients.put(client);
        }
      }
    });
  }

  Future<Order?> getOrder(int id) async {
    return await _isar.orders.get(id);
  }
}
