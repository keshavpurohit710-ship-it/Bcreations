import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../customers/customer_detail_screen.dart';
import '../customers/reminder.dart';
import 'order_form_screen.dart';
import 'order_tile.dart';
import 'payment_sheet.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final detail = ref.watch(orderDetailProvider(orderId));
    final settings = ref.watch(settingsProvider).valueOrNull;
    final d = detail.valueOrNull;
    final status = d?.row.order.status;
    final editable = status == OrderStatus.quote || status == OrderStatus.confirmed;

    return Scaffold(
      appBar: AppBar(
        title: Text(d?.row.order.number ?? ''),
        actions: [
          if (d != null && settings != null)
            IconButton(
              icon: const Icon(Icons.share),
              tooltip: t.actionShare,
              onPressed: () => SharePlus.instance.share(ShareParams(text: _shareText(context, d, settings))),
            ),
          if (editable)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: t.edit,
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => OrderFormScreen(orderId: orderId))),
            ),
          if (d != null && status != OrderStatus.cancelled)
            PopupMenuButton<String>(
              onSelected: (_) async {
                if (!await confirmDialog(context, t.confirmCancelOrder, ok: t.actionCancelOrder, danger: true)) return;
                await ref.read(ordersServiceProvider).cancel(orderId, date: DateTime.now());
              },
              itemBuilder: (_) => [PopupMenuItem(value: 'cancel', child: Text(t.actionCancelOrder))],
            ),
        ],
      ),
      body: AsyncBody(detail, builder: (d) {
        final o = d.row.order;
        return ListView(padding: const EdgeInsets.only(bottom: 40), children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(d.row.party.name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
            subtitle: Text(longDate(context, o.orderDate)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => CustomerDetailScreen(partyId: d.row.party.id))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(spacing: 8, runSpacing: 6, children: [
              Pill(t.status(o.status), color: statusColor(o.status)),
              if (o.status != OrderStatus.cancelled) payPill(context, d.row),
              if (o.promisedDate != null && o.status != OrderStatus.delivered)
                Pill(t.orderDeliverBy(shortDate(context, o.promisedDate!)), color: Colors.blueGrey, icon: Icons.event),
              if (o.status == OrderStatus.delivered && o.dueDate != null && d.row.balancePaise > 0)
                Pill(t.orderDue(shortDate(context, o.dueDate!)),
                    color: o.dueDate!.isBefore(DateTime.now()) ? badColor : warnColor, icon: Icons.schedule),
              if (o.channel != null) Pill(t.channel(o.channel!), color: Colors.blueGrey),
            ]),
          ),
          const SizedBox(height: 12),
          _Actions(d),
          SectionHeader(t.orderItems),
          for (final l in d.lines) _LineTile(l),
          if (d.photos.isNotEmpty) ...[
            SectionHeader(t.orderPhotos),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  Wrap(spacing: 8, runSpacing: 8, children: [for (final p in d.photos) PhotoThumb(p.path, size: 96)]),
            ),
          ],
          const Divider(height: 32),
          _totalRow(context, t.subtotal, d.itemsTotalPaise),
          if (o.orderDiscountPaise > 0)
            _totalRow(context, '${t.orderDiscount}${o.discountReason == null ? '' : ' (${o.discountReason})'}',
                -o.orderDiscountPaise),
          if (o.deliveryChargePaise > 0) _totalRow(context, t.orderDelivery, o.deliveryChargePaise),
          _totalRow(context, t.total, d.row.totalPaise, bold: true),
          if (d.row.paidPaise > 0) _totalRow(context, t.paid, -d.row.paidPaise, color: goodColor),
          if (o.status != OrderStatus.cancelled && d.row.paidPaise > 0)
            _totalRow(context, t.balance, d.row.balancePaise, bold: true),
          if (o.notes != null) Padding(padding: const EdgeInsets.all(16), child: Text(o.notes!)),
          if (d.payments.isNotEmpty) ...[
            SectionHeader(t.paymentsSection),
            for (final (p, applied) in d.payments) PaymentTile(p, appliedPaise: applied),
          ],
        ]);
      }),
    );
  }

  Widget _totalRow(BuildContext context, String label, int paise, {bool bold = false, Color? color}) {
    final style = (bold ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.bodyLarge)
        ?.copyWith(color: color);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(children: [
        Expanded(child: Text(label, style: style)),
        Text(paise < 0 ? '− ${formatPaise(-paise)}' : formatPaise(paise), style: style),
      ]),
    );
  }

  String _shareText(BuildContext context, OrderDetail d, Setting s) {
    final t = context.t;
    final o = d.row.order;
    final b = StringBuffer()
      ..writeln('*${o.status == OrderStatus.quote ? t.quoteText(s.businessName) : t.billText(s.businessName)}*')
      ..writeln('${o.number} · ${longDate(context, o.orderDate)}')
      ..writeln(d.row.party.name)
      ..writeln();
    for (final l in d.lines) {
      b.writeln(
          '• ${l.name}  ${formatMilli(l.line.qtyMilli)} × ${formatPaise(l.line.unitPricePaise)} = ${formatPaise(l.netPaise)}');
      final specs = [l.line.specColour, l.line.specSize, l.line.specText].whereType<String>();
      if (specs.isNotEmpty) b.writeln('   (${specs.join(', ')})');
    }
    b.writeln();
    if (o.orderDiscountPaise > 0) b.writeln('${t.orderDiscount}: − ${formatPaise(o.orderDiscountPaise)}');
    if (o.deliveryChargePaise > 0) b.writeln('${t.orderDelivery}: ${formatPaise(o.deliveryChargePaise)}');
    b.writeln('*${t.total}: ${formatPaise(d.row.totalPaise)}*');
    if (d.row.paidPaise > 0) {
      b
        ..writeln('${t.paid}: ${formatPaise(d.row.paidPaise)}')
        ..writeln('*${t.balance}: ${formatPaise(d.row.balancePaise)}*');
    }
    if (s.upiId != null && s.upiId!.isNotEmpty) b.writeln('\nUPI: ${s.upiId}');
    return b.toString();
  }
}

