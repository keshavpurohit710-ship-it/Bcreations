// Tapping through the real app the way she would, plus a check that every
// word on screen exists in Hindi. P6 (onboarding must be easy), P1, P10, P26.

import 'dart:convert';
import 'dart:io';

import 'package:bcreations/app/app.dart';
import 'package:bcreations/app/providers.dart';
import 'package:bcreations/data/database.dart';
import 'package:bcreations/features/customers/customer_detail_screen.dart';
import 'package:bcreations/features/orders/order_form_screen.dart';
import 'package:bcreations/features/settings/settings_screen.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _timeout = Timeout(Duration(minutes: 2));

Future<AppDatabase> _db(WidgetTester tester, {bool demo = false}) async => (await tester.runAsync(() async {
      final db = AppDatabase(NativeDatabase.memory());
      if (demo) {
        await loadDemo(db, languageCode: 'en');
      } else {
        await (db.update(db.settings)..where((s) => s.id.equals(settingsRowId)))
            .write(const SettingsCompanion(languageCode: Value('en')));
      }
      return db;
    }))!;

Future<void> _start(WidgetTester tester, AppDatabase db) async {
  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 2.75;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(ProviderScope(overrides: [databaseProvider.overrideWithValue(db)], child: const BcApp()));
  await _settle(tester);
}

Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Scrolls to the widget if it is below the fold (as a person would), then taps it.
Future<void> _tap(WidgetTester tester, Finder f) async {
  if (f.evaluate().isEmpty) {
    final page = find.byWidgetPredicate((w) => w is Scrollable && w.axisDirection == AxisDirection.down).last;
    await tester.scrollUntilVisible(f, 300, scrollable: page);
  }
  await tester.ensureVisible(f);
  await tester.pump();
  await tester.tap(f);
  await _settle(tester);
}

Future<void> _push(WidgetTester tester, Widget screen) async {
  tester.state<NavigatorState>(find.byType(Navigator).first).push(MaterialPageRoute(builder: (_) => screen));
  await _settle(tester);
}

Future<void> _end(WidgetTester tester) async {
  expect(tester.takeException(), isNull);
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 1));
}

