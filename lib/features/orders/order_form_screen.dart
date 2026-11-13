// New / edit order. Prices fill in from the customer's price list (with bulk
// discounts), every line shows a margin colour, and the credit limit is checked.

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/money.dart';
import '../../domain/order_service.dart';
import '../../domain/pricing.dart';
import '../items/product_picker.dart';
import 'party_picker.dart';

class _LineDraft {
  _LineDraft({this.product, this.listPricePaise, this.costPaise, String description = ''})
      : description = TextEditingController(text: description);

  Product? product; // null = custom item
  int? listPricePaise;
  int? costPaise;
  bool priceTouched = false;
  final TextEditingController description;
  final qty = TextEditingController(text: '1');
  final price = TextEditingController();
  final discount = TextEditingController();
  final colour = TextEditingController();
  final size = TextEditingController();
  final words = TextEditingController();
  bool showSpecs = false;

  List<TextEditingController> get _all => [description, qty, price, discount, colour, size, words];
  void dispose() {
    for (final c in _all) {
      c.dispose();
    }
  }

  int get qtyMilli => parseQty(qty.text) ?? 0;
  int get unitPaise => parseRupees(price.text) ?? 0;
  int get netPaise =>
      lineNetPaise(qtyMilli: qtyMilli, unitPricePaise: unitPaise, lineDiscountPaise: parseRupees(discount.text) ?? 0);

  String? _t(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();

  LineInput toInput() => LineInput(
        productId: product?.id,
        description: product == null ? description.text.trim() : null,
        qtyMilli: qtyMilli,
        unitPricePaise: unitPaise,
        listPricePaise: listPricePaise,
        lineDiscountPaise: parseRupees(discount.text) ?? 0,
        unitCostPaise: costPaise,
        specColour: _t(colour),
        specSize: _t(size),
        specText: _t(words),
      );
}

class OrderFormScreen extends ConsumerStatefulWidget {
  const OrderFormScreen({super.key, this.partyId, this.orderId});
  final String? partyId;

  /// Edit an existing quote / confirmed order.
  final String? orderId;

  @override
  ConsumerState<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends ConsumerState<OrderFormScreen> {
  final _lines = <_LineDraft>[];
  final _delivery = TextEditingController();
  final _discount = TextEditingController();
  final _reason = TextEditingController();
  final _notes = TextEditingController();
  final _advance = TextEditingController();
  final _newPhotos = <String>[];
  List<OrderPhoto> _oldPhotos = [];
  final _removedPhotoIds = <String>{};
  Party? _party;
  SalesChannel? _channel;
  DateTime _orderDate = DateTime.now();
  DateTime? _promised;
  bool _quote = false;
  bool _more = false;
  PaymentMethod _advanceMethod = PaymentMethod.upi;
  List<DiscountRule> _bulk = const [];
  bool _saving = false;
  bool _loading = true;

  bool get _editing => widget.orderId != null;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final db = ref.read(databaseProvider);
    _bulk = [
      for (final r in await (db.select(db.bulkRules)..where((r) => r.deletedAt.isNull())).get())
        DiscountRule(
            productId: r.productId,
            minQtyMilli: r.minQtyMilli,
            discountBp: r.discountBp,
            wholesaleOnly: r.wholesaleOnly),
    ];
    if (_editing) {
      final d = await ref.read(orderDetailProvider(widget.orderId!).future);
      final o = d.row.order;
      _party = d.row.party;
      _channel = o.channel;
      _orderDate = o.orderDate;
      _promised = o.promisedDate;
      _quote = o.status == OrderStatus.quote;
      _delivery.text = rupeesText(o.deliveryChargePaise == 0 ? null : o.deliveryChargePaise);
      _discount.text = rupeesText(o.orderDiscountPaise == 0 ? null : o.orderDiscountPaise);
      _reason.text = o.discountReason ?? '';
      _notes.text = o.notes ?? '';
      _oldPhotos = d.photos;
      for (final lv in d.lines) {
        final l = lv.line;
        final draft = _LineDraft(
            product: lv.product,
            listPricePaise: l.listPricePaise,
            costPaise: l.unitCostPaise,
            description: l.description ?? '')
          ..priceTouched = true;
        draft.qty.text = formatMilli(l.qtyMilli);
        draft.price.text = rupeesText(l.unitPricePaise);
        draft.discount.text = l.lineDiscountPaise == 0 ? '' : rupeesText(l.lineDiscountPaise);
        draft.colour.text = l.specColour ?? '';
        draft.size.text = l.specSize ?? '';
        draft.words.text = l.specText ?? '';
        draft.showSpecs = l.specColour != null || l.specSize != null || l.specText != null;
        _lines.add(draft);
      }
      _more = _promised != null || _discount.text.isNotEmpty || _notes.text.isNotEmpty;
    } else if (widget.partyId != null) {
      _setParty(await ref.read(catalogProvider).party(widget.partyId!));
    }
    if (mounted) setState(() => _loading = false);
  }

