// Stock: on hand, value, purchases, adjustments, shelf counts, production.

import 'package:drift/drift.dart';

import '../data/database.dart';
import 'money.dart';
import 'pricing.dart';

class MaterialNeed {
  const MaterialNeed({required this.material, required this.needMilli, required this.haveMilli});
  final Product material;
  final int needMilli;
  final int haveMilli;
  int get shortMilli => needMilli > haveMilli ? needMilli - haveMilli : 0;
}

class ShortageException implements Exception {
  ShortageException(this.shortages);
  final List<MaterialNeed> shortages;
  @override
  String toString() => 'Not enough material: '
      '${shortages.map((s) => '${s.material.name} short by ${formatMilli(s.shortMilli)} ${s.material.unit}').join(', ')}';
}

class StockService {
  StockService(this.db);
  final AppDatabase db;

  Expression<bool> _live(StockMoves m) => m.deletedAt.isNull();

  /// Quantity on the shelf (optionally as of a date).
  Future<int> onHandMilli(String productId, {DateTime? asOf}) async {
    final sum = db.stockMoves.qtyMilli.sum();
    final q = db.selectOnly(db.stockMoves)
      ..addColumns([sum])
      ..where(db.stockMoves.productId.equals(productId) & _live(db.stockMoves));
    if (asOf != null) q.where(db.stockMoves.movedAt.isSmallerOrEqualValue(asOf));
    return (await q.map((r) => r.read(sum)).getSingle()) ?? 0;
  }

  /// productId -> on hand, for every product with moves.
  Future<Map<String, int>> onHandAll() async {
    final sum = db.stockMoves.qtyMilli.sum();
    final q = db.selectOnly(db.stockMoves)
      ..addColumns([db.stockMoves.productId, sum])
      ..where(_live(db.stockMoves))
      ..groupBy([db.stockMoves.productId]);
    return {
      for (final r in await q.get()) r.read(db.stockMoves.productId)!: r.read(sum) ?? 0,
    };
  }

  /// Material value of all stock (optionally as of a date). Opening stock is
  /// always included, whatever its date.
  Future<int> stockValuePaise({DateTime? asOf}) async {
    final sum = db.stockMoves.valuePaise.sum();
    final q = db.selectOnly(db.stockMoves)
      ..addColumns([sum])
      ..where(_live(db.stockMoves));
    if (asOf != null) {
      q.where(db.stockMoves.movedAt.isSmallerOrEqualValue(asOf) |
          db.stockMoves.type.equalsValue(StockMoveType.opening));
    }
    return (await q.map((r) => r.read(sum)).getSingle()) ?? 0;
  }

  /// Average material cost per unit of what's on the shelf (value ÷ quantity).
  /// Falls back to the average of everything ever bought or made when stock is 0.
  Future<int> averageCostPaise(String productId) async {
    final qty = db.stockMoves.qtyMilli.sum();
    final value = db.stockMoves.valuePaise.sum();
    final onShelf = db.selectOnly(db.stockMoves)
      ..addColumns([qty, value])
      ..where(db.stockMoves.productId.equals(productId) & _live(db.stockMoves));
    final r = await onShelf.getSingle();
    final q = r.read(qty) ?? 0, v = r.read(value) ?? 0;
    if (q > 0 && v > 0) return divRound(v * milliPerUnit, q);

    final inQ = db.stockMoves.qtyMilli.sum();
    final inV = db.stockMoves.valuePaise.sum();
    final bought = db.selectOnly(db.stockMoves)
      ..addColumns([inQ, inV])
      ..where(db.stockMoves.productId.equals(productId) &
          _live(db.stockMoves) &
          db.stockMoves.type
              .isInValues([StockMoveType.opening, StockMoveType.purchase, StockMoveType.productionIn]));
    final b = await bought.getSingle();
    final bq = b.read(inQ) ?? 0, bv = b.read(inV) ?? 0;
    return bq > 0 ? divRound(bv * milliPerUnit, bq) : 0;
  }

  /// Material value of taking [qtyMilli] out at the current average cost (negative).
  Future<int> _outValue(String productId, int qtyMilli) async =>
      -amountForQty(qtyMilli, await averageCostPaise(productId));

  Future<void> addOpeningStock({
    required String productId,
    required int qtyMilli,
    int unitCostPaise = 0,
    required DateTime date,
  }) =>
      db.into(db.stockMoves).insert(StockMovesCompanion.insert(
            productId: productId,
            qtyMilli: qtyMilli,
            type: StockMoveType.opening,
            valuePaise: Value(amountForQty(qtyMilli, unitCostPaise)),
            movedAt: date,
          ));

  /// Bought from a supplier and paid now (supplier credit arrives in R2).
  Future<void> recordPurchase({
    required String productId,
    required int qtyMilli,
    required int totalCostPaise,
    required DateTime date,
    required PaymentMethod paidWith,
    String? supplierId,
    String? note,
  }) {
    if (qtyMilli <= 0) throw ArgumentError('Quantity must be more than zero');
    return db.transaction(() async {
      await db.into(db.stockMoves).insert(StockMovesCompanion.insert(
            productId: productId,
            qtyMilli: qtyMilli,
            type: StockMoveType.purchase,
            valuePaise: Value(totalCostPaise),
            movedAt: date,
            supplierId: Value(supplierId),
            note: Value(note),
          ));
      if (totalCostPaise > 0) {
        await db.into(db.payments).insert(PaymentsCompanion.insert(
              partyId: Value(supplierId),
              purpose: PaymentPurpose.supplierPayment,
              amountPaise: totalCostPaise,
              method: paidWith,
              paidOn: date,
              note: Value(note),
            ));
      }
    });
  }

