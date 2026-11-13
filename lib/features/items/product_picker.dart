import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import 'item_form_screen.dart';

/// Searchable list of items with photo, stock and price. [kinds] limits the list.
Future<Product?> pickProduct(BuildContext context, {Set<ProductKind>? kinds}) => showModalBottomSheet<Product>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => _ProductPicker(kinds: kinds),
    );

class _ProductPicker extends ConsumerStatefulWidget {
  const _ProductPicker({this.kinds});
  final Set<ProductKind>? kinds;

  @override
  ConsumerState<_ProductPicker> createState() => _ProductPickerState();
}

class _ProductPickerState extends ConsumerState<_ProductPicker> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: SearchBar(
            autoFocus: true,
            hintText: t.pickProduct,
            leading: const Icon(Icons.search),
            onChanged: (v) => setState(() => _q = v.trim().toLowerCase()),
          ),
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.add)),
          title: Text('+ ${t.itemNew}'),
          onTap: () async {
            final id = await Navigator.push<String>(context, MaterialPageRoute(builder: (_) => const ItemFormScreen()));
            if (id == null || !context.mounted) return;
            final db = ref.read(databaseProvider);
            final p = await (db.select(db.products)..where((x) => x.id.equals(id))).getSingle();
            if (context.mounted) Navigator.pop(context, p);
          },
        ),
        const Divider(height: 1),
        Expanded(
          child: AsyncBody(ref.watch(productsProvider), builder: (rows) {
            final shown = rows
                .where((r) =>
                    (widget.kinds == null || widget.kinds!.contains(r.product.kind)) &&
                    (_q.isEmpty || '${r.product.name} ${r.product.category ?? ''}'.toLowerCase().contains(_q)))
                .toList();
            if (shown.isEmpty) return EmptyState(icon: Icons.search_off, text: t.pickNone);
            return ListView.builder(
              itemCount: shown.length,
              itemBuilder: (_, i) => ProductListTile(shown[i], onTap: () => Navigator.pop(context, shown[i].product)),
            );
          }),
        ),
      ]),
    );
  }
}

class ProductAvatar extends StatelessWidget {
  const ProductAvatar(this.product, {super.key, this.size = 48});
  final Product product;
  final double size;

  @override
  Widget build(BuildContext context) {
    final path = product.photoPath;
    if (path != null && File(path).existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(File(path), width: size, height: size, fit: BoxFit.cover),
      );
    }
    return CircleAvatar(
      radius: size / 2,
      child: Icon(switch (product.kind) {
        ProductKind.rawMaterial => Icons.category_outlined,
        ProductKind.made => Icons.handyman_outlined,
        ProductKind.bought => Icons.shopping_bag_outlined,
      }),
    );
  }
}

class ProductListTile extends StatelessWidget {
  const ProductListTile(this.row, {super.key, required this.onTap});
  final ProductRow row;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final p = row.product;
    return ListTile(
      leading: ProductAvatar(p),
      title: Text(p.name, style: const TextStyle(fontSize: 18)),
      subtitle: Text(
        t.inStock(qtyLabel(row.onHandMilli, p.unit)),
        style: TextStyle(color: row.isLow || row.onHandMilli <= 0 ? badColor : null),
      ),
      trailing: p.retailPricePaise == null
          ? null
          : Text(formatPaise(p.retailPricePaise!), style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
