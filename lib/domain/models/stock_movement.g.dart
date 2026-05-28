// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_movement.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStockMovementCollection on Isar {
  IsarCollection<StockMovement> get stockMovements => this.collection();
}

const StockMovementSchema = CollectionSchema(
  name: r'StockMovement',
  id: -870476298981362719,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'inventoryItemId': PropertySchema(
      id: 1,
      name: r'inventoryItemId',
      type: IsarType.long,
    ),
    r'quantityChange': PropertySchema(
      id: 2,
      name: r'quantityChange',
      type: IsarType.long,
    ),
    r'reason': PropertySchema(
      id: 3,
      name: r'reason',
      type: IsarType.string,
    ),
    r'relatedOrderId': PropertySchema(
      id: 4,
      name: r'relatedOrderId',
      type: IsarType.long,
    )
  },
  estimateSize: _stockMovementEstimateSize,
  serialize: _stockMovementSerialize,
  deserialize: _stockMovementDeserialize,
  deserializeProp: _stockMovementDeserializeProp,
  idName: r'id',
  indexes: {
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
    ),
    r'relatedOrderId': IndexSchema(
      id: -939060893144861339,
      name: r'relatedOrderId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'relatedOrderId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _stockMovementGetId,
  getLinks: _stockMovementGetLinks,
  attach: _stockMovementAttach,
  version: '3.1.0+1',
);

int _stockMovementEstimateSize(
  StockMovement object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.reason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _stockMovementSerialize(
  StockMovement object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeLong(offsets[1], object.inventoryItemId);
  writer.writeLong(offsets[2], object.quantityChange);
  writer.writeString(offsets[3], object.reason);
  writer.writeLong(offsets[4], object.relatedOrderId);
}

StockMovement _stockMovementDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StockMovement();
  object.date = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  object.inventoryItemId = reader.readLongOrNull(offsets[1]);
  object.quantityChange = reader.readLong(offsets[2]);
  object.reason = reader.readStringOrNull(offsets[3]);
  object.relatedOrderId = reader.readLongOrNull(offsets[4]);
  return object;
}

P _stockMovementDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stockMovementGetId(StockMovement object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _stockMovementGetLinks(StockMovement object) {
  return [];
}

void _stockMovementAttach(
    IsarCollection<dynamic> col, Id id, StockMovement object) {
  object.id = id;
}

extension StockMovementQueryWhereSort
    on QueryBuilder<StockMovement, StockMovement, QWhere> {
  QueryBuilder<StockMovement, StockMovement, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhere> anyInventoryItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'inventoryItemId'),
      );
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhere> anyRelatedOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'relatedOrderId'),
      );
    });
  }
}

extension StockMovementQueryWhere
    on QueryBuilder<StockMovement, StockMovement, QWhereClause> {
  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause> idBetween(
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

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
      inventoryItemIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'inventoryItemId',
        value: [null],
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
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

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
      inventoryItemIdEqualTo(int? inventoryItemId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'inventoryItemId',
        value: [inventoryItemId],
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
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

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
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

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
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

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
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

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
      relatedOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'relatedOrderId',
        value: [null],
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
      relatedOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relatedOrderId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
      relatedOrderIdEqualTo(int? relatedOrderId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'relatedOrderId',
        value: [relatedOrderId],
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
      relatedOrderIdNotEqualTo(int? relatedOrderId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relatedOrderId',
              lower: [],
              upper: [relatedOrderId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relatedOrderId',
              lower: [relatedOrderId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relatedOrderId',
              lower: [relatedOrderId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relatedOrderId',
              lower: [],
              upper: [relatedOrderId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
      relatedOrderIdGreaterThan(
    int? relatedOrderId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relatedOrderId',
        lower: [relatedOrderId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
      relatedOrderIdLessThan(
    int? relatedOrderId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relatedOrderId',
        lower: [],
        upper: [relatedOrderId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterWhereClause>
      relatedOrderIdBetween(
    int? lowerRelatedOrderId,
    int? upperRelatedOrderId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relatedOrderId',
        lower: [lowerRelatedOrderId],
        includeLower: includeLower,
        upper: [upperRelatedOrderId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StockMovementQueryFilter
    on QueryBuilder<StockMovement, StockMovement, QFilterCondition> {
  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition> dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition> dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
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

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition> idBetween(
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

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      inventoryItemIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inventoryItemId',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      inventoryItemIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inventoryItemId',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      inventoryItemIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inventoryItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
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

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
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

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
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

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      quantityChangeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantityChange',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      quantityChangeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantityChange',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      quantityChangeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantityChange',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      quantityChangeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantityChange',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reason',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reason',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      reasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      relatedOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'relatedOrderId',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      relatedOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'relatedOrderId',
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      relatedOrderIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedOrderId',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      relatedOrderIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relatedOrderId',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      relatedOrderIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relatedOrderId',
        value: value,
      ));
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterFilterCondition>
      relatedOrderIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relatedOrderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StockMovementQueryObject
    on QueryBuilder<StockMovement, StockMovement, QFilterCondition> {}

extension StockMovementQueryLinks
    on QueryBuilder<StockMovement, StockMovement, QFilterCondition> {}

extension StockMovementQuerySortBy
    on QueryBuilder<StockMovement, StockMovement, QSortBy> {
  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      sortByInventoryItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inventoryItemId', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      sortByInventoryItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inventoryItemId', Sort.desc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      sortByQuantityChange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityChange', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      sortByQuantityChangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityChange', Sort.desc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> sortByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> sortByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      sortByRelatedOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedOrderId', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      sortByRelatedOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedOrderId', Sort.desc);
    });
  }
}

extension StockMovementQuerySortThenBy
    on QueryBuilder<StockMovement, StockMovement, QSortThenBy> {
  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      thenByInventoryItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inventoryItemId', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      thenByInventoryItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inventoryItemId', Sort.desc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      thenByQuantityChange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityChange', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      thenByQuantityChangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityChange', Sort.desc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> thenByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy> thenByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      thenByRelatedOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedOrderId', Sort.asc);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QAfterSortBy>
      thenByRelatedOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedOrderId', Sort.desc);
    });
  }
}

extension StockMovementQueryWhereDistinct
    on QueryBuilder<StockMovement, StockMovement, QDistinct> {
  QueryBuilder<StockMovement, StockMovement, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<StockMovement, StockMovement, QDistinct>
      distinctByInventoryItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inventoryItemId');
    });
  }

  QueryBuilder<StockMovement, StockMovement, QDistinct>
      distinctByQuantityChange() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantityChange');
    });
  }

  QueryBuilder<StockMovement, StockMovement, QDistinct> distinctByReason(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reason', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StockMovement, StockMovement, QDistinct>
      distinctByRelatedOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relatedOrderId');
    });
  }
}

extension StockMovementQueryProperty
    on QueryBuilder<StockMovement, StockMovement, QQueryProperty> {
  QueryBuilder<StockMovement, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StockMovement, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<StockMovement, int?, QQueryOperations>
      inventoryItemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inventoryItemId');
    });
  }

  QueryBuilder<StockMovement, int, QQueryOperations> quantityChangeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantityChange');
    });
  }

  QueryBuilder<StockMovement, String?, QQueryOperations> reasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reason');
    });
  }

  QueryBuilder<StockMovement, int?, QQueryOperations> relatedOrderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relatedOrderId');
    });
  }
}
