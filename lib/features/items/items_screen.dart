import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import 'item_detail_screen.dart';
import 'item_form_screen.dart';
import 'product_picker.dart';

enum _Filter { all, low, products, materials }

class ItemsScreen extends ConsumerStatefulWidget {
  const ItemsScreen({super.key});

  @override
  ConsumerState<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends ConsumerState<ItemsScreen> {
  _Filter _filter = _Filter.all;
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.navItems),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            tooltip: t.itemNew,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ItemFormScreen())),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(116),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: SearchBar(
                hintText: t.search,
                leading: const Icon(Icons.search),
                onChanged: (v) => setState(() => _q = v.trim().toLowerCase()),
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    for (final (f, label) in [
                      (_Filter.all, t.itemsAll),
                      (_Filter.low, t.itemsLow),
                      (_Filter.products, t.itemsProducts),
                      (_Filter.materials, t.itemsMaterials),
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                            label: Text(label), selected: _filter == f, onSelected: (_) => setState(() => _filter = f)),
                      ),
                  ]),
            ),
          ]),
        ),
      ),
      body: AsyncBody(ref.watch(productsProvider), builder: (rows) {
        final shown = rows.where((r) {
          final ok = switch (_filter) {
            _Filter.all => true,
            _Filter.low => r.isLow || r.onHandMilli < 0,
            _Filter.products => r.product.kind != ProductKind.rawMaterial,
            _Filter.materials => r.product.kind == ProductKind.rawMaterial,
          };
          return ok && (_q.isEmpty || '${r.product.name} ${r.product.category ?? ''}'.toLowerCase().contains(_q));
        }).toList();
        if (shown.isEmpty) return EmptyState(icon: Icons.inventory_2_outlined, text: t.itemsEmpty);
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 120),
          itemCount: shown.length,
          itemBuilder: (_, i) => ProductListTile(
            shown[i],
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => ItemDetailScreen(productId: shown[i].product.id))),
          ),
        );
      }),
    );
  }
}