  /// Damaged, used at home, found extra... [deltaMilli] may be + or −.
  Future<void> adjust({
    required String productId,
    required int deltaMilli,
    required String reason,
    required DateTime date,
  }) async {
    if (deltaMilli == 0) return;
    final avg = await averageCostPaise(productId);
    await db.into(db.stockMoves).insert(StockMovesCompanion.insert(
          productId: productId,
          qtyMilli: deltaMilli,
          type: StockMoveType.adjustment,
          valuePaise: Value(deltaMilli > 0 ? amountForQty(deltaMilli, avg) : -amountForQty(-deltaMilli, avg)),
          movedAt: date,
          note: Value(reason),
        ));
  }

  /// Shelf count: records the difference between counted and expected.
  /// Returns the difference (0 = the app was right).
  Future<int> recordCount({
    required String productId,
    required int countedMilli,
    required DateTime date,
  }) async {
    final expected = await onHandMilli(productId);
    final delta = countedMilli - expected;
    if (delta == 0) return 0;
    final avg = await averageCostPaise(productId);
    await db.into(db.stockMoves).insert(StockMovesCompanion.insert(
          productId: productId,
          qtyMilli: delta,
          type: StockMoveType.count,
          valuePaise: Value(delta > 0 ? amountForQty(delta, avg) : -amountForQty(-delta, avg)),
          movedAt: date,
          note: Value('Shelf count: expected ${formatMilli(expected)}, counted ${formatMilli(countedMilli)}'),
        ));
    return delta;
  }

  Future<List<RecipeLine>> recipe(String productId) =>
      (db.select(db.recipeLines)..where((r) => r.productId.equals(productId) & r.deletedAt.isNull())).get();

  /// Materials needed to make [qtyMilli] pieces, against what's on the shelf.
  Future<List<MaterialNeed>> materialNeeds(String productId, int qtyMilli) async {
    final needs = <MaterialNeed>[];
    for (final line in await recipe(productId)) {
      final material = await (db.select(db.products)..where((p) => p.id.equals(line.materialId))).getSingle();
      needs.add(MaterialNeed(
        material: material,
        needMilli: divRound(line.qtyMilli * qtyMilli, milliPerUnit),
        haveMilli: await onHandMilli(line.materialId),
      ));
    }
    return needs;
  }

  /// Made [qtyMilli] pieces: uses materials per the recipe, adds the pieces to
  /// stock at their material value, and records her time and overhead.
  /// Throws [ShortageException] unless [allowShortage] is true.
  Future<ProductionRun> produce({
    required String productId,
    required int qtyMilli,
    required DateTime date,
    int batchMinutes = 0,
    bool allowShortage = false,
    String? note,
  }) async {
    if (qtyMilli <= 0) throw ArgumentError('Quantity must be more than zero');
    final needs = await materialNeeds(productId, qtyMilli);
    final short = needs.where((n) => n.shortMilli > 0).toList();
    if (short.isNotEmpty && !allowShortage) throw ShortageException(short);
    final settings = await db.getSettings();

    return db.transaction(() async {
      var materialCost = 0;
      final useMoves = <StockMovesCompanion>[];
      for (final n in needs) {
        if (n.needMilli == 0) continue;
        final value = await _outValue(n.material.id, n.needMilli);
        materialCost -= value;
        useMoves.add(StockMovesCompanion.insert(
          productId: n.material.id,
          qtyMilli: -n.needMilli,
          type: StockMoveType.productionUse,
          valuePaise: Value(value),
          movedAt: date,
        ));
      }
      final labour = labourCostPaise(minutes: batchMinutes, hourlyRatePaise: settings.hourlyRatePaise);
      final run = await db.into(db.productionRuns).insertReturning(ProductionRunsCompanion.insert(
            productId: productId,
            qtyMilli: qtyMilli,
            madeOn: date,
            batchMinutes: Value(batchMinutes),
            materialCostPaise: materialCost,
            labourCostPaise: labour,
            overheadCostPaise: applyBp(materialCost + labour, settings.overheadBp),
            note: Value(note),
          ));
      for (final m in useMoves) {
        await db.into(db.stockMoves).insert(m.copyWith(productionRunId: Value(run.id)));
      }
      await db.into(db.stockMoves).insert(StockMovesCompanion.insert(
            productId: productId,
            qtyMilli: qtyMilli,
            type: StockMoveType.productionIn,
            valuePaise: Value(materialCost), // exactly what the materials were worth
            movedAt: date,
            productionRunId: Value(run.id),
          ));
      return run;
    });
  }

  /// Full cost of one piece (materials + her time + overhead) for pricing and
  /// margin colours. Uses the latest batch if one exists, otherwise the recipe
  /// at today's material costs, otherwise the average purchase cost.
  Future<int?> costPerPiecePaise(String productId) async {
    final settings = await db.getSettings();
    final latest = await (db.select(db.productionRuns)
          ..where((r) => r.productId.equals(productId) & r.deletedAt.isNull())
          ..orderBy([(r) => OrderingTerm.desc(r.madeOn)])
          ..limit(1))
        .getSingleOrNull();
    if (latest != null && latest.qtyMilli > 0) {
      final total = latest.materialCostPaise + latest.labourCostPaise + latest.overheadCostPaise;
      return divRound(total * milliPerUnit, latest.qtyMilli);
    }
    final lines = await recipe(productId);
    if (lines.isNotEmpty) {
      var material = 0;
      for (final l in lines) {
        material += amountForQty(l.qtyMilli, await averageCostPaise(l.materialId));
      }
      return fullCostPerPiecePaise(
          materialPerPiecePaise: material, labourPerPiecePaise: 0, overheadBp: settings.overheadBp);
    }
    final avg = await averageCostPaise(productId);
    if (avg <= 0) return null;
    return avg + applyBp(avg, settings.overheadBp);
  }
}
