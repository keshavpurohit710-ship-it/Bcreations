import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/nav.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import 'order_form_screen.dart';
import 'order_tile.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 3, vsync: this, initialIndex: ref.read(ordersTabProvider))
    ..addListener(() => ref.read(ordersTabProvider.notifier).state = _tabs.index);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  bool _matches(OrderRow r, OpenOrderFilter f) => switch (f) {
        OpenOrderFilter.all => true,
        OpenOrderFilter.toDeliver => r.order.status == OrderStatus.confirmed,
        OpenOrderFilter.quotes => r.order.status == OrderStatus.quote,
        OpenOrderFilter.withAdvance => r.paidPaise > 0,
      };

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    // Home can switch the tab (e.g. "1 quote waiting" -> Open, Quotes)
    ref.listen(ordersTabProvider, (_, i) {
      if (_tabs.index != i) _tabs.animateTo(i);
    });
    final openFilter = ref.watch(openOrderFilterProvider);

    Widget list(List<OrderRow> rows) => rows.isEmpty
        ? EmptyState(icon: Icons.receipt_long_outlined, text: t.ordersEmpty)
        : ListView(
            padding: const EdgeInsets.only(top: 4, bottom: 120),
            children: [for (final r in rows) OrderTile(r)],
          );

    return Scaffold(
      appBar: AppBar(
        title: Text(t.navOrders),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: t.orderNew,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderFormScreen())),
          ),
        ],
        bottom: TabBar(
            controller: _tabs, tabs: [Tab(text: t.ordersOpen), Tab(text: t.ordersDelivered), Tab(text: t.ordersAll)]),
      ),
      body: TabBarView(controller: _tabs, children: [
        // Open: with a filter row
        Column(children: [
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              children: [
                for (final (f, label) in [
                  (OpenOrderFilter.all, t.ordersAll),
                  (OpenOrderFilter.toDeliver, t.ordersToDeliver),
                  (OpenOrderFilter.quotes, t.ordersQuotes),
                  (OpenOrderFilter.withAdvance, t.ordersWithAdvance),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(label),
                      selected: openFilter == f,
                      onSelected: (_) => ref.read(openOrderFilterProvider.notifier).state = f,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: AsyncBody(
              ref.watch(ordersListProvider(OrderFilter.open)),
              builder: (rows) => list(rows.where((r) => _matches(r, openFilter)).toList()),
            ),
          ),
        ]),
        AsyncBody(ref.watch(ordersListProvider(OrderFilter.delivered)), builder: list),
        AsyncBody(ref.watch(ordersListProvider(OrderFilter.all)), builder: list),
      ]),
    );
  }
}
