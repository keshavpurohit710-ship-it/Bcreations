import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/transaction.dart';
import '../domain/models/client.dart';

class FinanceService {
  final Isar _isar;
  FinanceService(this._isar);

  Future<double> getClientOutstandingBalance(int clientId) async {
    // 1. Get ALL chargeable orders (both currently unpaid AND previously paid)
    final chargeableOrders = await _isar.orders
        .filter()
        .clientIdEqualTo(clientId)
        .group((q) => q.statusEqualTo('Delivered').or().statusEqualTo('Paid'))
        .findAll();

    double totalBilled = 0.0;

    if (chargeableOrders.isNotEmpty) {
      final orderIds = chargeableOrders.map((o) => o.id).toList();

      final allItems = await _isar.orderLineItems
          .filter()
          .anyOf(orderIds, (q, id) => q.orderIdEqualTo(id))
          .findAll();

      for (final item in allItems) {
        totalBilled += (item.quantity * item.pricePerUnit);
      }

      // Don't forget to add delivery costs to the billed total!
      for (final order in chargeableOrders) {
        final dCost = order.deliveryCost ?? 0.0;
        if (!dCost.isNaN) totalBilled += dCost;
      }
    }

    // 2. Sum ALL payments made by this client
    final payments = await _isar.transactions
        .filter()
        .clientIdEqualTo(clientId)
        .typeEqualTo('Income')
        .findAll();

    double totalPaid = 0.0;
    for (final payment in payments) {
      totalPaid += payment.amount;
    }

    // 3. True lifetime balance
    return totalBilled - totalPaid;
  }

// ==========================================
  // THE FIX: Batch Optimized Global AR Calculation
  // ==========================================
  Future<double> getGlobalOutstandingBalance() async {
    // 1. Fetch all non-vendor clients (DB Call 1)
    final clients =
        await _isar.clients.filter().not().typeEqualTo('Vendor').findAll();
    if (clients.isEmpty) return 0.0;

    final validClientIds = clients.map((c) => c.id).toSet();

    // 2. Fetch all chargeable orders (DB Call 2)
    final chargeableOrders = await _isar.orders
        .filter()
        .group((q) => q.statusEqualTo('Delivered').or().statusEqualTo('Paid'))
        .findAll();

    // 3. Fetch ALL line items (DB Call 3)
    // (Isar fetches 10,000+ items in ~2ms, much faster/safer than looping queries)
    final allItems = await _isar.orderLineItems.where().findAll();

    final orderTotals = <int, double>{};
    for (final item in allItems) {
      orderTotals[item.orderId] = (orderTotals[item.orderId] ?? 0.0) +
          (item.quantity * item.pricePerUnit);
    }

    // 4. Calculate total billed per client in RAM
    final clientBilled = <int, double>{};
    for (final order in chargeableOrders) {
      if (order.clientId == null || !validClientIds.contains(order.clientId))
        continue;

      double total = orderTotals[order.id] ?? 0.0;
      double dCost = order.deliveryCost ?? 0.0;
      if (!dCost.isNaN) total += dCost;

      clientBilled[order.clientId!] =
          (clientBilled[order.clientId!] ?? 0.0) + total;
    }

    // 5. Fetch ALL Income transactions (DB Call 4)
    final payments =
        await _isar.transactions.filter().typeEqualTo('Income').findAll();

    // 6. Calculate total paid per client in RAM
    final clientPaid = <int, double>{};
    for (final tx in payments) {
      if (tx.clientId == null || !validClientIds.contains(tx.clientId))
        continue;
      clientPaid[tx.clientId!] = (clientPaid[tx.clientId!] ?? 0.0) + tx.amount;
    }

    // 7. Calculate final strict positive dues
    double globalDues = 0.0;
    for (final clientId in validClientIds) {
      final billed = clientBilled[clientId] ?? 0.0;
      final paid = clientPaid[clientId] ?? 0.0;
      final balance = billed - paid;

      // Only count clients who actually owe money (ignore overpayments)
      if (balance > 0) {
        globalDues += balance;
      }
    }

    return globalDues;
  }

  // --- THE FIX: Added {DateTime? customDate} parameter ---
  Future<void> recordPayment(int clientId, double amount, String method,
      {int? orderId, DateTime? customDate}) async {
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
      ..date = customDate ?? DateTime.now(); // <-- Use customDate if provided

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

          double deliveryCost = order.deliveryCost ?? 0.0;
          if (deliveryCost.isNaN) deliveryCost = 0.0; // --- SANITIZE ---
          totalValue += deliveryCost;

          final payments = await _isar.transactions
              .filter()
              .relatedOrderIdEqualTo(orderId)
              .findAll();
          double totalPaid = payments.fold(0.0, (sum, p) => sum + p.amount);

          if (totalPaid >= totalValue) {
            order.status = 'Paid';
            order.paidAt =
                customDate ?? DateTime.now(); // <-- Keep order sync'd
            await _isar.orders.put(order);
          }
        }
      }
    });
  }

  // --- THE FIX: Added {DateTime? customDate} parameter ---
  Future<void> recordExpense(double amount, String category, String description,
      {DateTime? customDate}) async {
    final tx = Transaction()
      ..amount = amount
      ..type = 'Expense'
      ..paymentMethod = category
      ..description = description
      ..date = customDate ?? DateTime.now(); // <-- Use customDate if provided

    await _isar.writeTxn(() async {
      await _isar.transactions.put(tx);
    });
  }

  // --- THE FIX: Added {DateTime? customDate} parameter ---
  Future<void> recordBulkPayment(
      int clientId, double totalAmount, String method,
      {DateTime? customDate}) async {
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

        double deliveryCost = order.deliveryCost ?? 0.0;
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
          ..date =
              customDate ?? DateTime.now(); // <-- Use customDate if provided

        await _isar.transactions.put(tx);
        remainingAmount -= paymentToApply;

        if (paymentToApply >= balance) {
          order.status = 'Paid';
          order.paidAt = customDate ?? DateTime.now(); // <-- Keep order sync'd
          await _isar.orders.put(order);
        }
      }

      if (remainingAmount > 0) {
        final tx = Transaction()
          ..clientId = clientId
          ..amount = remainingAmount
          ..type = 'Income'
          ..paymentMethod = method
          ..date =
              customDate ?? DateTime.now(); // <-- Use customDate if provided
        await _isar.transactions.put(tx);
      }
    });
  }
}
