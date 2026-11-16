// Everything a widget test needs to boot the real app: in-memory real and
// practice shops, and a reminder scheduler that records instead of calling Android.

import 'package:bcreations/app/insights/insights.dart';
import 'package:bcreations/app/insights/insights_sync.dart';
import 'package:bcreations/app/providers.dart';
import 'package:bcreations/app/reminder_sync.dart';
import 'package:bcreations/app/reminders.dart';
import 'package:bcreations/data/database.dart';
import 'package:bcreations/l10n/app_localizations.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeScheduler implements ReminderScheduler {
  List<PlannedReminder>? lastPlan;
  int permissionAsks = 0;

  @override
  Future<void> apply(List<PlannedReminder> plan, S t) async => lastPlan = plan;

  @override
  Future<void> askPermission() async => permissionAsks++;
}

/// Records what the app would send, instead of sending it.
class FakeInsights implements Insights {
  final events = <InsightEvent>[];
  final snapshots = <String>[];
  @override
  bool enabled = false;

  Iterable<String> get screens => events.where((e) => e.kind == 'screen').map((e) => e.name);
  Iterable<InsightEvent> get taps => events.where((e) => e.kind == 'tap');
  Iterable<String> get saves => events.where((e) => e.kind == 'save').map((e) => e.name);

  void _add(InsightEvent e) {
    if (enabled) events.add(e);
  }

  @override
  Future<void> setEnabled(bool on) async => enabled = on;
  @override
  void screen(String name) => _add(InsightEvent('screen', name));
  @override
  void tap(String screen, double x, double y) => _add(InsightEvent('tap', 'tap', screen: screen, data: {'x': x, 'y': y}));
  @override
  void save(String table, String kind) => _add(InsightEvent('save', table, data: {'kind': kind}));
  @override
  void event(String name, [Map<String, Object?> data = const {}]) => _add(InsightEvent('event', name, data: data));
  @override
  Future<void> flush() async {}
  @override
  Future<bool> sendSnapshot({required String reason}) async {
    if (!enabled) return false;
    snapshots.add(reason);
    return true;
  }
}

class TestShops {
  TestShops(this.real, {this.askConsent = false}) : practice = AppDatabase(NativeDatabase.memory());
  final AppDatabase real;
  final AppDatabase practice;
  final scheduler = FakeScheduler();
  final insights = FakeInsights();
  final bool askConsent;

  List<Override> get overrides => [
        realDatabaseProvider.overrideWithValue(real),
        practiceDatabaseProvider.overrideWithValue(practice),
        reminderSchedulerProvider.overrideWithValue(scheduler),
        reminderSyncEnabledProvider.overrideWithValue(false),
        insightsProvider.overrideWithValue(insights),
        askConsentProvider.overrideWithValue(askConsent),
      ];
}
