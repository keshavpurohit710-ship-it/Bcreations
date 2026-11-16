// Whole-database operations: wipe, and fill with sample data.

import 'package:drift/drift.dart';

import 'database.dart';
import 'demo_seed.dart';

/// Deletes every row and puts back a fresh settings row.
/// [keep] carries over chosen settings (e.g. language) into the fresh row.
Future<void> resetDatabase(AppDatabase db, {SettingsCompanion keep = const SettingsCompanion()}) =>
    db.transaction(() async {
      for (final table in db.allTables.toList().reversed) {
        await db.delete(table).go();
      }
      await db.into(db.settings).insert(keep.copyWith(id: const Value(settingsRowId)));
    });

/// Replaces everything with two months of sample activity.
Future<void> loadDemo(AppDatabase db, {required String languageCode}) async {
  await resetDatabase(db, keep: SettingsCompanion(languageCode: Value(languageCode)));
  await seedDemoData(db, today: DateTime.now());
}
