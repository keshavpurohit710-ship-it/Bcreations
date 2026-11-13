import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import 'order_form_screen.dart';
import 'order_tile.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.navOrders),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              tooltip: t.orderNew,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderFormScreen())),
            ),
          ],
          bottom: TabBar(tabs: [Tab(text: t.ordersOpen), Tab(text: t.ordersDelivered), Tab(text: t.ordersAll)]),
        ),
        body: TabBarView(children: [
          for (final f in OrderFilter.values)
            AsyncBody(
              ref.watch(ordersListProvider(f)),
              builder: (rows) => rows.isEmpty
                  ? EmptyState(icon: Icons.receipt_long_outlined, text: t.ordersEmpty)
                  : ListView(
                      padding: const EdgeInsets.only(top: 8, bottom: 120),
                      children: [for (final r in rows) OrderTile(r)],
                    ),
            ),
        ]),
      ),
    );
  }
}
