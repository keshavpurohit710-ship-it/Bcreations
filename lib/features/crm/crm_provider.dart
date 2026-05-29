import 'package:isar/isar.dart'; // <-- ADD THIS LINE

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/client.dart';
import '../../domain/models/order.dart';
import '../../domain/models/transaction.dart';
// ... rest of the file

// --- NEW: Search Query State ---
final crmSearchQueryProvider = StateProvider<String>((ref) => '');

final activeClientsProvider = FutureProvider<List<Client>>((ref) async {
  ref.watch(clientWatcher);
  final isar = ref.read(isarProvider);
  final query =
      ref.watch(crmSearchQueryProvider).toLowerCase(); // Watch the search bar!

  final clients = await isar.clients.where().findAll();

  if (query.isEmpty) return clients;

  // In-memory filter for blazing fast search across both name and business
  return clients.where((c) {
    final name = c.name?.toLowerCase() ?? '';
    final biz = c.businessName?.toLowerCase() ?? '';
    return name.contains(query) || biz.contains(query);
  }).toList();
});

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

final activeVendorsProvider = FutureProvider<List<Client>>((ref) async {
  ref.watch(clientWatcher);
  final isar = ref.read(isarProvider);
  return await isar.clients.filter().typeEqualTo('Vendor').findAll();
});
