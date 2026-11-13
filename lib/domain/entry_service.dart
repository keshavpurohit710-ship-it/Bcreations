// Quick money entries: expenses and money taken for home. Every delete is a
// soft delete that can be undone.

import 'package:drift/drift.dart';

import '../data/database.dart';

const expenseCategories = ['Packaging', 'Courier', 'Travel', 'Phone', 'Rent', 'Electricity', 'Helper', 'Other'];

class EntryService {
  EntryService(this.db);
  final AppDatabase db;

  Future<String> addExpense({
    required String category,
    required int amountPaise,
    required PaymentMethod method,
    required DateTime date,
    String? note,
    String? receiptPath,
  }) async {
    if (amountPaise <= 0) throw ArgumentError('Amount must be more than zero');
    return (await db.into(db.expenses).insertReturning(ExpensesCompanion.insert(
              category: category,
              amountPaise: amountPaise,
              method: method,
              spentOn: date,
              note: Value(note),
              receiptPath: Value(receiptPath),
            )))
        .id;
  }

  Future<void> setExpenseDeleted(String id, bool deleted) => (db.update(db.expenses)..where((e) => e.id.equals(id)))
      .write(ExpensesCompanion(deletedAt: Value(deleted ? DateTime.now() : null), updatedAt: Value(DateTime.now())));

  Future<String> addWithdrawal({
    required int amountPaise,
    required PaymentMethod method,
    required DateTime date,
    String? note,
  }) async {
    if (amountPaise <= 0) throw ArgumentError('Amount must be more than zero');
    return (await db.into(db.ownerWithdrawals).insertReturning(OwnerWithdrawalsCompanion.insert(
              amountPaise: amountPaise,
              method: method,
              takenOn: date,
              note: Value(note),
            )))
        .id;
  }

  Future<void> setWithdrawalDeleted(String id, bool deleted) =>
      (db.update(db.ownerWithdrawals)..where((e) => e.id.equals(id))).write(OwnerWithdrawalsCompanion(
          deletedAt: Value(deleted ? DateTime.now() : null), updatedAt: Value(DateTime.now())));
}
