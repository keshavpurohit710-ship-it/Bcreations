// "Your shop": the few things needed before her real records start.
// Everything else (stock, who owes, orders in progress) comes from the
// checklist on Home, at her own pace.

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../data/database.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final _name = TextEditingController(text: 'Bcreations');
  final _upi = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _upi.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    setState(() => _busy = true);
    final db = ref.read(realDatabaseProvider);
    await (db.update(db.settings)..where((s) => s.id.equals(settingsRowId))).write(SettingsCompanion(
      businessName: Value(_name.text.trim().isEmpty ? 'Bcreations' : _name.text.trim()),
      upiId: Value(_upi.text.trim().isEmpty ? null : _upi.text.trim()),
      startDate: Value(DateTime.now()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t.setupTitle)),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(
          controller: _name,
          decoration: InputDecoration(labelText: t.welcomeBusiness),
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 16),
        TextField(controller: _upi, decoration: InputDecoration(labelText: t.setupUpi)),
        const SizedBox(height: 20),
        Text(t.welcomeFreshHint, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 24),
        FilledButton(onPressed: _busy ? null : _start, child: Text(t.setupStart)),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _busy ? null : () => ref.read(practiceProvider).enter(),
          child: Text(t.setupPractiseFirst),
        ),
      ]),
    );
  }
}
