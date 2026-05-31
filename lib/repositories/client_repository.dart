import 'package:isar/isar.dart';
import '../domain/models/client.dart';
import '../domain/models/order.dart';
import '../domain/models/transaction.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/stock_movement.dart'; // <-- 1. Needed for Vendor checks

class ClientRepository {
  final Isar _isar;
  ClientRepository(this._isar);

  Future<Client?> getClient(int id) async => await _isar.clients.get(id);

  Future<void> saveClient(Client client) async {
    await _isar.writeTxn(() async {
      await _isar.clients.put(client);
    });
  }

  Future<void> promoteLeadToClient(int id) async {
    await _isar.writeTxn(() async {
      final client = await _isar.clients.get(id);
      if (client != null && client.type == 'Lead') {
        client.type = 'Client';
        await _isar.clients.put(client);
      }
    });
  }

  Future<void> deleteClient(int id) async {
    final clientOrders =
        await _isar.orders.filter().clientIdEqualTo(id).findAll();
    final hasActiveOrders =
        clientOrders.any((order) => order.status != 'Cancelled');

    final hasTxs =
        await _isar.transactions.filter().clientIdEqualTo(id).isNotEmpty();

    // --- THE FIX: Protect Vendors with supply history ---
    final hasMovements =
        await _isar.stockMovements.filter().vendorIdEqualTo(id).isNotEmpty();

    if (hasActiveOrders || hasTxs || hasMovements) {
      throw Exception(
          'Cannot delete this contact. They have active orders, payment history, or supply history. Please edit the profile instead.');
    }

    await _isar.writeTxn(() async {
      for (final order in clientOrders) {
        final lineItems = await _isar.orderLineItems
            .filter()
            .orderIdEqualTo(order.id)
            .findAll();
        final lineItemIds = lineItems.map((item) => item.id).toList();
        await _isar.orderLineItems.deleteAll(lineItemIds);
      }

      final orderIds = clientOrders.map((order) => order.id).toList();
      await _isar.orders.deleteAll(orderIds);

      await _isar.clients.delete(id);
    });
  }
}
