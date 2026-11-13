// New / edit item. Only name and kind matter; everything else can come later.

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/catalog_service.dart';
import 'product_picker.dart';

const _units = ['pcs', 'm', 'cm', 'kg', 'g', 'L', 'ml', 'box', 'set', 'pair'];

class _RecipeDraft {
  _RecipeDraft(this.material, String qty) : qty = TextEditingController(text: qty);
  final Product material;
  final TextEditingController qty;
}

class ItemFormScreen extends ConsumerStatefulWidget {
  const ItemFormScreen({super.key, this.productId});
  final String? productId;

  @override
  ConsumerState<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends ConsumerState<ItemFormScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _category = TextEditingController();
  final _retail = TextEditingController();
  final _wholesale = TextEditingController();
  final _minStock = TextEditingController();
  final _openingQty = TextEditingController();
  final _openingCost = TextEditingController();
  final _recipe = <_RecipeDraft>[];
  ProductKind _kind = ProductKind.made;
  String _unit = 'pcs';
  String? _photo;
  bool _loading = true;
  bool _saving = false;

  bool get _editing => widget.productId != null;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (_editing) {
      final d = await ref.read(productDetailProvider(widget.productId!).future);
      final p = d.row.product;
      _name.text = p.name;
      _category.text = p.category ?? '';
      _retail.text = rupeesText(p.retailPricePaise);
      _wholesale.text = rupeesText(p.wholesalePricePaise);
      _minStock.text = p.minStockMilli == 0 ? '' : formatMilli(p.minStockMilli);
      _kind = p.kind;
      _unit = p.unit;
      _photo = p.photoPath;
      for (final (line, material) in d.recipe) {
        _recipe.add(_RecipeDraft(material, formatMilli(line.qtyMilli)));
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _category,
      _retail,
      _wholesale,
      _minStock,
      _openingQty,
      _openingCost,
      ..._recipe.map((r) => r.qty)
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    final catalog = ref.read(catalogProvider);
    final retail = parseRupees(_retail.text);
    final id = await catalog.saveProduct(
      ProductsCompanion(
        name: Value(_name.text.trim()),
        kind: Value(_kind),
        unit: Value(_unit),
        category: Value(_category.text.trim().isEmpty ? null : _category.text.trim()),
        photoPath: Value(_photo),
        retailPricePaise: Value(_kind == ProductKind.rawMaterial ? null : retail),
        wholesalePricePaise: Value(_kind == ProductKind.rawMaterial ? null : parseRupees(_wholesale.text)),
        minStockMilli: Value(parseQty(_minStock.text) ?? 0),
      ),
      id: widget.productId,
      recipe: _kind == ProductKind.made
          ? [for (final r in _recipe) RecipeInput(r.material.id, parseQty(r.qty.text) ?? 0)]
          : null,
      openingQtyMilli: parseQty(_openingQty.text) ?? 0,
      openingUnitCostPaise: parseRupees(_openingCost.text) ?? 0,
      today: DateTime.now(),
    );
    if (retail != null) await catalog.markPriceSet(id);
    if (mounted) Navigator.pop(context, id);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final sells = _kind != ProductKind.rawMaterial;
    return Scaffold(
      appBar: AppBar(title: Text(_editing ? t.itemEdit : t.itemNew)),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(20), children: [
          Row(children: [
            InkWell(
              onTap: () async {
                final path = await choosePhoto(context);
                if (path != null) setState(() => _photo = path);
              },
              child: _photo == null
                  ? Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.outline),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.add_a_photo_outlined),
                    )
                  : PhotoThumb(_photo!, onRemove: () => setState(() => _photo = null)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _name,
                autofocus: !_editing,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: t.itemName),
                style: const TextStyle(fontSize: 20),
                validator: (v) => (v ?? '').trim().isEmpty ? t.required : null,
              ),
            ),
          ]),
          const SizedBox(height: 20),
          Text(t.itemKind, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final k in [ProductKind.made, ProductKind.bought, ProductKind.rawMaterial])
              ChoiceChip(label: Text(t.kind(k)), selected: _kind == k, onSelected: (_) => setState(() => _kind = k)),
          ]),
          const SizedBox(height: 20),
          Text(t.itemUnit, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final u in {..._units, _unit})
              ChoiceChip(label: Text(u), selected: _unit == u, onSelected: (_) => setState(() => _unit = u)),
          ]),
          if (!_editing) ...[
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: QtyField(controller: _openingQty, label: t.itemOpeningQty, unit: _unit)),
              const SizedBox(width: 12),
              Expanded(child: MoneyField(controller: _openingCost, label: t.itemOpeningCost)),
            ]),
          ],
          if (sells) ...[
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: MoneyField(controller: _retail, label: t.itemRetail)),
              const SizedBox(width: 12),
              Expanded(child: MoneyField(controller: _wholesale, label: t.itemWholesale)),
            ]),
          ],
          if (_kind == ProductKind.made) ...[
            SectionHeader(t.itemRecipe),
            for (final (i, r) in _recipe.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(children: [
                  Expanded(flex: 3, child: Text(r.material.name, style: const TextStyle(fontSize: 17))),
                  Expanded(flex: 2, child: QtyField(controller: r.qty, label: t.quantity, unit: r.material.unit)),
                  IconButton(
                      icon: const Icon(Icons.delete_outline), onPressed: () => setState(() => _recipe.removeAt(i))),
                ]),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final m = await pickProduct(context, kinds: {ProductKind.rawMaterial});
                  if (m != null) setState(() => _recipe.add(_RecipeDraft(m, '')));
                },
                icon: const Icon(Icons.add),
                label: Text(t.itemAddMaterial),
              ),
            ),
          ],
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: QtyField(controller: _minStock, label: t.itemMinStock, unit: _unit)),
            const SizedBox(width: 12),
            Expanded(
                child: TextFormField(controller: _category, decoration: InputDecoration(labelText: t.itemCategory))),
          ]),
          const SizedBox(height: 28),
          FilledButton(onPressed: _saving ? null : _save, child: Text(t.save)),
        ]),
      ),
    );
  }
}
