import 'package:bcreations/data/demo_seed.dart';
import 'package:bcreations/domain/report_service.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  test('demo data loads and the money adds up', () async {
    final w = World();
    final today = DateTime(2026, 11, 12);
    await seedDemoData(w.db, today: today);

    final dues = await w.ledger.customerDues(today: today);
    expect(dues, isNotEmpty);
    expect(await w.ledger.advancesHeld(), 500000);

    final s = await w.reports.summary(from: DateTime(2026, 1, 1), to: today);
    expect(s.salesPaise, greaterThan(0));
    expect(s.cashAddedPaise, s.actualCashChangePaise);

    final best = await w.reports.bestSellers(from: DateTime(2026, 1, 1), to: today);
    expect(best.first.product.name, 'Kundan rakhi');

    // Opening balance from before the start shows in dues
    expect(dues.any((d) => d.party.name == 'Kala Gift Shop'), isTrue);
    await w.close();
  });

  test('month bounds cover the whole calendar month', () {
    final (from, to) = ReportService.monthBounds(DateTime(2026, 2, 14));
    expect(from.isBefore(DateTime(2026, 2, 1)), isTrue);
    expect(to.isBefore(DateTime(2026, 3, 1)), isTrue);
    expect(to.isAfter(DateTime(2026, 2, 28, 23, 59)), isTrue);
  });
}
