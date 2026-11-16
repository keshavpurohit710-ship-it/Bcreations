// First launch: choose a language, then learn with the practice shop or skip.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    await action();
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final lang = ref.watch(realSettingsProvider).valueOrNull?.languageCode ?? 'hi';
    final practice = ref.read(practiceProvider);
    return Scaffold(
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(24), children: [
          const SizedBox(height: 16),
          Center(child: Image.asset('assets/branding/icon_foreground.png', width: 110, height: 110)),
          const SizedBox(height: 8),
          Text(t.welcomeTitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(t.welcomeSubtitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 28),
          // Language first, before anything else
          Text(t.welcomeLanguage, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'hi', label: Text('हिन्दी')),
              ButtonSegment(value: 'en', label: Text('English')),
            ],
            selected: {lang},
            onSelectionChanged: (v) => practice.setLanguage(v.first),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: _busy ? null : () => _run(() => practice.enter(fresh: true)),
            icon: const Icon(Icons.school),
            label: Text(t.welcomeLearn),
          ),
          const SizedBox(height: 6),
          Text(t.welcomeLearnHint, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 20),
          TextButton(
            onPressed: _busy ? null : () => _run(practice.skipTutorial),
            child: Text(t.welcomeSkip),
          ),
        ]),
      ),
    );
  }
}
