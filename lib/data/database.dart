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
  StockChecks,
])
class AppDatabase extends _$AppDatabase {
  /// Pass an executor in tests (e.g. NativeDatabase.memory()).
  AppDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: 'bcreations'));

  /// v1: release-1 tables. v2: stock checks.
  /// Every change needs a step in onUpgrade so installed apps keep their data.
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await into(settings).insert(SettingsCompanion.insert(id: const Value(settingsRowId)));
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) await m.createTable(stockChecks);
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<Setting> getSettings() => (select(settings)..where((s) => s.id.equals(settingsRowId))).getSingle();
}
