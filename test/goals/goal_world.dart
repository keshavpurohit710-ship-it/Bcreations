// A small craft business in a box: an in-memory database with every service,
// plus shortcuts that read like what she does in a day.

import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/catalog_service.dart';
import 'package:bcreations/domain/entry_service.dart';
import 'package:bcreations/domain/order_service.dart';
import 'package:bcreations/domain/report_service.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;

import '../domain/helpers.dart';

export 'package:bcreations/domain/order_service.dart' show LineInput;
export '../domain/helpers.dart';

class Shop extends World {
  Shop() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    catalog = CatalogService(db, stock);
    entries = EntryService(db);
  }

  late final CatalogService catalog;
  late final EntryService entries;

  /// Creates an order (confirmed) for one catalogue item.
  Future<Order> order(String party, String product, int qty, int pricePaise, DateTime on,
          {int deliveryPaise = 0, OrderStatus status = OrderStatus.confirmed}) =>
      orders.createOrder(
        partyId: party,
        orderDate: on,
        status: status,
        deliveryChargePaise: deliveryPaise,
        lines: [LineInput(productId: product, qtyMilli: qty * 1000, unitPricePaise: pricePaise)],
      );

  /// Order + delivery on the same day.
  Future<Order> sell(String party, String product, int qty, int pricePaise, DateTime on) async {
    final o = await order(party, product, qty, pricePaise, on);
    await orders.deliver(o.id, date: on);
    return o;
  }

  Future<String> pay(String party, int paise, DateTime on, {String? orderId}) =>
      ledger.receivePayment(partyId: party, amountPaise: paise, method: PaymentMethod.upi, date: on, orderId: orderId);

  Future<void> buy(String product, int qtyMilli, int totalPaise, DateTime on) => stock.recordPurchase(
      productId: product, qtyMilli: qtyMilli, totalCostPaise: totalPaise, date: on, paidWith: PaymentMethod.cash);

  Future<PeriodSummary> month(int m) {
    final (from, to) = ReportService.monthBounds(d(m, 1));
    return reports.summary(from: from, to: to);
  }

  Future<int> dueOf(String party) => ledger.customerBalance(party);
}

/// ₹ helper so expectations read naturally: rs(1200) == 120000 paise.
int rs(num rupees) => (rupees * 100).round();
