import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../data/demo_seed.dart';
import '../../domain/money.dart';

/// Wipes every table and puts back a fresh settings row.
Future<void> resetDatabase(AppDatabase db) => db.transaction(() async {
      for (final table in db.allTables.toList().reversed) {
        await db.delete(table).go();
      }
      await db.into(db.settings).insert(SettingsCompanion.insert(id: const Value(settingsRowId)));
    });

Future<void> loadDemo(AppDatabase db, {required String languageCode}) async {
  await resetDatabase(db);
  await seedDemoData(db, today: DateTime.now());
  await (db.update(db.settings)..where((s) => s.id.equals(settingsRowId)))
      .write(SettingsCompanion(languageCode: Value(languageCode)));
}

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _name = TextEditingController();
  final _upi = TextEditingController();
  final _phone = TextEditingController();
  final _hourly = TextEditingController();
  final _overhead = TextEditingController();
  final _retail = TextEditingController();
  final _wholesale = TextEditingController();
  final _margin = TextEditingController();
  final _terms = TextEditingController();
  bool _loaded = false;

  void _fill(Setting s) {
    if (_loaded) return;
    _loaded = true;
    _name.text = s.businessName;
    _upi.text = s.upiId ?? '';
    _phone.text = s.phone ?? '';
    _hourly.text = rupeesText(s.hourlyRatePaise);
    _overhead.text = (s.overheadBp / 100).toStringAsFixed(0);
    _retail.text = (s.retailMarkupBp / bpPerWhole).toString();
    _wholesale.text = (s.wholesaleMarkupBp / bpPerWhole).toString();
    _margin.text = (s.targetMarginBp / 100).toStringAsFixed(0);
    _terms.text = '${s.wholesaleTermsDays}';
  }

  Future<void> _write(SettingsCompanion c) {
    final db = ref.read(databaseProvider);
    return (db.update(db.settings)..where((s) => s.id.equals(settingsRowId)))
        .write(c.copyWith(updatedAt: Value(DateTime.now())));
  }

  int? _bp(String text, int scale) {
    final v = double.tryParse(text.replaceAll(',', '.').trim());
    return v == null ? null : (v * scale).round();
  }

  Future<void> _saveAll() async {
    String? text(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();
    await _write(SettingsCompanion(
      businessName: Value(text(_name) ?? 'Bcreations'),
      upiId: Value(text(_upi)),
      phone: Value(text(_phone)),
      hourlyRatePaise: Value(parseRupees(_hourly.text) ?? 0),
      overheadBp: Value(_bp(_overhead.text, 100) ?? 1000),
      retailMarkupBp: Value(_bp(_retail.text, bpPerWhole) ?? 25000),
      wholesaleMarkupBp: Value(_bp(_wholesale.text, bpPerWhole) ?? 18000),
      targetMarginBp: Value(_bp(_margin.text, 100) ?? 4000),
      wholesaleTermsDays: Value(int.tryParse(_terms.text.trim()) ?? 15),
    ));
    if (mounted) showMessage(context, context.t.saved);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final settings = ref.watch(settingsProvider).valueOrNull;
    if (settings == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    _fill(settings);
    Widget field(TextEditingController c, String label, {bool number = false}) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: TextField(
            controller: c,
            keyboardType: number ? const TextInputType.numberWithOptions(decimal: true) : null,
            decoration: InputDecoration(labelText: label),
          ),
        );
    return Scaffold(
      appBar: AppBar(title: Text(t.settingsTitle)),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text(t.settingsLanguage, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'hi', label: Text('हिन्दी')),
            ButtonSegment(value: 'en', label: Text('English'))
          ],
          selected: {settings.languageCode},
          onSelectionChanged: (v) => _write(SettingsCompanion(languageCode: Value(v.first))),
        ),
        const SizedBox(height: 20),
        Text(t.settingsTheme, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: [
            ButtonSegment(value: 'light', label: Text(t.themeLight)),
            ButtonSegment(value: 'dark', label: Text(t.themeDark)),
            ButtonSegment(value: 'system', label: Text(t.themeSystem)),
          ],
          selected: {settings.themeMode},
          onSelectionChanged: (v) => _write(SettingsCompanion(themeMode: Value(v.first))),
        ),
        const SizedBox(height: 24),
        field(_name, t.settingsBusiness),
        field(_upi, t.settingsUpi),
        field(_phone, t.settingsPhone),
        SectionHeader(t.settingsPricing),
        field(_hourly, t.settingsHourly, number: true),
        field(_overhead, t.settingsOverhead, number: true),
        field(_retail, t.settingsRetailMarkup, number: true),
        field(_wholesale, t.settingsWholesaleMarkup, number: true),
        field(_margin, t.settingsTargetMargin, number: true),
        field(_terms, t.settingsTerms, number: true),
        FilledButton(onPressed: _saveAll, child: Text(t.save)),
        SectionHeader(t.settingsData),
        OutlinedButton.icon(
          icon: const Icon(Icons.science_outlined),
          label: Text(t.settingsDemo),
          onPressed: () async {
            if (!await confirmDialog(context, t.settingsDemoConfirm, ok: t.settingsDemo, danger: true)) return;
            await loadDemo(ref.read(databaseProvider), languageCode: settings.languageCode);
            if (context.mounted) {
              Navigator.pop(context);
              showMessage(context, t.demoLoaded);
            }
          },
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          icon: const Icon(Icons.delete_forever_outlined),
          label: Text(t.settingsReset),
          onPressed: () async {
            if (!await confirmDialog(context, t.settingsResetConfirm, ok: t.settingsReset, danger: true)) return;
            await resetDatabase(ref.read(databaseProvider));
            if (context.mounted) Navigator.pop(context);
          },
        ),
      ]),
    );
  }
}
