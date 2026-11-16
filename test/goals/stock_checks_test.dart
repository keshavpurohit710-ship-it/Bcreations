// When she goes ahead with less stock than the app shows, the app flags it on
// Home so she can find out why (count error, unrecorded purchase, ...).

import 'dart:io';

import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/report_service.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'goal_world.dart';

void main() {
  late Shop s;
  late String lace, potli, box;
  setUp(() async {
    s = Shop();
    lace = await s.product('Lace', ProductKind.rawMaterial, unit: 'm');
    potli = await s.product('Potli', ProductKind.made, retailPaise: rs(450));
    box = await s.product('Gift box', ProductKind.bought, retailPaise: rs(100));
    await s.recipe(potli, lace, 1000);
    await s.buy(lace, 3000, rs(150), d(5, 1)); // 3 m
    await s.stock.addOpeningStock(productId: box, qtyMilli: 2000, unitCostPaise: rs(40), date: d(5, 1));
  });
  tearDown(() => s.close());

  test('making with too little material raises a check for exactly what was missing', () async {
    await s.stock.produce(productId: potli, qtyMilli: 5000, date: d(5, 2), allowShortage: true);
    final checks = await s.stock.openChecks();
    expect(checks, hasLength(1));
    final (check, product) = checks.single;
    expect(product.id, lace);
    expect(check.kind, StockCheckKind.madeShort);
    expect(check.shortMilli, 2000);
  });

  test('making with enough material raises nothing', () async {
    await s.stock.produce(productId: potli, qtyMilli: 3000, date: d(5, 2));
    expect(await s.stock.openChecks(), isEmpty);
  });

  test('delivering more than in stock raises a check; enough stock or custom items do not', () async {
    final asha = await s.customer('Asha');
    final o = await s.orders.createOrder(partyId: asha, orderDate: d(5, 3), lines: [
      LineInput(productId: box, qtyMilli: 3000, unitPricePaise: rs(100)), // only 2 in stock
      const LineInput(description: 'Name plate', qtyMilli: 1000, unitPricePaise: 50000),
    ]);
    await s.orders.deliver(o.id, date: d(5, 4));
    final checks = await s.stock.openChecks();
    expect(checks.single.$1.kind, StockCheckKind.deliveredShort);
    expect(checks.single.$1.shortMilli, 1000);
    expect(checks.single.$1.orderId, o.id);
  });

  test('a shelf count clears the check; "It\'s fine" clears it too', () async {
    await s.stock.produce(productId: potli, qtyMilli: 5000, date: d(5, 2), allowShortage: true);
    expect(await s.stock.openChecks(), hasLength(1));
    await s.stock.recordCount(productId: lace, countedMilli: 0, date: d(5, 3));
    expect(await s.stock.openChecks(), isEmpty);

    final asha = await s.customer('Asha');
    await s.sell(asha, box, 5, rs(100), d(5, 4));
    final (check, _) = (await s.stock.openChecks()).single;
    await s.stock.resolveCheck(check.id, 'fine');
    expect(await s.stock.openChecks(), isEmpty);
  });

  test('going ahead and fixing it later keeps the money right', () async {
    final asha = await s.customer('Asha');
    await s.stock.produce(productId: potli, qtyMilli: 5000, date: d(5, 2), allowShortage: true);
    final o = await s.sell(asha, potli, 5, rs(450), d(5, 3));
    await s.pay(asha, rs(2250), d(5, 3), orderId: o.id);
    // She finds she had actually bought 2 m more lace and forgot to record it
    await s.buy(lace, 2000, rs(100), d(5, 4));
    await s.stock.recordCount(productId: lace, countedMilli: 0, date: d(5, 5));

    final (from, to) = ReportService.monthBounds(d(5, 1));
    final m = await s.reports.summary(from: from, to: to);
    expect(m.cashAddedPaise, m.actualCashChangePaise);
    expect(await s.stock.onHandMilli(lace), 0);
    expect(await s.stock.openChecks(), isEmpty);
  });

  test('upgrading an installed app (database v1) keeps all data and adds everything since', () async {
    final dir = await Directory.systemTemp.createTemp('bc_migration');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/app.sqlite');

    // An installed v1 app with some data
    var db = AppDatabase(NativeDatabase(file));
    await db.into(db.parties).insert(PartiesCompanion.insert(name: 'Asha', openingBalancePaise: const Value(120000)));
    await db.customStatement('DROP TABLE stock_checks');
    await _dropV3Columns(db);
    await db.customStatement('PRAGMA user_version = 1');
    await db.close();

    // The new app opens it
    db = AppDatabase(NativeDatabase(file));
    final parties = await db.select(db.parties).get();
    expect(parties.single.openingBalancePaise, 120000, reason: 'existing data kept');
    expect(await db.select(db.stockChecks).get(), isEmpty, reason: 'new table created');
    expect((await db.customSelect('PRAGMA user_version').getSingle()).data.values.first, 4);
    expect((await db.getSettings()).notifyMinutes, 540, reason: 'v3 settings columns added with defaults');
    await db.close();
  });

  test('upgrading from v2 (the build installed after round 1) keeps stock checks and adds reminders', () async {
    final dir = await Directory.systemTemp.createTemp('bc_migration_v2');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/app.sqlite');

    var db = AppDatabase(NativeDatabase(file));
    final lace = await db
        .into(db.products)
        .insertReturning(ProductsCompanion.insert(name: 'Lace', kind: ProductKind.rawMaterial));
    await db.into(db.stockChecks).insert(StockChecksCompanion.insert(
        productId: lace.id, kind: StockCheckKind.madeShort, shortMilli: 500, raisedOn: DateTime(2026, 11, 16)));
    await _dropV3Columns(db);
    await db.customStatement('PRAGMA user_version = 2');
    await db.close();

    db = AppDatabase(NativeDatabase(file));
    expect((await db.select(db.stockChecks).get()).single.shortMilli, 500);
    final settings = await db.getSettings();
    expect(settings.notifyEnabled, isTrue);
    expect(settings.practiceActive, isFalse);
    expect(settings.tutorialDoneAt, isNull);
    expect(settings.insightsConsent, isNull, reason: 'v4: not asked yet');
    await db.close();
  });

  test('upgrading from v3 (tutorial build) asks about insights once', () async {
    final dir = await Directory.systemTemp.createTemp('bc_migration_v3');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/app.sqlite');

    var db = AppDatabase(NativeDatabase(file));
    await db.customStatement('UPDATE settings SET notify_minutes = 600');
    await _dropV4Columns(db);
    await db.customStatement('PRAGMA user_version = 3');
    await db.close();

    db = AppDatabase(NativeDatabase(file));
    final settings = await db.getSettings();
    expect(settings.notifyMinutes, 600, reason: 'v3 data kept');
    expect(settings.insightsConsent, isNull);
    expect(settings.lastSnapshotAt, isNull);
    await db.close();
  });
}

/// Turns a current database back into its pre-v3 shape (SQLite 3.35+ can drop columns).
Future<void> _dropV3Columns(AppDatabase db) async {
  await _dropV4Columns(db);
  for (final c in ['tutorial_done_at', 'practice_active', 'notify_enabled', 'notify_minutes']) {
    await db.customStatement('ALTER TABLE settings DROP COLUMN $c');
  }
}

Future<void> _dropV4Columns(AppDatabase db) async {
  for (final c in ['insights_consent', 'last_snapshot_at']) {
    await db.customStatement('ALTER TABLE settings DROP COLUMN $c');
  }
}
