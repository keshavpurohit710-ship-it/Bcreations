import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/client.dart';

final activeClientsProvider = FutureProvider<List<Client>>((ref) async {
  ref.watch(clientWatcher); // <--- THE HEARTBEAT
  final isar = ref.read(isarProvider);
  return await isar.clients.filter().isArchivedEqualTo(false).findAll();
});

final clientBalanceProvider =
    FutureProvider.family<double, int>((ref, clientId) async {
  ref.watch(orderWatcher); // <--- Re-runs math if an order completes
  ref.watch(txWatcher); // <--- Re-runs math if a payment happens
  final financeService = ref.read(financeServiceProvider);
  return await financeService.getClientOutstandingBalance(clientId);
});
