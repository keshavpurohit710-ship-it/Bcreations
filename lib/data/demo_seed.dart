// Realistic demo data for a small craft business, used while building and
// testing screens (never inserted into her real database automatically).

import 'package:drift/drift.dart';

import '../domain/ledger_service.dart';
import '../domain/order_service.dart';
import '../domain/stock_service.dart';
import 'database.dart';

/// Fills an EMPTY database with ~2 months of activity ending at [today].
Future<void> seedDemoData(AppDatabase db, {required DateTime today}) async {
  final stock = StockService(db);
  final ledger = LedgerService(db);
  final orders = OrderService(db, stock, ledger);
  DateTime ago(int days) => DateTime(today.year, today.month, today.day - days, 11);

  await (db.update(db.settings)..where((s) => s.id.equals(settingsRowId))).write(SettingsCompanion(
    businessName: const Value('Bcreations'),
    upiId: const Value('bcreations@upi'),
    startDate: Value(ago(60)),
  ));

  Future<String> product(String name, ProductKind kind,
          {String unit = 'pcs', String? category, int? retail, int? wholesale, int minStock = 0}) async =>
      (await db.into(db.products).insertReturning(ProductsCompanion.insert(
                name: name,
                kind: kind,
                unit: Value(unit),
                category: Value(category),
                retailPricePaise: Value(retail),
                wholesalePricePaise: Value(wholesale),
                minStockMilli: Value(minStock),
              )))
          .id;

  Future<String> party(String name,
          {PartyRole role = PartyRole.customer,
          PriceType price = PriceType.retail,
          SalesChannel? channel,
          String? phone,
          int? creditLimit,
          int opening = 0}) async =>
      (await db.into(db.parties).insertReturning(PartiesCompanion.insert(
                name: name,
                role: Value(role),
                priceType: Value(price),
                defaultChannel: Value(channel),
                phone: Value(phone),
                creditLimitPaise: Value(creditLimit),
                openingBalancePaise: Value(opening),
              )))
          .id;

  // Materials
  final lace =
      await product('Golden lace', ProductKind.rawMaterial, unit: 'm', category: 'Fabric', minStock: 5000);
  final silk =
      await product('Silk cloth', ProductKind.rawMaterial, unit: 'm', category: 'Fabric', minStock: 3000);
  final beads =
      await product('Kundan beads', ProductKind.rawMaterial, unit: 'g', category: 'Beads', minStock: 200000);
  final wax = await product('Wax', ProductKind.rawMaterial, unit: 'kg', category: 'Candle', minStock: 2000);
  final box = await product('Gift box', ProductKind.rawMaterial, category: 'Packaging', minStock: 20000);

  // Products
  final rakhi =
      await product('Kundan rakhi', ProductKind.made, category: 'Rakhi', retail: 15000, wholesale: 9000);
  final potli =
      await product('Silk potli bag', ProductKind.made, category: 'Bags', retail: 45000, wholesale: 30000);
  final candle = await product('Diya candle set', ProductKind.made, category: 'Candles', retail: 60000);
  final hamper = await product('Festive hamper', ProductKind.bought, category: 'Hampers', retail: 150000);

  Future<void> recipe(String p, String m, int milli) => db
      .into(db.recipeLines)
      .insert(RecipeLinesCompanion.insert(productId: p, materialId: m, qtyMilli: milli));
  await recipe(rakhi, beads, 15000);
  await recipe(rakhi, lace, 300);
  await recipe(potli, silk, 500);
  await recipe(potli, lace, 800);
  await recipe(candle, wax, 400);
  await recipe(candle, box, 1000);

  // People
  final sharma = await party('Sharma Traders', role: PartyRole.supplier, phone: '+91 98200 11111');
  final giftShop = await party('Kala Gift Shop',
      price: PriceType.wholesale,
      channel: SalesChannel.shop,
      phone: '+91 98200 22222',
      creditLimit: 1000000,
      opening: 250000);
  final boutique = await party('Rang Boutique',
      price: PriceType.wholesale, channel: SalesChannel.shop, phone: '+91 98200 33333');
  final asha = await party('Asha Mehta', channel: SalesChannel.individual, phone: '+91 98200 44444');
  final priya = await party('Priya (Instagram)', channel: SalesChannel.online, phone: '+91 98200 55555');

  // Opening stock and purchases
  await stock.addOpeningStock(productId: hamper, qtyMilli: 6000, unitCostPaise: 80000, date: ago(60));
  await stock.addOpeningStock(productId: box, qtyMilli: 40000, unitCostPaise: 2500, date: ago(60));
  await stock.recordPurchase(
      productId: beads,
      qtyMilli: 1000000,
      totalCostPaise: 250000,
      date: ago(55),
      paidWith: PaymentMethod.upi,
      supplierId: sharma);
  await stock.recordPurchase(
      productId: lace,
      qtyMilli: 50000,
      totalCostPaise: 150000,
      date: ago(55),
      paidWith: PaymentMethod.upi,
      supplierId: sharma);
  await stock.recordPurchase(
      productId: silk,
      qtyMilli: 20000,
      totalCostPaise: 240000,
      date: ago(50),
      paidWith: PaymentMethod.cash,
      supplierId: sharma);
  await stock.recordPurchase(
      productId: wax, qtyMilli: 10000, totalCostPaise: 180000, date: ago(45), paidWith: PaymentMethod.cash);

  // Production
  await stock.produce(productId: rakhi, qtyMilli: 50000, date: ago(50), batchMinutes: 600);
  await stock.produce(productId: potli, qtyMilli: 20000, date: ago(45), batchMinutes: 720);
  await stock.produce(productId: candle, qtyMilli: 15000, date: ago(40), batchMinutes: 300);

  // Orders
  final o1 = await orders.createOrder(partyId: giftShop, orderDate: ago(40), lines: [
    LineInput(productId: rakhi, qtyMilli: 30000, unitPricePaise: 9000, listPricePaise: 9000),
    LineInput(productId: potli, qtyMilli: 10000, unitPricePaise: 30000, listPricePaise: 30000),
  ]);
  await orders.deliver(o1.id, date: ago(35));
  await ledger.receivePayment(
      partyId: giftShop, amountPaise: 300000, method: PaymentMethod.bank, date: ago(20));

  final o2 = await orders.createOrder(
    partyId: asha,
    orderDate: ago(30),
    deliveryChargePaise: 8000,
    lines: [LineInput(productId: candle, qtyMilli: 2000, unitPricePaise: 60000, listPricePaise: 60000)],
  );
  await ledger.receivePayment(
      partyId: asha, amountPaise: 128000, method: PaymentMethod.upi, date: ago(28), orderId: o2.id);
  await orders.deliver(o2.id, date: ago(28));

  final o3 = await orders.createOrder(
      partyId: boutique,
      orderDate: ago(25),
      orderDiscountPaise: 20000,
      discountReason: 'Bulk',
      lines: [
        LineInput(productId: potli, qtyMilli: 6000, unitPricePaise: 30000, listPricePaise: 30000),
        LineInput(productId: hamper, qtyMilli: 2000, unitPricePaise: 140000, listPricePaise: 150000),
      ]);
  await orders.deliver(o3.id, date: ago(22));

  // Custom order in progress with an advance
  final o4 = await orders.createOrder(
    partyId: priya,
    orderDate: ago(5),
    promisedDate: ago(-7),
    channel: SalesChannel.online,
    lines: const [
      LineInput(
        description: 'Wedding potli bags with names',
        qtyMilli: 25000,
        unitPricePaise: 55000,
        unitCostPaise: 28000,
        specColour: 'Maroon with gold',
        specText: 'Riya weds Karan',
      ),
    ],
  );
  await ledger.receivePayment(
      partyId: priya, amountPaise: 500000, method: PaymentMethod.upi, date: ago(5), orderId: o4.id);

  // A quote not yet confirmed
  await orders.createOrder(
    partyId: asha,
    orderDate: ago(1),
    status: OrderStatus.quote,
    lines: [LineInput(productId: hamper, qtyMilli: 3000, unitPricePaise: 150000, listPricePaise: 150000)],
  );

  // Expenses, withdrawals, a breakage
  for (final (cat, amt, days) in [
    ('Courier', 18000, 34),
    ('Packaging', 25000, 30),
    ('Travel', 6000, 22),
    ('Phone', 39900, 15),
    ('Courier', 12000, 8),
  ]) {
    await db.into(db.expenses).insert(ExpensesCompanion.insert(
        category: cat, amountPaise: amt, method: PaymentMethod.cash, spentOn: ago(days)));
  }
  await db.into(db.ownerWithdrawals).insert(OwnerWithdrawalsCompanion.insert(
      amountPaise: 200000, method: PaymentMethod.upi, takenOn: ago(12), note: const Value('Home')));
  await stock.adjust(productId: candle, deltaMilli: -1000, reason: 'Cracked in transit', date: ago(26));
}
