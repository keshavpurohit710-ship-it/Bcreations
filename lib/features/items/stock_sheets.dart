// Quick stock entries: bought, made, adjust, shelf count.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/stock_service.dart';
import '../orders/party_picker.dart';
import 'product_picker.dart';

Future<void> showBuySheet(BuildContext context, {Product? product}) => showFormSheet(context, _BuyForm(product));
Future<void> showMakeSheet(BuildContext context, {Product? product}) => showFormSheet(context, _MakeForm(product));
Future<void> showAdjustSheet(BuildContext context, Product product) => showFormSheet(context, _AdjustForm(product));
Future<void> showCountSheet(BuildContext context, Product product) => showFormSheet(context, _CountForm(product));

class _ProductField extends StatelessWidget {
  const _ProductField({required this.label, required this.product, required this.kinds, required this.onPicked});
  final String label;
  final Product? product;
  final Set<ProductKind> kinds;
  final ValueChanged<Product> onPicked;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async {
          final p = await pickProduct(context, kinds: kinds);
          if (p != null) onPicked(p);
        },
        child: InputDecorator(
          decoration: InputDecoration(labelText: label, suffixIcon: const Icon(Icons.arrow_drop_down)),
          child: Text(product?.name ?? context.t.pickProduct, style: const TextStyle(fontSize: 18)),
        ),
      );
}

// ------------------------------------------------------------------ buy

class _BuyForm extends ConsumerStatefulWidget {
  const _BuyForm(this.initial);
  final Product? initial;

  @override
  ConsumerState<_BuyForm> createState() => _BuyFormState();
}

class _BuyFormState extends ConsumerState<_BuyForm> {
  final _form = GlobalKey<FormState>();
  final _qty = TextEditingController();
  final _cost = TextEditingController();
  late Product? _product = widget.initial;
  Party? _supplier;
  PaymentMethod _method = PaymentMethod.cash;
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Form(
      key: _form,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(t.buyTitle, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        _ProductField(
          label: t.buyItem,
          product: _product,
          kinds: const {ProductKind.rawMaterial, ProductKind.bought},
          onPicked: (p) => setState(() => _product = p),
        ),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(
              child: QtyField(
                  controller: _qty,
                  label: t.quantity,
                  unit: _product?.unit,
                  validator: (v) => requiredQty(context, v))),
          const SizedBox(width: 12),
          Expanded(
              child:
                  MoneyField(controller: _cost, label: t.buyTotalCost, validator: (v) => requiredAmount(context, v))),
        ]),
        const SizedBox(height: 16),
        MethodChips(value: _method, onChanged: (m) => setState(() => _method = m)),
        const SizedBox(height: 16),
        PartyField(
          party: _supplier,
          suppliers: true,
          label: t.buySupplier,
          onPicked: (p) => setState(() => _supplier = p),
        ),
        const SizedBox(height: 16),
        DateRow(label: t.date, date: _date, onChanged: (d) => setState(() => _date = d ?? DateTime.now())),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _saving || _product == null
              ? null
              : () async {
                  if (!_form.currentState!.validate()) return;
                  setState(() => _saving = true);
                  await ref.read(stockProvider).recordPurchase(
                        productId: _product!.id,
                        qtyMilli: parseQty(_qty.text)!,
                        totalCostPaise: parseRupees(_cost.text)!,
                        date: _date,
                        paidWith: _method,
                        supplierId: _supplier?.id,
                      );
                  if (context.mounted) Navigator.pop(context);
                },
          child: Text(t.save),
        ),
      ]),
    );
  }
}

// ----------------------------------------------------------------- make

class _MakeForm extends ConsumerStatefulWidget {
  const _MakeForm(this.initial);
  final Product? initial;

  @override
  ConsumerState<_MakeForm> createState() => _MakeFormState();
}

