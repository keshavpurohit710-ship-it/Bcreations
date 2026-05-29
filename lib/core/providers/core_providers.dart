import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../main.dart';
import '../../services/inventory_service.dart';
import '../../services/finance_service.dart';
import '../../services/fulfillment_service.dart';
import '../../services/order_service.dart';
import '../../services/crm_service.dart';
import '../../services/notification_service.dart';
import '../../services/backup_service.dart';

import '../../domain/models/client.dart';
import '../../domain/models/order.dart';
import '../../domain/models/stock_movement.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/inventory_item.dart'; // <--- NEW IMPORT
import '../../repositories/client_repository.dart';
import '../../repositories/order_repository.dart';

// THE FIX: No more global variable reference.
// We define a strict contract that MUST be fulfilled at app startup.
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError(
      'CRITICAL: isarProvider was not initialized! Make sure to override it in ProviderScope.');
});

// ... Keep your other service providers (financeServiceProvider, etc.) exactly as they are ...

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
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(
      ref.read(isarProvider), ref.read(financeServiceProvider));
});
// 1. Injects Isar into the Client Repository
final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  final isar = ref.read(isarProvider);
  return ClientRepository(isar);
});

// 2. Injects Isar into the Order Repository
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final isar = ref.read(isarProvider);
  return OrderRepository(isar);
});
// ... (your existing providers) ...

// Add this to the very bottom:
final backupServiceProvider = Provider<BackupService>((ref) {
  final isar = ref.read(isarProvider);
  return BackupService(isar);
});
