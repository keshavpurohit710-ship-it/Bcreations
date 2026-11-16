// You live far from her: the app must show you what she does and what went
// wrong — but only if she said yes, and never her photos.

import 'package:bcreations/app/app.dart';
import 'package:bcreations/app/insights/insights.dart';
import 'package:bcreations/app/insights/snapshot.dart';
import 'package:bcreations/data/database.dart';
import 'package:bcreations/data/maintenance.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../app_harness.dart';

const _timeout = Timeout(Duration(minutes: 2));

Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _tapText(WidgetTester tester, String text) async {
  await tester.scrollUntilVisible(find.text(text), 200, scrollable: find.byType(Scrollable).first);
  await tester.ensureVisible(find.text(text));
  await tester.pump();
  await tester.tap(find.text(text));
  await _settle(tester);
}

Future<void> _end(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 3));
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('Upload batches', () {
    test('events are split into documents of at most 300', () {
      final b = InsightBuffer();
      for (var i = 0; i < 650; i++) {
        b.add(InsightEvent('tap', 'tap', screen: 'Home'));
      }
      final batches = b.drain();
      expect(batches.map((x) => x.length), [300, 300, 50]);
      expect(b.length, 0);
    });

    test('a failed upload puts events back, oldest first', () {
      final b = InsightBuffer();
      b.add(InsightEvent('event', 'a'));
      final failed = b.drain().expand((x) => x).toList();
      b.add(InsightEvent('event', 'b'));
      b.restore(failed);
      expect(b.drain().single.map((e) => e.name), ['a', 'b']);
    });

    test('offline for days: only the newest events are kept', () {
      final b = InsightBuffer(maxKept: 100);
      for (var i = 0; i < 250; i++) {
        b.add(InsightEvent('event', '$i'));
      }
      final names = b.drain().expand((x) => x).map((e) => e.name).toList();
      expect(names.length, 100);
      expect(names.first, '150');
      expect(names.last, '249');
    });

    test('an event becomes small JSON with time, kind, name, screen, data', () {
      final e = InsightEvent('tap', 'tap', screen: 'OrderForm', data: {'x': 50}, at: DateTime.utc(2026, 11, 16, 9));
      expect(e.toJson(), {'t': '2026-11-16T09:00:00.000Z', 'k': 'tap', 'n': 'tap', 's': 'OrderForm', 'd': {'x': 50}});
    });
  });

  group('Data copy', () {
    test('every table is copied as stored, and big tables are split', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await loadDemo(db, languageCode: 'en');

      final tables = await exportTables(db);
      expect(tables.keys, containsAll(db.allTables.map((t) => t.actualTableName)));
      final parties = await db.select(db.parties).get();
      expect(tables['parties']!.length, parties.length);
      expect(tables['settings']!.single['id'], settingsRowId);

      final rows = [for (var i = 0; i < 701; i++) <String, Object?>{'i': i}];
      expect(chunkRows(rows).map((c) => c.length), [300, 300, 101]);
      expect(chunkRows(const []), isEmpty);
    });

    test('photos are not part of the copy (only file paths on the phone)', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await loadDemo(db, languageCode: 'en');
      final tables = await exportTables(db);
      for (final rows in tables.values) {
        for (final row in rows) {
          for (final v in row.values) {
            expect(v is List<int>, isFalse, reason: 'no image bytes are uploaded');
          }
        }
      }
    });
  });

  group('Consent', () {
    Future<TestShops> boot(WidgetTester tester, {bool? consent}) async {
      tester.view.physicalSize = const Size(1080, 2340);
      tester.view.devicePixelRatio = 2.75;
      addTearDown(tester.view.reset);
      final real = AppDatabase(NativeDatabase.memory());
      await tester.runAsync(() => (real.update(real.settings)..where((s) => s.id.equals(settingsRowId)))
          .write(SettingsCompanion(languageCode: const Value('en'), insightsConsent: Value(consent))));
      final shops = TestShops(real, askConsent: true);
      await tester.pumpWidget(ProviderScope(overrides: shops.overrides, child: const BcApp()));
      await _settle(tester);
      return shops;
    }

    testWidgets('asked first; "No" sends nothing and goes on to the welcome', timeout: _timeout, (tester) async {
      final shops = await boot(tester);
      expect(find.text('Help fix problems from afar'), findsOneWidget);
      expect(find.text('Photos are NOT sent — they stay on this phone'), findsOneWidget);

      await _tapText(tester, 'No, keep everything on this phone');
      expect(find.text('Learn in 5 minutes with a practice shop'), findsOneWidget);
      expect((await tester.runAsync(shops.real.getSettings))!.insightsConsent, isFalse);

      await tester.tap(find.text('Learn in 5 minutes with a practice shop'));
      await _settle(tester);
      expect(shops.insights.enabled, isFalse);
      expect(shops.insights.events, isEmpty, reason: 'nothing recorded without a yes');
      expect(shops.insights.snapshots, isEmpty);
      await _end(tester);
    });

    testWidgets('"Yes" turns it on: screens, taps, saves and a first data copy', timeout: _timeout, (tester) async {
      final shops = await boot(tester);
      await _tapText(tester, 'Yes, send it');
      expect(shops.insights.enabled, isTrue);
      expect(shops.insights.snapshots, ['daily'], reason: 'first copy right away');

      await tester.tap(find.text('Learn in 5 minutes with a practice shop'));
      await _settle(tester);
      expect(shops.insights.taps, isNotEmpty);
      expect(shops.insights.events.map((e) => e.name), contains('practice_on'));
      expect(shops.insights.saves, contains('real.settings'));

      // Opening a form is logged by its name
      await tester.tap(find.text('Show me'));
      await _settle(tester);
      expect(shops.insights.screens, contains('ItemFormScreen'));
      expect(shops.insights.taps.last.screen, isNotNull);
      await _end(tester);
    });

    testWidgets('already answered: not asked again; switch in Settings turns it off', timeout: _timeout,
        (tester) async {
      final shops = await boot(tester, consent: true);
      expect(find.text('Help fix problems from afar'), findsNothing);
      expect(shops.insights.enabled, isTrue);

      await tester.runAsync(() => (shops.real.update(shops.real.settings)..where((s) => s.id.equals(settingsRowId)))
          .write(const SettingsCompanion(insightsConsent: Value(false))));
      await _settle(tester);
      expect(shops.insights.enabled, isFalse);
      await _end(tester);
    });
  });
}
