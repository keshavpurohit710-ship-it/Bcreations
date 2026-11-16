// Bottom navigation (Home · Orders · Customers · Items · Money) and the big
// ＋ button that opens quick entries from anywhere.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/customers/customers_screen.dart';
import '../features/home/home_screen.dart';
import '../features/items/items_screen.dart';
import '../features/items/stock_sheets.dart';
import '../features/money/money_screen.dart';
import '../features/money/money_sheets.dart';
import '../features/orders/order_form_screen.dart';
import '../features/orders/orders_screen.dart';
import '../features/orders/payment_sheet.dart';
import 'format.dart';

/// Selected bottom tab: 0 Home, 1 Orders, 2 Customers, 3 Items, 4 Money.
final shellTabProvider = StateProvider<int>((ref) => 0);

class Shell extends ConsumerWidget {
  const Shell({super.key});

  /// Switch tab from anywhere (Home cards, the tutorial guide...).
  static void goTo(BuildContext context, int tab) =>
      ProviderScope.containerOf(context, listen: false).read(shellTabProvider.notifier).state = tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final tab = ref.watch(shellTabProvider);
    void setTab(int i) => ref.read(shellTabProvider.notifier).state = i;
    return Scaffold(
      body: IndexedStack(index: tab, children: const [
        HomeScreen(),
        OrdersScreen(),
        CustomersScreen(),
        ItemsScreen(),
        MoneyScreen(),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'quickAdd',
        onPressed: () => showQuickAdd(context),
        icon: const Icon(Icons.add, size: 28),
        label: Text(t.quickAdd, style: const TextStyle(fontSize: 15)),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: setTab,
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: t.navHome),
          NavigationDestination(
              icon: const Icon(Icons.receipt_long_outlined),
              selectedIcon: const Icon(Icons.receipt_long),
              label: t.navOrders),
          NavigationDestination(
              icon: const Icon(Icons.people_outline), selectedIcon: const Icon(Icons.people), label: t.navCustomers),
          NavigationDestination(
              icon: const Icon(Icons.inventory_2_outlined),
              selectedIcon: const Icon(Icons.inventory_2),
              label: t.navItems),
          NavigationDestination(
              icon: const Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: const Icon(Icons.account_balance_wallet),
              label: t.navMoney),
        ],
      ),
    );
  }
}

Future<void> showQuickAdd(BuildContext context) async {
  final t = context.t;
  final choice = await showModalBottomSheet<int>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        for (final (i, icon, label) in [
          (0, Icons.receipt_long, t.quickNewOrder),
          (1, Icons.payments, t.quickPayment),
          (2, Icons.shopping_bag_outlined, t.quickExpense),
          (3, Icons.home_outlined, t.quickWithdrawal),
          (4, Icons.handyman_outlined, t.quickMake),
          (5, Icons.local_shipping_outlined, t.quickBuy),
        ])
          ListTile(
            leading: Icon(icon, size: 28),
            title: Text(label, style: const TextStyle(fontSize: 16)),
            onTap: () => Navigator.pop(ctx, i),
          ),
      ]),
    ),
  );
  if (!context.mounted || choice == null) return;
  switch (choice) {
    case 0:
      Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderFormScreen()));
    case 1:
      showPaymentSheet(context);
    case 2:
      showExpenseSheet(context);
    case 3:
      showWithdrawalSheet(context);
    case 4:
      showMakeSheet(context);
    case 5:
      showBuySheet(context);
  }
}
