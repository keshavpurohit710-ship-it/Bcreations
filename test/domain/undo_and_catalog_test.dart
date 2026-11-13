import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/catalog_service.dart';
import 'package:bcreations/domain/entry_service.dart';
import 'package:bcreations/domain/order_service.dart';
import 'package:bcreations/domain/report_service.dart';
import 'package:drift/drift.dart' show Value, driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late World w;
  setUp(() => w = World());
  tearDown(() => w.close());

  test('deleting a payment reopens the dues; undo puts it back exactly', () async {
    final c = await w.customer('Asha');
    final item = await w.product('Potli', ProductKind.bought, retailPaise: 40000);
    await w.stock.addOpeningStock(productId: item, qtyMilli: 5000, unitCostPaise: 20000, date: d(1, 1));
    final o = await w.orders.createOrder(
        partyId: c, orderDate: d(2, 1), lines: [LineInput(productId: item, qtyMilli: 1000, unitPricePaise: 40000)]);
    await w.orders.deliver(o.id, date: d(2, 2));
    final pay = await w.ledger.receivePayment(partyId: c, amountPaise: 40000, method: PaymentMethod.upi, date: d(2, 3));
    expect(await w.ledger.customerBalance(c), 0);

    final stamp = await w.ledger.deletePayment(pay);
    expect(await w.ledger.customerBalance(c), 40000);
    expect(await w.ledger.orderPaid(o.id), 0);

    await w.ledger.restorePayment(pay, stamp);
    expect(await w.ledger.customerBalance(c), 0);
    expect(await w.ledger.orderPaid(o.id), 40000);
  });

  test('expenses and money for home can be undone and leave the month report', () async {
    final entries = EntryService(w.db);
    final e =
        await entries.addExpense(category: 'Courier', amountPaise: 15000, method: PaymentMethod.cash, date: d(3, 5));
    final h = await entries.addWithdrawal(amountPaise: 50000, method: PaymentMethod.upi, date: d(3, 6));
    final (from, to) = ReportService.monthBounds(d(3, 1));

    var s = await w.reports.summary(from: from, to: to);
    expect(s.expensesPaise, 15000);
    expect(s.withdrawalsPaise, 50000);

    await entries.setExpenseDeleted(e, true);
    await entries.setWithdrawalDeleted(h, true);
    s = await w.reports.summary(from: from, to: to);
    expect(s.expensesPaise, 0);
    expect(s.withdrawalsPaise, 0);

    await entries.setExpenseDeleted(e, false);
    s = await w.reports.summary(from: from, to: to);
    expect(s.expensesPaise, 15000);
  });

  test('saving an item with a recipe and opening stock; editing replaces the recipe', () async {
    final catalog = CatalogService(w.db, w.stock);
    final lace = await w.product('Lace', ProductKind.rawMaterial, unit: 'm');
    final beads = await w.product('Beads', ProductKind.rawMaterial, unit: 'g');
    final id = await catalog.saveProduct(
      const ProductsCompanion(name: Value('Rakhi'), kind: Value(ProductKind.made), retailPricePaise: Value(15000)),
      recipe: [RecipeInput(lace, 300)],
      openingQtyMilli: 12000,
      openingUnitCostPaise: 4000,
      today: d(1, 1),
    );
    expect(await w.stock.onHandMilli(id), 12000);
    expect((await w.stock.recipe(id)).single.materialId, lace);

    await catalog.saveProduct(
      const ProductsCompanion(name: Value('Rakhi'), kind: Value(ProductKind.made)),
      id: id,
      recipe: [RecipeInput(beads, 15000), RecipeInput(lace, 200)],
      today: d(2, 1),
    );
    final recipe = await w.stock.recipe(id);
    expect(recipe.map((r) => r.materialId).toSet(), {beads, lace});
    expect(recipe.firstWhere((r) => r.materialId == lace).qtyMilli, 200);
    expect(await w.stock.onHandMilli(id), 12000, reason: 'editing never adds opening stock again');
  });

  test('archiving hides a customer but keeps their history', () async {
    final catalog = CatalogService(w.db, w.stock);
    final c = await w.customer('Old shop', openingBalancePaise: 30000);
    await catalog.setPartyArchived(c, true);
    expect((await catalog.party(c)).archived, isTrue);
    expect(await w.ledger.customerBalance(c), 30000);
  });
}
