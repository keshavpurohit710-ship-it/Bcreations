import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/transaction.dart';

class FinanceService {
  final Isar _isar;
  FinanceService(this._isar);

  /// DERIVED DATA: Calculates exactly what a client owes right now
  Future<double> getClientOutstandingBalance(int clientId) async {
    final deliveredOrders = await _isar.orders
        .filter()
        .clientIdEqualTo(clientId)
        .statusEqualTo('Delivered')
        .findAll();

    double totalBilled = 0.0;

    // THE FIX: Check if they have orders to avoid empty queries
    if (deliveredOrders.isNotEmpty) {
      // 1. Extract all order IDs into a simple list
      final orderIds = deliveredOrders.map((o) => o.id).toList();

      // 2. Perform ONE batch query for all line items matching those IDs
      final allItems = await _isar.orderLineItems
          .filter()
          .anyOf(orderIds, (q, id) => q.orderIdEqualTo(id))
          .findAll();

      // 3. Do the math in RAM
      for (final item in allItems) {
        totalBilled += (item.quantity * item.pricePerUnit);
      }
    }

    // Sum all payments made by this client
    final payments = await _isar.transactions
        .filter()
        .clientIdEqualTo(clientId)
        .typeEqualTo('Income')
        .findAll();

    double totalPaid = 0.0;
    for (final payment in payments) {
      totalPaid += payment.amount;
    }

    return totalBilled - totalPaid;
  }

  /// ACTION: Safely record a new payment
  Future<void> recordPayment(int clientId, double amount, String method) async {
    final tx = Transaction()
      ..clientId = clientId
      ..amount = amount
      ..type = 'Income'
      ..paymentMethod = method
      ..date = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.transactions.put(tx);
    });
  }
}
