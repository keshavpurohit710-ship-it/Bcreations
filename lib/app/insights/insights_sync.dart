// Connects the app to [Insights]: consent, screens, taps, saves, uploads.

import 'dart:async';

import 'package:drift/drift.dart' show TableUpdate, Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database.dart';
import '../providers.dart';
import '../shell.dart';
import 'insights.dart';

final insightsProvider = Provider<Insights>((ref) => NoInsights());

/// Whether to show the one-time consent screen. Tests that are not about
/// consent switch it off so they start where they always did.
final askConsentProvider = Provider<bool>((ref) => true);

/// Name of whatever is on screen: the top screen or sheet, or the current tab.
class ScreenTracker extends NavigatorObserver {
  ScreenTracker(this._onScreen);
  final void Function(String name) _onScreen;
  final _stack = <Route<dynamic>>[];
  String tabName = 'tab:Home';
  String current = 'tab:Home';

  static const _tabs = ['Home', 'Orders', 'Customers', 'Items', 'Money'];

  void setTab(int index) {
    tabName = 'tab:${_tabs[index.clamp(0, _tabs.length - 1)]}';
    _update();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.add(route);
    // The page is built on the next frame; then its widget names are known.
    WidgetsBinding.instance.addPostFrameCallback((_) => _update());
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.remove(route);
    _update();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.remove(route);
    _update();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null) _stack.remove(oldRoute);
    if (newRoute != null) _stack.add(newRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) => _update());
  }

  void _update() {
    final top = _stack.length > 1 ? _nameOf(_stack.last) : null;
    final name = top ?? tabName;
    if (name != current) {
      current = name;
      _onScreen(name);
    }
  }

  /// Finds the first widget in the route whose type names a screen, sheet or form.
  static String? _nameOf(Route<dynamic> route) {
    if (route.settings.name != null && route.settings.name != '/') return route.settings.name;
    final context = route is ModalRoute ? route.subtreeContext : null;
    if (context == null) return route.runtimeType.toString();
    String? found;
    var depth = 0;
    void visit(Element e) {
      if (found != null || depth > 40) return;
      final type = e.widget.runtimeType.toString();
      if (type.endsWith('Screen') || type.endsWith('Form') || type.endsWith('Picker') || type.endsWith('Dialog')) {
        found = type.replaceFirst('_', '');
        return;
      }
      depth++;
      e.visitChildElements(visit);
      depth--;
    }

    (context as Element).visitChildElements(visit);
    return found ?? (route is PopupRoute ? 'popup' : route.runtimeType.toString());
  }
}

final screenTrackerProvider = Provider<ScreenTracker>((ref) {
  final insights = ref.watch(insightsProvider);
  return ScreenTracker(insights.screen);
});

class InsightsSync extends ConsumerStatefulWidget {
  const InsightsSync({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<InsightsSync> createState() => _InsightsSyncState();
}

class _InsightsSyncState extends ConsumerState<InsightsSync> with WidgetsBindingObserver {
  final _subs = <StreamSubscription<Set<TableUpdate>>>[];

  Insights get _insights => ref.read(insightsProvider);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _listenTo(ref.read(realDatabaseProvider), 'real');
  }

  void _listenTo(AppDatabase db, String shop) {
    _subs.add(db.tableUpdates().listen((updates) {
      for (final u in updates) {
        _insights.save('$shop.${u.table}', u.kind?.name ?? 'change');
      }
    }));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _insights.event('app_background');
      _insights.flush();
    } else if (state == AppLifecycleState.resumed) {
      _insights.event('app_open');
      _maybeDailySnapshot();
    }
  }

  /// At most one automatic data copy per day.
  Future<void> _maybeDailySnapshot() async {
    if (!_insights.enabled) return;
    final db = ref.read(realDatabaseProvider);
    final s = await db.getSettings();
    final last = s.lastSnapshotAt;
    if (last != null && DateTime.now().difference(last) < const Duration(hours: 24)) return;
    if (await _insights.sendSnapshot(reason: 'daily')) {
      await (db.update(db.settings)..where((x) => x.id.equals(settingsRowId)))
          .write(SettingsCompanion(lastSnapshotAt: Value(DateTime.now())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tracker = ref.watch(screenTrackerProvider);
    ref.listen(realSettingsProvider, (prev, next) async {
      final consent = next.valueOrNull?.insightsConsent ?? false;
      if (consent != _insights.enabled) {
        await _insights.setEnabled(consent);
        if (consent) {
          _insights.event('app_open', {'language': next.valueOrNull?.languageCode});
          unawaited(_maybeDailySnapshot());
        }
      }
      final practice = next.valueOrNull?.practiceActive ?? false;
      if (practice != (prev?.valueOrNull?.practiceActive ?? false)) {
        _insights.event(practice ? 'practice_on' : 'practice_off');
        if (practice && _subs.length == 1) _listenTo(ref.read(practiceDatabaseProvider), 'practice');
      }
    });
    ref.listen(shellTabProvider, (_, i) => tracker.setTab(i));

    // Every tap: which screen, and where (as % of the screen)
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerUp: (e) {
        final size = MediaQuery.sizeOf(context);
        if (size.width > 0 && size.height > 0) {
          _insights.tap(tracker.current, e.position.dx / size.width, e.position.dy / size.height);
        }
      },
      child: widget.child,
    );
  }
}
