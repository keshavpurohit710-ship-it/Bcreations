// Everything a widget test needs to boot the real app: in-memory real and
// practice shops, and a reminder scheduler that records instead of calling Android.

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

class TestShops {
  TestShops(this.real) : practice = AppDatabase(NativeDatabase.memory());
  final AppDatabase real;
  final AppDatabase practice;
  final scheduler = FakeScheduler();

  List<Override> get overrides => [
        realDatabaseProvider.overrideWithValue(real),
        practiceDatabaseProvider.overrideWithValue(practice),
        reminderSchedulerProvider.overrideWithValue(scheduler),
        reminderSyncEnabledProvider.overrideWithValue(false),
      ];
}
