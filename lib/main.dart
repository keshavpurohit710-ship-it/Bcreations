import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/insights/firebase_insights.dart';
import 'app/insights/insights_sync.dart';
import 'app/providers.dart';
import 'data/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late final ProviderContainer container;

  // Help from afar: starts switched off; InsightsSync turns it on only if she agreed.
  final insights = await FirebaseInsights.start(shops: {
    'real': () => container.read(realDatabaseProvider),
    'practice': () => container.read(practiceDatabaseProvider),
  });
  if (insights is FirebaseInsights) {
    final previous = FlutterError.onError;
    FlutterError.onError = (details) {
      insights.recordFlutterError(details);
      previous?.call(details);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      insights.recordError(error, stack, fatal: true);
      return false; // let Flutter report it as usual too
    };
  }

  container = ProviderContainer(overrides: [
    realDatabaseProvider.overrideWithValue(AppDatabase()),
    insightsProvider.overrideWithValue(insights),
  ]);
  runApp(UncontrolledProviderScope(container: container, child: const BcApp()));
}
