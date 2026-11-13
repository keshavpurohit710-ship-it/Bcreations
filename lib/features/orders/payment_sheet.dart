// "Payment received": a few taps. Amount is pre-filled with what's due.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import 'party_picker.dart';

Future<void> showPaymentSheet(BuildContext context, {String? partyId, String? orderId}) =>
    showFormSheet(context, _PaymentForm(partyId: partyId, orderId: orderId));

class _PaymentForm extends ConsumerStatefulWidget {
  const _PaymentForm({this.partyId, this.orderId});
  final String? partyId;
  final String? orderId;

  @override
  ConsumerState<_PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends ConsumerState<_PaymentForm> {
  final _form = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _ref = TextEditingController();
  Party? _party;
  Order? _order;
  PaymentMethod _method = PaymentMethod.upi;
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ledger = ref.read(ledgerProvider);
    if (widget.orderId != null) {
      final o = await ref.read(ordersServiceProvider).get(widget.orderId!);
      final due = await ledger.orderBalance(o.id);
      _order = o;
      _party = await ref.read(catalogProvider).party(o.partyId);
      if (due > 0) _amount.text = rupeesText(due);
    } else if (widget.partyId != null) {
      await _setParty(widget.partyId!);
    }
    if (mounted) setState(() {});
  }

  Future<void> _setParty(String id) async {
    _party = await ref.read(catalogProvider).party(id);
    final bal = await ref.read(ledgerProvider).customerBalance(id);
    _amount.text = bal > 0 ? rupeesText(bal) : '';
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _amount.dispose();
    _ref.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_party == null || !_form.currentState!.validate()) return;
    setState(() => _saving = true);
    final ledger = ref.read(ledgerProvider);
    final notice = UndoNotice.of(context);
    final savedText = context.t.paymentSaved(formatPaise(parseRupees(_amount.text)!));
    final amount = parseRupees(_amount.text)!;
    final id = await ledger.receivePayment(
      partyId: _party!.id,
      amountPaise: amount,
      method: _method,
      date: _date,
      orderId: _order?.id,
      reference: _ref.text.trim().isEmpty ? null : _ref.text.trim(),
    );
    if (!mounted) return;
    Navigator.pop(context);
    notice.show(savedText, () async {
      await ledger.deletePayment(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Form(
      key: _form,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(t.paymentTitle, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        PartyField(
          party: _party,
          enabled: widget.orderId == null && widget.partyId == null,
          onPicked: (p) => _setParty(p.id),
        ),
        if (_order != null)
          Padding(padding: const EdgeInsets.only(top: 8), child: Text(t.paymentForOrder(_order!.number))),
        if (_order == null && _party != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(t.paymentAnyOrder, style: Theme.of(context).textTheme.bodySmall),
          ),
        const SizedBox(height: 16),
        MoneyField(controller: _amount, label: t.amount, autofocus: true, validator: (v) => requiredAmount(context, v)),
        const SizedBox(height: 16),
        MethodChips(value: _method, onChanged: (m) => setState(() => _method = m)),
        const SizedBox(height: 16),
        DateRow(label: t.date, date: _date, onChanged: (d) => setState(() => _date = d ?? DateTime.now())),
        const SizedBox(height: 16),
        TextFormField(controller: _ref, decoration: InputDecoration(labelText: t.paymentReference)),
        const SizedBox(height: 20),
        FilledButton(onPressed: _saving || _party == null ? null : _save, child: Text(t.save)),
      ]),
    );
  }
}
