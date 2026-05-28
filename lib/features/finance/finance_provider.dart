import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../main.dart';
import '../../models/transaction.dart';

final financeProvider =
    StateNotifierProvider<FinanceNotifier, List<Transaction>>((ref) {
  return FinanceNotifier();
});

class FinanceNotifier extends StateNotifier<List<Transaction>> {
  FinanceNotifier() : super([]) {
    loadTransactions();
  }

  // Read: Fetch all transactions, sorted by newest first
  Future<void> loadTransactions() async {
    final txns = await isar.transactions.where().sortByDateDesc().findAll();
    state = txns;
  }

  // Create: Add a new income or expense entry
  Future<void> addTransaction(
      String desc, double amount, String type, String category) async {
    final newTxn = Transaction()
      ..date = DateTime.now()
      ..description = desc
      ..amount = amount
      ..type = type
      ..category = category;

    await isar.writeTxn(() async {
      await isar.transactions.put(newTxn);
    });

    await loadTransactions();
  }
}
