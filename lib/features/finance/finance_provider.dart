import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/transaction.dart';

final recentTransactionsProvider =
    FutureProvider<List<Transaction>>((ref) async {
  ref.watch(txWatcher); // <--- THE HEARTBEAT
  final isar = ref.read(isarProvider);
  return await isar.transactions.where().sortByDateDesc().limit(50).findAll();
});
