// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOrderCollection on Isar {
  IsarCollection<Order> get orders => this.collection();
}

const OrderSchema = CollectionSchema(
  name: r'Order',
  id: 103494837486634173,
  properties: {
    r'clientId': PropertySchema(
      id: 0,
      name: r'clientId',
      type: IsarType.long,
    ),
    r'clientName': PropertySchema(
      id: 1,
      name: r'clientName',
      type: IsarType.string,
    ),
    r'currentStageIndex': PropertySchema(
      id: 2,
      name: r'currentStageIndex',
      type: IsarType.long,
    ),
    r'date': PropertySchema(
      id: 3,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'expectedCompletionDate': PropertySchema(
      id: 4,
      name: r'expectedCompletionDate',
      type: IsarType.dateTime,
    ),
    r'isPaid': PropertySchema(
      id: 5,
      name: r'isPaid',
      type: IsarType.bool,
    ),
    r'orderNumber': PropertySchema(
      id: 6,
      name: r'orderNumber',
      type: IsarType.string,
    ),
    r'orderStatus': PropertySchema(
      id: 7,
      name: r'orderStatus',
      type: IsarType.string,
    ),
    r'paymentDueDate': PropertySchema(
      id: 8,
      name: r'paymentDueDate',
      type: IsarType.dateTime,
    ),
    r'stages': PropertySchema(
      id: 9,
      name: r'stages',
      type: IsarType.stringList,
    ),
    r'totalAmount': PropertySchema(
      id: 10,
      name: r'totalAmount',
      type: IsarType.double,
    )
  },
  estimateSize: _orderEstimateSize,
  serialize: _orderSerialize,
  deserialize: _orderDeserialize,
  deserializeProp: _orderDeserializeProp,
  idName: r'id',
  indexes: {
    r'orderNumber': IndexSchema(
      id: 7506692016205733885,
      name: r'orderNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'orderNumber',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'clientId': IndexSchema(
      id: 2639372232964765565,
      name: r'clientId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'clientId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'orderStatus': IndexSchema(
      id: -8892489903912947379,
      name: r'orderStatus',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'orderStatus',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _orderGetId,
  getLinks: _orderGetLinks,
  attach: _orderAttach,
  version: '3.1.0+1',
);

int _orderEstimateSize(
  Order object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.clientName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.orderNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.orderStatus.length * 3;
  {
    final list = object.stages;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  return bytesCount;
}

void _orderSerialize(
  Order object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.clientId);
  writer.writeString(offsets[1], object.clientName);
  writer.writeLong(offsets[2], object.currentStageIndex);
  writer.writeDateTime(offsets[3], object.date);
  writer.writeDateTime(offsets[4], object.expectedCompletionDate);
  writer.writeBool(offsets[5], object.isPaid);
  writer.writeString(offsets[6], object.orderNumber);
  writer.writeString(offsets[7], object.orderStatus);
  writer.writeDateTime(offsets[8], object.paymentDueDate);
  writer.writeStringList(offsets[9], object.stages);
  writer.writeDouble(offsets[10], object.totalAmount);
}

Order _orderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Order();
  object.clientId = reader.readLongOrNull(offsets[0]);
  object.clientName = reader.readStringOrNull(offsets[1]);
  object.currentStageIndex = reader.readLong(offsets[2]);
  object.date = reader.readDateTimeOrNull(offsets[3]);
  object.expectedCompletionDate = reader.readDateTimeOrNull(offsets[4]);
  object.id = id;
  object.isPaid = reader.readBool(offsets[5]);
  object.orderNumber = reader.readStringOrNull(offsets[6]);
  object.orderStatus = reader.readString(offsets[7]);
  object.paymentDueDate = reader.readDateTimeOrNull(offsets[8]);
  object.stages = reader.readStringList(offsets[9]);
  object.totalAmount = reader.readDouble(offsets[10]);
  return object;
}

P _orderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readStringList(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _orderGetId(Order object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _orderGetLinks(Order object) {
  return [];
}

void _orderAttach(IsarCollection<dynamic> col, Id id, Order object) {
  object.id = id;
}

extension OrderQueryWhereSort on QueryBuilder<Order, Order, QWhere> {
  QueryBuilder<Order, Order, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Order, Order, QAfterWhere> anyOrderNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'orderNumber'),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhere> anyClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'clientId'),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhere> anyOrderStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'orderStatus'),
      );
    });
  }
}

