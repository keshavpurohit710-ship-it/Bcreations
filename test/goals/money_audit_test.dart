// A randomised audit of the books. For several random "lives" of the business,
// do months of mixed everyday activity, then check after each month that every
// number she sees reconciles. If any money or stock ever goes missing, this
// test finds the sequence that did it (the seed is in the test name).

import 'dart:math';

import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/pricing.dart';
import 'package:bcreations/domain/report_service.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';

import 'goal_world.dart';

const _seeds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
const _opsPerMonth = 60;
const _months = 4;

void main() {
  for (final seed in _seeds) {
    test('books reconcile every month (random seed $seed)', () async {
      final s = Shop();
      addTearDown(s.close);
      final rnd = Random(seed);
      T pick<T>(List<T> xs) => xs[rnd.nextInt(xs.length)];

      // --- the business on day one
      final materials = [
        await s.product('Lace', ProductKind.rawMaterial, unit: 'm'),
        await s.product('Beads', ProductKind.rawMaterial, unit: 'g'),
        await s.product('Wax', ProductKind.rawMaterial, unit: 'kg'),
      ];
      final made = [
        await s.product('Potli', ProductKind.made, retailPaise: rs(450)),
        await s.product('Candle', ProductKind.made, retailPaise: rs(250)),
      ];
      await s.recipe(made[0], materials[0], 800);
      await s.recipe(made[0], materials[1], 25000);
      await s.recipe(made[1], materials[2], 333);
      final bought = [
        await s.product('Hamper', ProductKind.bought, retailPaise: rs(1500)),
        await s.product('Gift box', ProductKind.bought, retailPaise: rs(100)),
      ];
      await s.stock.addOpeningStock(productId: bought[0], qtyMilli: 10000, unitCostPaise: rs(900), date: d(1, 1));
      await s.stock.addOpeningStock(productId: bought[1], qtyMilli: 50000, unitCostPaise: rs(35), date: d(1, 1));
      final sellable = [...made, ...bought];
      final customers = [
        await s.customer('Shop A', priceType: PriceType.wholesale, openingBalancePaise: rs(2500)),
        await s.customer('Shop B', priceType: PriceType.wholesale, creditLimitPaise: rs(10000)),
        await s.customer('Asha'),
        await s.customer('Priya', openingBalancePaise: rs(300)),
      ];
      final supplier = await s.supplier('Sharma Traders');

      final openOrders = <String>[];
      final deliveredOrders = <String>[];
      final payments = <String>[];

      for (var month = 1; month <= _months; month++) {
        for (var i = 0; i < _opsPerMonth; i++) {
          final day = DateTime(2026, month, 1 + (i * 27 ~/ _opsPerMonth), 9 + i % 8);
          switch (rnd.nextInt(14)) {
            case 0 || 1: // buy materials or stock to resell
              final p = pick([...materials, ...bought]);
              await s.stock.recordPurchase(
                  productId: p,
                  qtyMilli: (1 + rnd.nextInt(40)) * 500,
                  totalCostPaise: rs(50 + rnd.nextInt(2000)),
                  date: day,
                  paidWith: pick(PaymentMethod.values),
                  supplierId: rnd.nextBool() ? supplier : null);
            case 2: // make a batch (sometimes with material short)
              await s.stock.produce(
                  productId: pick(made),
                  qtyMilli: (1 + rnd.nextInt(12)) * 1000,
                  date: day,
                  batchMinutes: rnd.nextInt(600),
                  allowShortage: true);
            case 3 || 4: // new order, possibly a quote, custom item, discounts, advance
              final party = pick(customers);
              final lines = [
                for (var n = 0; n <= rnd.nextInt(3); n++)
                  rnd.nextInt(5) == 0
                      ? LineInput(
                          description: 'Custom $n',
                          qtyMilli: (1 + rnd.nextInt(5)) * 1000,
                          unitPricePaise: rs(100 + rnd.nextInt(900)),
                          specText: 'Name $n')
                      : LineInput(
                          productId: pick(sellable),
                          qtyMilli: (1 + rnd.nextInt(20)) * 500,
                          unitPricePaise: rs(50 + rnd.nextInt(1500)),
                          lineDiscountPaise: rnd.nextInt(4) == 0 ? rs(rnd.nextInt(20)) : 0),
              ];
              final o = await s.orders.createOrder(
                partyId: party,
                orderDate: day,
                lines: lines,
                status: rnd.nextInt(4) == 0 ? OrderStatus.quote : OrderStatus.confirmed,
                deliveryChargePaise: rnd.nextBool() ? rs(rnd.nextInt(150)) : 0,
                orderDiscountPaise: rnd.nextInt(5) == 0 ? rs(rnd.nextInt(30)) : 0,
              );
              openOrders.add(o.id);
              if (rnd.nextInt(3) == 0) {
                payments.add(await s.pay(party, rs(10 + rnd.nextInt(800)), day, orderId: o.id));
              }
            case 5 || 6: // deliver something
              if (openOrders.isEmpty) break;
              final id = openOrders.removeAt(rnd.nextInt(openOrders.length));
              await s.orders.deliver(id, date: day);
              deliveredOrders.add(id);
            case 7: // cancel an open or delivered order
              final pool = rnd.nextBool() ? openOrders : deliveredOrders;
              if (pool.isEmpty) break;
              await s.orders.cancel(pool.removeAt(rnd.nextInt(pool.length)), date: day);
            case 8 || 9: // customer pays (general or for an order)
              final party = pick(customers);
              payments.add(await s.pay(party, rs(20 + rnd.nextInt(3000)), day,
                  orderId: deliveredOrders.isNotEmpty && rnd.nextBool() ? pick(deliveredOrders) : null));
            case 10: // refund credit, or delete a mistaken payment
              final party = pick(customers);
              final bal = await s.dueOf(party);
              if (bal < 0) {
                await s.ledger
                    .refund(partyId: party, amountPaise: -bal ~/ 2 + 1, method: PaymentMethod.cash, date: day);
              } else if (payments.isNotEmpty) {
                await s.ledger.deletePayment(payments.removeAt(rnd.nextInt(payments.length)));
              }
            case 11: // small expense
              await s.entries.addExpense(
                  category: pick(['Packaging', 'Courier', 'Travel', 'Phone']),
                  amountPaise: rs(10 + rnd.nextInt(500)),
                  method: PaymentMethod.cash,
                  date: day);
            case 12: // money for home
              await s.entries
                  .addWithdrawal(amountPaise: rs(100 + rnd.nextInt(2000)), method: PaymentMethod.upi, date: day);
            default: // breakage, found extra, or a shelf count
              final p = pick([...materials, ...sellable]);
              if (rnd.nextBool()) {
                await s.stock.adjust(
                    productId: p,
                    deltaMilli: (rnd.nextBool() ? -1 : 1) * (1 + rnd.nextInt(3)) * 500,
                    reason: 'x',
                    date: day);
              } else {
                final now = await s.stock.onHandMilli(p);
                await s.stock.recordCount(productId: p, countedMilli: max(0, now - rnd.nextInt(3) * 500), date: day);
              }
          }
        }

        // ------------------------------------------------ month-end audit
        final (from, to) = ReportService.monthBounds(d(month, 1));
        final m = await s.reports.summary(from: from, to: to);
        expect(m.cashAddedPaise, m.actualCashChangePaise,
            reason: 'month $month: "Where did my profit go?" must equal real cash in − cash out');
        await _auditBooks(s, customers, month);
      }

      // Deleting a mistaken payment later changes earlier months, so re-check every
      // month as it stands now, then compare the total with every cash movement.
      var cashSinceStart = 0;
      for (var month = 1; month <= _months; month++) {
        final (from, to) = ReportService.monthBounds(d(month, 1));
        final m = await s.reports.summary(from: from, to: to);
        expect(m.cashAddedPaise, m.actualCashChangePaise, reason: 'month $month, re-checked at the end');
        cashSinceStart += m.actualCashChangePaise;
      }
      final cashIn = await _sum(
          s, 'SELECT SUM(amount_paise) FROM payments WHERE deleted_at IS NULL AND purpose = ?', ['customerPayment']);
      final cashOut = await _sum(
              s,
              'SELECT SUM(amount_paise) FROM payments WHERE deleted_at IS NULL AND purpose IN (?, ?)',
              ['customerRefund', 'supplierPayment']) +
          await _sum(s, 'SELECT SUM(amount_paise) FROM expenses WHERE deleted_at IS NULL') +
          await _sum(s, 'SELECT SUM(amount_paise) FROM owner_withdrawals WHERE deleted_at IS NULL');
      expect(cashSinceStart, cashIn - cashOut, reason: 'monthly cash adds up to the whole period');
    }, timeout: const Timeout(Duration(minutes: 3)));
  }
}

