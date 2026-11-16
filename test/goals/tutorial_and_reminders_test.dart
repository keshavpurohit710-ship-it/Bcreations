// She lives far from you, so the app must teach itself (tutorial with a
// practice shop that never mixes with her real books) and remind her by itself.

import 'package:bcreations/app/app.dart';
import 'package:bcreations/app/practice.dart';
import 'package:bcreations/app/reminder_sync.dart';
import 'package:bcreations/app/reminders.dart';
import 'package:bcreations/data/database.dart';
import 'package:bcreations/data/maintenance.dart';
import 'package:bcreations/domain/entry_service.dart';
import 'package:bcreations/domain/ledger_service.dart';
import 'package:bcreations/domain/order_service.dart';
import 'package:bcreations/domain/stock_service.dart';
import 'package:bcreations/l10n/app_localizations.dart';
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

/// Runs [f] on the test's clock and advances it until done. Needed once the app is
/// on screen: its live queries share the database queue with [f].
Future<T> _run<T>(WidgetTester tester, Future<T> Function() f) async {
  var done = false;
  late T result;
  Object? error;
  f().then((v) {
    result = v;
    done = true;
  }, onError: (Object e) {
    error = e;
    done = true;
  });
  for (var i = 0; i < 300 && !done; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 10)));
    await tester.pump(const Duration(milliseconds: 50));
  }
  if (error != null) throw error!;
  expect(done, isTrue, reason: 'database work did not finish');
  return result;
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('Reminders: what and when', () {
    final en = lookupS(const Locale('en'));
    final now = DateTime(2026, 11, 16, 8, 0); // Monday 8 am
    const facts = ReminderFacts(
      toCollectPaise: 960000,
      collectCount: 2,
      toDeliverCount: 1,
      lowStockCount: 3,
      stockChecksCount: 1,
    );

    test('a daily summary at her chosen time, with only what needs her', () {
      final plan = planReminders(facts: facts, now: now, enabled: true, minutesAfterMidnight: 540, t: en);
      final daily = plan.single;
      expect(daily.at, DateTime(2026, 11, 16, 9, 0));
      expect(daily.repeatsDaily, isTrue);
      expect(daily.body, contains('Collect ₹9,600 from 2 customers'));
      expect(daily.body, contains('1 order to deliver'));
      expect(daily.body, contains('Stock to check'));
      expect(daily.body, contains('3 items running low'));
    });

    test('if the time has passed today, the summary starts tomorrow', () {
      final plan = planReminders(
          facts: facts, now: DateTime(2026, 11, 16, 20, 0), enabled: true, minutesAfterMidnight: 540, t: en);
      expect(plan.single.at, DateTime(2026, 11, 17, 9, 0));
    });

    test('nothing to do means no summary; switched off means nothing at all', () {
      expect(planReminders(facts: const ReminderFacts(), now: now, enabled: true, minutesAfterMidnight: 540, t: en),
          isEmpty);
      expect(planReminders(facts: facts, now: now, enabled: false, minutesAfterMidnight: 540, t: en), isEmpty);
    });

    test('a reminder on the promised delivery day; past dates are skipped', () {
      final plan = planReminders(
        facts: ReminderFacts(deliveries: [
          (DateTime(2026, 11, 20), 'Priya', 'BC-0004'),
          (DateTime(2026, 11, 10), 'Old', 'BC-0001'), // already past
        ]),
        now: now,
        enabled: true,
        minutesAfterMidnight: 540,
        t: en,
      );
      final r = plan.single;
      expect(r.at, DateTime(2026, 11, 20, 9, 0));
      expect(r.title, 'Deliver today: Priya · BC-0004');
      expect(r.channel, ReminderChannel.delivery);
    });

    test('reminders come in her language', () {
      final hi = lookupS(const Locale('hi'));
      final plan = planReminders(facts: facts, now: now, enabled: true, minutesAfterMidnight: 540, t: hi);
      expect(plan.single.body, contains('ग्राहकों से'));
    });
  });

  group('Practice shop never touches her real books', () {
    late AppDatabase real, practice;
    late PracticeService svc;
    setUp(() async {
      real = AppDatabase(NativeDatabase.memory());
      practice = AppDatabase(NativeDatabase.memory());
      svc = PracticeService(real, () => practice);
      await (real.update(real.settings)..where((s) => s.id.equals(settingsRowId)))
          .write(const SettingsCompanion(languageCode: Value('hi')));
    });
    tearDown(() async {
      await real.close();
      await practice.close();
    });

    test('entering practice keeps her language and starts at Home', () async {
      await svc.enter(fresh: true);
      expect((await real.getSettings()).practiceActive, isTrue);
      final p = await practice.getSettings();
      expect(p.languageCode, 'hi');
      expect(p.startDate, isNotNull);
    });

    test('what she enters in practice stays in practice', () async {
      await svc.enter(fresh: true);
      await practice.into(practice.parties).insert(PartiesCompanion.insert(name: 'Asha (practice)'));
      await svc.exit(finishTutorial: true);
      expect(await real.select(real.parties).get(), isEmpty);
      expect(await practice.select(practice.parties).get(), hasLength(1), reason: 'kept for later practice');
      final r = await real.getSettings();
      expect(r.practiceActive, isFalse);
      expect(r.tutorialDoneAt, isNotNull);
    });

    test('starting the tutorial again empties the practice shop', () async {
      await svc.enter(fresh: true);
      await practice.into(practice.parties).insert(PartiesCompanion.insert(name: 'Asha'));
      await svc.exit(finishTutorial: true);
      await svc.restartTutorial();
      expect(await practice.select(practice.parties).get(), isEmpty);
      expect((await real.getSettings()).tutorialDoneAt, isNull);
    });

    test('changing language in practice changes it for the real shop too', () async {
      await svc.enter(fresh: true);
      await svc.setLanguage('en');
      expect((await real.getSettings()).languageCode, 'en');
      expect((await practice.getSettings()).languageCode, 'en');
    });
  });

  group('The tutorial, tapped through', () {
    testWidgets('language → practice → each step detected → real shop setup', timeout: _timeout, (tester) async {
      tester.view.physicalSize = const Size(1080, 2340);
      tester.view.devicePixelRatio = 2.75;
      addTearDown(tester.view.reset);
      final real = AppDatabase(NativeDatabase.memory());
      final shops = TestShops(real);
      await _q(
          tester,
          () => (real.update(real.settings)..where((s) => s.id.equals(settingsRowId)))
              .write(const SettingsCompanion(languageCode: Value('en'))));
      await tester.pumpWidget(ProviderScope(overrides: shops.overrides, child: const BcApp()));
      await _settle(tester);

      await tester.tap(find.text('Learn in 5 minutes with a practice shop'));
      await _settle(tester);
      expect(find.text('Practice shop — nothing here is real'), findsOneWidget);
      expect(find.textContaining('Step 1 of 7'), findsOneWidget);

      // "Show me" opens the right screen
      await tester.tap(find.text('Show me'));
      await _settle(tester);
      expect(find.text('New item'), findsOneWidget);
      expect(find.textContaining('Name: Rakhi'), findsOneWidget, reason: 'the prompt stays visible over the form');
      Navigator.of(tester.element(find.text('New item'))).pop();
      await _settle(tester);

      // She does each step (here directly on the practice shop); the guide follows
      final p = shops.practice;
      final stock = StockService(p);
      final ledger = LedgerService(p);
      final orders = OrderService(p, stock, ledger);
      late String rakhi, asha, orderId;
      Future<void> doStep(Future<void> Function() f, String nextStep) async {
        await _run(tester, f);
        await _settle(tester);
        expect(find.textContaining(nextStep), findsOneWidget);
      }

      await doStep(() async {
        rakhi = (await p.into(p.products).insertReturning(ProductsCompanion.insert(
                name: 'Rakhi', kind: ProductKind.bought, retailPricePaise: const Value(15000))))
            .id;
        await stock.addOpeningStock(productId: rakhi, qtyMilli: 20000, unitCostPaise: 4000, date: DateTime.now());
      }, 'Step 2 of 7');
      await doStep(() async {
        asha = (await p
                .into(p.parties)
                .insertReturning(PartiesCompanion.insert(name: 'Asha', openingBalancePaise: const Value(50000))))
            .id;
      }, 'Step 3 of 7');
      await doStep(() async {
        orderId = (await orders.createOrder(
                partyId: asha,
                orderDate: DateTime.now(),
                lines: [LineInput(productId: rakhi, qtyMilli: 5000, unitPricePaise: 15000)]))
            .id;
        await ledger.receivePayment(
            partyId: asha, amountPaise: 20000, method: PaymentMethod.cash, date: DateTime.now(), orderId: orderId);
      }, 'Step 4 of 7');
      await doStep(() => orders.deliver(orderId, date: DateTime.now()), 'Step 5 of 7');
      await doStep(
          () => ledger.receivePayment(
              partyId: asha, amountPaise: 105000, method: PaymentMethod.upi, date: DateTime.now()),
          'Step 6 of 7');
      await doStep(
          () => EntryService(p)
              .addExpense(category: 'Courier', amountPaise: 8000, method: PaymentMethod.cash, date: DateTime.now()),
          'Step 7 of 7');

      await tester.tap(find.text('I have seen it'));
      await _settle(tester);
      expect(find.text('Well done! You know the basics.'), findsOneWidget);

      await tester.tap(find.text('Start my real shop'));
      await _settle(tester);
      expect(find.text('Your shop'), findsOneWidget);
      expect(find.text('Practice shop — nothing here is real'), findsNothing);
      await tester.tap(find.text('Start my real shop'));
      await _settle(tester);
      expect(find.text('Finish setting up'), findsOneWidget, reason: 'real shop starts empty, with the checklist');
      expect(await _run(tester, () => real.select(real.parties).get()), isEmpty);

      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 3));
    });
  });

  group('Reminders follow her real shop', () {
    test('planned from real data once her real shop has started; permission asked once', () async {
      final real = AppDatabase(NativeDatabase.memory());
      addTearDown(real.close);
      final scheduler = FakeScheduler();

      // Before setup: nothing is scheduled
      expect(await syncRemindersOnce(real, scheduler, now: DateTime(2026, 11, 16, 8), askPermission: true), isEmpty);
      expect(scheduler.permissionAsks, 0);

      await loadDemo(real, languageCode: 'en');
      final plan = await syncRemindersOnce(real, scheduler, now: DateTime.now(), askPermission: true);
      expect(plan.firstWhere((r) => r.repeatsDaily).body, contains('Collect ₹9,600 from 2 customers'));
      expect(plan.any((r) => r.channel == ReminderChannel.delivery), isTrue, reason: "Priya's promised date");
      expect(scheduler.lastPlan, plan);
      expect(scheduler.permissionAsks, 1);
    });

    test('switching reminders off clears them', () async {
      final real = AppDatabase(NativeDatabase.memory());
      addTearDown(real.close);
      await loadDemo(real, languageCode: 'en');
      await (real.update(real.settings)..where((s) => s.id.equals(settingsRowId)))
          .write(const SettingsCompanion(notifyEnabled: Value(false)));
      final scheduler = FakeScheduler();
      expect(await syncRemindersOnce(real, scheduler, now: DateTime.now()), isEmpty);
      expect(scheduler.lastPlan, isEmpty);
    });
  });
}
