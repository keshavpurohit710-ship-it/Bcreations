import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/pricing.dart';
import 'item_form_screen.dart';
import 'product_picker.dart';
import 'stock_sheets.dart';

class ItemDetailScreen extends ConsumerWidget {
  const ItemDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final detail = ref.watch(productDetailProvider(productId));
    final settings = ref.watch(settingsProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(detail.valueOrNull?.row.product.name ?? ''),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: t.edit,
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => ItemFormScreen(productId: productId))),
          ),
          PopupMenuButton<String>(
            onSelected: (_) async {
              await ref.read(catalogProvider).setProductArchived(productId, true);
              if (!context.mounted) return;
              Navigator.pop(context);
              showUndo(context, t.archived, () => ref.read(catalogProvider).setProductArchived(productId, false));
            },
            itemBuilder: (_) => [PopupMenuItem(value: 'archive', child: Text(t.archive))],
          ),
        ],
      ),
      body: AsyncBody(detail, builder: (d) {
        final p = d.row.product;
        final low = d.row.isLow || d.row.onHandMilli < 0;
        final suggested = d.costPerPiecePaise == null || settings == null || p.kind == ProductKind.rawMaterial
            ? null
            : suggestPrices(
                fullCostPaise: d.costPerPiecePaise!,
                retailMarkupBp: settings.retailMarkupBp,
                wholesaleMarkupBp: settings.wholesaleMarkupBp);
        return ListView(padding: const EdgeInsets.only(bottom: 40), children: [
          ListTile(
            leading: ProductAvatar(p, size: 64),
            title: Text(t.kind(p.kind)),
            subtitle: p.category == null ? null : Text(p.category!),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.onHand, style: Theme.of(context).textTheme.bodySmall),
                Text(qtyLabel(d.row.onHandMilli, p.unit),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: low ? badColor : null)),
                const SizedBox(height: 8),
                Text('${t.stockValue}: ${formatPaise(d.stockValuePaise)}'),
                if (d.costPerPiecePaise != null) Text('${t.costPerPiece}: ${formatPaise(d.costPerPiecePaise!)}'),
                if (p.retailPricePaise != null)
                  Text('${t.retailLabel}: ${formatPaise(p.retailPricePaise!)}'
                      '${p.wholesalePricePaise == null ? '' : ' · ${t.wholesaleLabel}: ${formatPaise(p.wholesalePricePaise!)}'}'),
                if (suggested != null) ...[
                  const SizedBox(height: 6),
                  Text(t.suggestedPrices(formatPaise(suggested.retailPaise), formatPaise(suggested.wholesalePaise)),
                      style: Theme.of(context).textTheme.bodySmall),
                ],
                if (d.needsReview) ...[
                  const SizedBox(height: 8),
                  Pill(t.priceReview, color: warnColor, icon: Icons.trending_up),
                ],
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Wrap(spacing: 10, runSpacing: 10, children: [
              if (p.kind == ProductKind.made)
                FilledButton.icon(
                    onPressed: () => showMakeSheet(context, product: p),
                    icon: const Icon(Icons.handyman),
                    label: Text(t.actionMake))
              else
                FilledButton.icon(
                    onPressed: () => showBuySheet(context, product: p),
                    icon: const Icon(Icons.add_shopping_cart),
                    label: Text(t.actionBuy)),
              OutlinedButton.icon(
                  onPressed: () => showAdjustSheet(context, p),
                  icon: const Icon(Icons.exposure),
                  label: Text(t.actionAdjust)),
              OutlinedButton.icon(
                  onPressed: () => showCountSheet(context, p),
                  icon: const Icon(Icons.fact_check_outlined),
                  label: Text(t.actionCount)),
            ]),
          ),
          if (d.recipe.isNotEmpty) ...[
            SectionHeader(t.itemRecipe),
            for (final (line, material) in d.recipe)
              ListTile(dense: true, title: Text(material.name), trailing: Text(qtyLabel(line.qtyMilli, material.unit))),
          ],
          SectionHeader(t.history),
          for (final m in d.moves)
            ListTile(
              dense: true,
              leading: Icon(m.qtyMilli >= 0 ? Icons.add_circle_outline : Icons.remove_circle_outline,
                  color: m.qtyMilli >= 0 ? goodColor : warnColor),
              title: Text(m.note ?? t.move(m.type), style: const TextStyle(fontSize: 16)),
              subtitle: Text(longDate(context, m.movedAt)),
              trailing: Text('${m.qtyMilli > 0 ? '+' : ''}${qtyLabel(m.qtyMilli, p.unit)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
        ]);
      }),
    );
  }
}
