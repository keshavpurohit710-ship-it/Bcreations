// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetClientCollection on Isar {
  IsarCollection<Client> get clients => this.collection();
}

const ClientSchema = CollectionSchema(
  name: r'Client',
  id: 1578245643436550370,
  properties: {
    r'businessName': PropertySchema(
      id: 0,
      name: r'businessName',
      type: IsarType.string,
    ),
    r'clientType': PropertySchema(
      id: 1,
      name: r'clientType',
      type: IsarType.string,
    ),
    r'creditLimit': PropertySchema(
      id: 2,
      name: r'creditLimit',
      type: IsarType.double,
    ),
    r'email': PropertySchema(
      id: 3,
      name: r'email',
      type: IsarType.string,
    ),
    r'followUpNotes': PropertySchema(
      id: 4,
      name: r'followUpNotes',
      type: IsarType.string,
    ),
    r'interactionHistory': PropertySchema(
      id: 5,
      name: r'interactionHistory',
      type: IsarType.objectList,
      target: r'InteractionRecord',
    ),
    r'lastCompletedOrderDate': PropertySchema(
      id: 6,
      name: r'lastCompletedOrderDate',
      type: IsarType.dateTime,
    ),
    r'lastContactDate': PropertySchema(
      id: 7,
      name: r'lastContactDate',
      type: IsarType.dateTime,
    ),
    r'lastOrderAmount': PropertySchema(
      id: 8,
      name: r'lastOrderAmount',
      type: IsarType.double,
    ),
    r'lastOrderDate': PropertySchema(
      id: 9,
      name: r'lastOrderDate',
      type: IsarType.dateTime,
    ),
    r'lastPaymentDate': PropertySchema(
      id: 10,
      name: r'lastPaymentDate',
      type: IsarType.dateTime,
    ),
    r'leadSource': PropertySchema(
      id: 11,
      name: r'leadSource',
      type: IsarType.string,
    ),
    r'location': PropertySchema(
      id: 12,
      name: r'location',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 13,
      name: r'name',
      type: IsarType.string,
    ),
    r'nextFollowUpDate': PropertySchema(
      id: 14,
      name: r'nextFollowUpDate',
      type: IsarType.dateTime,
    ),
    r'notes': PropertySchema(
      id: 15,
      name: r'notes',
      type: IsarType.string,
    ),
    r'openOrders': PropertySchema(
      id: 16,
      name: r'openOrders',
      type: IsarType.long,
    ),
    r'outstandingAmount': PropertySchema(
      id: 17,
      name: r'outstandingAmount',
      type: IsarType.double,
    ),
    r'overdueAmount': PropertySchema(
      id: 18,
      name: r'overdueAmount',
      type: IsarType.double,
    ),
    r'paymentTerms': PropertySchema(
      id: 19,
      name: r'paymentTerms',
      type: IsarType.string,
    ),
    r'phone': PropertySchema(
      id: 20,
      name: r'phone',
      type: IsarType.string,
    ),
    r'relationshipStage': PropertySchema(
      id: 21,
      name: r'relationshipStage',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 22,
      name: r'status',
      type: IsarType.string,
    ),
    r'totalOrders': PropertySchema(
      id: 23,
      name: r'totalOrders',
      type: IsarType.long,
    ),
    r'totalRevenue': PropertySchema(
      id: 24,
      name: r'totalRevenue',
      type: IsarType.double,
    )
  },
  estimateSize: _clientEstimateSize,
  serialize: _clientSerialize,
  deserialize: _clientDeserialize,
  deserializeProp: _clientDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'businessName': IndexSchema(
      id: 416964881003464860,
      name: r'businessName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'businessName',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'phone': IndexSchema(
      id: -6308098324157559207,
      name: r'phone',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'phone',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'location': IndexSchema(
      id: -2052452620202604545,
      name: r'location',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'location',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'relationshipStage': IndexSchema(
      id: -9025183552677638192,
      name: r'relationshipStage',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'relationshipStage',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'clientType': IndexSchema(
      id: 6096951205510060952,
      name: r'clientType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'clientType',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'status': IndexSchema(
      id: -107785170620420283,
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'nextFollowUpDate': IndexSchema(
      id: -75571557421885833,
      name: r'nextFollowUpDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nextFollowUpDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'InteractionRecord': InteractionRecordSchema},
  getId: _clientGetId,
  getLinks: _clientGetLinks,
  attach: _clientAttach,
  version: '3.1.0+1',
);

int _clientEstimateSize(
  Client object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.businessName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.clientType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.followUpNotes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.interactionHistory.length * 3;
  {
    final offsets = allOffsets[InteractionRecord]!;
    for (var i = 0; i < object.interactionHistory.length; i++) {
      final value = object.interactionHistory[i];
      bytesCount +=
          InteractionRecordSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.leadSource;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.location;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentTerms;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.phone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.relationshipStage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _clientSerialize(
  Client object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.businessName);
  writer.writeString(offsets[1], object.clientType);
  writer.writeDouble(offsets[2], object.creditLimit);
  writer.writeString(offsets[3], object.email);
  writer.writeString(offsets[4], object.followUpNotes);
  writer.writeObjectList<InteractionRecord>(
    offsets[5],
    allOffsets,
    InteractionRecordSchema.serialize,
    object.interactionHistory,
  );
  writer.writeDateTime(offsets[6], object.lastCompletedOrderDate);
  writer.writeDateTime(offsets[7], object.lastContactDate);
  writer.writeDouble(offsets[8], object.lastOrderAmount);
  writer.writeDateTime(offsets[9], object.lastOrderDate);
  writer.writeDateTime(offsets[10], object.lastPaymentDate);
  writer.writeString(offsets[11], object.leadSource);
  writer.writeString(offsets[12], object.location);
  writer.writeString(offsets[13], object.name);
  writer.writeDateTime(offsets[14], object.nextFollowUpDate);
  writer.writeString(offsets[15], object.notes);
  writer.writeLong(offsets[16], object.openOrders);
  writer.writeDouble(offsets[17], object.outstandingAmount);
  writer.writeDouble(offsets[18], object.overdueAmount);
  writer.writeString(offsets[19], object.paymentTerms);
  writer.writeString(offsets[20], object.phone);
  writer.writeString(offsets[21], object.relationshipStage);
  writer.writeString(offsets[22], object.status);
  writer.writeLong(offsets[23], object.totalOrders);
  writer.writeDouble(offsets[24], object.totalRevenue);
}

Client _clientDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Client();
  object.businessName = reader.readStringOrNull(offsets[0]);
  object.clientType = reader.readStringOrNull(offsets[1]);
  object.creditLimit = reader.readDoubleOrNull(offsets[2]);
  object.email = reader.readStringOrNull(offsets[3]);
  object.followUpNotes = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.interactionHistory = reader.readObjectList<InteractionRecord>(
        offsets[5],
        InteractionRecordSchema.deserialize,
        allOffsets,
        InteractionRecord(),
      ) ??
      [];
  object.lastCompletedOrderDate = reader.readDateTimeOrNull(offsets[6]);
  object.lastContactDate = reader.readDateTimeOrNull(offsets[7]);
  object.lastOrderAmount = reader.readDouble(offsets[8]);
  object.lastOrderDate = reader.readDateTimeOrNull(offsets[9]);
  object.lastPaymentDate = reader.readDateTimeOrNull(offsets[10]);
  object.leadSource = reader.readStringOrNull(offsets[11]);
  object.location = reader.readStringOrNull(offsets[12]);
  object.name = reader.readStringOrNull(offsets[13]);
  object.nextFollowUpDate = reader.readDateTimeOrNull(offsets[14]);
  object.notes = reader.readStringOrNull(offsets[15]);
  object.openOrders = reader.readLong(offsets[16]);
  object.outstandingAmount = reader.readDouble(offsets[17]);
  object.overdueAmount = reader.readDouble(offsets[18]);
  object.paymentTerms = reader.readStringOrNull(offsets[19]);
  object.phone = reader.readStringOrNull(offsets[20]);
  object.relationshipStage = reader.readStringOrNull(offsets[21]);
  object.status = reader.readStringOrNull(offsets[22]);
  object.totalOrders = reader.readLong(offsets[23]);
  object.totalRevenue = reader.readDouble(offsets[24]);
  return object;
}

P _clientDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readObjectList<InteractionRecord>(
            offset,
            InteractionRecordSchema.deserialize,
            allOffsets,
            InteractionRecord(),
          ) ??
          []) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readDouble(offset)) as P;
    case 18:
      return (reader.readDouble(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readLong(offset)) as P;
    case 24:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _clientGetId(Client object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _clientGetLinks(Client object) {
  return [];
}

void _clientAttach(IsarCollection<dynamic> col, Id id, Client object) {
  object.id = id;
}

extension ClientQueryWhereSort on QueryBuilder<Client, Client, QWhere> {
  QueryBuilder<Client, Client, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Client, Client, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }

  QueryBuilder<Client, Client, QAfterWhere> anyBusinessName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'businessName'),
      );
    });
  }

  QueryBuilder<Client, Client, QAfterWhere> anyPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'phone'),
      );
    });
  }

  QueryBuilder<Client, Client, QAfterWhere> anyLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'location'),
      );
    });
  }

  QueryBuilder<Client, Client, QAfterWhere> anyRelationshipStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'relationshipStage'),
      );
    });
  }

  QueryBuilder<Client, Client, QAfterWhere> anyClientType() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'clientType'),
      );
    });
  }

  QueryBuilder<Client, Client, QAfterWhere> anyStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'status'),
      );
    });
  }

  QueryBuilder<Client, Client, QAfterWhere> anyNextFollowUpDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'nextFollowUpDate'),
      );
    });
  }
}

