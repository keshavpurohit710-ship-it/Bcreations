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
class FakeInsights with InsightRecorder {
  @override
  final buffer = InsightBuffer(maxKept: 100000);
  final snapshots = <String>[];
  int flushes = 0;
  @override
  bool enabled = false;

  /// Everything recorded so far (the fake never uploads, so nothing is drained).
  List<InsightEvent> get events => [for (final b in _peek()) ...b];
  List<List<InsightEvent>> _peek() {
    final batches = buffer.drain();
    buffer.restore([for (final b in batches) ...b]);
    return batches;
  }

  Iterable<String> get screens => events.where((e) => e.kind == 'screen').map((e) => e.name);
  Iterable<InsightEvent> get taps => events.where((e) => e.kind == 'tap');
  Iterable<String> get saves => events.where((e) => e.kind == 'save').map((e) => e.name);

  @override
  Future<void> setEnabled(bool on) async => enabled = on;
  @override
  Future<void> flush() async => flushes++;
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
