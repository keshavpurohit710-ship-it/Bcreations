import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/welcome/welcome_screen.dart';
import '../l10n/app_localizations.dart';
import 'providers.dart';
import 'shell.dart';
import 'theme.dart';

class BcApp extends ConsumerWidget {
  const BcApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).valueOrNull;
    return MaterialApp(
      title: 'Bcreations',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: switch (settings?.themeMode) {
        'dark' => ThemeMode.dark,
        'system' => ThemeMode.system,
        _ => ThemeMode.light,
      },
      locale: Locale(settings?.languageCode ?? 'hi'),
      supportedLocales: S.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: settings == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : settings.startDate == null
              ? const WelcomeScreen()
              : const Shell(),
    );
  }
}