class _LineTile extends StatelessWidget {
  const _LineTile(this.l);
  final LineView l;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final specs = [l.line.specColour, l.line.specSize, l.line.specText].whereType<String>().toList();
    return ListTile(
      title: Text(l.product == null ? '${l.name} · ${t.customItem}' : l.name, style: const TextStyle(fontSize: 17)),
      subtitle: Text([
        '${qtyLabel(l.line.qtyMilli, l.product?.unit ?? '')} × ${formatPaise(l.line.unitPricePaise)}',
        if (l.line.lineDiscountPaise > 0) '− ${formatPaise(l.line.lineDiscountPaise)}',
        if (specs.isNotEmpty) specs.join(' · '),
      ].join('\n')),
      isThreeLine: specs.isNotEmpty,
      trailing: Text(formatPaise(l.netPaise), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
    );
  }
}

/// The next sensible step for this order, as big buttons.
class _Actions extends ConsumerWidget {
  const _Actions(this.d);
  final OrderDetail d;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final o = d.row.order;
    final svc = ref.read(ordersServiceProvider);
    final settings = ref.watch(settingsProvider).valueOrNull;
    final buttons = <Widget>[
      if (o.status == OrderStatus.quote)
        FilledButton.icon(
            onPressed: () => svc.confirm(o.id), icon: const Icon(Icons.thumb_up), label: Text(t.actionConfirm)),
      if (o.status == OrderStatus.confirmed)
        FilledButton.icon(
          onPressed: () => _deliver(context, ref),
          icon: const Icon(Icons.local_shipping),
          label: Text(t.actionDeliver),
        ),
      if (o.status != OrderStatus.cancelled && d.row.balancePaise > 0)
        (o.status == OrderStatus.delivered ? FilledButton.icon : OutlinedButton.icon)(
          onPressed: () => showPaymentSheet(context, orderId: o.id),
          icon: const Icon(Icons.payments),
          label: Text(o.status == OrderStatus.delivered ? t.receivePayment : t.takeAdvance),
        ),
      if (o.status == OrderStatus.delivered && d.row.balancePaise > 0 && settings != null)
        OutlinedButton.icon(
          onPressed: () async {
            final bal = await ref.read(ledgerProvider).customerBalance(d.row.party.id);
            if (context.mounted) {
              sendReminder(context,
                  party: d.row.party, balancePaise: bal > 0 ? bal : d.row.balancePaise, settings: settings);
            }
          },
          icon: const Icon(Icons.chat, color: goodColor),
          label: Text(t.sendReminder),
        ),
    ];
    if (buttons.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(spacing: 12, runSpacing: 10, children: buttons),
    );
  }

  /// Warns if stock is short, then delivers.
  Future<void> _deliver(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final stock = ref.read(stockProvider);
    for (final l in d.lines.where((l) => l.product != null)) {
      final have = await stock.onHandMilli(l.product!.id);
      if (have < l.line.qtyMilli) {
        if (!context.mounted) return;
        final go = await confirmDialog(
          context,
          t.stockWarnBody(qtyLabel(have, l.product!.unit), l.name, qtyLabel(l.line.qtyMilli, l.product!.unit)),
          ok: t.deliverAnyway,
        );
        if (!go) return;
      }
    }
    await ref.read(ordersServiceProvider).deliver(d.row.order.id, date: DateTime.now());
  }
}
