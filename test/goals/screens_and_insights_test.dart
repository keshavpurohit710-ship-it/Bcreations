// Real screens, tapped the way she would: readable in Hindi with large text,
// nothing destructive without asking, Undo that goes away by itself, Home
// cards that lead somewhere — and "help from afar" wired into all of it.

import 'package:bcreations/app/app.dart';
import 'package:bcreations/app/practice.dart';
import 'package:bcreations/data/database.dart';
import 'package:bcreations/features/orders/order_detail_screen.dart';
import 'package:bcreations/features/settings/settings_screen.dart';
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

Future<T> _q<T>(WidgetTester tester, Future<T> Function() f) async => (await tester.runAsync(f)) as T;

/// A shop as she would have it: sample data, or empty, in [lang].
Future<AppDatabase> _db(WidgetTester tester, {bool demo = true, String lang = 'en', bool? consent = false}) async =>
    (await tester.runAsync(() async {
      final db = AppDatabase(NativeDatabase.memory());
      if (demo) await loadDemo(db, languageCode: lang);
      await (db.update(db.settings)..where((s) => s.id.equals(settingsRowId)))
          .write(SettingsCompanion(languageCode: Value(lang), insightsConsent: Value(consent)));
      return db;
    }))!;

Future<TestShops> _start(WidgetTester tester, AppDatabase db, {bool askConsent = false, double textScale = 1}) async {
  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 2.75;
  addTearDown(tester.view.reset);
  if (textScale != 1) {
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  }
  final shops = TestShops(db, askConsent: askConsent);
  await tester.pumpWidget(ProviderScope(overrides: shops.overrides, child: const BcApp()));
  await _settle(tester);
  return shops;
}

Future<void> _end(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 3));
}

Future<void> _tap(WidgetTester tester, Finder f) async {
  if (f.evaluate().isEmpty) {
    final page = find.byWidgetPredicate((w) => w is Scrollable && w.axisDirection == AxisDirection.down).last;
    await tester.scrollUntilVisible(f, 300, scrollable: page);
  }
  await tester.ensureVisible(f.first);
  await tester.pump();
  await tester.tap(f.first);
  await _settle(tester);
}

Future<void> _push(WidgetTester tester, Widget screen) async {
  tester.state<NavigatorState>(find.byType(Navigator).first).push(MaterialPageRoute(builder: (_) => screen));
  await _settle(tester);
}

void _expectNoLayoutError(WidgetTester tester, String where) {
  final e = tester.takeException();
  if (e == null) return;
  final details = e is FlutterError ? e.diagnostics.map((d) => d.toString()).join('\n') : '$e';
  fail('$where: $details');
}

