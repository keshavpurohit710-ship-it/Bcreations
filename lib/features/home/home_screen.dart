// Home = today's to-do list: who to collect from, what to deliver, what's
// running low, and how the month is going.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/shell.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../customers/customer_detail_screen.dart';
import '../customers/customer_form_screen.dart';
import '../customers/reminder.dart';
import '../items/item_form_screen.dart';
import '../orders/order_detail_screen.dart';
import '../orders/order_form_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final settings = ref.watch(settingsProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(settings?.businessName ?? t.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: t.settingsTitle,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
      body: AsyncBody(
        ref.watch(homeProvider),
        builder: (h) => ListView(
          padding: const EdgeInsets.only(bottom: 120),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Text(t.homeGreeting, style: Theme.of(context).textTheme.headlineSmall),
            ),
            if (h.productCount == 0 || h.customerCount == 0 || h.orderCount == 0) _SetupCard(h),
            SectionHeader(t.homeToDo),
            ..._todo(context, ref, h, settings),
            SectionHeader(t.homeMonth),
            _MonthCard(h),
          ],
        ),
      ),
    );
  }

  List<Widget> _todo(BuildContext context, WidgetRef ref, HomeData h, Setting? settings) {
    final t = context.t;
    final cards = <Widget>[];

    if (h.dues.isNotEmpty) {
      cards.add(Card(
        child: Column(children: [
          ListTile(
            leading:
                const CircleAvatar(backgroundColor: badColor, child: Icon(Icons.currency_rupee, color: Colors.white)),
            title: Text(t.homeCollect(formatPaise(h.toCollectPaise), h.dues.length)),
            subtitle:
                h.lateCount > 0 ? Text(t.homeOverdue(h.lateCount), style: const TextStyle(color: badColor)) : null,
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Shell.goTo(context, 2),
          ),
          for (final d in h.dues.take(3))
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 72, right: 8),
              title: Text(d.party.name, style: const TextStyle(fontSize: 16)),
              subtitle: BalanceRow(balancePaise: d.balancePaise, daysLate: d.daysOverdue),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerDetailScreen(partyId: d.party.id))),
              trailing: settings == null
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.chat, color: goodColor),
                      tooltip: t.sendReminder,
                      onPressed: () =>
                          sendReminder(context, party: d.party, balancePaise: d.balancePaise, settings: settings),
                    ),
            ),
        ]),
      ));
    }

    if (h.toDeliver.isNotEmpty) {
      cards.add(Card(
        child: Column(children: [
          ListTile(
            leading:
                const CircleAvatar(backgroundColor: warnColor, child: Icon(Icons.local_shipping, color: Colors.white)),
            title: Text(t.homeToDeliver(h.toDeliver.length)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Shell.goTo(context, 1),
          ),
          for (final o in h.toDeliver.take(3))
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 72, right: 16),
              title: Text('${o.party.name} · ${o.order.number}', style: const TextStyle(fontSize: 16)),
              subtitle: o.order.promisedDate == null
                  ? null
                  : Text(t.orderDeliverBy(shortDate(context, o.order.promisedDate!)),
                      style: TextStyle(color: o.order.promisedDate!.isBefore(DateTime.now()) ? badColor : null)),
              trailing: Text(formatPaise(o.totalPaise)),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: o.order.id))),
            ),
        ]),
      ));
    }

    void simple(IconData icon, Color color, String text, VoidCallback onTap) => cards.add(Card(
          child: ListTile(
            leading: CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
            title: Text(text),
            trailing: const Icon(Icons.chevron_right),
            onTap: onTap,
          ),
        ));

    if (h.quotes > 0) {
      simple(Icons.request_quote, Colors.blueGrey, t.homeQuotes(h.quotes), () => Shell.goTo(context, 1));
    }
    if (h.advancesPaise > 0) {
      simple(Icons.savings, goodColor, t.homeAdvances(formatPaise(h.advancesPaise)), () => Shell.goTo(context, 1));
    }
    if (h.lowStock.isNotEmpty) {
      cards.add(Card(
        child: ListTile(
          leading: const CircleAvatar(backgroundColor: badColor, child: Icon(Icons.inventory_2, color: Colors.white)),
          title: Text(t.homeLowStock(h.lowStock.length)),
          subtitle: Text(h.lowStock.take(4).map((p) => p.product.name).join(', ')),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Shell.goTo(context, 3),
        ),
      ));
    }
    if (h.priceReviewCount > 0) {
      simple(Icons.trending_up, warnColor, t.homePriceReview(h.priceReviewCount), () => Shell.goTo(context, 3));
    }
    if (cards.isEmpty) {
      cards.add(
          Card(child: ListTile(leading: const Icon(Icons.check_circle, color: goodColor), title: Text(t.homeAllGood))));
    }
    return cards;
  }
}

/// "Owes ₹1,200 · 13 days late" in red/amber text.
class BalanceRow extends StatelessWidget {
  const BalanceRow({super.key, required this.balancePaise, required this.daysLate});
  final int balancePaise;
  final int daysLate;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final late = daysLate > 0;
    return Text(
      late ? '${t.owes(formatPaise(balancePaise))} · ${t.daysLate(daysLate)}' : t.owes(formatPaise(balancePaise)),
      style: TextStyle(color: late ? badColor : warnColor, fontWeight: FontWeight.w600),
    );
  }
}

class _SetupCard extends StatelessWidget {
  const _SetupCard(this.h);
  final HomeData h;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    Widget step(bool done, String label, Widget screen) => ListTile(
          leading: Icon(done ? Icons.check_circle : Icons.radio_button_unchecked, color: done ? goodColor : null),
          title: Text(label, style: TextStyle(decoration: done ? TextDecoration.lineThrough : null)),
          trailing: done ? null : const Icon(Icons.chevron_right),
          onTap: done ? null : () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
        );
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(children: [
        ListTile(title: Text(t.homeSetupTitle, style: Theme.of(context).textTheme.titleMedium)),
        step(h.productCount > 0, t.homeSetupItems, const ItemFormScreen()),
        step(h.customerCount > 0, t.homeSetupCustomers, const CustomerFormScreen()),
        step(h.orderCount > 0, t.homeSetupOrders, const OrderFormScreen()),
      ]),
    );
  }
}

class _MonthCard extends StatelessWidget {
  const _MonthCard(this.h);
  final HomeData h;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final m = h.month;
    Widget figure(String label, int paise, {Color? color}) => Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(formatPaise(paise),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ]),
        );
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Shell.goTo(context, 4),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            figure(t.moneySales, m.salesPaise),
            figure(t.moneyProfit, m.netProfitPaise, color: m.netProfitPaise >= 0 ? goodColor : badColor),
            figure(t.moneyBridgeCash, m.cashAddedPaise),
          ]),
        ),
      ),
    );
  }
}
