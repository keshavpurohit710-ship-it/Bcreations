// First launch: language, business name, then start fresh or try sample data.

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../data/database.dart';
import '../settings/settings_screen.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _name = TextEditingController(text: 'Bcreations');
  bool _busy = false;

  Future<void> _write(SettingsCompanion c) {
    final db = ref.read(databaseProvider);
    return (db.update(db.settings)..where((s) => s.id.equals(settingsRowId))).write(c);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final lang = ref.watch(settingsProvider).valueOrNull?.languageCode ?? 'hi';
    return Scaffold(
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(24), children: [
          const SizedBox(height: 24),
          Center(child: Image.asset('assets/branding/icon_foreground.png', width: 120, height: 120)),
          const SizedBox(height: 12),
          Text(t.welcomeTitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(t.welcomeSubtitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 32),
          Text(t.welcomeLanguage, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'hi', label: Text('हिन्दी')),
              ButtonSegment(value: 'en', label: Text('English'))
            ],
            selected: {lang},
            onSelectionChanged: (v) => _write(SettingsCompanion(languageCode: Value(v.first))),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: t.welcomeBusiness),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 24),
          Text(t.welcomeFreshHint, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _busy
                ? null
                : () async {
                    setState(() => _busy = true);
                    await _write(SettingsCompanion(
                      businessName: Value(_name.text.trim().isEmpty ? 'Bcreations' : _name.text.trim()),
                      startDate: Value(DateTime.now()),
                    ));
                  },
            child: Text(t.welcomeStart),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _busy
                ? null
                : () async {
                    setState(() => _busy = true);
                    await loadDemo(ref.read(databaseProvider), languageCode: lang);
                  },
            child: Text(t.welcomeDemo),
          ),
        ]),
      ),
    );
  }
}
