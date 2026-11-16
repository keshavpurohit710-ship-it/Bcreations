// What to remind her about on the phone, and when. Pure logic (no plugin), so
// it is unit-tested; reminder_sync.dart hands the plan to Android.

import 'package:drift/drift.dart' hide Column;

import '../data/database.dart';
import '../domain/ledger_service.dart';
import '../domain/money.dart';
import '../domain/stock_service.dart';
import '../l10n/app_localizations.dart';

enum ReminderChannel { daily, delivery }

class PlannedReminder {
  const PlannedReminder({
    required this.id,
    required this.at,
    required this.title,
    required this.body,
    required this.channel,
    this.repeatsDaily = false,
  });
  final int id;
  final DateTime at;
  final String title;
  final String body;
  final ReminderChannel channel;

  /// The daily summary repeats at the same time; its numbers are refreshed
  /// every time the app is opened or the data changes.
  final bool repeatsDaily;
}

class ReminderFacts {
  const ReminderFacts({
    this.toCollectPaise = 0,
    this.collectCount = 0,
    this.toDeliverCount = 0,
    this.lowStockCount = 0,
    this.stockChecksCount = 0,
    this.deliveries = const [],
  });
  final int toCollectPaise;
  final int collectCount;
  final int toDeliverCount;
  final int lowStockCount;
  final int stockChecksCount;

  /// Confirmed orders with a promised date: (date, customer, order number).
  final List<(DateTime, String, String)> deliveries;
}

const dailyReminderId = 1;
const _deliveryIdBase = 1000;
const _maxDeliveryReminders = 60;

List<PlannedReminder> planReminders({
  required ReminderFacts facts,
  required DateTime now,
  required bool enabled,
  required int minutesAfterMidnight,
  required S t,
}) {
  if (!enabled) return const [];
  DateTime atTime(DateTime day) =>
      DateTime(day.year, day.month, day.day, minutesAfterMidnight ~/ 60, minutesAfterMidnight % 60);

  final plan = <PlannedReminder>[];

  // Daily summary: only what needs her, in one line each
  final lines = [
    if (facts.collectCount > 0) t.homeCollect(formatPaise(facts.toCollectPaise), facts.collectCount),
    if (facts.toDeliverCount > 0) t.homeToDeliver(facts.toDeliverCount),
    if (facts.stockChecksCount > 0) t.stockCheckTitle,
    if (facts.lowStockCount > 0) t.homeLowStock(facts.lowStockCount),
  ];
  if (lines.isNotEmpty) {
    var first = atTime(now);
    if (!first.isAfter(now)) first = atTime(now.add(const Duration(days: 1)));
    plan.add(PlannedReminder(
      id: dailyReminderId,
      at: first,
      title: t.notifDigestTitle,
      body: lines.join('\n'),
      channel: ReminderChannel.daily,
      repeatsDaily: true,
    ));
  }

  // On the promised day, a reminder to deliver
  final upcoming = facts.deliveries.where((d) => atTime(d.$1).isAfter(now)).toList()
    ..sort((a, b) => a.$1.compareTo(b.$1));
  for (final (i, (date, name, number)) in upcoming.take(_maxDeliveryReminders).indexed) {
    plan.add(PlannedReminder(
      id: _deliveryIdBase + i,
      at: atTime(date),
      title: t.notifDeliverToday(name, number),
      body: t.homeToDeliver(1),
      channel: ReminderChannel.delivery,
    ));
  }
  return plan;
}

/// Gathers the numbers for reminders from her REAL shop.
Future<ReminderFacts> loadReminderFacts(AppDatabase db, {required DateTime today}) async {
  final ledger = LedgerService(db);
  final stock = StockService(db);
  final dues = await ledger.customerDues(today: today);
  final open = await (db.select(db.orders)
        ..where((o) => o.deletedAt.isNull() & o.status.equalsValue(OrderStatus.confirmed)))
      .get();
  final names = {for (final p in await db.select(db.parties).get()) p.id: p.name};
  final onHand = await stock.onHandAll();
  final products = await (db.select(db.products)..where((p) => p.deletedAt.isNull() & p.archived.equals(false))).get();
  return ReminderFacts(
    toCollectPaise: dues.fold(0, (a, d) => a + d.balancePaise),
    collectCount: dues.length,
    toDeliverCount: open.length,
    lowStockCount: products.where((p) => p.minStockMilli > 0 && (onHand[p.id] ?? 0) <= p.minStockMilli).length,
    stockChecksCount: (await stock.openChecks()).length,
    deliveries: [
      for (final o in open)
        if (o.promisedDate != null) (o.promisedDate!, names[o.partyId] ?? '', o.number),
    ],
  );
}