extension OrderQueryWhere on QueryBuilder<Order, Order, QWhereClause> {
  QueryBuilder<Order, Order, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Order, Order, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> idBetween(
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

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orderNumber',
        value: [null],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderNumber',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberEqualTo(
      String? orderNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orderNumber',
        value: [orderNumber],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberNotEqualTo(
      String? orderNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderNumber',
              lower: [],
              upper: [orderNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderNumber',
              lower: [orderNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderNumber',
              lower: [orderNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderNumber',
              lower: [],
              upper: [orderNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberGreaterThan(
    String? orderNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderNumber',
        lower: [orderNumber],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberLessThan(
    String? orderNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderNumber',
        lower: [],
        upper: [orderNumber],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberBetween(
    String? lowerOrderNumber,
    String? upperOrderNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderNumber',
        lower: [lowerOrderNumber],
        includeLower: includeLower,
        upper: [upperOrderNumber],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberStartsWith(
      String OrderNumberPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderNumber',
        lower: [OrderNumberPrefix],
        upper: ['$OrderNumberPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orderNumber',
        value: [''],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'orderNumber',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'orderNumber',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'orderNumber',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'orderNumber',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> clientIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'clientId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> clientIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clientId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> clientIdEqualTo(int? clientId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'clientId',
        value: [clientId],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> clientIdNotEqualTo(
      int? clientId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientId',
              lower: [],
              upper: [clientId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientId',
              lower: [clientId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientId',
              lower: [clientId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientId',
              lower: [],
              upper: [clientId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> clientIdGreaterThan(
    int? clientId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clientId',
        lower: [clientId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> clientIdLessThan(
    int? clientId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clientId',
        lower: [],
        upper: [clientId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> clientIdBetween(
    int? lowerClientId,
    int? upperClientId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clientId',
        lower: [lowerClientId],
        includeLower: includeLower,
        upper: [upperClientId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderStatusEqualTo(
      String orderStatus) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orderStatus',
        value: [orderStatus],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderStatusNotEqualTo(
      String orderStatus) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderStatus',
              lower: [],
              upper: [orderStatus],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderStatus',
              lower: [orderStatus],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderStatus',
              lower: [orderStatus],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderStatus',
              lower: [],
              upper: [orderStatus],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderStatusGreaterThan(
    String orderStatus, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderStatus',
        lower: [orderStatus],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderStatusLessThan(
    String orderStatus, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderStatus',
        lower: [],
        upper: [orderStatus],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderStatusBetween(
    String lowerOrderStatus,
    String upperOrderStatus, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderStatus',
        lower: [lowerOrderStatus],
        includeLower: includeLower,
        upper: [upperOrderStatus],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderStatusStartsWith(
      String OrderStatusPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'orderStatus',
        lower: [OrderStatusPrefix],
        upper: ['$OrderStatusPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orderStatus',
        value: [''],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> orderStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'orderStatus',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'orderStatus',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'orderStatus',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'orderStatus',
              upper: [''],
            ));
      }
    });
  }
}

extension OrderQueryFilter on QueryBuilder<Order, Order, QFilterCondition> {
  QueryBuilder<Order, Order, QAfterFilterCondition> clientIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clientId',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clientId',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientId',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientId',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientId',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clientName',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clientName',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientName',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientName',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> currentStageIndexEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStageIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      currentStageIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStageIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> currentStageIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStageIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> currentStageIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStageIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<Order, Order, QAfterFilterCondition>
      expectedCompletionDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedCompletionDate',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      expectedCompletionDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedCompletionDate',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      expectedCompletionDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedCompletionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      expectedCompletionDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedCompletionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      expectedCompletionDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedCompletionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      expectedCompletionDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedCompletionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> isPaidEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPaid',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'orderNumber',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'orderNumber',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orderNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orderNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orderStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orderStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> orderStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orderStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> paymentDueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentDueDate',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> paymentDueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentDueDate',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> paymentDueDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> paymentDueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> paymentDueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> paymentDueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentDueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stages',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stages',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stages',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stages',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stages',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stages',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> stagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> totalAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> totalAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> totalAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> totalAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension OrderQueryObject on QueryBuilder<Order, Order, QFilterCondition> {}

extension OrderQueryLinks on QueryBuilder<Order, Order, QFilterCondition> {}

extension OrderQuerySortBy on QueryBuilder<Order, Order, QSortBy> {
  QueryBuilder<Order, Order, QAfterSortBy> sortByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByClientName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByClientNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByCurrentStageIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStageIndex', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByCurrentStageIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStageIndex', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByExpectedCompletionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedCompletionDate', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByExpectedCompletionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedCompletionDate', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByIsPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaid', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByIsPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaid', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByOrderNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNumber', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByOrderNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNumber', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByOrderStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderStatus', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByOrderStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderStatus', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByPaymentDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDueDate', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByPaymentDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDueDate', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension OrderQuerySortThenBy on QueryBuilder<Order, Order, QSortThenBy> {
  QueryBuilder<Order, Order, QAfterSortBy> thenByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientId', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByClientName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByClientNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientName', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByCurrentStageIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStageIndex', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByCurrentStageIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStageIndex', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByExpectedCompletionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedCompletionDate', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByExpectedCompletionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedCompletionDate', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByIsPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaid', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByIsPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaid', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByOrderNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNumber', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByOrderNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNumber', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByOrderStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderStatus', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByOrderStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderStatus', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByPaymentDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDueDate', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByPaymentDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDueDate', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension OrderQueryWhereDistinct on QueryBuilder<Order, Order, QDistinct> {
  QueryBuilder<Order, Order, QDistinct> distinctByClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientId');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByClientName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByCurrentStageIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStageIndex');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByExpectedCompletionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedCompletionDate');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByIsPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPaid');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByOrderNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByOrderStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByPaymentDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentDueDate');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByStages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stages');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAmount');
    });
  }
}

extension OrderQueryProperty on QueryBuilder<Order, Order, QQueryProperty> {
  QueryBuilder<Order, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Order, int?, QQueryOperations> clientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientId');
    });
  }

  QueryBuilder<Order, String?, QQueryOperations> clientNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientName');
    });
  }

  QueryBuilder<Order, int, QQueryOperations> currentStageIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStageIndex');
    });
  }

  QueryBuilder<Order, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Order, DateTime?, QQueryOperations>
      expectedCompletionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedCompletionDate');
    });
  }

  QueryBuilder<Order, bool, QQueryOperations> isPaidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPaid');
    });
  }

  QueryBuilder<Order, String?, QQueryOperations> orderNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderNumber');
    });
  }

  QueryBuilder<Order, String, QQueryOperations> orderStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderStatus');
    });
  }

  QueryBuilder<Order, DateTime?, QQueryOperations> paymentDueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentDueDate');
    });
  }

  QueryBuilder<Order, List<String>?, QQueryOperations> stagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stages');
    });
  }

  QueryBuilder<Order, double, QQueryOperations> totalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAmount');
    });
  }
}
