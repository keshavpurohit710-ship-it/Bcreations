import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/client.dart';
import '../../domain/models/order.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/stock_movement.dart'; // <-- 1. Needed for Supply History

final crmSearchQueryProvider = StateProvider<String>((ref) => '');

// ==========================================
// CLIENTS & LEADS
// ==========================================
final activeClientsProvider = FutureProvider<List<Client>>((ref) async {
  ref.watch(clientWatcher);
  final isar = ref.read(isarProvider);
  final query = ref.watch(crmSearchQueryProvider).toLowerCase();

  final allActiveRecords =
      await isar.clients.filter().isArchivedEqualTo(false).findAll();
  final clients = allActiveRecords.where((c) => c.type != 'Vendor').toList();

  if (query.isEmpty) return clients;

  return clients.where((c) {
    final name = c.name?.toLowerCase() ?? '';
    final biz = c.businessName?.toLowerCase() ?? '';
    return name.contains(query) || biz.contains(query);
  }).toList();
});
// --- THE FIX: Live tracking for single profiles ---
final singleClientProvider =
    FutureProvider.family<Client?, int>((ref, clientId) async {
  ref.watch(clientWatcher); // Listens to Isar database changes
  final isar = ref.read(isarProvider);
  return await isar.clients.get(clientId);
});

// ==========================================
// VENDORS & SUPPLIERS
// ==========================================
final activeVendorsProvider = FutureProvider<List<Client>>((ref) async {
  ref.watch(clientWatcher);
  final isar = ref.read(isarProvider);
  final query =
      ref.watch(crmSearchQueryProvider).toLowerCase(); // Watch Search Bar!

  final allActiveVendors = await isar.clients
      .filter()
      .isArchivedEqualTo(false)
      .typeEqualTo('Vendor')
      .findAll();

  if (query.isEmpty) return allActiveVendors;

  return allActiveVendors.where((v) {
    final name = v.name?.toLowerCase() ?? '';
    final biz = v.businessName?.toLowerCase() ?? '';
    return name.contains(query) || biz.contains(query);
  }).toList();
});

// ==========================================
// HISTORY & LEDGERS
// ==========================================
final clientBalanceProvider =
    FutureProvider.family<double, int>((ref, clientId) async {
  ref.watch(orderWatcher);
  ref.watch(txWatcher);
  return await ref
      .read(financeServiceProvider)
      .getClientOutstandingBalance(clientId);
});

final clientOrdersProvider =
    FutureProvider.family<List<Order>, int>((ref, clientId) async {
  ref.watch(orderWatcher);
  final isar = ref.read(isarProvider);
  return await isar.orders
      .filter()
      .clientIdEqualTo(clientId)
      .sortByDateDesc()
      .findAll();
});

final clientTransactionsProvider =
    FutureProvider.family<List<Transaction>, int>((ref, clientId) async {
  ref.watch(txWatcher);
  final isar = ref.read(isarProvider);
  return await isar.transactions
      .filter()
      .clientIdEqualTo(clientId)
      .sortByDateDesc()
      .findAll();
});

// --- NEW: VENDOR SUPPLY HISTORY ---
final vendorStockMovementsProvider =
    FutureProvider.family<List<StockMovement>, int>((ref, vendorId) async {
  ref.watch(stockWatcher);
  final isar = ref.read(isarProvider);

  final movements =
      await isar.stockMovements.filter().vendorIdEqualTo(vendorId).findAll();
  // Sort in-memory safely to ensure newest shipments are at the top
  movements.sort(
      (a, b) => (b.date ?? DateTime.now()).compareTo(a.date ?? DateTime.now()));
  return movements;
});
