// When the app shows less stock than she needs, ask what happened instead of
// silently going negative. Each answer keeps money and stock right:
//  * count   -> shelf count corrects stock (no cash involved)
//  * record  -> enter the missing purchase (cash out) or batch (materials used)
//  * proceed -> go ahead; a "stock to check" card appears on Home

import 'package:flutter/material.dart';

import '../../app/format.dart';
import '../../data/database.dart';
import 'stock_sheets.dart';

class ShortItem {
  const ShortItem(this.product, {required this.haveMilli, required this.needMilli});
  final Product product;
  final int haveMilli;
  final int needMilli;
}

enum _Choice { count, record, proceed }

/// Returns true if she chose to go ahead anyway. For "count" or "record" it
/// opens the right sheet and returns false (she can try again afterwards).
Future<bool> handleShortage(BuildContext context, List<ShortItem> items) async {
  if (items.isEmpty) return true;
  final t = context.t;
  final first = items.first.product;
  final recordLabel = first.kind == ProductKind.made ? t.shortageMade : t.shortageBuy;

  final choice = await showDialog<_Choice>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(t.shortageTitle),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (final i in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(t.shortageLine(
                i.product.name,
                qtyLabel(i.needMilli, i.product.unit),
                qtyLabel(i.haveMilli, i.product.unit),
              )),
            ),
          const SizedBox(height: 8),
          Text(t.shortageQuestion, style: Theme.of(ctx).textTheme.titleSmall),
          const SizedBox(height: 8),
          for (final (c, label, icon) in [
            (_Choice.count, t.shortageCount, Icons.fact_check_outlined),
            (_Choice.record, recordLabel, first.kind == ProductKind.made ? Icons.handyman : Icons.add_shopping_cart),
            (_Choice.proceed, t.shortageProceed, Icons.arrow_forward),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(alignment: Alignment.centerLeft),
                  onPressed: () => Navigator.pop(ctx, c),
                  icon: Icon(icon, size: 20),
                  label: Text(label),
                ),
              ),
            ),
        ]),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text(t.cancel))],
    ),
  );
  if (!context.mounted || choice == null) return false;
  switch (choice) {
    case _Choice.count:
      await showCountSheet(context, first);
      return false;
    case _Choice.record:
      if (first.kind == ProductKind.made) {
        await showMakeSheet(context, product: first);
      } else {
        await showBuySheet(context, product: first);
      }
      return false;
    case _Choice.proceed:
      return true;
  }
}
