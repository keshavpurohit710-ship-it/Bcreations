import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/client.dart';
import '../../domain/models/order.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/stock_movement.dart'; // <-- 1. Needed for Supply History

// Fetch a single client/vendor by their ID
final singleClientProvider =
    FutureProvider.family<Client?, int>((ref, id) async {
  // If you have a clientWatcher to auto-refresh, uncomment the next line:
  // ref.watch(clientWatcher);

  final isar = ref.read(isarProvider);
  return await isar.clients.get(id);
});
final clientSearchQueryProvider = StateProvider<String>((ref) => '');
final vendorSearchQueryProvider = StateProvider<String>((ref) => '');
// ==========================================
// CLIENTS & LEADS
// ==========================================
final activeClientsProvider = FutureProvider<List<Client>>((ref) async {
  ref.watch(clientWatcher);
  final isar = ref.read(isarProvider);

  // Watch ONLY the client search query
  final query = ref.watch(clientSearchQueryProvider).toLowerCase();

  var clients = await isar.clients
      .filter()
      .group((q) => q.typeEqualTo('Client').or().typeEqualTo('Lead'))
      .findAll();

  if (query.isNotEmpty) {
    clients = clients.where((c) {
      final name = (c.name ?? '').toLowerCase();
      final biz = (c.businessName ?? '').toLowerCase();
      final phone = (c.phone ?? '').toLowerCase();
      return name.contains(query) ||
          biz.contains(query) ||
          phone.contains(query);
    }).toList();
  }

  return clients;
});

// --- Update Vendor Provider ---
final activeVendorsProvider = FutureProvider<List<Client>>((ref) async {
  ref.watch(clientWatcher);
  final isar = ref.read(isarProvider);

  // Watch ONLY the vendor search query
  final query = ref.watch(vendorSearchQueryProvider).toLowerCase();

  var vendors = await isar.clients.filter().typeEqualTo('Vendor').findAll();

  if (query.isNotEmpty) {
    vendors = vendors.where((v) {
      final name = (v.name ?? '').toLowerCase();
      final biz = (v.businessName ?? '').toLowerCase();
      final phone = (v.phone ?? '').toLowerCase();
      return name.contains(query) ||
          biz.contains(query) ||
          phone.contains(query);
    }).toList();
  }

  return vendors;
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
