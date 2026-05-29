import 'package:isar/isar.dart';
import '../domain/models/client.dart';
import '../domain/models/order.dart';
import '../domain/models/transaction.dart';
import '../domain/models/order_line_item.dart'; // <-- 1. Needed to clean up ghost items

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

  // --- THE FIX: Smart Deletion Logic ---
  Future<void> deleteClient(int id) async {
    // 1. Fetch all orders for this specific client
    final clientOrders =
        await _isar.orders.filter().clientIdEqualTo(id).findAll();

    // 2. Check if ANY order is NOT cancelled (meaning it's active or delivered)
    final hasActiveOrders =
        clientOrders.any((order) => order.status != 'Cancelled');

    // 3. Check for any financial payment history
    final hasTxs =
        await _isar.transactions.filter().clientIdEqualTo(id).isNotEmpty();

    // 4. Block deletion only if active orders or money is involved
    if (hasActiveOrders || hasTxs) {
      throw Exception(
          'Cannot delete this client. They have active/delivered orders or payment history. Please edit the profile instead.');
    }

    await _isar.writeTxn(() async {
      // 5. CASCADING DELETE: Sweep away the dead cancelled orders and their items
      for (final order in clientOrders) {
        final lineItems = await _isar.orderLineItems
            .filter()
            .orderIdEqualTo(order.id)
            .findAll();
        final lineItemIds = lineItems.map((item) => item.id).toList();
        await _isar.orderLineItems.deleteAll(lineItemIds); // Delete the items
      }

      final orderIds = clientOrders.map((order) => order.id).toList();
      await _isar.orders.deleteAll(orderIds); // Delete the cancelled orders

      // 6. Finally, safely delete the client
      await _isar.clients.delete(id);
    });
  }
}
