// A plain copy of every table, for the data snapshot. Values are kept as
// stored (dates as numbers, money in paise) so nothing is lost or reformatted.

import '../../data/database.dart';

/// table name -> rows (column -> value)
Future<Map<String, List<Map<String, Object?>>>> exportTables(AppDatabase db) async {
  final out = <String, List<Map<String, Object?>>>{};
  for (final table in db.allTables) {
    final name = table.actualTableName;
    final rows = await db.customSelect('SELECT * FROM "$name"').get();
    out[name] = [for (final r in rows) Map<String, Object?>.from(r.data)];
  }
  return out;
}

/// Splits rows into chunks small enough for one Firestore document (< 1 MB).
List<List<Map<String, Object?>>> chunkRows(List<Map<String, Object?>> rows, {int size = 300}) => [
      for (var i = 0; i < rows.length; i += size) rows.sublist(i, i + size > rows.length ? rows.length : i + size),
    ];
