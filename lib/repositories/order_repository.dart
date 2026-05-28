import 'package:isar/isar.dart';
import '../main.dart';
import '../domain/models/order.dart';

class OrderRepository {
  Future<List<Order>> getAllOrders() async {
    return await isar.orders.where().sortByDateDesc().findAll();
  }

  Future<void> saveOrder(Order order) async {
    await isar.writeTxn(() async {
      await isar.orders.put(order);
    });
  }

  Future<Order?> getOrder(int id) async {
    return await isar.orders.get(id);
  }
}