class _MakeFormState extends ConsumerState<_MakeForm> {
  final _qty = TextEditingController();
  final _hours = TextEditingController();
  late Product? _product = widget.initial;
  List<MaterialNeed> _needs = [];
  bool _hasRecipe = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final p = _product;
    if (p == null) return;
    final stock = ref.read(stockProvider);
    final recipe = await stock.recipe(p.id);
    final needs = await stock.materialNeeds(p.id, parseQty(_qty.text) ?? 0);
    if (mounted) {
      setState(() {
        _hasRecipe = recipe.isNotEmpty;
        _needs = needs;
      });
    }
  }

  Future<void> _save({bool allowShortage = false}) async {
    final qty = parseQty(_qty.text) ?? 0;
    if (_product == null || qty <= 0) return;
    setState(() => _saving = true);
    final minutes = ((double.tryParse(_hours.text.replaceAll(',', '.')) ?? 0) * 60).round();
    try {
      await ref.read(stockProvider).produce(
            productId: _product!.id,
            qtyMilli: qty,
            date: DateTime.now(),
            batchMinutes: minutes,
            allowShortage: allowShortage,
          );
      if (mounted) Navigator.pop(context);
    } on ShortageException {
      setState(() => _saving = false);
      if (!mounted) return;
      if (await confirmDialog(context, context.t.makeShortConfirm, ok: context.t.makeAnyway)) {
        await _save(allowShortage: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final short = _needs.any((n) => n.shortMilli > 0);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(t.makeTitle, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      _ProductField(
        label: t.makeItem,
        product: _product,
        kinds: const {ProductKind.made},
        onPicked: (p) {
          setState(() => _product = p);
          _refresh();
        },
      ),
      if (_product != null && !_hasRecipe)
        Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Pill(t.makeNoRecipe, color: warnColor, icon: Icons.info_outline)),
      const SizedBox(height: 16),
      QtyField(
          controller: _qty,
          label: t.makeHowMany,
          unit: _product?.unit,
          autofocus: _product != null,
          onChanged: (_) => _refresh()),
      const SizedBox(height: 16),
      QtyField(controller: _hours, label: t.makeHours, unit: 'h'),
      if (_needs.isNotEmpty && (parseQty(_qty.text) ?? 0) > 0) ...[
        SectionHeader(t.makeNeeds),
        for (final n in _needs)
          ListTile(
            dense: true,
            title: Text(n.material.name, style: const TextStyle(fontSize: 16)),
            subtitle: Text(
                '${qtyLabel(n.needMilli, n.material.unit)} · ${t.inStock(qtyLabel(n.haveMilli, n.material.unit))}'),
            trailing: n.shortMilli > 0
                ? Pill(t.makeShort(qtyLabel(n.shortMilli, n.material.unit)), color: badColor)
                : const Icon(Icons.check_circle, color: goodColor),
          ),
      ],
      const SizedBox(height: 20),
      if (short)
        OutlinedButton(onPressed: _saving ? null : () => _save(allowShortage: true), child: Text(t.makeAnyway))
      else
        FilledButton(onPressed: _saving || _product == null ? null : _save, child: Text(t.save)),
    ]);
  }
}

// --------------------------------------------------------------- adjust

class _AdjustForm extends ConsumerStatefulWidget {
  const _AdjustForm(this.product);
  final Product product;

  @override
  ConsumerState<_AdjustForm> createState() => _AdjustFormState();
}

class _AdjustFormState extends ConsumerState<_AdjustForm> {
  final _qty = TextEditingController();
  final _other = TextEditingController();
  bool _remove = true;
  String _reason = 'damaged';

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final reasons = {
      'damaged': t.reasonDamaged,
      'home': t.reasonHome,
      'found': t.reasonFound,
      'other': t.reasonOther,
    };
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('${t.adjustTitle} · ${widget.product.name}', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      SegmentedButton<bool>(
        segments: [
          ButtonSegment(value: true, label: Text(t.adjustRemove), icon: const Icon(Icons.remove)),
          ButtonSegment(value: false, label: Text(t.adjustAdd), icon: const Icon(Icons.add)),
        ],
        selected: {_remove},
        onSelectionChanged: (s) => setState(() {
          _remove = s.first;
          _reason = _remove ? 'damaged' : 'found';
        }),
      ),
      const SizedBox(height: 16),
      QtyField(controller: _qty, label: t.quantity, unit: widget.product.unit, autofocus: true),
      const SizedBox(height: 16),
      Wrap(spacing: 8, runSpacing: 8, children: [
        for (final e in reasons.entries)
          ChoiceChip(
              label: Text(e.value), selected: _reason == e.key, onSelected: (_) => setState(() => _reason = e.key)),
      ]),
      if (_reason == 'other') ...[
        const SizedBox(height: 12),
        TextField(controller: _other, decoration: InputDecoration(labelText: t.note)),
      ],
      const SizedBox(height: 20),
      FilledButton(
        onPressed: () async {
          final q = parseQty(_qty.text) ?? 0;
          if (q <= 0) return;
          await ref.read(stockProvider).adjust(
                productId: widget.product.id,
                deltaMilli: _remove ? -q : q,
                reason: _reason == 'other'
                    ? (_other.text.trim().isEmpty ? reasons['other']! : _other.text.trim())
                    : reasons[_reason]!,
                date: DateTime.now(),
              );
          if (context.mounted) Navigator.pop(context);
        },
        child: Text(t.save),
      ),
    ]);
  }
}

// ---------------------------------------------------------------- count

class _CountForm extends ConsumerStatefulWidget {
  const _CountForm(this.product);
  final Product product;

  @override
  ConsumerState<_CountForm> createState() => _CountFormState();
}

class _CountFormState extends ConsumerState<_CountForm> {
  final _qty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('${t.countTitle} · ${widget.product.name}', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      QtyField(controller: _qty, label: t.countHowMany, unit: widget.product.unit, autofocus: true),
      const SizedBox(height: 20),
      FilledButton(
        onPressed: () async {
          final counted = parseQty(_qty.text);
          if (counted == null) return;
          final diff = await ref
              .read(stockProvider)
              .recordCount(productId: widget.product.id, countedMilli: counted, date: DateTime.now());
          if (!context.mounted) return;
          final msg = diff == 0
              ? t.countMatched
              : t.countResult('${diff > 0 ? '+' : ''}${qtyLabel(diff, widget.product.unit)}');
          Navigator.pop(context);
          showMessage(context, msg);
        },
        child: Text(t.save),
      ),
    ]);
  }
}
