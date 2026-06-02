import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/client.dart'; // Needed for cross-field search join

// --- THE FIX: StateProvider for Finance Search ---
final financeSearchQueryProvider = StateProvider<String>((ref) => '');

// --- THE FIX: Removed the 50-item cap so the entire ledger is visible ---
final recentTransactionsProvider =
    FutureProvider<List<Transaction>>((ref) async {
  ref.watch(txWatcher);
  final isar = ref.read(isarProvider);
  final query = ref.watch(financeSearchQueryProvider).toLowerCase();

  // Fetch ALL transactions chronologically without any .limit() or .take()
  var transactions = await isar.transactions.where().sortByDateDesc().findAll();

  // In-Memory Multi-Field Search (Preserved from Request 4)
  if (query.isNotEmpty) {
    // Resolve associated Client/Vendor profiles
    final clients = await isar.clients.where().findAll();
    final clientMap = {for (var c in clients) c.id: c};

    transactions = transactions.where((tx) {
      final clientName =
          (tx.clientId != null ? (clientMap[tx.clientId]?.name ?? '') : '')
              .toLowerCase();
      final bizName = (tx.clientId != null
              ? (clientMap[tx.clientId]?.businessName ?? '')
              : '')
          .toLowerCase();
      final amountStr = tx.amount.toString();
      final amountFixed = tx.amount.toStringAsFixed(0);
      final method = (tx.paymentMethod ?? '').toLowerCase();

      return clientName.contains(query) ||
          bizName.contains(query) ||
          amountStr.contains(query) ||
          amountFixed.contains(query) ||
          method.contains(query);
    }).toList();
  }

  // Return the full, uncapped list (filtered if a search is active)
  return transactions;
});
// Add to lib/features/finance/finance_provider.dart
final orderPaymentsProvider =
    FutureProvider.family<List<Transaction>, int>((ref, orderId) async {
  ref.watch(txWatcher); // Auto-refresh if a new payment is made
  final isar = ref.read(isarProvider);

  return await isar.transactions
      .filter()
      .relatedOrderIdEqualTo(orderId)
      .typeEqualTo('Income')
      .sortByDateDesc() // Show most recent payments at the top
      .findAll();
});
