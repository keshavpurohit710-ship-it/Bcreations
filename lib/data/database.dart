import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

export 'tables.dart';

part 'database.g.dart';

const settingsRowId = 'settings';

@DriftDatabase(tables: [
  Settings,
  BulkRules,
  Parties,
  Products,
  RecipeLines,
  StockMoves,
  ProductionRuns,
  Orders,
  OrderLines,
  OrderPhotos,
  Payments,
  PaymentAllocations,
  Expenses,
  OwnerWithdrawals,
])
class AppDatabase extends _$AppDatabase {
  /// Pass an executor in tests (e.g. NativeDatabase.memory()).
  AppDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: 'bcreations'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await into(settings).insert(SettingsCompanion.insert(id: const Value(settingsRowId)));
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<Setting> getSettings() => (select(settings)..where((s) => s.id.equals(settingsRowId))).getSingle();
}