Future<T> _q<T>(WidgetTester tester, Future<T> Function() f) async => (await tester.runAsync(f)) as T;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('P6 · Getting started is quick and needs nothing from the past', () {
    testWidgets('"Start fresh" lands on Home with a 3-step checklist', timeout: _timeout, (tester) async {
      final db = await _db(tester);
      await _start(tester, db);
      expect(find.text('Welcome to Bcreations'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Bcreations Crafts');
      await _tap(tester, find.text('Start fresh'));

      expect(find.text('Bcreations Crafts'), findsOneWidget, reason: 'her business name is on Home');
      expect(find.text('Finish setting up'), findsOneWidget);
      expect(find.text('Add what you have in stock'), findsOneWidget);
      expect(find.text('Add customers who owe you'), findsOneWidget);
      expect(find.text('Add orders in progress'), findsOneWidget);
      await _end(tester);
    });

    testWidgets('adding an item needs only a name and how many she has', timeout: _timeout, (tester) async {
      final db = await _db(tester);
      await _q(
          tester,
          () => (db.update(db.settings)..where((s) => s.id.equals(settingsRowId)))
              .write(SettingsCompanion(startDate: Value(DateTime.now()))));
      await _start(tester, db);

      await _tap(tester, find.text('Add what you have in stock'));
      await tester.enterText(find.widgetWithText(TextFormField, 'Name'), 'Silk potli');
      await tester.enterText(find.widgetWithText(TextFormField, 'How many do you have now?'), '12');
      await _tap(tester, find.widgetWithText(FilledButton, 'Save'));

      final items = await _q(tester, () => db.select(db.products).get());
      expect(items.single.name, 'Silk potli');
      final onHand = await _q(tester, () => db.customSelect('SELECT SUM(qty_milli) q FROM stock_moves').getSingle());
      expect(onHand.data['q'], 12000);
      await _end(tester);
    });
  });

  group('Everyday journeys with real screens', () {
    testWidgets('P1 · receiving payment from a customer who owes clears the dues', timeout: _timeout, (tester) async {
      final db = await _db(tester, demo: true);
      await _start(tester, db);
      final boutique =
          await _q(tester, () => (db.select(db.parties)..where((p) => p.name.equals('Rang Boutique'))).getSingle());
      await _push(tester, CustomerDetailScreen(partyId: boutique.id));
      expect(find.textContaining('Owes'), findsWidgets);

      await _tap(tester, find.widgetWithText(FilledButton, 'Receive payment'));
      // The amount is pre-filled with what they owe: one tap to save.
      await _tap(tester, find.widgetWithText(FilledButton, 'Save'));
      expect(find.textContaining('received'), findsOneWidget, reason: 'confirmation with Undo');
      expect(find.text('Settled'), findsOneWidget);
      await _end(tester);
    });

    testWidgets('P10 · an expense takes two taps and an amount', timeout: _timeout, (tester) async {
      final db = await _db(tester, demo: true);
      await _start(tester, db);
      await _tap(tester, find.text('Add'));
      await _tap(tester, find.text('Expense'));
      await tester.enterText(find.byType(TextFormField).first, '123');
      await _tap(tester, find.text('Courier'));
      await _tap(tester, find.widgetWithText(FilledButton, 'Save'));

      final today = DateTime.now();
      final saved = await _q(tester, () => (db.select(db.expenses)..where((e) => e.amountPaise.equals(12300))).get());
      expect(saved.single.category, 'Courier');
      expect(saved.single.spentOn.day, today.day);
      expect(find.textContaining('₹123'), findsOneWidget, reason: 'confirmation with Undo');
      await _end(tester);
    });

    testWidgets('a new order: pick an item, the right price fills in, save', timeout: _timeout, (tester) async {
      final db = await _db(tester, demo: true);
      await _start(tester, db);
      final asha =
          await _q(tester, () => (db.select(db.parties)..where((p) => p.name.equals('Asha Mehta'))).getSingle());
      final before = await _q(tester, () => db.select(db.orders).get());

      await _push(tester, OrderFormScreen(partyId: asha.id));
      expect(find.text('Asha Mehta'), findsOneWidget);
      await _tap(tester, find.text('Add item'));
      await _tap(tester, find.text('Kundan rakhi'));
      expect(find.text('₹150'), findsWidgets, reason: 'retail price for an individual customer');
      await _tap(tester, find.widgetWithText(FilledButton, 'Save'));

      final after = await _q(tester, () => db.select(db.orders).get());
      expect(after.length, before.length + 1);
      final created = after.firstWhere((o) => !before.any((b) => b.id == o.id));
      final lines =
          await _q(tester, () => (db.select(db.orderLines)..where((l) => l.orderId.equals(created.id))).get());
      expect(lines.single.unitPricePaise, 15000);
      expect(lines.single.unitCostPaise, isNotNull, reason: 'cost saved for margin');
      await _end(tester);
    });

    testWidgets('P26 · search finds a customer by part of the name', timeout: _timeout, (tester) async {
      final db = await _db(tester, demo: true);
      await _start(tester, db);
      await _tap(tester, find.byIcon(Icons.people_outline).last);
      expect(find.text('Asha Mehta'), findsOneWidget);
      expect(find.text('Kala Gift Shop'), findsOneWidget);
      await tester.enterText(find.byType(SearchBar), 'asha');
      await _settle(tester);
      expect(find.text('Asha Mehta'), findsOneWidget);
      expect(find.text('Kala Gift Shop'), findsNothing);
      await _end(tester);
    });
  });

  group('Hindi · every word she sees exists in Hindi', () {
    Map<String, dynamic> arb(String lang) =>
        jsonDecode(File('lib/l10n/app_$lang.arb').readAsStringSync()) as Map<String, dynamic>;
    final en = arb('en');
    final hi = arb('hi');
    final keys = en.keys.where((k) => !k.startsWith('@')).toList();
    // Words that are the same in both languages on purpose
    const same = {'appName', 'whatsapp', 'methodUpi', 'settingsUpi'};

    test('Hindi has every string, none empty, and actually translated', () {
      expect(keys.length, greaterThan(250));
      for (final k in keys) {
        expect(hi[k], isA<String>(), reason: 'missing Hindi for $k');
        expect((hi[k] as String).trim(), isNotEmpty, reason: 'empty Hindi for $k');
        if (!same.contains(k)) expect(hi[k], isNot(en[k]), reason: '$k is still in English');
      }
    });

    test('Hindi uses the same {placeholders} as English, so amounts and names always appear', () {
      final ph = RegExp(r'\{(\w+)\}');
      Set<String> names(String s) => ph.allMatches(s).map((m) => m.group(1)!).toSet();
      for (final k in keys) {
        expect(names(hi[k] as String), names(en[k] as String), reason: 'placeholders differ in $k');
      }
    });
  });
}
