// Asked once: may the app send usage and a copy of the data so problems can be
// fixed from afar? Plain words, both choices equally easy, changeable later.

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../data/database.dart';

class ConsentScreen extends ConsumerWidget {
  const ConsentScreen({super.key, this.popWhenDone = false});

  /// Opened on top of another screen (first run) rather than as Home.
  final bool popWhenDone;

  Future<void> _answer(BuildContext context, WidgetRef ref, bool yes) async {
    final db = ref.read(realDatabaseProvider);
    await (db.update(db.settings)..where((s) => s.id.equals(settingsRowId)))
        .write(SettingsCompanion(insightsConsent: Value(yes)));
    if (popWhenDone && context.mounted) Navigator.pop(context, yes);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final lang = ref.watch(realSettingsProvider).valueOrNull?.languageCode ?? 'hi';
    Widget point(IconData icon, String text) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
          ]),
        );
    return Scaffold(
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(24), children: [
          // Language first, so she can read the rest
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'hi', label: Text('हिन्दी')),
              ButtonSegment(value: 'en', label: Text('English')),
            ],
            selected: {lang},
            onSelectionChanged: (v) => ref.read(practiceProvider).setLanguage(v.first),
          ),
          const SizedBox(height: 20),
          const Center(child: CircleAvatar(radius: 36, child: Icon(Icons.support_agent, size: 36))),
          const SizedBox(height: 16),
          Text(t.consentTitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(t.consentIntro, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          point(Icons.touch_app_outlined, t.consentTaps),
          point(Icons.bug_report_outlined, t.consentErrors),
          point(Icons.storage_outlined, t.consentData),
          point(Icons.photo_outlined, t.consentPhotos),
          point(Icons.lock_outline, t.consentWho),
          point(Icons.toggle_on_outlined, t.consentChange),
          const SizedBox(height: 16),
          FilledButton(onPressed: () => _answer(context, ref, true), child: Text(t.consentYes)),
          const SizedBox(height: 10),
          OutlinedButton(onPressed: () => _answer(context, ref, false), child: Text(t.consentNo)),
        ]),
      ),
    );
  }
}