  void _setParty(Party p) {
    _party = p;
    _channel ??= p.defaultChannel;
    for (final l in _lines) {
      _reprice(l, refreshList: true);
    }
  }

  @override
  void dispose() {
    for (final l in _lines) {
      l.dispose();
    }
    for (final c in [_delivery, _discount, _reason, _notes, _advance]) {
      c.dispose();
    }
    super.dispose();
  }

  PriceType get _priceType => _party?.priceType ?? PriceType.retail;

  Future<void> _addProduct() async {
    final p = await pickProduct(context, kinds: {ProductKind.made, ProductKind.bought, ProductKind.rawMaterial});
    if (p == null) return;
    final cost = await ref.read(stockProvider).costPerPiecePaise(p.id);
    final draft = _LineDraft(product: p, costPaise: cost);
    _reprice(draft, refreshList: true);
    setState(() => _lines.add(draft));
  }

  void _addCustom() => setState(() => _lines.add(_LineDraft()..showSpecs = true));

  /// List price for this customer, minus any bulk discount (unless she typed a price).
  void _reprice(_LineDraft l, {bool refreshList = false}) {
    final p = l.product;
    if (p == null) return;
    final settings = ref.read(settingsProvider).valueOrNull;
    if (refreshList) {
      l.listPricePaise = listPricePaise(
        priceType: _priceType,
        retailPricePaise: p.retailPricePaise,
        wholesalePricePaise: p.wholesalePricePaise,
        defaultWholesaleDiscountBp: settings?.defaultWholesaleDiscountBp ?? 3000,
      );
    }
    if (l.priceTouched || l.listPricePaise == null) return;
    final bp = bulkDiscountBp(rules: _bulk, productId: p.id, qtyMilli: l.qtyMilli, priceType: _priceType);
    l.price.text = rupeesText(l.listPricePaise! - applyBp(l.listPricePaise!, bp));
  }

  int get _total => orderTotalPaise(
        lineNetPaise: _lines.map((l) => l.netPaise),
        orderDiscountPaise: parseRupees(_discount.text) ?? 0,
        deliveryChargePaise: parseRupees(_delivery.text) ?? 0,
      );

