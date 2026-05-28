import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/transaction.dart';

class FinanceService {
  final Isar _isar;
  FinanceService(this._isar);

  /// DERIVED DATA: Calculate Outstanding Balance for a Client
  Future<double> getClientOutstandingBalance(int clientId) async {
    // 1. Calculate total billed (Completed Orders only)
    final completedOrders = await _isar.orders
        .filter()
        .clientIdEqualTo(clientId)
        .statusEqualTo('Completed')
        .findAll();

    double totalBilled = 0;
    for (final order in completedOrders) {
      final lineItems = await _isar.orderLineItems
          .filter()
          .orderIdEqualTo(order.id)
          .findAll();

      for (final item in lineItems) {
        totalBilled += (item.pricePerUnit * item.quantity);
      }
    }

    // 2. Calculate total paid
    final payments = await _isar.transactions
        .filter()
        .clientIdEqualTo(clientId)
        .typeEqualTo('Income')
        .findAll();

    double totalPaid = payments.fold(0.0, (sum, tx) => sum + tx.amount);

    // 3. Balance = Billed - Paid
    return totalBilled - totalPaid;
  }

  /// ACTION: Record a client payment safely
  Future<void> recordPayment(int clientId, double amount, String method,
      {int? orderId}) async {
    final transaction = Transaction()
      ..clientId = clientId
      ..amount = amount
      ..type = 'Income'
      ..paymentMethod = method
      ..date = DateTime.now()
      ..relatedOrderId = orderId;

    await _isar.writeTxn(() async {
      await _isar.transactions.put(transaction);
    });
  }
}
