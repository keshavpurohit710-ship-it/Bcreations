// Drift table definitions for Bcreations (schema version 1).
//
// Every table carries sync-ready columns (UUID id, createdAt, updatedAt,
// deletedAt) so cloud sync can be added later without reshaping data.
// Rows are soft-deleted (deletedAt set) rather than removed.
// Units: see lib/domain/money.dart (Paise, Milli, Bp suffixes).

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// New random id (UUID v4) for any row.
String newId() => _uuid.v4();

mixin SyncColumns on Table {
  TextColumn get id => text().clientDefault(newId)();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ---------------------------------------------------------------------------
// Enums (stored as their names, so the database stays readable)
// ---------------------------------------------------------------------------

enum PartyRole { customer, supplier, both }

enum PriceType { retail, wholesale }

enum SalesChannel { shop, individual, exhibition, online }

enum ProductKind { rawMaterial, made, bought }

enum OrderStatus { quote, confirmed, delivered, cancelled }

/// Why money moved. customerPayment is money IN (incl. advances);
/// customerRefund and supplierPayment are money OUT.
enum PaymentPurpose { customerPayment, customerRefund, supplierPayment }

enum PaymentMethod { cash, upi, bank, cheque, other }

enum StockMoveType {
  opening, // stock already on the shelf at onboarding
  purchase, // bought from a supplier
  productionIn, // finished pieces made
  productionUse, // materials used to make pieces
  sale, // delivered to a customer
  saleReversal, // delivered order cancelled
  adjustment, // damaged, personal use, found...
  count, // difference found during a shelf count
}

// ---------------------------------------------------------------------------
// Settings (exactly one row, id = 'settings')
// ---------------------------------------------------------------------------

class Settings extends Table with SyncColumns {
  TextColumn get businessName => text().withDefault(const Constant('Bcreations'))();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get upiId => text().nullable()();
  TextColumn get logoPath => text().nullable()();
  TextColumn get languageCode => text().withDefault(const Constant('hi'))();

  // Pricing (plan §5.4)
  IntColumn get hourlyRatePaise => integer().withDefault(const Constant(10000))(); // ₹100/h
  IntColumn get overheadBp => integer().withDefault(const Constant(1000))(); // 10 %
  IntColumn get retailMarkupBp => integer().withDefault(const Constant(25000))(); // ×2.5
  IntColumn get wholesaleMarkupBp => integer().withDefault(const Constant(18000))(); // ×1.8
  IntColumn get defaultWholesaleDiscountBp => integer().withDefault(const Constant(3000))(); // 30 %
  IntColumn get targetMarginBp => integer().withDefault(const Constant(4000))(); // 40 %
  IntColumn get priceReviewThresholdBp => integer().withDefault(const Constant(1000))(); // 10 %

  // Payment terms (days after delivery) by customer price type
  IntColumn get wholesaleTermsDays => integer().withDefault(const Constant(15))();
  IntColumn get retailTermsDays => integer().withDefault(const Constant(0))();

  // Order numbering: BC-0001, BC-0002 ...
  TextColumn get orderPrefix => text().withDefault(const Constant('BC-'))();
  IntColumn get nextOrderNumber => integer().withDefault(const Constant(1))();

  /// The day she started using the app; opening balances are as of this date.
  DateTimeColumn get startDate => dateTime().nullable()();
}

/// Quantity discounts. productId == null -> applies to every product.
class BulkRules extends Table with SyncColumns {
  TextColumn get productId => text().nullable().references(Products, #id)();
  IntColumn get minQtyMilli => integer()();
  IntColumn get discountBp => integer()();
  BoolColumn get wholesaleOnly => boolean().withDefault(const Constant(true))();
}

// ---------------------------------------------------------------------------
// People
// ---------------------------------------------------------------------------

class Parties extends Table with SyncColumns {
  TextColumn get name => text()();
  TextColumn get businessName => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get role => textEnum<PartyRole>().withDefault(const Constant('customer'))();
  TextColumn get priceType => textEnum<PriceType>().withDefault(const Constant('retail'))();
  TextColumn get defaultChannel => textEnum<SalesChannel>().nullable()();

  /// null = no limit.
  IntColumn get creditLimitPaise => integer().nullable()();

  /// null = use the default from Settings for this price type.
  IntColumn get paymentTermsDays => integer().nullable()();

  /// Owed at onboarding: positive = they owe her, negative = she owes them.
  IntColumn get openingBalancePaise => integer().withDefault(const Constant(0))();

  TextColumn get notes => text().nullable()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
}

// ---------------------------------------------------------------------------
// Products, recipes, stock
// ---------------------------------------------------------------------------

class Products extends Table with SyncColumns {
  TextColumn get name => text()();
  TextColumn get kind => textEnum<ProductKind>()();
  TextColumn get unit => text().withDefault(const Constant('pcs'))();
  TextColumn get category => text().nullable()();
  TextColumn get sku => text().nullable()();
  TextColumn get photoPath => text().nullable()();

  IntColumn get retailPricePaise => integer().nullable()();

  /// null -> retail price minus Settings.defaultWholesaleDiscountBp.
  IntColumn get wholesalePricePaise => integer().nullable()();

  /// Full cost per piece when the price was last set (for "Prices to review").
  IntColumn get priceSetCostPaise => integer().nullable()();

  IntColumn get minStockMilli => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
}

/// One line of a product's recipe: [qtyMilli] of [materialId] per 1 piece.
class RecipeLines extends Table with SyncColumns {
  @ReferenceName('recipeLines')
  TextColumn get productId => text().references(Products, #id)();
  @ReferenceName('usedInRecipes')
  TextColumn get materialId => text().references(Products, #id)();
  IntColumn get qtyMilli => integer()();
}

/// Every change to stock. On hand = sum(qtyMilli); stock value = sum(valuePaise).
/// [valuePaise] is the signed MATERIAL value of the move (money actually spent),
/// never her labour, so the "Where did my profit go?" bridge reconciles to cash.
class StockMoves extends Table with SyncColumns {
  TextColumn get productId => text().references(Products, #id)();
  IntColumn get qtyMilli => integer()(); // + in, - out
  TextColumn get type => textEnum<StockMoveType>()();
  IntColumn get valuePaise => integer().withDefault(const Constant(0))(); // + in, - out
  DateTimeColumn get movedAt => dateTime()();
  TextColumn get orderId => text().nullable().references(Orders, #id)();
  TextColumn get productionRunId => text().nullable().references(ProductionRuns, #id)();
  TextColumn get supplierId => text().nullable().references(Parties, #id)();
  TextColumn get note => text().nullable()();
}

class ProductionRuns extends Table with SyncColumns {
  TextColumn get productId => text().references(Products, #id)();
  IntColumn get qtyMilli => integer()();
  DateTimeColumn get madeOn => dateTime()();
  IntColumn get batchMinutes => integer().withDefault(const Constant(0))();
  IntColumn get materialCostPaise => integer()(); // total for the batch
  IntColumn get labourCostPaise => integer()(); // her time, at Settings.hourlyRate
  IntColumn get overheadCostPaise => integer()();
  TextColumn get note => text().nullable()();
}

// ---------------------------------------------------------------------------
// Orders
// ---------------------------------------------------------------------------

class Orders extends Table with SyncColumns {
  TextColumn get number => text()();
  TextColumn get partyId => text().references(Parties, #id)();
  DateTimeColumn get orderDate => dateTime()();
  TextColumn get status => textEnum<OrderStatus>()();
  TextColumn get channel => textEnum<SalesChannel>().nullable()();
  DateTimeColumn get promisedDate => dateTime().nullable()(); // delivery promised
  DateTimeColumn get deliveredAt => dateTime().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()(); // payment due
  IntColumn get deliveryChargePaise => integer().withDefault(const Constant(0))();
  IntColumn get orderDiscountPaise => integer().withDefault(const Constant(0))();
  TextColumn get discountReason => text().nullable()();
  TextColumn get notes => text().nullable()();
}

class OrderLines extends Table with SyncColumns {
  TextColumn get orderId => text().references(Orders, #id)();

  /// null = custom item (made-to-order piece not in the catalogue).
  TextColumn get productId => text().nullable().references(Products, #id)();
  TextColumn get description => text().nullable()();
  IntColumn get position => integer().withDefault(const Constant(0))();

  IntColumn get qtyMilli => integer()();
  IntColumn get unitPricePaise => integer()(); // price actually charged
  IntColumn get listPricePaise => integer().nullable()(); // price list said
  IntColumn get lineDiscountPaise => integer().withDefault(const Constant(0))();

  /// Full cost per piece (materials + labour + overhead) when the line was made,
  /// for margin colours. For custom items: her estimate, if any.
  IntColumn get unitCostPaise => integer().nullable()();

  // What exactly the customer wants (reference photos live in OrderPhotos)
  TextColumn get specColour => text().nullable()();
  TextColumn get specSize => text().nullable()();
  TextColumn get specText => text().nullable()(); // name / words to engrave or print
  TextColumn get notes => text().nullable()();
}

class OrderPhotos extends Table with SyncColumns {
  TextColumn get orderId => text().references(Orders, #id)();
  TextColumn get orderLineId => text().nullable().references(OrderLines, #id)();
  TextColumn get path => text()();
  TextColumn get caption => text().nullable()();
}

// ---------------------------------------------------------------------------
// Money
// ---------------------------------------------------------------------------

class Payments extends Table with SyncColumns {
  TextColumn get partyId => text().nullable().references(Parties, #id)();
  TextColumn get purpose => textEnum<PaymentPurpose>()();
  IntColumn get amountPaise => integer()(); // always positive; purpose gives direction
  TextColumn get method => textEnum<PaymentMethod>()();
  DateTimeColumn get paidOn => dateTime()();
  TextColumn get reference => text().nullable()(); // UPI ref / sender name / cheque no.
  TextColumn get note => text().nullable()();
}

/// Which order(s) a customer payment pays for. Allocated to an order that is
/// not delivered yet == an advance. Unallocated remainder == credit she holds.
class PaymentAllocations extends Table with SyncColumns {
  TextColumn get paymentId => text().references(Payments, #id)();
  TextColumn get orderId => text().references(Orders, #id)();
  IntColumn get amountPaise => integer()();
}

class Expenses extends Table with SyncColumns {
  TextColumn get category => text()(); // Packaging, Courier, Travel, Phone, ...
  IntColumn get amountPaise => integer()();
  TextColumn get method => textEnum<PaymentMethod>()();
  DateTimeColumn get spentOn => dateTime()();
  TextColumn get partyId => text().nullable().references(Parties, #id)();
  TextColumn get note => text().nullable()();
  TextColumn get receiptPath => text().nullable()();
}

/// Money taken out of the business for home / personal use.
class OwnerWithdrawals extends Table with SyncColumns {
  IntColumn get amountPaise => integer()();
  TextColumn get method => textEnum<PaymentMethod>()();
  DateTimeColumn get takenOn => dateTime()();
  TextColumn get note => text().nullable()();
}
