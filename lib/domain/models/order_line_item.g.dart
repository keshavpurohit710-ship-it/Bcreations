// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_line_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOrderLineItemCollection on Isar {
  IsarCollection<OrderLineItem> get orderLineItems => this.collection();
}

const OrderLineItemSchema = CollectionSchema(
  name: r'OrderLineItem',
  id: 7535635659540315611,
  properties: {
    r'inventoryItemId': PropertySchema(
      id: 0,
      name: r'inventoryItemId',
      type: IsarType.long,
    ),
    r'orderId': PropertySchema(
      id: 1,
      name: r'orderId',
      type: IsarType.long,
    ),
    r'pricePerUnit': PropertySchema(
      id: 2,
      name: r'pricePerUnit',
      type: IsarType.double,
    ),
    r'quantity': PropertySchema(
      id: 3,
      name: r'quantity',
      type: IsarType.long,
    )
  },
  estimateSize: _orderLineItemEstimateSize,
  serialize: _orderLineItemSerialize,
  deserialize: _orderLineItemDeserialize,
  deserializeProp: _orderLineItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'orderId': IndexSchema(
      id: -6176610178429382285,
      name: r'orderId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'orderId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'inventoryItemId': IndexSchema(
      id: -8922134744435378615,
      name: r'inventoryItemId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'inventoryItemId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _orderLineItemGetId,
  getLinks: _orderLineItemGetLinks,
  attach: _orderLineItemAttach,
  version: '3.1.0+1',
);

int _orderLineItemEstimateSize(
  OrderLineItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _orderLineItemSerialize(
  OrderLineItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.inventoryItemId);
  writer.writeLong(offsets[1], object.orderId);
  writer.writeDouble(offsets[2], object.pricePerUnit);
  writer.writeLong(offsets[3], object.quantity);
}

OrderLineItem _orderLineItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OrderLineItem();
  object.id = id;
  object.inventoryItemId = reader.readLongOrNull(offsets[0]);
  object.orderId = reader.readLongOrNull(offsets[1]);
  object.pricePerUnit = reader.readDouble(offsets[2]);
  object.quantity = reader.readLong(offsets[3]);
  return object;
}

P _orderLineItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _orderLineItemGetId(OrderLineItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _orderLineItemGetLinks(OrderLineItem object) {
  return [];
}

void _orderLineItemAttach(
    IsarCollection<dynamic> col, Id id, OrderLineItem object) {
  object.id = id;
}

extension OrderLineItemQueryWhereSort
    on QueryBuilder<OrderLineItem, OrderLineItem, QWhere> {
  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhere> anyOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'orderId'),
      );
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhere> anyInventoryItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'inventoryItemId'),
      );
    });
  }
}

extension OrderLineItemQueryWhere
    on QueryBuilder<OrderLineItem, OrderLineItem, QWhereClause> {
  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      orderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orderId',
        value: [null],
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      orderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause> orderIdEqualTo(
      int? orderId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orderId',
        value: [orderId],
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      orderIdNotEqualTo(int? orderId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderId',
              lower: [],
              upper: [orderId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderId',
              lower: [orderId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderId',
              lower: [orderId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderId',
              lower: [],
              upper: [orderId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      orderIdGreaterThan(
    int? orderId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderId',
        lower: [orderId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause> orderIdLessThan(
    int? orderId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderId',
        lower: [],
        upper: [orderId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause> orderIdBetween(
    int? lowerOrderId,
    int? upperOrderId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderId',
        lower: [lowerOrderId],
        includeLower: includeLower,
        upper: [upperOrderId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      inventoryItemIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'inventoryItemId',
        value: [null],
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      inventoryItemIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'inventoryItemId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      inventoryItemIdEqualTo(int? inventoryItemId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'inventoryItemId',
        value: [inventoryItemId],
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      inventoryItemIdNotEqualTo(int? inventoryItemId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'inventoryItemId',
              lower: [],
              upper: [inventoryItemId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'inventoryItemId',
              lower: [inventoryItemId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'inventoryItemId',
              lower: [inventoryItemId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'inventoryItemId',
              lower: [],
              upper: [inventoryItemId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      inventoryItemIdGreaterThan(
    int? inventoryItemId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'inventoryItemId',
        lower: [inventoryItemId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      inventoryItemIdLessThan(
    int? inventoryItemId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'inventoryItemId',
        lower: [],
        upper: [inventoryItemId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterWhereClause>
      inventoryItemIdBetween(
    int? lowerInventoryItemId,
    int? upperInventoryItemId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'inventoryItemId',
        lower: [lowerInventoryItemId],
        includeLower: includeLower,
        upper: [upperInventoryItemId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OrderLineItemQueryFilter
    on QueryBuilder<OrderLineItem, OrderLineItem, QFilterCondition> {
  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      inventoryItemIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inventoryItemId',
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      inventoryItemIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inventoryItemId',
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      inventoryItemIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inventoryItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      inventoryItemIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inventoryItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      inventoryItemIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inventoryItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      inventoryItemIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inventoryItemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      orderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'orderId',
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      orderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'orderId',
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      orderIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      orderIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      orderIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      orderIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      pricePerUnitEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pricePerUnit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      pricePerUnitGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pricePerUnit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      pricePerUnitLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pricePerUnit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      pricePerUnitBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pricePerUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OrderLineItemQueryObject
    on QueryBuilder<OrderLineItem, OrderLineItem, QFilterCondition> {}

extension OrderLineItemQueryLinks
    on QueryBuilder<OrderLineItem, OrderLineItem, QFilterCondition> {}

extension OrderLineItemQuerySortBy
    on QueryBuilder<OrderLineItem, OrderLineItem, QSortBy> {
  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      sortByInventoryItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inventoryItemId', Sort.asc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      sortByInventoryItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inventoryItemId', Sort.desc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy> sortByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy> sortByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      sortByPricePerUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerUnit', Sort.asc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      sortByPricePerUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerUnit', Sort.desc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension OrderLineItemQuerySortThenBy
    on QueryBuilder<OrderLineItem, OrderLineItem, QSortThenBy> {
  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      thenByInventoryItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inventoryItemId', Sort.asc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      thenByInventoryItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inventoryItemId', Sort.desc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy> thenByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy> thenByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      thenByPricePerUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerUnit', Sort.asc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      thenByPricePerUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerUnit', Sort.desc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension OrderLineItemQueryWhereDistinct
    on QueryBuilder<OrderLineItem, OrderLineItem, QDistinct> {
  QueryBuilder<OrderLineItem, OrderLineItem, QDistinct>
      distinctByInventoryItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inventoryItemId');
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QDistinct> distinctByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderId');
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QDistinct>
      distinctByPricePerUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pricePerUnit');
    });
  }

  QueryBuilder<OrderLineItem, OrderLineItem, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }
}

extension OrderLineItemQueryProperty
    on QueryBuilder<OrderLineItem, OrderLineItem, QQueryProperty> {
  QueryBuilder<OrderLineItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OrderLineItem, int?, QQueryOperations>
      inventoryItemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inventoryItemId');
    });
  }

  QueryBuilder<OrderLineItem, int?, QQueryOperations> orderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderId');
    });
  }

  QueryBuilder<OrderLineItem, double, QQueryOperations> pricePerUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pricePerUnit');
    });
  }

  QueryBuilder<OrderLineItem, int, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }
}
