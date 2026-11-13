import 'package:flutter/material.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import 'order_detail_screen.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.row, {super.key, this.showCustomer = true});
  final OrderRow row;
  final bool showCustomer;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final o = row.order;
    final late =
        o.status == OrderStatus.confirmed && o.promisedDate != null && o.promisedDate!.isBefore(DateTime.now());
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: o.id))),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                child: Text(showCustomer ? row.party.name : o.number,
                    style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis),
              ),
              Text(formatPaise(row.totalPaise), style: Theme.of(context).textTheme.titleMedium),
            ]),
            const SizedBox(height: 4),
            Text(
              [if (showCustomer) o.number, shortDate(context, o.orderDate)].join(' · '),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 6, children: [
              Pill(t.status(o.status), color: statusColor(o.status)),
              if (o.status != OrderStatus.cancelled) payPill(context, row),
              if (o.status == OrderStatus.confirmed && o.promisedDate != null)
                Pill(t.orderDeliverBy(shortDate(context, o.promisedDate!)),
                    color: late ? badColor : Colors.blueGrey, icon: Icons.event),
            ]),
          ]),
        ),
      ),
    );
  }
}

Widget payPill(BuildContext context, OrderRow row) {
  final t = context.t;
  final delivered = row.order.status == OrderStatus.delivered;
  if (!delivered) {
    return row.paidPaise > 0
        ? Pill(t.payAdvance(formatPaise(row.paidPaise)), color: goodColor, icon: Icons.savings)
        : const SizedBox.shrink();
  }
  return switch (row.payState) {
    PayState.paid => Pill(t.payPaid, color: goodColor, icon: Icons.check),
    PayState.partly => Pill('${t.payPartly} · ${t.balance} ${formatPaise(row.balancePaise)}', color: warnColor),
    PayState.unpaid => Pill(t.payUnpaid, color: badColor),
  };
}
