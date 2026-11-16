import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/tutorial/tutorial.dart';
import '../features/welcome/setup_screen.dart';
import '../features/welcome/welcome_screen.dart';
import '../l10n/app_localizations.dart';
import 'providers.dart';
import 'reminder_sync.dart';
import 'shell.dart';
import 'theme.dart';

/// What the app shows:
///  1. first launch            -> Welcome (language, then practise or skip)
///  2. practice shop           -> Shell on the practice database, with banner + guide
///  3. tutorial done/skipped   -> "Your shop" setup, then Shell on the real database
class BcApp extends ConsumerWidget {
  const BcApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final real = ref.watch(realSettingsProvider).valueOrNull;
    final practice = real?.practiceActive ?? false;
    final tutorialRunning = practice && real?.tutorialDoneAt == null;

    final Widget home;
    if (real == null) {
      home = const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (practice) {
      home = const Shell(key: ValueKey('practice'));
    } else if (real.startDate == null) {
      home = real.tutorialDoneAt == null ? const WelcomeScreen() : const SetupScreen();
    } else {
      home = const Shell(key: ValueKey('real'));
    }

    return MaterialApp(
      title: 'Bcreations',
      debugShowCheckedModeBanner: false,
      navigatorKey: appNavigatorKey,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: switch (real?.themeMode) {
        'dark' => ThemeMode.dark,
        'system' => ThemeMode.system,
        _ => ThemeMode.light,
      },
      locale: Locale(real?.languageCode ?? 'hi'),
      supportedLocales: S.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Banner and guide sit above every screen, so the prompts stay visible
      // while she fills in a form.
      builder: (context, child) => ReminderSync(
        child: !practice
            ? child!
            : Column(children: [
                const PracticeBanner(),
                if (tutorialRunning) const TutorialCoach(),
                Expanded(child: MediaQuery.removePadding(context: context, removeTop: true, child: child!)),
              ]),
      ),
      home: home,
    );
  }
}
