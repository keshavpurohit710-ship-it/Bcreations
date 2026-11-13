// Two-tap money entries: an expense, or money taken for home.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/entry_service.dart';

Future<void> showExpenseSheet(BuildContext context) => showFormSheet(context, const _EntryForm(withdrawal: false));
Future<void> showWithdrawalSheet(BuildContext context) => showFormSheet(context, const _EntryForm(withdrawal: true));

class _EntryForm extends ConsumerStatefulWidget {
  const _EntryForm({required this.withdrawal});
  final bool withdrawal;

  @override
  ConsumerState<_EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends ConsumerState<_EntryForm> {
  final _form = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _note = TextEditingController();
  String _category = expenseCategories.first;
  PaymentMethod _method = PaymentMethod.cash;
  DateTime _date = DateTime.now();
  bool _saving = false;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    final t = context.t;
    final notice = UndoNotice.of(context);
    final entries = ref.read(entriesProvider);
    final amount = parseRupees(_amount.text)!;
    final note = _note.text.trim().isEmpty ? null : _note.text.trim();
    final String id;
    if (widget.withdrawal) {
      id = await entries.addWithdrawal(amountPaise: amount, method: _method, date: _date, note: note);
    } else {
      id = await entries.addExpense(category: _category, amountPaise: amount, method: _method, date: _date, note: note);
    }
    if (!mounted) return;
    Navigator.pop(context);
    notice.show('${t.saved} · ${formatPaise(amount)}',
        () => widget.withdrawal ? entries.setWithdrawalDeleted(id, true) : entries.setExpenseDeleted(id, true));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Form(
      key: _form,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(widget.withdrawal ? t.withdrawalTitle : t.expenseTitle, style: Theme.of(context).textTheme.titleLarge),
        if (widget.withdrawal) ...[
          const SizedBox(height: 8),
          Text(t.withdrawalHint, style: Theme.of(context).textTheme.bodyMedium),
        ],
        const SizedBox(height: 16),
        MoneyField(controller: _amount, label: t.amount, autofocus: true, validator: (v) => requiredAmount(context, v)),
        if (!widget.withdrawal) ...[
          const SizedBox(height: 16),
          Text(t.expenseCategory, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final c in expenseCategories)
              ChoiceChip(
                  label: Text(t.categoryName(c)),
                  selected: _category == c,
                  onSelected: (_) => setState(() => _category = c)),
          ]),
        ],
        const SizedBox(height: 16),
        MethodChips(value: _method, onChanged: (m) => setState(() => _method = m)),
        const SizedBox(height: 16),
        DateRow(label: t.date, date: _date, onChanged: (d) => setState(() => _date = d ?? DateTime.now())),
        const SizedBox(height: 16),
        TextField(controller: _note, decoration: InputDecoration(labelText: t.note)),
        const SizedBox(height: 20),
        FilledButton(onPressed: _saving ? null : _save, child: Text(t.save)),
      ]),
    );
  }
}
