import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../orders/order_form_screen.dart';
import '../orders/order_tile.dart';
import '../orders/payment_sheet.dart';
import 'customer_form_screen.dart';
import 'reminder.dart';

class CustomerDetailScreen extends ConsumerWidget {
  const CustomerDetailScreen({super.key, required this.partyId});
  final String partyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final detail = ref.watch(partyDetailProvider(partyId));
    final settings = ref.watch(settingsProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(detail.valueOrNull?.party.name ?? ''),
        actions: [
          if (detail.valueOrNull != null)
            PopupMenuButton<String>(
              onSelected: (v) async {
                final party = detail.value!.party;
                if (v == 'edit') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerFormScreen(party: party)));
                } else if (v == 'archive') {
                  await ref.read(catalogProvider).setPartyArchived(party.id, true);
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  showUndo(context, t.archived, () => ref.read(catalogProvider).setPartyArchived(party.id, false));
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(value: 'edit', child: Text(t.edit)),
                PopupMenuItem(value: 'archive', child: Text(t.archive)),
              ],
            ),
        ],
      ),
      body: AsyncBody(detail, builder: (d) {
        final p = d.party;
        final isCustomer = p.role != PartyRole.supplier;
        return ListView(padding: const EdgeInsets.only(bottom: 40), children: [
          if (p.businessName != null || p.phone != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Text([p.businessName, p.phone].whereType<String>().join(' · '),
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                    onPressed: () => callPhone(context, p.phone), icon: const Icon(Icons.call), label: Text(t.call)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => openWhatsApp(context, p.phone),
                  icon: const Icon(Icons.chat, color: goodColor),
                  label: Text(t.whatsapp),
                ),
              ),
            ]),
          ),
          if (isCustomer) ...[
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  BalancePill(d.balancePaise, daysLate: d.daysLate),
                  if (p.creditLimitPaise != null) ...[
                    const SizedBox(height: 8),
                    Text('${t.creditLimit}: ${formatPaise(p.creditLimitPaise!)}',
                        style: TextStyle(color: d.credit.exceedsLimit ? badColor : null)),
                  ],
                  const SizedBox(height: 16),
                  Wrap(spacing: 12, runSpacing: 12, children: [
                    FilledButton.icon(
                      onPressed: () => showPaymentSheet(context, partyId: p.id),
                      icon: const Icon(Icons.payments),
                      label: Text(t.receivePayment),
                    ),
                    if (d.balancePaise > 0 && settings != null)
                      FilledButton.tonalIcon(
                        onPressed: () =>
                            sendReminder(context, party: p, balancePaise: d.balancePaise, settings: settings),
                        icon: const Icon(Icons.chat),
                        label: Text(t.sendReminder),
                      ),
                    OutlinedButton.icon(
                      onPressed: () =>
                          Navigator.push(context, MaterialPageRoute(builder: (_) => OrderFormScreen(partyId: p.id))),
                      icon: const Icon(Icons.add),
                      label: Text(t.quickNewOrder),
                    ),
                  ]),
                ]),
              ),
            ),
            SectionHeader(t.ordersSection),
            if (d.orders.isEmpty)
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(t.noOrders))
            else
              for (final o in d.orders) OrderTile(o, showCustomer: false),
          ],
          SectionHeader(t.paymentsSection),
          if (d.payments.isEmpty)
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(t.noPayments))
          else
            for (final pay in d.payments) PaymentTile(pay),
        ]);
      }),
    );
  }
}

/// One payment, with delete + undo.
class PaymentTile extends ConsumerWidget {
  const PaymentTile(this.payment, {super.key, this.appliedPaise});
  final Payment payment;
  final int? appliedPaise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final incoming = payment.purpose == PaymentPurpose.customerPayment;
    final amount = appliedPaise ?? payment.amountPaise;
    return ListTile(
      leading: Icon(incoming ? Icons.south_west : Icons.north_east, color: incoming ? goodColor : badColor),
      title: Text('${incoming ? '+' : '−'} ${formatPaise(amount)}',
          style: TextStyle(fontWeight: FontWeight.w600, color: incoming ? goodColor : badColor)),
      subtitle: Text([
        longDate(context, payment.paidOn),
        t.method(payment.method),
        if (payment.reference != null) payment.reference!,
      ].join(' · ')),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: t.delete,
        onPressed: () async {
          final ledger = ref.read(ledgerProvider);
          final stamp = await ledger.deletePayment(payment.id);
          if (context.mounted) showUndo(context, t.deleted, () => ledger.restorePayment(payment.id, stamp));
        },
      ),
    );
  }
}
