import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../main.dart';
import '../../models/order.dart';
import '../../models/client.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, List<Order>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<Order>> {
  OrderNotifier() : super([]) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    final orders = await isar.orders.where().sortByDateDesc().findAll();
    state = orders;
  }

  // --- THE BULLETPROOF FINANCE ENGINE ---
  // Calculates exact math strictly from the Orders table (No orphan balances)
  Future<void> _syncClientFinances(int clientId) async {
    final client = await isar.clients.get(clientId);
    if (client == null) return;

    final clientOrders =
        await isar.orders.filter().clientIdEqualTo(clientId).findAll();

    double outstanding = 0.0;
    double overdue = 0.0;
    final now = DateTime.now();

    for (var o in clientOrders) {
      if (!o.isPaid && o.orderStatus != 'Cancelled') {
        outstanding += o.totalAmount;
        if (o.paymentDueDate != null && o.paymentDueDate!.isBefore(now)) {
          overdue += o.totalAmount;
        }
      }
    }

    client.outstandingAmount = outstanding;
    client.overdueAmount = overdue;
    await isar.clients.put(client);
  }

  // Helper to parse payment terms into an exact due date
  DateTime _calculateDueDate(String? terms) {
    final now = DateTime.now();
    if (terms == '15 Days') return now.add(const Duration(days: 15));
    if (terms == '30 Days') return now.add(const Duration(days: 30));
    if (terms == 'Net-60') return now.add(const Duration(days: 60));
    return now; // Default: Immediate Payment
  }

  // ==========================================
  Future<void> addOrder(
      int clientId, String clientName, double amount, List<String> customStages,
      {String? newClientType, DateTime? expectedCompletionDate}) async {
    await isar.writeTxn(() async {
      final client = await isar.clients.get(clientId);
      if (client == null) return;

      final newOrder = Order()
        ..orderNumber =
            '#ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}'
        ..clientId = clientId
        ..clientName = clientName
        ..totalAmount = amount
        ..date = DateTime.now()
        ..expectedCompletionDate = expectedCompletionDate
        ..paymentDueDate =
            _calculateDueDate(client.paymentTerms) // Assigns due date
        ..stages = customStages
        ..currentStageIndex = 0
        ..orderStatus = 'Active'
        ..isPaid = false;

      await isar.orders.put(newOrder);

      client.totalOrders += 1;
      client.openOrders += 1;
      client.lastOrderDate = DateTime.now();
      client.lastOrderAmount = amount;

      final orderLog = InteractionRecord()
        ..timestamp = DateTime.now()
        ..interactionType = 'Order Created'
        ..description = 'Order ${newOrder.orderNumber} created for ₹$amount';
      client.interactionHistory = [...client.interactionHistory, orderLog];

      if (client.relationshipStage == 'lead') {
        client.relationshipStage = 'active_client';
        if (newClientType != null) client.clientType = newClientType;
        final conversionLog = InteractionRecord()
          ..timestamp = DateTime.now()
          ..interactionType = 'System'
          ..description = 'Converted to Active Client (First Order)';
        client.interactionHistory = [
          ...client.interactionHistory,
          conversionLog
        ];
      }
      await isar.clients.put(client);

      await _syncClientFinances(clientId); // Sync math
    });
    await loadOrders();
  }

  // ==========================================
  Future<void> advanceStage(int id) async {
    await isar.writeTxn(() async {
      final order = await isar.orders.get(id);
      if (order != null &&
          order.stages != null &&
          order.orderStatus == 'Active') {
        if (order.currentStageIndex < order.stages!.length - 1) {
          order.currentStageIndex += 1;
          if (order.currentStageIndex == order.stages!.length - 1)
            order.orderStatus = 'Completed';
          await isar.orders.put(order);

          if (order.clientId != null) {
            final client = await isar.clients.get(order.clientId!);
            if (client != null) {
              if (order.orderStatus == 'Completed') {
                if (client.openOrders > 0) client.openOrders -= 1;
                client.lastCompletedOrderDate = DateTime.now();
              }
              final stageLog = InteractionRecord()
                ..timestamp = DateTime.now()
                ..interactionType = 'Order Update'
                ..description =
                    'Order ${order.orderNumber} advanced to: ${order.stages![order.currentStageIndex]}';
              client.interactionHistory = [
                ...client.interactionHistory,
                stageLog
              ];
              await isar.clients.put(client);
            }
          }
        }
      }
    });
    await loadOrders();
  }

  // ==========================================
  Future<void> markOrderPaid(int id) async {
    await isar.writeTxn(() async {
      final order = await isar.orders.get(id);
      if (order != null && !order.isPaid) {
        order.isPaid = true;
        await isar.orders.put(order);

        if (order.clientId != null) {
          final client = await isar.clients.get(order.clientId!);
          if (client != null) {
            client.totalRevenue +=
                order.totalAmount; // Revenue only increases upon ACTUAL payment
            client.lastPaymentDate = DateTime.now(); // Stamps last payment date

            final payLog = InteractionRecord()
              ..timestamp = DateTime.now()
              ..interactionType = 'Payment'
              ..description =
                  'Payment of ₹${order.totalAmount} received for ${order.orderNumber}';
            client.interactionHistory = [...client.interactionHistory, payLog];
            await isar.clients.put(client);

            await _syncClientFinances(
                order.clientId!); // Recalculate outstanding/overdue
          }
        }
      }
    });
    await loadOrders();
  }

  // ==========================================
  Future<void> cancelOrder(int id) async {
    await isar.writeTxn(() async {
      final order = await isar.orders.get(id);
      if (order != null && order.orderStatus != 'Cancelled') {
        bool wasActive = order.orderStatus == 'Active';
        order.orderStatus = 'Cancelled';
        await isar.orders.put(order);

        if (order.clientId != null) {
          final client = await isar.clients.get(order.clientId!);
          if (client != null) {
            client.totalOrders -= 1;
            if (wasActive && client.openOrders > 0) client.openOrders -= 1;
            if (order.isPaid) client.totalRevenue -= order.totalAmount;

            final cancelLog = InteractionRecord()
              ..timestamp = DateTime.now()
              ..interactionType = 'Order Cancelled'
              ..description = 'Order ${order.orderNumber} cancelled.';
            client.interactionHistory = [
              ...client.interactionHistory,
              cancelLog
            ];
            await isar.clients.put(client);

            await _syncClientFinances(
                order.clientId!); // Strip from outstanding math
          }
        }
      }
    });
    await loadOrders();
  }
}
