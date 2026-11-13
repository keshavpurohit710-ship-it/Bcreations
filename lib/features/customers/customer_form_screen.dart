import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';

/// New or edit customer / supplier. Only the name is required.
class CustomerFormScreen extends ConsumerStatefulWidget {
  const CustomerFormScreen({super.key, this.party, this.initialRole = PartyRole.customer});
  final Party? party;
  final PartyRole initialRole;

  @override
  ConsumerState<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends ConsumerState<CustomerFormScreen> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.party?.name);
  late final _business = TextEditingController(text: widget.party?.businessName);
  late final _phone = TextEditingController(text: widget.party?.phone);
  late final _limit = TextEditingController(text: rupeesText(widget.party?.creditLimitPaise));
  late final _terms = TextEditingController(text: widget.party?.paymentTermsDays?.toString() ?? '');
  late final _opening = TextEditingController(
      text: (widget.party?.openingBalancePaise ?? 0) == 0 ? '' : rupeesText(widget.party!.openingBalancePaise));
  late final _notes = TextEditingController(text: widget.party?.notes);
  late PartyRole _role = widget.party?.role ?? widget.initialRole;
  late PriceType _price = widget.party?.priceType ?? PriceType.retail;
  bool _more = false;
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_name, _business, _phone, _limit, _terms, _opening, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    String? text(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();
    final id = await ref.read(catalogProvider).saveParty(
          PartiesCompanion(
            name: Value(_name.text.trim()),
            businessName: Value(text(_business)),
            phone: Value(text(_phone)),
            role: Value(_role),
            priceType: Value(_price),
            defaultChannel: Value(_price == PriceType.wholesale ? SalesChannel.shop : SalesChannel.individual),
            creditLimitPaise: Value(parseRupees(_limit.text)),
            paymentTermsDays: Value(int.tryParse(_terms.text.trim())),
            openingBalancePaise: Value(parseRupees(_opening.text) ?? 0),
            notes: Value(text(_notes)),
          ),
          id: widget.party?.id,
        );
    if (mounted) Navigator.pop(context, id);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final isCustomer = _role != PartyRole.supplier;
    return Scaffold(
      appBar: AppBar(title: Text(widget.party == null ? t.customerNew : t.customerEdit)),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(20), children: [
          TextFormField(
            controller: _name,
            autofocus: widget.party == null,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(labelText: t.customerName),
            style: const TextStyle(fontSize: 20),
            validator: (v) => (v ?? '').trim().isEmpty ? t.required : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: t.customerPhone, prefixIcon: const Icon(Icons.phone)),
          ),
          const SizedBox(height: 20),
          Text(t.customerType, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<PartyRole>(
            segments: [
              for (final r in PartyRole.values) ButtonSegment(value: r, label: Text(t.role(r))),
            ],
            selected: {_role},
            onSelectionChanged: (s) => setState(() => _role = s.first),
          ),
          if (isCustomer) ...[
            const SizedBox(height: 20),
            Text(t.priceTypeLabel, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<PriceType>(
              segments: [
                ButtonSegment(value: PriceType.retail, label: Text(t.priceRetail)),
                ButtonSegment(value: PriceType.wholesale, label: Text(t.priceWholesale)),
              ],
              selected: {_price},
              onSelectionChanged: (s) => setState(() => _price = s.first),
            ),
            const SizedBox(height: 20),
            MoneyField(controller: _opening, label: t.openingOwes),
          ],
          const SizedBox(height: 8),
          if (!_more)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => setState(() => _more = true),
                icon: const Icon(Icons.expand_more),
                label: Text(t.orderMore),
              ),
            )
          else ...[
            const SizedBox(height: 12),
            TextFormField(controller: _business, decoration: InputDecoration(labelText: t.customerBusiness)),
            if (isCustomer) ...[
              const SizedBox(height: 16),
              MoneyField(controller: _limit, label: t.creditLimit),
              const SizedBox(height: 16),
              TextFormField(
                controller: _terms,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: t.paymentTerms),
              ),
            ],
            const SizedBox(height: 16),
            TextFormField(controller: _notes, maxLines: 2, decoration: InputDecoration(labelText: t.note)),
          ],
          const SizedBox(height: 24),
          FilledButton(onPressed: _saving ? null : _save, child: Text(t.save)),
        ]),
      ),
    );
  }
}
