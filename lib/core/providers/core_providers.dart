import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../main.dart';
import '../../services/inventory_service.dart';
import '../../services/finance_service.dart';
import '../../services/fulfillment_service.dart';
import '../../services/order_service.dart';
import '../../services/crm_service.dart';

import '../../domain/models/client.dart';
import '../../domain/models/order.dart';
import '../../domain/models/stock_movement.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/inventory_item.dart'; // <--- NEW IMPORT

final isarProvider = Provider<Isar>((ref) {
  return isar;
});

final inventoryServiceProvider = Provider<InventoryService>((ref) {
  return InventoryService(ref.read(isarProvider));
});

final financeServiceProvider = Provider<FinanceService>((ref) {
  return FinanceService(ref.read(isarProvider));
});

final fulfillmentServiceProvider = Provider<FulfillmentService>((ref) {
  return FulfillmentService(ref.read(isarProvider));
});

final orderServiceProvider = Provider<OrderService>((ref) {
  return OrderService(ref.read(isarProvider));
});

final clientWatcher = StreamProvider(
    (ref) => ref.read(isarProvider).clients.watchLazy(fireImmediately: true));
final orderWatcher = StreamProvider(
    (ref) => ref.read(isarProvider).orders.watchLazy(fireImmediately: true));
final stockWatcher = StreamProvider((ref) =>
    ref.read(isarProvider).stockMovements.watchLazy(fireImmediately: true));
final txWatcher = StreamProvider((ref) =>
    ref.read(isarProvider).transactions.watchLazy(fireImmediately: true));
// --- THE FIX: We were missing this heartbeat! ---
final inventoryItemWatcher = StreamProvider((ref) =>
    ref.read(isarProvider).inventoryItems.watchLazy(fireImmediately: true));
final crmServiceProvider = Provider<CrmService>((ref) {
  return CrmService(ref.read(isarProvider));
});