const _tabs = [
  ('Orders', Icons.receipt_long_outlined),
  ('Customers', Icons.people_outline),
  ('Items', Icons.inventory_2_outlined),
  ('Money', Icons.account_balance_wallet_outlined),
  ('Home', Icons.home_outlined),
];

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('Readable for her: Hindi, large text, light theme', () {
    testWidgets('a brand-new phone opens in Hindi on a light background', timeout: _timeout, (tester) async {
      final db = AppDatabase(NativeDatabase.memory()); // nothing changed: the real defaults
      await _start(tester, db, askConsent: true);
      expect(find.text('दूर से ही दिक्कतें ठीक करने में मदद करें'), findsOneWidget);
      final theme = Theme.of(tester.element(find.byType(Scaffold).first));
      expect(theme.brightness, Brightness.light);
      await _end(tester);
    });

    for (final lang in ['hi', 'en']) {
      testWidgets('every tab fits with the phone\'s text set 30 % larger ($lang)', timeout: _timeout,
          (tester) async {
        final db = await _db(tester, lang: lang);
        await _start(tester, db, textScale: 1.3);
        _expectNoLayoutError(tester, 'Home');
        for (final (name, icon) in _tabs) {
          await tester.tap(find.byIcon(icon).last);
          await _settle(tester);
          _expectNoLayoutError(tester, name);
        }
        await _end(tester);
      });
    }
  });

  group('Nothing is lost by one wrong tap', () {
    testWidgets('cancelling an order asks first; saying no changes nothing', timeout: _timeout, (tester) async {
      final db = await _db(tester);
      await _start(tester, db);
      final order = await _q(
          tester,
          () => (db.select(db.orders)..where((o) => o.status.equalsValue(OrderStatus.confirmed)))
              .get()
              .then((l) => l.first));
      await _push(tester, OrderDetailScreen(orderId: order.id));
      await _tap(tester, find.byIcon(Icons.more_vert));
      await _tap(tester, find.text('Cancel order'));
      expect(find.textContaining('Cancel this order?'), findsOneWidget);
      await _tap(tester, find.widgetWithText(TextButton, 'Cancel'));
      final after = await _q(tester, () => (db.select(db.orders)..where((o) => o.id.equals(order.id))).getSingle());
      expect(after.status, OrderStatus.confirmed);
      await _end(tester);
    });

    testWidgets('"Delete all data" asks first, and keeps her language and choices', timeout: _timeout,
        (tester) async {
      final db = await _db(tester, consent: true);
      await _start(tester, db);
      await _push(tester, const SettingsScreen());
      await _tap(tester, find.text('Delete all data'));
      expect(find.textContaining('It cannot be undone'), findsOneWidget);
      await _tap(tester, find.widgetWithText(TextButton, 'Cancel'));
      expect(await _q(tester, () => db.select(db.parties).get()), isNotEmpty, reason: 'said no: nothing deleted');

      await _tap(tester, find.text('Delete all data'));
      await _tap(tester, find.widgetWithText(FilledButton, 'Delete all data'));
      expect(await _q(tester, () => db.select(db.parties).get()), isEmpty);
      final s = await _q(tester, db.getSettings);
      expect(s.languageCode, 'en');
      expect(s.insightsConsent, isTrue, reason: 'her answer about help from afar is kept');
      await _end(tester);
    });

    testWidgets('the Undo bar after saving goes away by itself after 5 seconds', timeout: _timeout,
        (tester) async {
      final db = await _db(tester);
      await _start(tester, db);
      await _tap(tester, find.text('Add'));
      await _tap(tester, find.text('Expense'));
      await tester.enterText(find.byType(TextFormField).first, '45');
      await _tap(tester, find.widgetWithText(FilledButton, 'Save'));
      expect(find.text('Undo'), findsOneWidget);
      await tester.pump(const Duration(seconds: 6));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Undo'), findsNothing);
      await _end(tester);
    });

    testWidgets('Undo really removes what was just saved', timeout: _timeout, (tester) async {
      final db = await _db(tester);
      await _start(tester, db);
      await _tap(tester, find.text('Add'));
      await _tap(tester, find.text('Expense'));
      await tester.enterText(find.byType(TextFormField).first, '77');
      await _tap(tester, find.widgetWithText(FilledButton, 'Save'));
      await _tap(tester, find.text('Undo'));
      final left = await _q(tester,
          () => (db.select(db.expenses)..where((e) => e.amountPaise.equals(7700) & e.deletedAt.isNull())).get());
      expect(left, isEmpty);
      await _end(tester);
    });
  });

  group('Home cards lead to exactly what they talk about', () {
    testWidgets('"orders to deliver" lists orders to deliver, not quotes', timeout: _timeout, (tester) async {
      final db = await _db(tester);
      await _start(tester, db);
      await _tap(tester, find.textContaining('to deliver'));
      expect(find.text('Priya (Instagram)'), findsWidgets);
      expect(find.text('Asha Mehta'), findsNothing, reason: 'hers is a quote');
      await _end(tester);
    });

    testWidgets('the month card opens Money with "Where did my profit go?"', timeout: _timeout, (tester) async {
      final db = await _db(tester);
      await _start(tester, db);
      await _tap(tester, find.text('Cash actually added'));
      expect(find.text('Where did my profit go?'), findsWidgets);
      await _end(tester);
    });
  });

  group('Help from afar, wired into the app', () {
    testWidgets('the consent screen can be read in English or Hindi before answering', timeout: _timeout,
        (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      final shops = await _start(tester, db, askConsent: true);
      expect(find.text('दूर से ही दिक्कतें ठीक करने में मदद करें'), findsOneWidget);
      await _tap(tester, find.text('English'));
      expect(find.text('Help fix problems from afar'), findsOneWidget);
      expect((await _q(tester, db.getSettings)).insightsConsent, isNull, reason: 'changing language is not an answer');
      expect(shops.insights.enabled, isFalse);
      await _end(tester);
    });

    testWidgets('Settings: the switch turns it on and off; "Send a report now" sends a copy', timeout: _timeout,
        (tester) async {
      final db = await _db(tester, consent: false);
      final shops = await _start(tester, db);
      await _push(tester, const SettingsScreen());
      expect(find.text('Send a report now'), findsNothing, reason: 'only offered when it is on');

      await _tap(tester, find.text('Send usage and data copy'));
      expect((await _q(tester, db.getSettings)).insightsConsent, isTrue);
      expect(shops.insights.enabled, isTrue);

      await _tap(tester, find.text('Send a report now'));
      expect(shops.insights.snapshots, contains('manual'));
      expect(shops.insights.flushes, greaterThan(0), reason: 'taps so far go with the report');
      expect(find.textContaining('Report sent'), findsOneWidget);

      await _tap(tester, find.text('Send usage and data copy'));
      expect(shops.insights.enabled, isFalse);
      final before = shops.insights.events.length;
      await tester.tap(find.byType(Scaffold).first, warnIfMissed: false);
      await _settle(tester);
      expect(shops.insights.events.length, before, reason: 'off means nothing more is recorded');
      await _end(tester);
    });

    testWidgets('a data copy goes at most once a day', timeout: _timeout, (tester) async {
      final db = await _db(tester, consent: true);
      await _q(
          tester,
          () => (db.update(db.settings)..where((s) => s.id.equals(settingsRowId))).write(
              SettingsCompanion(lastSnapshotAt: Value(DateTime.now().subtract(const Duration(hours: 3))))));
      final shops = await _start(tester, db);
      expect(shops.insights.enabled, isTrue);
      expect(shops.insights.snapshots, isEmpty, reason: 'last copy was 3 hours ago');

      // A day later she opens the app again
      await _q(
          tester,
          () => (db.update(db.settings)..where((s) => s.id.equals(settingsRowId))).write(
              SettingsCompanion(lastSnapshotAt: Value(DateTime.now().subtract(const Duration(hours: 25))))));
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await _settle(tester);
      expect(shops.insights.snapshots, ['daily']);
      final last = (await _q(tester, db.getSettings)).lastSnapshotAt!;
      expect(DateTime.now().difference(last).inMinutes, lessThan(5), reason: 'remembered, so not sent again today');
      await _end(tester);
    });

    testWidgets('leaving the app sends what was recorded; coming back is logged', timeout: _timeout,
        (tester) async {
      final db = await _db(tester, consent: true);
      final shops = await _start(tester, db);
      final flushes = shops.insights.flushes;
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await _settle(tester);
      expect(shops.insights.flushes, greaterThan(flushes));
      expect(shops.insights.events.map((e) => e.name), contains('app_background'));
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await _settle(tester);
      expect(shops.insights.events.map((e) => e.name), contains('app_open'));
      await _end(tester);
    });

    testWidgets('tabs are named, and each tap says which screen it was on', timeout: _timeout, (tester) async {
      final db = await _db(tester, consent: true);
      final shops = await _start(tester, db);
      for (final (_, icon) in _tabs) {
        await tester.tap(find.byIcon(icon).last);
        await _settle(tester);
      }
      expect(shops.insights.screens, containsAllInOrder(['tab:Orders', 'tab:Customers', 'tab:Items', 'tab:Money', 'tab:Home']));
      final tapScreens = shops.insights.taps.map((e) => e.screen).toList();
      expect(tapScreens, containsAllInOrder(['tab:Home', 'tab:Orders', 'tab:Customers', 'tab:Items', 'tab:Money']),
          reason: 'each tab-bar tap is logged on the screen it was made from');
      for (final tap in shops.insights.taps) {
        final x = tap.data['x']! as int, y = tap.data['y']! as int;
        expect(x, inInclusiveRange(0, 100));
        expect(y, inInclusiveRange(0, 100));
      }
      await _end(tester);
    });

    testWidgets('what she saves is logged by shop and table — practice kept apart from real', timeout: _timeout,
        (tester) async {
      final db = await _db(tester, consent: true, demo: false);
      await _q(
          tester,
          () => (db.update(db.settings)..where((s) => s.id.equals(settingsRowId)))
              .write(SettingsCompanion(startDate: Value(DateTime.now()))));
      final shops = await _start(tester, db);
      await _tap(tester, find.text('Add'));
      await _tap(tester, find.text('Expense'));
      await tester.enterText(find.byType(TextFormField).first, '20');
      await _tap(tester, find.widgetWithText(FilledButton, 'Save'));
      expect(shops.insights.saves, contains('real.expenses'));

      await _q(tester, () => PracticeService(db, () => shops.practice).enter());
      await _settle(tester);
      expect(shops.insights.events.map((e) => e.name), contains('practice_on'));
      await _q(tester,
          () => shops.practice.into(shops.practice.expenses).insert(ExpensesCompanion.insert(
              category: 'Courier', amountPaise: 1000, method: PaymentMethod.cash, spentOn: DateTime.now())));
      await _settle(tester);
      expect(shops.insights.saves, contains('practice.expenses'));
      await _end(tester);
    });
  });
}
