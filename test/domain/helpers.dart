import 'package:bcreations/data/database.dart';
import 'package:bcreations/domain/ledger_service.dart';
import 'package:bcreations/domain/order_service.dart';
import 'package:bcreations/domain/report_service.dart';
import 'package:bcreations/domain/stock_service.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';

/// A fresh in-memory database with every service wired up.
class World {
  World() : db = AppDatabase(NativeDatabase.memory()) {
    stock = StockService(db);
    ledger = LedgerService(db);
    orders = OrderService(db, stock, ledger);
    reports = ReportService(db, ledger, stock);
  }

  final AppDatabase db;
  late final StockService stock;
  late final LedgerService ledger;
  late final OrderService orders;
  late final ReportService reports;

  Future<void> close() => db.close();

  Future<String> customer(
    String name, {
    PriceType priceType = PriceType.retail,
    int? creditLimitPaise,
    int openingBalancePaise = 0,
    int? termsDays,
  }) async =>
      (await db.into(db.parties).insertReturning(PartiesCompanion.insert(
                name: name,
                priceType: Value(priceType),
                creditLimitPaise: Value(creditLimitPaise),
                openingBalancePaise: Value(openingBalancePaise),
                paymentTermsDays: Value(termsDays),
              )))
          .id;

  Future<String> supplier(String name) async => (await db
          .into(db.parties)
          .insertReturning(PartiesCompanion.insert(name: name, role: const Value(PartyRole.supplier))))
      .id;

  Future<String> product(String name, ProductKind kind, {String unit = 'pcs', int? retailPaise}) async =>
      (await db.into(db.products).insertReturning(ProductsCompanion.insert(
                name: name,
                kind: kind,
                unit: Value(unit),
                retailPricePaise: Value(retailPaise),
              )))
          .id;

  Future<void> recipe(String productId, String materialId, int qtyMilli) => db
      .into(db.recipeLines)
      .insert(RecipeLinesCompanion.insert(productId: productId, materialId: materialId, qtyMilli: qtyMilli));

  Future<void> expense(String category, int paise, DateTime on) => db.into(db.expenses).insert(
      ExpensesCompanion.insert(category: category, amountPaise: paise, method: PaymentMethod.cash, spentOn: on));

  Future<void> withdraw(int paise, DateTime on) => db
      .into(db.ownerWithdrawals)
      .insert(OwnerWithdrawalsCompanion.insert(amountPaise: paise, method: PaymentMethod.upi, takenOn: on));

  Future<Order> getOrder(String id) => (db.select(db.orders)..where((o) => o.id.equals(id))).getSingle();
}

DateTime d(int month, int day) => DateTime(2026, month, day, 12);
