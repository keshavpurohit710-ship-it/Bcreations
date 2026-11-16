// Keeps the phone's scheduled reminders in step with her REAL shop.
// Re-plans (debounced) whenever the real database or reminder settings change;
// the practice shop never schedules anything.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../data/database.dart';
import '../l10n/app_localizations.dart';
import 'providers.dart';
import 'reminders.dart';

/// Talks to Android. Replaced by a fake in tests.
abstract class ReminderScheduler {
  Future<void> apply(List<PlannedReminder> plan, S t);
  Future<void> askPermission();
}

class PhoneReminderScheduler implements ReminderScheduler {
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  Future<void> _init() async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation((await FlutterTimezone.getLocalTimezone()).identifier));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    }
    await _plugin.initialize(
        settings: const InitializationSettings(android: AndroidInitializationSettings('ic_stat_bcreations')));
    _ready = true;
  }

  @override
  Future<void> askPermission() async {
    try {
      await _init();
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } catch (e) {
      debugPrint('Reminder permission: $e');
    }
  }

  @override
  Future<void> apply(List<PlannedReminder> plan, S t) async {
    try {
      await _init();
      await _plugin.cancelAll();
      for (final r in plan) {
        final details = NotificationDetails(
          android: AndroidNotificationDetails(
            r.channel.name,
            r.channel == ReminderChannel.daily ? t.notifChannelDaily : t.notifChannelDelivery,
            importance: Importance.high,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(r.body),
          ),
        );
        await _plugin.zonedSchedule(
          id: r.id,
          title: r.title,
          body: r.body,
          scheduledDate: tz.TZDateTime.from(r.at, tz.local),
          notificationDetails: details,
          // Inexact: no special "alarms" permission needed; a few minutes late is fine.
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: r.repeatsDaily ? DateTimeComponents.time : null,
        );
      }
    } catch (e) {
      debugPrint('Reminders not scheduled: $e');
    }
  }
}

final reminderSchedulerProvider = Provider<ReminderScheduler>((ref) => PhoneReminderScheduler());

/// Off in widget tests: the debounce timer runs on the test's fake clock.
final reminderSyncEnabledProvider = Provider<bool>((ref) => true);

/// Plans and schedules reminders from her real shop once. Returns the plan.
Future<List<PlannedReminder>> syncRemindersOnce(
  AppDatabase db,
  ReminderScheduler scheduler, {
  required DateTime now,
  bool askPermission = false,
}) async {
  final settings = await db.getSettings();
  if (settings.startDate == null) return const []; // her real shop hasn't started yet
  if (askPermission && settings.notifyEnabled) await scheduler.askPermission();
  final t = lookupS(Locale(settings.languageCode));
  final plan = planReminders(
    facts: await loadReminderFacts(db, today: now),
    now: now,
    enabled: settings.notifyEnabled,
    minutesAfterMidnight: settings.notifyMinutes,
    t: t,
  );
  await scheduler.apply(plan, t);
  return plan;
}

class ReminderSync extends ConsumerStatefulWidget {
  const ReminderSync({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<ReminderSync> createState() => _ReminderSyncState();
}

class _ReminderSyncState extends ConsumerState<ReminderSync> {
  StreamSubscription<void>? _changes;
  Timer? _debounce;
  bool _askedPermission = false;

  @override
  void initState() {
    super.initState();
    if (!ref.read(reminderSyncEnabledProvider)) return;
    _changes = ref.read(realDatabaseProvider).tableUpdates().listen((_) => _schedule());
    _schedule();
  }

  @override
  void dispose() {
    _changes?.cancel();
    _debounce?.cancel();
    super.dispose();
  }

  void _schedule() {
    if (!ref.read(reminderSyncEnabledProvider)) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 2), _sync);
  }

  Future<void> _sync() async {
    if (!mounted) return;
    final ask = !_askedPermission;
    _askedPermission = true;
    await syncRemindersOnce(
      ref.read(realDatabaseProvider),
      ref.read(reminderSchedulerProvider),
      now: DateTime.now(),
      askPermission: ask,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Settings changes (on/off, time, language) re-plan too
    ref.listen(realSettingsProvider, (_, __) => _schedule());
    return widget.child;
  }
}
