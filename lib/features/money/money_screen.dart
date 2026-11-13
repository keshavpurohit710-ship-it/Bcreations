// The month in money: profit, "Where did my profit go?", best sellers,
// expenses and money taken for home.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../domain/report_service.dart';
import 'money_sheets.dart';

class MoneyScreen extends ConsumerStatefulWidget {
  const MoneyScreen({super.key});

  @override
  ConsumerState<MoneyScreen> createState() => _MoneyScreenState();
}

class _MoneyScreenState extends ConsumerState<MoneyScreen> {
  DateTime _month = monthKey(DateTime.now());
  bool _byProfit = false;

  void _shift(int months) => setState(() => _month = DateTime(_month.year, _month.month + months));

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final isCurrent = _month == monthKey(DateTime.now());
    return Scaffold(
      appBar: AppBar(title: Text(t.navMoney)),
      body: AsyncBody(ref.watch(moneyProvider(_month)), builder: (m) {
        final s = m.summary;
        final best = _byProfit ? m.bestByProfit : m.bestByQty;
        return ListView(padding: const EdgeInsets.only(bottom: 120), children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(icon: const Icon(Icons.chevron_left), onPressed: () => _shift(-1)),
            Text(monthLabel(context, _month), style: Theme.of(context).textTheme.titleMedium),
            IconButton(icon: const Icon(Icons.chevron_right), onPressed: isCurrent ? null : () => _shift(1)),
          ]),
          if (isCurrent)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(children: [
                Expanded(child: _Stat(t.toCollect, m.toCollectPaise, color: m.toCollectPaise > 0 ? warnColor : null)),
                const SizedBox(width: 12),
                Expanded(child: _Stat(t.advancesHeld, m.advancesPaise)),
              ]),
            ),
          Card(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                _Row(t.moneySales, s.salesPaise),
                _Row(t.moneyCostOfGoods, -s.costOfGoodsSoldPaise),
                if (s.stockLossesPaise != 0) _Row(t.moneyLosses, -s.stockLossesPaise),
                _Row(t.moneyExpenses, -s.expensesPaise),
                const Divider(height: 20),
                _Row(t.moneyProfit, s.netProfitPaise, big: true, color: s.netProfitPaise >= 0 ? goodColor : badColor),
              ]),
            ),
          ),
          _Bridge(s),
          if (s.timeValuePaise > 0 || s.discountsGivenPaise > 0)
            Card(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(children: [
                if (s.timeValuePaise > 0)
                  ListTile(
                    leading: const Icon(Icons.schedule),
                    title: Text('${t.moneyTime}: ${formatPaise(s.timeValuePaise)}'),
                    subtitle: Text(
                        t.moneyTimeHint(formatPaise(ref.watch(settingsProvider).valueOrNull?.hourlyRatePaise ?? 0))),
                  ),
                if (s.discountsGivenPaise > 0)
                  ListTile(
                    leading: const Icon(Icons.local_offer_outlined),
                    title: Text('${t.moneyDiscounts}: ${formatPaise(s.discountsGivenPaise)}'),
                  ),
              ]),
            ),
          SectionHeader(t.moneyBest),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: false, label: Text(t.moneyByQty)),
                ButtonSegment(value: true, label: Text(t.moneyByProfit)),
              ],
              selected: {_byProfit},
              onSelectionChanged: (v) => setState(() => _byProfit = v.first),
            ),
          ),
          if (best.isEmpty)
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(t.moneyNoSales))
          else
            for (final (i, item) in best.take(5).indexed)
              ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text(item.product.name, style: const TextStyle(fontSize: 17)),
                subtitle: Text(
                    '${qtyLabel(item.qtyMilli, item.product.unit)} · ${t.moneySales}: ${formatPaise(item.revenuePaise)}'),
                trailing: Text(formatPaise(item.profitPaise),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: item.profitPaise >= 0 ? goodColor : badColor)),
              ),
          SectionHeader(
            t.moneyEntries,
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                  tooltip: t.quickExpense,
                  icon: const Icon(Icons.shopping_bag_outlined),
                  onPressed: () => showExpenseSheet(context)),
              IconButton(
                  tooltip: t.quickWithdrawal,
                  icon: const Icon(Icons.home_outlined),
                  onPressed: () => showWithdrawalSheet(context)),
            ]),
          ),
          if (m.entries.isEmpty)
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(t.moneyNoEntries))
          else
            for (final e in m.entries)
              ListTile(
                leading: Icon(e.isWithdrawal ? Icons.home_outlined : Icons.shopping_bag_outlined),
                title: Text(e.isWithdrawal ? t.withdrawalTitle : t.categoryName(e.label),
                    style: const TextStyle(fontSize: 17)),
                subtitle: Text([shortDate(context, e.date), if (e.note != null) e.note!].join(' · ')),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text('− ${formatPaise(e.amountPaise)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: t.delete,
                    onPressed: () async {
                      final entries = ref.read(entriesProvider);
                      e.isWithdrawal
                          ? await entries.setWithdrawalDeleted(e.id, true)
                          : await entries.setExpenseDeleted(e.id, true);
                      if (context.mounted) {
                        showUndo(
                            context,
                            t.deleted,
                            () => e.isWithdrawal
                                ? entries.setWithdrawalDeleted(e.id, false)
                                : entries.setExpenseDeleted(e.id, false));
                      }
                    },
                  ),
                ]),
              ),
        ]);
      }),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.paise, {this.color});
  final String label;
  final int paise;
  final Color? color;

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            Text(formatPaise(paise), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color)),
          ]),
        ),
      );
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.paise, {this.big = false, this.color});
  final String label;
  final int paise;
  final bool big;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style =
        (big ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.bodyLarge)?.copyWith(color: color);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Expanded(child: Text(label, style: style)),
        Text(paise < 0 ? '− ${formatPaise(-paise)}' : formatPaise(paise), style: style),
      ]),
    );
  }
}

/// Profit → cash, in plain words. Each step can go either way.
class _Bridge extends StatelessWidget {
  const _Bridge(this.s);
  final PeriodSummary s;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    Widget step(String more, String less, int change) {
      if (change == 0) return const SizedBox.shrink();
      return _Row(change > 0 ? more : less, -change);
    }

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.35),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.moneyBridgeTitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          _Row(t.moneyProfit, s.netProfitPaise),
          step(t.moneyBridgeCustomers, t.moneyBridgeCustomersBack, s.receivablesChangePaise),
          step(t.moneyBridgeStock, t.moneyBridgeStockBack, s.stockValueChangePaise),
          if (s.withdrawalsPaise > 0) _Row(t.moneyBridgeHome, -s.withdrawalsPaise),
          const Divider(height: 20),
          _Row(t.moneyBridgeCash, s.cashAddedPaise, big: true, color: s.cashAddedPaise >= 0 ? goodColor : badColor),
        ]),
      ),
    );
  }
}