  Future<void> _save() async {
    final t = context.t;
    if (_party == null) return showMessage(context, t.orderNeedsCustomer);
    final valid = _lines.where((l) => l.qtyMilli > 0 && (l.product != null || l.description.text.trim().isNotEmpty));
    if (valid.isEmpty) return showMessage(context, t.orderNeedsItem);
    setState(() => _saving = true);
    final svc = ref.read(ordersServiceProvider);
    final db = ref.read(databaseProvider);
    final inputs = valid.map((l) => l.toInput()).toList();
    String? text(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();
    final delivery = parseRupees(_delivery.text) ?? 0;
    final discount = parseRupees(_discount.text) ?? 0;

    late String orderId;
    if (_editing) {
      orderId = widget.orderId!;
      await svc.replaceLines(orderId, inputs);
      await svc.updateDetails(orderId,
          orderDate: _orderDate,
          channel: _channel,
          promisedDate: _promised,
          deliveryChargePaise: delivery,
          orderDiscountPaise: discount,
          discountReason: text(_reason),
          notes: text(_notes));
      for (final id in _removedPhotoIds) {
        await (db.update(db.orderPhotos)..where((p) => p.id.equals(id)))
            .write(OrderPhotosCompanion(deletedAt: Value(DateTime.now())));
      }
    } else {
      final order = await svc.createOrder(
        partyId: _party!.id,
        lines: inputs,
        orderDate: _orderDate,
        status: _quote ? OrderStatus.quote : OrderStatus.confirmed,
        channel: _channel,
        promisedDate: _promised,
        deliveryChargePaise: delivery,
        orderDiscountPaise: discount,
        discountReason: text(_reason),
        notes: text(_notes),
      );
      orderId = order.id;
      final advance = parseRupees(_advance.text) ?? 0;
      if (advance > 0) {
        await ref.read(ledgerProvider).receivePayment(
            partyId: _party!.id, amountPaise: advance, method: _advanceMethod, date: _orderDate, orderId: orderId);
      }
    }
    for (final path in _newPhotos) {
      await db.into(db.orderPhotos).insert(OrderPhotosCompanion.insert(orderId: orderId, path: path));
    }
    if (mounted) Navigator.pop(context, orderId);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final settings = ref.watch(settingsProvider).valueOrNull;
    final credit = _party == null ? null : ref.watch(partyDetailProvider(_party!.id)).valueOrNull;
    final total = _total;
    String? creditWarning;
    if (credit != null && !_editing) {
      final limit = credit.party.creditLimitPaise;
      if (limit != null && credit.balancePaise + total > limit) {
        creditWarning = t.creditWarnLimit(credit.party.name, formatPaise(limit));
      } else if (credit.credit.hasOverdue) {
        creditWarning = t.creditWarnOverdue(credit.party.name, formatPaise(credit.balancePaise));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(_editing ? t.orderEdit : t.orderNew)),
      body: ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 140), children: [
        PartyField(party: _party, enabled: !_editing, onPicked: (p) => setState(() => _setParty(p))),
        if (creditWarning != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Pill(creditWarning, color: badColor, icon: Icons.warning_amber),
          ),
        SectionHeader(t.orderItems),
        for (final (i, l) in _lines.indexed) _lineCard(i, l, settings),
        Wrap(spacing: 12, runSpacing: 8, children: [
          FilledButton.tonalIcon(onPressed: _addProduct, icon: const Icon(Icons.add), label: Text(t.orderAddItem)),
          OutlinedButton.icon(
              onPressed: _addCustom, icon: const Icon(Icons.brush_outlined), label: Text(t.orderAddCustom)),
        ]),
        const SizedBox(height: 20),
        MoneyField(controller: _delivery, label: t.orderDelivery, onChanged: (_) => setState(() {})),
        const SizedBox(height: 16),
        DateRow(
          label: t.orderPromised,
          date: _promised,
          allowFuture: true,
          clearable: true,
          onChanged: (d) => setState(() => _promised = d),
        ),
        const SizedBox(height: 16),
        Text(t.orderPhotos, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final p in _oldPhotos.where((p) => !_removedPhotoIds.contains(p.id)))
            PhotoThumb(p.path, onRemove: () => setState(() => _removedPhotoIds.add(p.id))),
          for (final path in _newPhotos) PhotoThumb(path, onRemove: () => setState(() => _newPhotos.remove(path))),
          OutlinedButton.icon(
            onPressed: () async {
              final path = await choosePhoto(context);
              if (path != null) setState(() => _newPhotos.add(path));
            },
            icon: const Icon(Icons.add_a_photo_outlined),
            label: Text(t.orderAddPhoto),
          ),
        ]),
        if (!_editing) ...[
          const SizedBox(height: 20),
          MoneyField(controller: _advance, label: t.orderAdvance, onChanged: (_) => setState(() {})),
          if ((parseRupees(_advance.text) ?? 0) > 0) ...[
            const SizedBox(height: 8),
            MethodChips(value: _advanceMethod, onChanged: (m) => setState(() => _advanceMethod = m)),
          ],
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(t.orderJustQuote),
            value: _quote,
            onChanged: (v) => setState(() => _quote = v),
          ),
        ],
        if (!_more)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
                onPressed: () => setState(() => _more = true),
                icon: const Icon(Icons.expand_more),
                label: Text(t.orderMore)),
          )
        else ...[
          const SizedBox(height: 12),
          Text(t.orderChannel, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final c in SalesChannel.values)
              ChoiceChip(
                  label: Text(t.channel(c)), selected: _channel == c, onSelected: (_) => setState(() => _channel = c)),
          ]),
          const SizedBox(height: 16),
          MoneyField(controller: _discount, label: t.orderDiscount, onChanged: (_) => setState(() {})),
          if ((parseRupees(_discount.text) ?? 0) > 0) ...[
            const SizedBox(height: 12),
            TextField(controller: _reason, decoration: InputDecoration(labelText: t.orderDiscountReason)),
          ],
          const SizedBox(height: 16),
          DateRow(
              label: t.orderDate, date: _orderDate, onChanged: (d) => setState(() => _orderDate = d ?? DateTime.now())),
          const SizedBox(height: 16),
          TextField(controller: _notes, maxLines: 3, decoration: InputDecoration(labelText: t.orderNotes)),
        ],
      ]),
      bottomSheet: Material(
        elevation: 8,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(children: [
              Expanded(
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(t.total, style: Theme.of(context).textTheme.bodySmall),
                  Text(formatPaise(total), style: Theme.of(context).textTheme.headlineSmall),
                ]),
              ),
              FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: const Icon(Icons.check),
                label: Text(t.save),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _lineCard(int index, _LineDraft l, Setting? settings) {
    final t = context.t;
    final band = marginBand(
      unitPricePaise: l.unitPaise,
      unitCostPaise: l.costPaise,
      targetMarginBp: settings?.targetMarginBp ?? 4000,
    );
    final (bandText, bandColor) = switch (band) {
      MarginBand.healthy => (t.marginHealthy, goodColor),
      MarginBand.thin => (t.marginThin, warnColor),
      MarginBand.loss => (t.marginLoss, badColor),
      MarginBand.unknown => ('', Colors.transparent),
    };
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 4, 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            if (l.product != null) ...[ProductAvatar(l.product!, size: 36), const SizedBox(width: 10)],
            Expanded(
              child: l.product != null
                  ? Text(l.product!.name, style: Theme.of(context).textTheme.titleMedium)
                  : TextField(
                      controller: l.description,
                      decoration: InputDecoration(labelText: t.orderCustomName, border: InputBorder.none),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: t.delete,
              onPressed: () => setState(() => _lines.removeAt(index).dispose()),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(children: [
              Expanded(
                child: QtyField(
                  controller: l.qty,
                  label: t.quantity,
                  unit: l.product?.unit,
                  onChanged: (_) => setState(() => _reprice(l)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MoneyField(
                  controller: l.price,
                  label: t.price,
                  onChanged: (_) => setState(() => l.priceTouched = true),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 6),
          Wrap(spacing: 8, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
            Text(formatPaise(l.netPaise), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            if (band != MarginBand.unknown) Pill(bandText, color: bandColor),
            if (l.listPricePaise != null && l.listPricePaise != l.unitPaise)
              Text(t.listPriceWas(formatPaise(l.listPricePaise!)), style: Theme.of(context).textTheme.bodySmall),
            TextButton.icon(
              onPressed: () => setState(() => l.showSpecs = !l.showSpecs),
              icon: Icon(l.showSpecs ? Icons.expand_less : Icons.tune),
              label: Text('${t.orderColour} / ${t.orderSize} / ${t.orderNameText}'),
            ),
          ]),
          if (l.showSpecs)
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 4),
              child: Column(children: [
                Row(children: [
                  Expanded(
                      child: TextField(controller: l.colour, decoration: InputDecoration(labelText: t.orderColour))),
                  const SizedBox(width: 12),
                  Expanded(child: TextField(controller: l.size, decoration: InputDecoration(labelText: t.orderSize))),
                ]),
                const SizedBox(height: 12),
                TextField(controller: l.words, decoration: InputDecoration(labelText: t.orderNameText)),
                const SizedBox(height: 12),
                MoneyField(controller: l.discount, label: t.lineDiscount, onChanged: (_) => setState(() {})),
              ]),
            ),
        ]),
      ),
    );
  }
}