extension ClientQueryWhere on QueryBuilder<Client, Client, QWhereClause> {
  QueryBuilder<Client, Client, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Client, Client, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> idBetween(
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

  QueryBuilder<Client, Client, QAfterWhereClause> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [null],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nameEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nameNotEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nameGreaterThan(
    String? name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nameLessThan(
    String? name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nameBetween(
    String? lowerName,
    String? upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nameStartsWith(
      String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'businessName',
        value: [null],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'businessName',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameEqualTo(
      String? businessName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'businessName',
        value: [businessName],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameNotEqualTo(
      String? businessName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'businessName',
              lower: [],
              upper: [businessName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'businessName',
              lower: [businessName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'businessName',
              lower: [businessName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'businessName',
              lower: [],
              upper: [businessName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameGreaterThan(
    String? businessName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'businessName',
        lower: [businessName],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameLessThan(
    String? businessName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'businessName',
        lower: [],
        upper: [businessName],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameBetween(
    String? lowerBusinessName,
    String? upperBusinessName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'businessName',
        lower: [lowerBusinessName],
        includeLower: includeLower,
        upper: [upperBusinessName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameStartsWith(
      String BusinessNamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'businessName',
        lower: [BusinessNamePrefix],
        upper: ['$BusinessNamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'businessName',
        value: [''],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> businessNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'businessName',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'businessName',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'businessName',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'businessName',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'phone',
        value: [null],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'phone',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneEqualTo(String? phone) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'phone',
        value: [phone],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneNotEqualTo(
      String? phone) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phone',
              lower: [],
              upper: [phone],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phone',
              lower: [phone],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phone',
              lower: [phone],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phone',
              lower: [],
              upper: [phone],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneGreaterThan(
    String? phone, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'phone',
        lower: [phone],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneLessThan(
    String? phone, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'phone',
        lower: [],
        upper: [phone],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneBetween(
    String? lowerPhone,
    String? upperPhone, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'phone',
        lower: [lowerPhone],
        includeLower: includeLower,
        upper: [upperPhone],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneStartsWith(
      String PhonePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'phone',
        lower: [PhonePrefix],
        upper: ['$PhonePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'phone',
        value: [''],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'phone',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'phone',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'phone',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'phone',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'location',
        value: [null],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'location',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationEqualTo(
      String? location) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'location',
        value: [location],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationNotEqualTo(
      String? location) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'location',
              lower: [],
              upper: [location],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'location',
              lower: [location],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'location',
              lower: [location],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'location',
              lower: [],
              upper: [location],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationGreaterThan(
    String? location, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'location',
        lower: [location],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationLessThan(
    String? location, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'location',
        lower: [],
        upper: [location],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationBetween(
    String? lowerLocation,
    String? upperLocation, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'location',
        lower: [lowerLocation],
        includeLower: includeLower,
        upper: [upperLocation],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationStartsWith(
      String LocationPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'location',
        lower: [LocationPrefix],
        upper: ['$LocationPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'location',
        value: [''],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'location',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'location',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'location',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'location',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> relationshipStageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'relationshipStage',
        value: [null],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> relationshipStageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relationshipStage',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> relationshipStageEqualTo(
      String? relationshipStage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'relationshipStage',
        value: [relationshipStage],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> relationshipStageNotEqualTo(
      String? relationshipStage) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relationshipStage',
              lower: [],
              upper: [relationshipStage],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relationshipStage',
              lower: [relationshipStage],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relationshipStage',
              lower: [relationshipStage],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'relationshipStage',
              lower: [],
              upper: [relationshipStage],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> relationshipStageGreaterThan(
    String? relationshipStage, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relationshipStage',
        lower: [relationshipStage],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> relationshipStageLessThan(
    String? relationshipStage, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relationshipStage',
        lower: [],
        upper: [relationshipStage],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> relationshipStageBetween(
    String? lowerRelationshipStage,
    String? upperRelationshipStage, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relationshipStage',
        lower: [lowerRelationshipStage],
        includeLower: includeLower,
        upper: [upperRelationshipStage],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> relationshipStageStartsWith(
      String RelationshipStagePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'relationshipStage',
        lower: [RelationshipStagePrefix],
        upper: ['$RelationshipStagePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> relationshipStageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'relationshipStage',
        value: [''],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause>
      relationshipStageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'relationshipStage',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'relationshipStage',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'relationshipStage',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'relationshipStage',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'clientType',
        value: [null],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clientType',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeEqualTo(
      String? clientType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'clientType',
        value: [clientType],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeNotEqualTo(
      String? clientType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientType',
              lower: [],
              upper: [clientType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientType',
              lower: [clientType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientType',
              lower: [clientType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientType',
              lower: [],
              upper: [clientType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeGreaterThan(
    String? clientType, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clientType',
        lower: [clientType],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeLessThan(
    String? clientType, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clientType',
        lower: [],
        upper: [clientType],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeBetween(
    String? lowerClientType,
    String? upperClientType, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clientType',
        lower: [lowerClientType],
        includeLower: includeLower,
        upper: [upperClientType],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeStartsWith(
      String ClientTypePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clientType',
        lower: [ClientTypePrefix],
        upper: ['$ClientTypePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'clientType',
        value: [''],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> clientTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'clientType',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'clientType',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'clientType',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'clientType',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [null],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'status',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusEqualTo(
      String? status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusNotEqualTo(
      String? status) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusGreaterThan(
    String? status, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'status',
        lower: [status],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusLessThan(
    String? status, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'status',
        lower: [],
        upper: [status],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusBetween(
    String? lowerStatus,
    String? upperStatus, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'status',
        lower: [lowerStatus],
        includeLower: includeLower,
        upper: [upperStatus],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusStartsWith(
      String StatusPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'status',
        lower: [StatusPrefix],
        upper: ['$StatusPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [''],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'status',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'status',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'status',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'status',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nextFollowUpDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nextFollowUpDate',
        value: [null],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nextFollowUpDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextFollowUpDate',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nextFollowUpDateEqualTo(
      DateTime? nextFollowUpDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nextFollowUpDate',
        value: [nextFollowUpDate],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nextFollowUpDateNotEqualTo(
      DateTime? nextFollowUpDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextFollowUpDate',
              lower: [],
              upper: [nextFollowUpDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextFollowUpDate',
              lower: [nextFollowUpDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextFollowUpDate',
              lower: [nextFollowUpDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextFollowUpDate',
              lower: [],
              upper: [nextFollowUpDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nextFollowUpDateGreaterThan(
    DateTime? nextFollowUpDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextFollowUpDate',
        lower: [nextFollowUpDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nextFollowUpDateLessThan(
    DateTime? nextFollowUpDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextFollowUpDate',
        lower: [],
        upper: [nextFollowUpDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterWhereClause> nextFollowUpDateBetween(
    DateTime? lowerNextFollowUpDate,
    DateTime? upperNextFollowUpDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextFollowUpDate',
        lower: [lowerNextFollowUpDate],
        includeLower: includeLower,
        upper: [upperNextFollowUpDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ClientQueryFilter on QueryBuilder<Client, Client, QFilterCondition> {
  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'businessName',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'businessName',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'businessName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'businessName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'businessName',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> businessNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'businessName',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clientType',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clientType',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientType',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> clientTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientType',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> creditLimitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'creditLimit',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> creditLimitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'creditLimit',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> creditLimitEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditLimit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> creditLimitGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditLimit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> creditLimitLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditLimit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> creditLimitBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditLimit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'followUpNotes',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'followUpNotes',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'followUpNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'followUpNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'followUpNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'followUpNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'followUpNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'followUpNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'followUpNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'followUpNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> followUpNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'followUpNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      followUpNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'followUpNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Client, Client, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Client, Client, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Client, Client, QAfterFilterCondition>
      interactionHistoryLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'interactionHistory',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      interactionHistoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'interactionHistory',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      interactionHistoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'interactionHistory',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      interactionHistoryLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'interactionHistory',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      interactionHistoryLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'interactionHistory',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      interactionHistoryLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'interactionHistory',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastCompletedOrderDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastCompletedOrderDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastCompletedOrderDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastCompletedOrderDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastCompletedOrderDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastCompletedOrderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastCompletedOrderDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastCompletedOrderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastCompletedOrderDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastCompletedOrderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastCompletedOrderDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastCompletedOrderDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastContactDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastContactDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastContactDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastContactDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastContactDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastContactDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastContactDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastContactDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastContactDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastContactDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastContactDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastContactDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastOrderAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastOrderAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastOrderAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastOrderAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastOrderAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastOrderAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastOrderAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastOrderAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastOrderDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastOrderDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastOrderDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastOrderDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastOrderDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastOrderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastOrderDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastOrderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastOrderDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastOrderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastOrderDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastOrderDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastPaymentDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPaymentDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastPaymentDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPaymentDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastPaymentDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      lastPaymentDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastPaymentDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> lastPaymentDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPaymentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leadSource',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leadSource',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leadSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leadSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leadSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leadSource',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'leadSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'leadSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'leadSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'leadSource',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leadSource',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> leadSourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'leadSource',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nextFollowUpDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextFollowUpDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      nextFollowUpDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextFollowUpDate',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nextFollowUpDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextFollowUpDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      nextFollowUpDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextFollowUpDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nextFollowUpDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextFollowUpDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> nextFollowUpDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextFollowUpDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> openOrdersEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openOrders',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> openOrdersGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openOrders',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> openOrdersLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openOrders',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> openOrdersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openOrders',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> outstandingAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outstandingAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      outstandingAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outstandingAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> outstandingAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outstandingAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> outstandingAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outstandingAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> overdueAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overdueAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> overdueAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overdueAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> overdueAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overdueAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> overdueAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overdueAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentTerms',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentTerms',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentTerms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentTerms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentTerms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentTerms',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentTerms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentTerms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentTerms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentTerms',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentTerms',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> paymentTermsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentTerms',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      relationshipStageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'relationshipStage',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      relationshipStageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'relationshipStage',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> relationshipStageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relationshipStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      relationshipStageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relationshipStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> relationshipStageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relationshipStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> relationshipStageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relationshipStage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      relationshipStageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'relationshipStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> relationshipStageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'relationshipStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> relationshipStageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'relationshipStage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> relationshipStageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'relationshipStage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      relationshipStageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relationshipStage',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition>
      relationshipStageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'relationshipStage',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> totalOrdersEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalOrders',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> totalOrdersGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalOrders',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> totalOrdersLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalOrders',
        value: value,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> totalOrdersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalOrders',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> totalRevenueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> totalRevenueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> totalRevenueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Client, Client, QAfterFilterCondition> totalRevenueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalRevenue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ClientQueryObject on QueryBuilder<Client, Client, QFilterCondition> {
  QueryBuilder<Client, Client, QAfterFilterCondition> interactionHistoryElement(
      FilterQuery<InteractionRecord> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'interactionHistory');
    });
  }
}

extension ClientQueryLinks on QueryBuilder<Client, Client, QFilterCondition> {}

extension ClientQuerySortBy on QueryBuilder<Client, Client, QSortBy> {
  QueryBuilder<Client, Client, QAfterSortBy> sortByBusinessName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessName', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByBusinessNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessName', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByClientType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientType', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByClientTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientType', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByCreditLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimit', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByCreditLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimit', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByFollowUpNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'followUpNotes', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByFollowUpNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'followUpNotes', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLastCompletedOrderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletedOrderDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy>
      sortByLastCompletedOrderDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletedOrderDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLastContactDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastContactDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLastContactDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastContactDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLastOrderAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOrderAmount', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLastOrderAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOrderAmount', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLastOrderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOrderDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLastOrderDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOrderDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLastPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPaymentDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLastPaymentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPaymentDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLeadSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadSource', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLeadSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadSource', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByNextFollowUpDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextFollowUpDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByNextFollowUpDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextFollowUpDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByOpenOrders() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOrders', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByOpenOrdersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOrders', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByOutstandingAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outstandingAmount', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByOutstandingAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outstandingAmount', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByOverdueAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueAmount', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByOverdueAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueAmount', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByPaymentTerms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentTerms', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByPaymentTermsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentTerms', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByRelationshipStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relationshipStage', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByRelationshipStageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relationshipStage', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByTotalOrders() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrders', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByTotalOrdersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrders', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByTotalRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRevenue', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> sortByTotalRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRevenue', Sort.desc);
    });
  }
}

extension ClientQuerySortThenBy on QueryBuilder<Client, Client, QSortThenBy> {
  QueryBuilder<Client, Client, QAfterSortBy> thenByBusinessName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessName', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByBusinessNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessName', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByClientType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientType', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByClientTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientType', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByCreditLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimit', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByCreditLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimit', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByFollowUpNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'followUpNotes', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByFollowUpNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'followUpNotes', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLastCompletedOrderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletedOrderDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy>
      thenByLastCompletedOrderDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletedOrderDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLastContactDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastContactDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLastContactDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastContactDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLastOrderAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOrderAmount', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLastOrderAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOrderAmount', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLastOrderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOrderDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLastOrderDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOrderDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLastPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPaymentDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLastPaymentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPaymentDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLeadSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadSource', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLeadSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadSource', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByNextFollowUpDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextFollowUpDate', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByNextFollowUpDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextFollowUpDate', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByOpenOrders() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOrders', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByOpenOrdersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOrders', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByOutstandingAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outstandingAmount', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByOutstandingAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outstandingAmount', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByOverdueAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueAmount', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByOverdueAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueAmount', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByPaymentTerms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentTerms', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByPaymentTermsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentTerms', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByRelationshipStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relationshipStage', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByRelationshipStageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relationshipStage', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByTotalOrders() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrders', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByTotalOrdersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOrders', Sort.desc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByTotalRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRevenue', Sort.asc);
    });
  }

  QueryBuilder<Client, Client, QAfterSortBy> thenByTotalRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRevenue', Sort.desc);
    });
  }
}

extension ClientQueryWhereDistinct on QueryBuilder<Client, Client, QDistinct> {
  QueryBuilder<Client, Client, QDistinct> distinctByBusinessName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'businessName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByClientType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByCreditLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditLimit');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByFollowUpNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'followUpNotes',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByLastCompletedOrderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCompletedOrderDate');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByLastContactDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastContactDate');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByLastOrderAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastOrderAmount');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByLastOrderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastOrderDate');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByLastPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPaymentDate');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByLeadSource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leadSource', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByLocation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByNextFollowUpDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextFollowUpDate');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByOpenOrders() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openOrders');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByOutstandingAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'outstandingAmount');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByOverdueAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overdueAmount');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByPaymentTerms(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentTerms', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByRelationshipStage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relationshipStage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByTotalOrders() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalOrders');
    });
  }

  QueryBuilder<Client, Client, QDistinct> distinctByTotalRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalRevenue');
    });
  }
}

extension ClientQueryProperty on QueryBuilder<Client, Client, QQueryProperty> {
  QueryBuilder<Client, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> businessNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'businessName');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> clientTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientType');
    });
  }

  QueryBuilder<Client, double?, QQueryOperations> creditLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditLimit');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> followUpNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'followUpNotes');
    });
  }

  QueryBuilder<Client, List<InteractionRecord>, QQueryOperations>
      interactionHistoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interactionHistory');
    });
  }

  QueryBuilder<Client, DateTime?, QQueryOperations>
      lastCompletedOrderDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCompletedOrderDate');
    });
  }

  QueryBuilder<Client, DateTime?, QQueryOperations> lastContactDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastContactDate');
    });
  }

  QueryBuilder<Client, double, QQueryOperations> lastOrderAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastOrderAmount');
    });
  }

  QueryBuilder<Client, DateTime?, QQueryOperations> lastOrderDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastOrderDate');
    });
  }

  QueryBuilder<Client, DateTime?, QQueryOperations> lastPaymentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPaymentDate');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> leadSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leadSource');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Client, DateTime?, QQueryOperations> nextFollowUpDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextFollowUpDate');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Client, int, QQueryOperations> openOrdersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openOrders');
    });
  }

  QueryBuilder<Client, double, QQueryOperations> outstandingAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'outstandingAmount');
    });
  }

  QueryBuilder<Client, double, QQueryOperations> overdueAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overdueAmount');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> paymentTermsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentTerms');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> relationshipStageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relationshipStage');
    });
  }

  QueryBuilder<Client, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Client, int, QQueryOperations> totalOrdersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalOrders');
    });
  }

  QueryBuilder<Client, double, QQueryOperations> totalRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalRevenue');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const InteractionRecordSchema = Schema(
  name: r'InteractionRecord',
  id: 299743861468248990,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'interactionType': PropertySchema(
      id: 1,
      name: r'interactionType',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 2,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _interactionRecordEstimateSize,
  serialize: _interactionRecordSerialize,
  deserialize: _interactionRecordDeserialize,
  deserializeProp: _interactionRecordDeserializeProp,
);

int _interactionRecordEstimateSize(
  InteractionRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.interactionType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _interactionRecordSerialize(
  InteractionRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeString(offsets[1], object.interactionType);
  writer.writeDateTime(offsets[2], object.timestamp);
}

InteractionRecord _interactionRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InteractionRecord();
  object.description = reader.readStringOrNull(offsets[0]);
  object.interactionType = reader.readStringOrNull(offsets[1]);
  object.timestamp = reader.readDateTimeOrNull(offsets[2]);
  return object;
}

P _interactionRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension InteractionRecordQueryFilter
    on QueryBuilder<InteractionRecord, InteractionRecord, QFilterCondition> {
  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interactionType',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interactionType',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interactionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interactionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interactionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interactionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interactionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interactionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interactionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interactionType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interactionType',
        value: '',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      interactionTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interactionType',
        value: '',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      timestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      timestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      timestampEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      timestampLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<InteractionRecord, InteractionRecord, QAfterFilterCondition>
      timestampBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InteractionRecordQueryObject
    on QueryBuilder<InteractionRecord, InteractionRecord, QFilterCondition> {}