Future<int> _sum(Shop s, String sql, [List<Object> args = const []]) async {
  final row = await s.db.customSelect(sql, variables: [for (final a in args) Variable(a)]).getSingle();
  return (row.data.values.first as int?) ?? 0;
}

/// Checks every number against an independent calculation from raw rows.
Future<void> _auditBooks(Shop s, List<String> customers, int month) async {
  final db = s.db;
  final why = 'after month $month';

  // Stock: quantity and value are exactly the sum of all movements
  for (final p in await db.select(db.products).get()) {
    final raw =
        await _sum(s, 'SELECT SUM(qty_milli) FROM stock_moves WHERE deleted_at IS NULL AND product_id = ?', [p.id]);
    expect(await s.stock.onHandMilli(p.id), raw, reason: '$why: stock of ${p.name}');
  }
  expect(await s.stock.stockValuePaise(),
      await _sum(s, 'SELECT SUM(value_paise) FROM stock_moves WHERE deleted_at IS NULL'),
      reason: '$why: stock value');

  // Making things never creates or destroys material value
  final madeIn = await _sum(s, "SELECT SUM(value_paise) FROM stock_moves WHERE type = 'productionIn'");
  final usedUp = await _sum(s, "SELECT SUM(value_paise) FROM stock_moves WHERE type = 'productionUse'");
  expect(madeIn, -usedUp, reason: '$why: production keeps material value');

  // Orders: never paid more than the bill; cancelled orders hold no payment
  for (final o in await db.select(db.orders).get()) {
    final total = await s.ledger.orderTotal(o.id);
    final paid = await s.ledger.orderPaid(o.id);
    expect(paid, greaterThanOrEqualTo(0), reason: '$why: ${o.number} paid');
    if (o.status == OrderStatus.cancelled) {
      expect(paid, 0, reason: '$why: cancelled ${o.number} keeps no money');
    } else {
      expect(paid, lessThanOrEqualTo(total), reason: '$why: ${o.number} over-allocated');
    }
  }

  // A payment is never spent twice
  for (final p in await (db.select(db.payments)..where((x) => x.deletedAt.isNull())).get()) {
    final used = await _sum(
        s, 'SELECT SUM(amount_paise) FROM payment_allocations WHERE deleted_at IS NULL AND payment_id = ?', [p.id]);
    expect(used, lessThanOrEqualTo(p.amountPaise), reason: '$why: payment used more than once');
  }

  // Each customer's balance, rebuilt from scratch
  var allDues = 0;
  for (final c in customers) {
    final party = await (db.select(db.parties)..where((x) => x.id.equals(c))).getSingle();
    final delivered = await (db.select(db.orders)
          ..where((o) => o.partyId.equals(c) & o.status.equalsValue(OrderStatus.delivered)))
        .get();
    var billed = 0;
    for (final o in delivered) {
      final lines = await s.ledger.linesOf(o.id);
      billed += orderTotalPaise(
        lineNetPaise: lines.map((l) => lineNetPaise(
            qtyMilli: l.qtyMilli, unitPricePaise: l.unitPricePaise, lineDiscountPaise: l.lineDiscountPaise)),
        orderDiscountPaise: o.orderDiscountPaise,
        deliveryChargePaise: o.deliveryChargePaise,
      );
    }
    final paid = await _sum(
        s,
        "SELECT SUM(amount_paise) FROM payments WHERE deleted_at IS NULL AND party_id = ? AND purpose = 'customerPayment'",
        [c]);
    final refunded = await _sum(
        s,
        "SELECT SUM(amount_paise) FROM payments WHERE deleted_at IS NULL AND party_id = ? AND purpose = 'customerRefund'",
        [c]);
    final expected = party.openingBalancePaise + billed - paid + refunded;
    expect(await s.ledger.customerBalance(c), expected, reason: '$why: balance of ${party.name}');
    if (expected > 0) allDues += expected;
  }

  // The "collect" list on Home shows exactly the customers who owe money
  final dues = await s.ledger.customerDues(today: d(month, 28));
  expect(dues.fold<int>(0, (a, x) => a + x.balancePaise), allDues, reason: '$why: dues list total');
  expect(dues.every((x) => x.balancePaise > 0), isTrue);
}
