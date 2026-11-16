import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/nav.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import 'item_detail_screen.dart';
import 'item_form_screen.dart';
import 'product_picker.dart';

class ItemsScreen extends ConsumerStatefulWidget {
  const ItemsScreen({super.key});

  @override
  ConsumerState<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends ConsumerState<ItemsScreen> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final filter = ref.watch(itemFilterProvider);
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
                      (ItemFilter.all, t.itemsAll),
                      (ItemFilter.low, t.itemsLow),
                      (ItemFilter.review, t.itemsReview),
                      (ItemFilter.products, t.itemsProducts),
                      (ItemFilter.materials, t.itemsMaterials),
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                            label: Text(label),
                            selected: filter == f,
                            onSelected: (_) => ref.read(itemFilterProvider.notifier).state = f),
                      ),
                  ]),
            ),
          ]),
        ),
      ),
      body: AsyncBody(ref.watch(productsProvider), builder: (rows) {
        final shown = rows.where((r) {
          final ok = switch (filter) {
            ItemFilter.all => true,
            ItemFilter.low => r.isLow || r.onHandMilli < 0,
            ItemFilter.review => r.needsReview,
            ItemFilter.products => r.product.kind != ProductKind.rawMaterial,
            ItemFilter.materials => r.product.kind == ProductKind.rawMaterial,
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
