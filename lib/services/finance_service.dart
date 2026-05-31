import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/transaction.dart';
import '../domain/models/client.dart';

class FinanceService {
  final Isar _isar;
  FinanceService(this._isar);

  Future<double> getClientOutstandingBalance(int clientId) async {
    final chargeableOrders = await _isar.orders
        .filter()
        .clientIdEqualTo(clientId)
        .group((q) => q.statusEqualTo('Delivered').or().statusEqualTo('Paid'))
        .findAll();

    double totalBilled = 0.0;
    if (chargeableOrders.isNotEmpty) {
      for (final order in chargeableOrders) {
        // --- THE FIX: Sanitize NaN for old orders ---
        totalBilled += (order.deliveryCost.isNaN ? 0.0 : order.deliveryCost);
      }
      final orderIds = chargeableOrders.map((o) => o.id).toList();
      final allItems = await _isar.orderLineItems
          .filter()
          .anyOf(orderIds, (q, id) => q.orderIdEqualTo(id))
          .findAll();
      for (final item in allItems) {
        totalBilled += (item.quantity * item.pricePerUnit);
      }
    }

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

  Future<double> getGlobalOutstandingBalance() async {
    final clients = await _isar.clients.where().findAll();
    double globalDues = 0.0;
    for (final client in clients) {
      if (client.type == 'Vendor') continue;
      final balance = await getClientOutstandingBalance(client.id);
      if (balance > 0) globalDues += balance;
    }
    return globalDues;
  }

  Future<void> recordPayment(int clientId, double amount, String method,
      {int? orderId}) async {
    if (orderId != null && orderId != -1) {
      final order = await _isar.orders.get(orderId);
      double deliveryCost = order?.deliveryCost ?? 0.0;
      if (deliveryCost.isNaN) deliveryCost = 0.0; // --- SANITIZE ---

      final items =
          await _isar.orderLineItems.filter().orderIdEqualTo(orderId).findAll();
      double totalValue = items.fold(
          0.0, (sum, item) => sum + (item.quantity * item.pricePerUnit));
      totalValue += deliveryCost;

      final pastPayments = await _isar.transactions
          .filter()
          .relatedOrderIdEqualTo(orderId)
          .findAll();
      double pastPaid = pastPayments.fold(0.0, (sum, p) => sum + p.amount);

      double balance = totalValue - pastPaid;

      if (double.parse(amount.toStringAsFixed(2)) >
          double.parse(balance.toStringAsFixed(2))) {
        throw Exception(
            'Payment (₹$amount) exceeds this order\'s balance (₹$balance).\n\nIf you are paying for multiple orders, please select "Pay All Unpaid Orders" from the dropdown.');
      }
    }

    final tx = Transaction()
      ..clientId = clientId
      ..amount = amount
      ..type = 'Income'
      ..paymentMethod = method
      ..relatedOrderId = orderId
      ..date = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.transactions.put(tx);

      if (orderId != null && orderId != -1) {
        final order = await _isar.orders.get(orderId);
        if (order != null && order.status == 'Delivered') {
          final items = await _isar.orderLineItems
              .filter()
              .orderIdEqualTo(orderId)
              .findAll();
          double totalValue = items.fold(
              0.0, (sum, item) => sum + (item.quantity * item.pricePerUnit));

          double deliveryCost = order.deliveryCost;
          if (deliveryCost.isNaN) deliveryCost = 0.0; // --- SANITIZE ---
          totalValue += deliveryCost;

          final payments = await _isar.transactions
              .filter()
              .relatedOrderIdEqualTo(orderId)
              .findAll();
          double totalPaid = payments.fold(0.0, (sum, p) => sum + p.amount);

          if (totalPaid >= totalValue) {
            order.status = 'Paid';
            order.paidAt = DateTime.now();
            await _isar.orders.put(order);
          }
        }
      }
    });
  }

  Future<void> recordExpense(
      double amount, String category, String description) async {
    final tx = Transaction()
      ..amount = amount
      ..type = 'Expense'
      ..paymentMethod = category // <-- Strictly the category now
      ..description = description // <-- Dedicated description field
      ..date = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.transactions.put(tx);
    });
  }

  Future<void> recordBulkPayment(
      int clientId, double totalAmount, String method) async {
    final unpaidOrders = await _isar.orders
        .filter()
        .clientIdEqualTo(clientId)
        .statusEqualTo('Delivered')
        .sortByDate()
        .findAll();
    double remainingAmount = totalAmount;

    await _isar.writeTxn(() async {
      for (final order in unpaidOrders) {
        if (remainingAmount <= 0) break;

        final items = await _isar.orderLineItems
            .filter()
            .orderIdEqualTo(order.id)
            .findAll();
        double orderTotal = items.fold(
            0.0, (sum, item) => sum + (item.quantity * item.pricePerUnit));

        double deliveryCost = order.deliveryCost;
        if (deliveryCost.isNaN) deliveryCost = 0.0; // --- SANITIZE ---
        orderTotal += deliveryCost;

        final pastPayments = await _isar.transactions
            .filter()
            .relatedOrderIdEqualTo(order.id)
            .findAll();
        double orderPaid = pastPayments.fold(0.0, (sum, p) => sum + p.amount);

        double balance = orderTotal - orderPaid;
        if (balance <= 0) continue;

        double paymentToApply =
            remainingAmount >= balance ? balance : remainingAmount;

        final tx = Transaction()
          ..clientId = clientId
          ..amount = paymentToApply
          ..type = 'Income'
          ..paymentMethod = method
          ..relatedOrderId = order.id
          ..date = DateTime.now();

        await _isar.transactions.put(tx);
        remainingAmount -= paymentToApply;

        if (paymentToApply >= balance) {
          order.status = 'Paid';
          order.paidAt = DateTime.now();
          await _isar.orders.put(order);
        }
      }

      if (remainingAmount > 0) {
        final tx = Transaction()
          ..clientId = clientId
          ..amount = remainingAmount
          ..type = 'Income'
          ..paymentMethod = method
          ..date = DateTime.now();
        await _isar.transactions.put(tx);
      }
    });
  }
}
