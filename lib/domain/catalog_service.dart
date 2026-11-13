// Customers/suppliers and products: create, edit, archive.

import 'package:drift/drift.dart';

import '../data/database.dart';
import 'stock_service.dart';

class RecipeInput {
  const RecipeInput(this.materialId, this.qtyMilli);
  final String materialId;
  final int qtyMilli;
}

class CatalogService {
  CatalogService(this.db, this.stock);
  final AppDatabase db;
  final StockService stock;

  // ----------------------------------------------------------------- parties

  Future<String> saveParty(PartiesCompanion data, {String? id}) async {
    if (id == null) return (await db.into(db.parties).insertReturning(data)).id;
    await (db.update(db.parties)..where((p) => p.id.equals(id))).write(data.copyWith(updatedAt: Value(DateTime.now())));
    return id;
  }

  Future<void> setPartyArchived(String id, bool archived) => (db.update(db.parties)..where((p) => p.id.equals(id)))
      .write(PartiesCompanion(archived: Value(archived), updatedAt: Value(DateTime.now())));

  Future<Party> party(String id) => (db.select(db.parties)..where((p) => p.id.equals(id))).getSingle();

  // ---------------------------------------------------------------- products

  /// Creates or updates a product. For a new product, [openingQtyMilli] is what
  /// she has on the shelf right now (at [openingUnitCostPaise] each).
  Future<String> saveProduct(
    ProductsCompanion data, {
    String? id,
    List<RecipeInput>? recipe,
    int openingQtyMilli = 0,
    int openingUnitCostPaise = 0,
    required DateTime today,
  }) =>
      db.transaction(() async {
        final productId = id ?? (await db.into(db.products).insertReturning(data)).id;
        if (id != null) {
          await (db.update(db.products)..where((p) => p.id.equals(id)))
              .write(data.copyWith(updatedAt: Value(DateTime.now())));
        }
        if (recipe != null) {
          await (db.update(db.recipeLines)..where((r) => r.productId.equals(productId) & r.deletedAt.isNull()))
              .write(RecipeLinesCompanion(deletedAt: Value(DateTime.now())));
          for (final r in recipe.where((r) => r.qtyMilli > 0)) {
            await db.into(db.recipeLines).insert(
                RecipeLinesCompanion.insert(productId: productId, materialId: r.materialId, qtyMilli: r.qtyMilli));
          }
        }
        if (id == null && openingQtyMilli > 0) {
          await stock.addOpeningStock(
              productId: productId, qtyMilli: openingQtyMilli, unitCostPaise: openingUnitCostPaise, date: today);
        }
        return productId;
      });

  Future<void> setProductArchived(String id, bool archived) => (db.update(db.products)..where((p) => p.id.equals(id)))
      .write(ProductsCompanion(archived: Value(archived), updatedAt: Value(DateTime.now())));

  /// Remember the cost at which she set the price (for "Prices to review").
  Future<void> markPriceSet(String id) async {
    final cost = await stock.costPerPiecePaise(id);
    await (db.update(db.products)..where((p) => p.id.equals(id)))
        .write(ProductsCompanion(priceSetCostPaise: Value(cost), updatedAt: Value(DateTime.now())));
  }
}
