// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _businessNameMeta = const VerificationMeta('businessName');
  @override
  late final GeneratedColumn<String> businessName = GeneratedColumn<String>('business_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, defaultValue: const Constant('Bcreations'));
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone =
      GeneratedColumn<String>('phone', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta = const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address =
      GeneratedColumn<String>('address', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _upiIdMeta = const VerificationMeta('upiId');
  @override
  late final GeneratedColumn<String> upiId =
      GeneratedColumn<String>('upi_id', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logoPathMeta = const VerificationMeta('logoPath');
  @override
  late final GeneratedColumn<String> logoPath =
      GeneratedColumn<String>('logo_path', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _languageCodeMeta = const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>('language_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, defaultValue: const Constant('hi'));
  static const VerificationMeta _themeModeMeta = const VerificationMeta('themeMode');
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>('theme_mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, defaultValue: const Constant('light'));
  static const VerificationMeta _hourlyRatePaiseMeta = const VerificationMeta('hourlyRatePaise');
  @override
  late final GeneratedColumn<int> hourlyRatePaise = GeneratedColumn<int>('hourly_rate_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(10000));
  static const VerificationMeta _overheadBpMeta = const VerificationMeta('overheadBp');
  @override
  late final GeneratedColumn<int> overheadBp = GeneratedColumn<int>('overhead_bp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(1000));
  static const VerificationMeta _retailMarkupBpMeta = const VerificationMeta('retailMarkupBp');
  @override
  late final GeneratedColumn<int> retailMarkupBp = GeneratedColumn<int>('retail_markup_bp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(25000));
  static const VerificationMeta _wholesaleMarkupBpMeta = const VerificationMeta('wholesaleMarkupBp');
  @override
  late final GeneratedColumn<int> wholesaleMarkupBp = GeneratedColumn<int>('wholesale_markup_bp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(18000));
  static const VerificationMeta _defaultWholesaleDiscountBpMeta = const VerificationMeta('defaultWholesaleDiscountBp');
  @override
  late final GeneratedColumn<int> defaultWholesaleDiscountBp = GeneratedColumn<int>(
      'default_wholesale_discount_bp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(3000));
  static const VerificationMeta _targetMarginBpMeta = const VerificationMeta('targetMarginBp');
  @override
  late final GeneratedColumn<int> targetMarginBp = GeneratedColumn<int>('target_margin_bp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(4000));
  static const VerificationMeta _priceReviewThresholdBpMeta = const VerificationMeta('priceReviewThresholdBp');
  @override
  late final GeneratedColumn<int> priceReviewThresholdBp = GeneratedColumn<int>(
      'price_review_threshold_bp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(1000));
  static const VerificationMeta _wholesaleTermsDaysMeta = const VerificationMeta('wholesaleTermsDays');
  @override
  late final GeneratedColumn<int> wholesaleTermsDays = GeneratedColumn<int>('wholesale_terms_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(15));
  static const VerificationMeta _retailTermsDaysMeta = const VerificationMeta('retailTermsDays');
  @override
  late final GeneratedColumn<int> retailTermsDays = GeneratedColumn<int>('retail_terms_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
  static const VerificationMeta _orderPrefixMeta = const VerificationMeta('orderPrefix');
  @override
  late final GeneratedColumn<String> orderPrefix = GeneratedColumn<String>('order_prefix', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, defaultValue: const Constant('BC-'));
  static const VerificationMeta _nextOrderNumberMeta = const VerificationMeta('nextOrderNumber');
  @override
  late final GeneratedColumn<int> nextOrderNumber = GeneratedColumn<int>('next_order_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(1));
  static const VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>('start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        businessName,
        phone,
        address,
        upiId,
        logoPath,
        languageCode,
        themeMode,
        hourlyRatePaise,
        overheadBp,
        retailMarkupBp,
        wholesaleMarkupBp,
        defaultWholesaleDiscountBp,
        targetMarginBp,
        priceReviewThresholdBp,
        wholesaleTermsDays,
        retailTermsDays,
        orderPrefix,
        nextOrderNumber,
        startDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('business_name')) {
      context.handle(_businessNameMeta, businessName.isAcceptableOrUnknown(data['business_name']!, _businessNameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(_phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta, address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('upi_id')) {
      context.handle(_upiIdMeta, upiId.isAcceptableOrUnknown(data['upi_id']!, _upiIdMeta));
    }
    if (data.containsKey('logo_path')) {
      context.handle(_logoPathMeta, logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta));
    }
    if (data.containsKey('language_code')) {
      context.handle(_languageCodeMeta, languageCode.isAcceptableOrUnknown(data['language_code']!, _languageCodeMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(_themeModeMeta, themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta));
    }
    if (data.containsKey('hourly_rate_paise')) {
      context.handle(_hourlyRatePaiseMeta,
          hourlyRatePaise.isAcceptableOrUnknown(data['hourly_rate_paise']!, _hourlyRatePaiseMeta));
    }
    if (data.containsKey('overhead_bp')) {
      context.handle(_overheadBpMeta, overheadBp.isAcceptableOrUnknown(data['overhead_bp']!, _overheadBpMeta));
    }
    if (data.containsKey('retail_markup_bp')) {
      context.handle(
          _retailMarkupBpMeta, retailMarkupBp.isAcceptableOrUnknown(data['retail_markup_bp']!, _retailMarkupBpMeta));
    }
    if (data.containsKey('wholesale_markup_bp')) {
      context.handle(_wholesaleMarkupBpMeta,
          wholesaleMarkupBp.isAcceptableOrUnknown(data['wholesale_markup_bp']!, _wholesaleMarkupBpMeta));
    }
    if (data.containsKey('default_wholesale_discount_bp')) {
      context.handle(
          _defaultWholesaleDiscountBpMeta,
          defaultWholesaleDiscountBp.isAcceptableOrUnknown(
              data['default_wholesale_discount_bp']!, _defaultWholesaleDiscountBpMeta));
    }
    if (data.containsKey('target_margin_bp')) {
      context.handle(
          _targetMarginBpMeta, targetMarginBp.isAcceptableOrUnknown(data['target_margin_bp']!, _targetMarginBpMeta));
    }
    if (data.containsKey('price_review_threshold_bp')) {
      context.handle(
          _priceReviewThresholdBpMeta,
          priceReviewThresholdBp.isAcceptableOrUnknown(
              data['price_review_threshold_bp']!, _priceReviewThresholdBpMeta));
    }
    if (data.containsKey('wholesale_terms_days')) {
      context.handle(_wholesaleTermsDaysMeta,
          wholesaleTermsDays.isAcceptableOrUnknown(data['wholesale_terms_days']!, _wholesaleTermsDaysMeta));
    }
    if (data.containsKey('retail_terms_days')) {
      context.handle(_retailTermsDaysMeta,
          retailTermsDays.isAcceptableOrUnknown(data['retail_terms_days']!, _retailTermsDaysMeta));
    }
    if (data.containsKey('order_prefix')) {
      context.handle(_orderPrefixMeta, orderPrefix.isAcceptableOrUnknown(data['order_prefix']!, _orderPrefixMeta));
    }
    if (data.containsKey('next_order_number')) {
      context.handle(_nextOrderNumberMeta,
          nextOrderNumber.isAcceptableOrUnknown(data['next_order_number']!, _nextOrderNumberMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta, startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      businessName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}business_name'])!,
      phone: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}phone']),
      address: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}address']),
      upiId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}upi_id']),
      logoPath: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}logo_path']),
      languageCode: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      themeMode: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}theme_mode'])!,
      hourlyRatePaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}hourly_rate_paise'])!,
      overheadBp: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}overhead_bp'])!,
      retailMarkupBp: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}retail_markup_bp'])!,
      wholesaleMarkupBp:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}wholesale_markup_bp'])!,
      defaultWholesaleDiscountBp:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}default_wholesale_discount_bp'])!,
      targetMarginBp: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}target_margin_bp'])!,
      priceReviewThresholdBp:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}price_review_threshold_bp'])!,
      wholesaleTermsDays:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}wholesale_terms_days'])!,
      retailTermsDays:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}retail_terms_days'])!,
      orderPrefix: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}order_prefix'])!,
      nextOrderNumber:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}next_order_number'])!,
      startDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String businessName;
  final String? phone;
  final String? address;
  final String? upiId;
  final String? logoPath;
  final String languageCode;
  final String themeMode;
  final int hourlyRatePaise;
  final int overheadBp;
  final int retailMarkupBp;
  final int wholesaleMarkupBp;
  final int defaultWholesaleDiscountBp;
  final int targetMarginBp;
  final int priceReviewThresholdBp;
  final int wholesaleTermsDays;
  final int retailTermsDays;
  final String orderPrefix;
  final int nextOrderNumber;

  /// The day she started using the app; opening balances are as of this date.
  final DateTime? startDate;
  const Setting(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.businessName,
      this.phone,
      this.address,
      this.upiId,
      this.logoPath,
      required this.languageCode,
      required this.themeMode,
      required this.hourlyRatePaise,
      required this.overheadBp,
      required this.retailMarkupBp,
      required this.wholesaleMarkupBp,
      required this.defaultWholesaleDiscountBp,
      required this.targetMarginBp,
      required this.priceReviewThresholdBp,
      required this.wholesaleTermsDays,
      required this.retailTermsDays,
      required this.orderPrefix,
      required this.nextOrderNumber,
      this.startDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['business_name'] = Variable<String>(businessName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || upiId != null) {
      map['upi_id'] = Variable<String>(upiId);
    }
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    map['language_code'] = Variable<String>(languageCode);
    map['theme_mode'] = Variable<String>(themeMode);
    map['hourly_rate_paise'] = Variable<int>(hourlyRatePaise);
    map['overhead_bp'] = Variable<int>(overheadBp);
    map['retail_markup_bp'] = Variable<int>(retailMarkupBp);
    map['wholesale_markup_bp'] = Variable<int>(wholesaleMarkupBp);
    map['default_wholesale_discount_bp'] = Variable<int>(defaultWholesaleDiscountBp);
    map['target_margin_bp'] = Variable<int>(targetMarginBp);
    map['price_review_threshold_bp'] = Variable<int>(priceReviewThresholdBp);
    map['wholesale_terms_days'] = Variable<int>(wholesaleTermsDays);
    map['retail_terms_days'] = Variable<int>(retailTermsDays);
    map['order_prefix'] = Variable<String>(orderPrefix);
    map['next_order_number'] = Variable<int>(nextOrderNumber);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      businessName: Value(businessName),
      phone: phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      address: address == null && nullToAbsent ? const Value.absent() : Value(address),
      upiId: upiId == null && nullToAbsent ? const Value.absent() : Value(upiId),
      logoPath: logoPath == null && nullToAbsent ? const Value.absent() : Value(logoPath),
      languageCode: Value(languageCode),
      themeMode: Value(themeMode),
      hourlyRatePaise: Value(hourlyRatePaise),
      overheadBp: Value(overheadBp),
      retailMarkupBp: Value(retailMarkupBp),
      wholesaleMarkupBp: Value(wholesaleMarkupBp),
      defaultWholesaleDiscountBp: Value(defaultWholesaleDiscountBp),
      targetMarginBp: Value(targetMarginBp),
      priceReviewThresholdBp: Value(priceReviewThresholdBp),
      wholesaleTermsDays: Value(wholesaleTermsDays),
      retailTermsDays: Value(retailTermsDays),
      orderPrefix: Value(orderPrefix),
      nextOrderNumber: Value(nextOrderNumber),
      startDate: startDate == null && nullToAbsent ? const Value.absent() : Value(startDate),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      businessName: serializer.fromJson<String>(json['businessName']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      upiId: serializer.fromJson<String?>(json['upiId']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      hourlyRatePaise: serializer.fromJson<int>(json['hourlyRatePaise']),
      overheadBp: serializer.fromJson<int>(json['overheadBp']),
      retailMarkupBp: serializer.fromJson<int>(json['retailMarkupBp']),
      wholesaleMarkupBp: serializer.fromJson<int>(json['wholesaleMarkupBp']),
      defaultWholesaleDiscountBp: serializer.fromJson<int>(json['defaultWholesaleDiscountBp']),
      targetMarginBp: serializer.fromJson<int>(json['targetMarginBp']),
      priceReviewThresholdBp: serializer.fromJson<int>(json['priceReviewThresholdBp']),
      wholesaleTermsDays: serializer.fromJson<int>(json['wholesaleTermsDays']),
      retailTermsDays: serializer.fromJson<int>(json['retailTermsDays']),
      orderPrefix: serializer.fromJson<String>(json['orderPrefix']),
      nextOrderNumber: serializer.fromJson<int>(json['nextOrderNumber']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'businessName': serializer.toJson<String>(businessName),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'upiId': serializer.toJson<String?>(upiId),
      'logoPath': serializer.toJson<String?>(logoPath),
      'languageCode': serializer.toJson<String>(languageCode),
      'themeMode': serializer.toJson<String>(themeMode),
      'hourlyRatePaise': serializer.toJson<int>(hourlyRatePaise),
      'overheadBp': serializer.toJson<int>(overheadBp),
      'retailMarkupBp': serializer.toJson<int>(retailMarkupBp),
      'wholesaleMarkupBp': serializer.toJson<int>(wholesaleMarkupBp),
      'defaultWholesaleDiscountBp': serializer.toJson<int>(defaultWholesaleDiscountBp),
      'targetMarginBp': serializer.toJson<int>(targetMarginBp),
      'priceReviewThresholdBp': serializer.toJson<int>(priceReviewThresholdBp),
      'wholesaleTermsDays': serializer.toJson<int>(wholesaleTermsDays),
      'retailTermsDays': serializer.toJson<int>(retailTermsDays),
      'orderPrefix': serializer.toJson<String>(orderPrefix),
      'nextOrderNumber': serializer.toJson<int>(nextOrderNumber),
      'startDate': serializer.toJson<DateTime?>(startDate),
    };
  }

  Setting copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? businessName,
          Value<String?> phone = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> upiId = const Value.absent(),
          Value<String?> logoPath = const Value.absent(),
          String? languageCode,
          String? themeMode,
          int? hourlyRatePaise,
          int? overheadBp,
          int? retailMarkupBp,
          int? wholesaleMarkupBp,
          int? defaultWholesaleDiscountBp,
          int? targetMarginBp,
          int? priceReviewThresholdBp,
          int? wholesaleTermsDays,
          int? retailTermsDays,
          String? orderPrefix,
          int? nextOrderNumber,
          Value<DateTime?> startDate = const Value.absent()}) =>
      Setting(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        businessName: businessName ?? this.businessName,
        phone: phone.present ? phone.value : this.phone,
        address: address.present ? address.value : this.address,
        upiId: upiId.present ? upiId.value : this.upiId,
        logoPath: logoPath.present ? logoPath.value : this.logoPath,
        languageCode: languageCode ?? this.languageCode,
        themeMode: themeMode ?? this.themeMode,
        hourlyRatePaise: hourlyRatePaise ?? this.hourlyRatePaise,
        overheadBp: overheadBp ?? this.overheadBp,
        retailMarkupBp: retailMarkupBp ?? this.retailMarkupBp,
        wholesaleMarkupBp: wholesaleMarkupBp ?? this.wholesaleMarkupBp,
        defaultWholesaleDiscountBp: defaultWholesaleDiscountBp ?? this.defaultWholesaleDiscountBp,
        targetMarginBp: targetMarginBp ?? this.targetMarginBp,
        priceReviewThresholdBp: priceReviewThresholdBp ?? this.priceReviewThresholdBp,
        wholesaleTermsDays: wholesaleTermsDays ?? this.wholesaleTermsDays,
        retailTermsDays: retailTermsDays ?? this.retailTermsDays,
        orderPrefix: orderPrefix ?? this.orderPrefix,
        nextOrderNumber: nextOrderNumber ?? this.nextOrderNumber,
        startDate: startDate.present ? startDate.value : this.startDate,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      businessName: data.businessName.present ? data.businessName.value : this.businessName,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      upiId: data.upiId.present ? data.upiId.value : this.upiId,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      languageCode: data.languageCode.present ? data.languageCode.value : this.languageCode,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      hourlyRatePaise: data.hourlyRatePaise.present ? data.hourlyRatePaise.value : this.hourlyRatePaise,
      overheadBp: data.overheadBp.present ? data.overheadBp.value : this.overheadBp,
      retailMarkupBp: data.retailMarkupBp.present ? data.retailMarkupBp.value : this.retailMarkupBp,
      wholesaleMarkupBp: data.wholesaleMarkupBp.present ? data.wholesaleMarkupBp.value : this.wholesaleMarkupBp,
      defaultWholesaleDiscountBp: data.defaultWholesaleDiscountBp.present
          ? data.defaultWholesaleDiscountBp.value
          : this.defaultWholesaleDiscountBp,
      targetMarginBp: data.targetMarginBp.present ? data.targetMarginBp.value : this.targetMarginBp,
      priceReviewThresholdBp:
          data.priceReviewThresholdBp.present ? data.priceReviewThresholdBp.value : this.priceReviewThresholdBp,
      wholesaleTermsDays: data.wholesaleTermsDays.present ? data.wholesaleTermsDays.value : this.wholesaleTermsDays,
      retailTermsDays: data.retailTermsDays.present ? data.retailTermsDays.value : this.retailTermsDays,
      orderPrefix: data.orderPrefix.present ? data.orderPrefix.value : this.orderPrefix,
      nextOrderNumber: data.nextOrderNumber.present ? data.nextOrderNumber.value : this.nextOrderNumber,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('businessName: $businessName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('upiId: $upiId, ')
          ..write('logoPath: $logoPath, ')
          ..write('languageCode: $languageCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('hourlyRatePaise: $hourlyRatePaise, ')
          ..write('overheadBp: $overheadBp, ')
          ..write('retailMarkupBp: $retailMarkupBp, ')
          ..write('wholesaleMarkupBp: $wholesaleMarkupBp, ')
          ..write('defaultWholesaleDiscountBp: $defaultWholesaleDiscountBp, ')
          ..write('targetMarginBp: $targetMarginBp, ')
          ..write('priceReviewThresholdBp: $priceReviewThresholdBp, ')
          ..write('wholesaleTermsDays: $wholesaleTermsDays, ')
          ..write('retailTermsDays: $retailTermsDays, ')
          ..write('orderPrefix: $orderPrefix, ')
          ..write('nextOrderNumber: $nextOrderNumber, ')
          ..write('startDate: $startDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        createdAt,
        updatedAt,
        deletedAt,
        businessName,
        phone,
        address,
        upiId,
        logoPath,
        languageCode,
        themeMode,
        hourlyRatePaise,
        overheadBp,
        retailMarkupBp,
        wholesaleMarkupBp,
        defaultWholesaleDiscountBp,
        targetMarginBp,
        priceReviewThresholdBp,
        wholesaleTermsDays,
        retailTermsDays,
        orderPrefix,
        nextOrderNumber,
        startDate
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.businessName == this.businessName &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.upiId == this.upiId &&
          other.logoPath == this.logoPath &&
          other.languageCode == this.languageCode &&
          other.themeMode == this.themeMode &&
          other.hourlyRatePaise == this.hourlyRatePaise &&
          other.overheadBp == this.overheadBp &&
          other.retailMarkupBp == this.retailMarkupBp &&
          other.wholesaleMarkupBp == this.wholesaleMarkupBp &&
          other.defaultWholesaleDiscountBp == this.defaultWholesaleDiscountBp &&
          other.targetMarginBp == this.targetMarginBp &&
          other.priceReviewThresholdBp == this.priceReviewThresholdBp &&
          other.wholesaleTermsDays == this.wholesaleTermsDays &&
          other.retailTermsDays == this.retailTermsDays &&
          other.orderPrefix == this.orderPrefix &&
          other.nextOrderNumber == this.nextOrderNumber &&
          other.startDate == this.startDate);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> businessName;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> upiId;
  final Value<String?> logoPath;
  final Value<String> languageCode;
  final Value<String> themeMode;
  final Value<int> hourlyRatePaise;
  final Value<int> overheadBp;
  final Value<int> retailMarkupBp;
  final Value<int> wholesaleMarkupBp;
  final Value<int> defaultWholesaleDiscountBp;
  final Value<int> targetMarginBp;
  final Value<int> priceReviewThresholdBp;
  final Value<int> wholesaleTermsDays;
  final Value<int> retailTermsDays;
  final Value<String> orderPrefix;
  final Value<int> nextOrderNumber;
  final Value<DateTime?> startDate;
  final Value<int> rowid;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.businessName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.upiId = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.hourlyRatePaise = const Value.absent(),
    this.overheadBp = const Value.absent(),
    this.retailMarkupBp = const Value.absent(),
    this.wholesaleMarkupBp = const Value.absent(),
    this.defaultWholesaleDiscountBp = const Value.absent(),
    this.targetMarginBp = const Value.absent(),
    this.priceReviewThresholdBp = const Value.absent(),
    this.wholesaleTermsDays = const Value.absent(),
    this.retailTermsDays = const Value.absent(),
    this.orderPrefix = const Value.absent(),
    this.nextOrderNumber = const Value.absent(),
    this.startDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.businessName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.upiId = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.hourlyRatePaise = const Value.absent(),
    this.overheadBp = const Value.absent(),
    this.retailMarkupBp = const Value.absent(),
    this.wholesaleMarkupBp = const Value.absent(),
    this.defaultWholesaleDiscountBp = const Value.absent(),
    this.targetMarginBp = const Value.absent(),
    this.priceReviewThresholdBp = const Value.absent(),
    this.wholesaleTermsDays = const Value.absent(),
    this.retailTermsDays = const Value.absent(),
    this.orderPrefix = const Value.absent(),
    this.nextOrderNumber = const Value.absent(),
    this.startDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<Setting> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? businessName,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? upiId,
    Expression<String>? logoPath,
    Expression<String>? languageCode,
    Expression<String>? themeMode,
    Expression<int>? hourlyRatePaise,
    Expression<int>? overheadBp,
    Expression<int>? retailMarkupBp,
    Expression<int>? wholesaleMarkupBp,
    Expression<int>? defaultWholesaleDiscountBp,
    Expression<int>? targetMarginBp,
    Expression<int>? priceReviewThresholdBp,
    Expression<int>? wholesaleTermsDays,
    Expression<int>? retailTermsDays,
    Expression<String>? orderPrefix,
    Expression<int>? nextOrderNumber,
    Expression<DateTime>? startDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (businessName != null) 'business_name': businessName,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (upiId != null) 'upi_id': upiId,
      if (logoPath != null) 'logo_path': logoPath,
      if (languageCode != null) 'language_code': languageCode,
      if (themeMode != null) 'theme_mode': themeMode,
      if (hourlyRatePaise != null) 'hourly_rate_paise': hourlyRatePaise,
      if (overheadBp != null) 'overhead_bp': overheadBp,
      if (retailMarkupBp != null) 'retail_markup_bp': retailMarkupBp,
      if (wholesaleMarkupBp != null) 'wholesale_markup_bp': wholesaleMarkupBp,
      if (defaultWholesaleDiscountBp != null) 'default_wholesale_discount_bp': defaultWholesaleDiscountBp,
      if (targetMarginBp != null) 'target_margin_bp': targetMarginBp,
      if (priceReviewThresholdBp != null) 'price_review_threshold_bp': priceReviewThresholdBp,
      if (wholesaleTermsDays != null) 'wholesale_terms_days': wholesaleTermsDays,
      if (retailTermsDays != null) 'retail_terms_days': retailTermsDays,
      if (orderPrefix != null) 'order_prefix': orderPrefix,
      if (nextOrderNumber != null) 'next_order_number': nextOrderNumber,
      if (startDate != null) 'start_date': startDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? businessName,
      Value<String?>? phone,
      Value<String?>? address,
      Value<String?>? upiId,
      Value<String?>? logoPath,
      Value<String>? languageCode,
      Value<String>? themeMode,
      Value<int>? hourlyRatePaise,
      Value<int>? overheadBp,
      Value<int>? retailMarkupBp,
      Value<int>? wholesaleMarkupBp,
      Value<int>? defaultWholesaleDiscountBp,
      Value<int>? targetMarginBp,
      Value<int>? priceReviewThresholdBp,
      Value<int>? wholesaleTermsDays,
      Value<int>? retailTermsDays,
      Value<String>? orderPrefix,
      Value<int>? nextOrderNumber,
      Value<DateTime?>? startDate,
      Value<int>? rowid}) {
    return SettingsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      businessName: businessName ?? this.businessName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      upiId: upiId ?? this.upiId,
      logoPath: logoPath ?? this.logoPath,
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
      hourlyRatePaise: hourlyRatePaise ?? this.hourlyRatePaise,
      overheadBp: overheadBp ?? this.overheadBp,
      retailMarkupBp: retailMarkupBp ?? this.retailMarkupBp,
      wholesaleMarkupBp: wholesaleMarkupBp ?? this.wholesaleMarkupBp,
      defaultWholesaleDiscountBp: defaultWholesaleDiscountBp ?? this.defaultWholesaleDiscountBp,
      targetMarginBp: targetMarginBp ?? this.targetMarginBp,
      priceReviewThresholdBp: priceReviewThresholdBp ?? this.priceReviewThresholdBp,
      wholesaleTermsDays: wholesaleTermsDays ?? this.wholesaleTermsDays,
      retailTermsDays: retailTermsDays ?? this.retailTermsDays,
      orderPrefix: orderPrefix ?? this.orderPrefix,
      nextOrderNumber: nextOrderNumber ?? this.nextOrderNumber,
      startDate: startDate ?? this.startDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (businessName.present) {
      map['business_name'] = Variable<String>(businessName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (upiId.present) {
      map['upi_id'] = Variable<String>(upiId.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (hourlyRatePaise.present) {
      map['hourly_rate_paise'] = Variable<int>(hourlyRatePaise.value);
    }
    if (overheadBp.present) {
      map['overhead_bp'] = Variable<int>(overheadBp.value);
    }
    if (retailMarkupBp.present) {
      map['retail_markup_bp'] = Variable<int>(retailMarkupBp.value);
    }
    if (wholesaleMarkupBp.present) {
      map['wholesale_markup_bp'] = Variable<int>(wholesaleMarkupBp.value);
    }
    if (defaultWholesaleDiscountBp.present) {
      map['default_wholesale_discount_bp'] = Variable<int>(defaultWholesaleDiscountBp.value);
    }
    if (targetMarginBp.present) {
      map['target_margin_bp'] = Variable<int>(targetMarginBp.value);
    }
    if (priceReviewThresholdBp.present) {
      map['price_review_threshold_bp'] = Variable<int>(priceReviewThresholdBp.value);
    }
    if (wholesaleTermsDays.present) {
      map['wholesale_terms_days'] = Variable<int>(wholesaleTermsDays.value);
    }
    if (retailTermsDays.present) {
      map['retail_terms_days'] = Variable<int>(retailTermsDays.value);
    }
    if (orderPrefix.present) {
      map['order_prefix'] = Variable<String>(orderPrefix.value);
    }
    if (nextOrderNumber.present) {
      map['next_order_number'] = Variable<int>(nextOrderNumber.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('businessName: $businessName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('upiId: $upiId, ')
          ..write('logoPath: $logoPath, ')
          ..write('languageCode: $languageCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('hourlyRatePaise: $hourlyRatePaise, ')
          ..write('overheadBp: $overheadBp, ')
          ..write('retailMarkupBp: $retailMarkupBp, ')
          ..write('wholesaleMarkupBp: $wholesaleMarkupBp, ')
          ..write('defaultWholesaleDiscountBp: $defaultWholesaleDiscountBp, ')
          ..write('targetMarginBp: $targetMarginBp, ')
          ..write('priceReviewThresholdBp: $priceReviewThresholdBp, ')
          ..write('wholesaleTermsDays: $wholesaleTermsDays, ')
          ..write('retailTermsDays: $retailTermsDays, ')
          ..write('orderPrefix: $orderPrefix, ')
          ..write('nextOrderNumber: $nextOrderNumber, ')
          ..write('startDate: $startDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<ProductKind, String> kind =
      GeneratedColumn<String>('kind', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ProductKind>($ProductsTable.$converterkind);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>('unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, defaultValue: const Constant('pcs'));
  static const VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category =
      GeneratedColumn<String>('category', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku =
      GeneratedColumn<String>('sku', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta = const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath =
      GeneratedColumn<String>('photo_path', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _retailPricePaiseMeta = const VerificationMeta('retailPricePaise');
  @override
  late final GeneratedColumn<int> retailPricePaise = GeneratedColumn<int>('retail_price_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _wholesalePricePaiseMeta = const VerificationMeta('wholesalePricePaise');
  @override
  late final GeneratedColumn<int> wholesalePricePaise = GeneratedColumn<int>('wholesale_price_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _priceSetCostPaiseMeta = const VerificationMeta('priceSetCostPaise');
  @override
  late final GeneratedColumn<int> priceSetCostPaise = GeneratedColumn<int>('price_set_cost_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _minStockMilliMeta = const VerificationMeta('minStockMilli');
  @override
  late final GeneratedColumn<int> minStockMilli = GeneratedColumn<int>('min_stock_milli', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes =
      GeneratedColumn<String>('notes', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _archivedMeta = const VerificationMeta('archived');
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>('archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        name,
        kind,
        unit,
        category,
        sku,
        photoPath,
        retailPricePaise,
        wholesalePricePaise,
        priceSetCostPaise,
        minStockMilli,
        notes,
        archived
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(_unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta, category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(_skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta, photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('retail_price_paise')) {
      context.handle(_retailPricePaiseMeta,
          retailPricePaise.isAcceptableOrUnknown(data['retail_price_paise']!, _retailPricePaiseMeta));
    }
    if (data.containsKey('wholesale_price_paise')) {
      context.handle(_wholesalePricePaiseMeta,
          wholesalePricePaise.isAcceptableOrUnknown(data['wholesale_price_paise']!, _wholesalePricePaiseMeta));
    }
    if (data.containsKey('price_set_cost_paise')) {
      context.handle(_priceSetCostPaiseMeta,
          priceSetCostPaise.isAcceptableOrUnknown(data['price_set_cost_paise']!, _priceSetCostPaiseMeta));
    }
    if (data.containsKey('min_stock_milli')) {
      context.handle(
          _minStockMilliMeta, minStockMilli.isAcceptableOrUnknown(data['min_stock_milli']!, _minStockMilliMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(_notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('archived')) {
      context.handle(_archivedMeta, archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      kind: $ProductsTable.$converterkind
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}kind'])!),
      unit: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      category: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}category']),
      sku: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}sku']),
      photoPath: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      retailPricePaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}retail_price_paise']),
      wholesalePricePaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}wholesale_price_paise']),
      priceSetCostPaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}price_set_cost_paise']),
      minStockMilli: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}min_stock_milli'])!,
      notes: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}notes']),
      archived: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}archived'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ProductKind, String, String> $converterkind =
      const EnumNameConverter<ProductKind>(ProductKind.values);
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String name;
  final ProductKind kind;
  final String unit;
  final String? category;
  final String? sku;
  final String? photoPath;
  final int? retailPricePaise;

  /// null -> retail price minus Settings.defaultWholesaleDiscountBp.
  final int? wholesalePricePaise;

  /// Full cost per piece when the price was last set (for "Prices to review").
  final int? priceSetCostPaise;
  final int minStockMilli;
  final String? notes;
  final bool archived;
  const Product(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.name,
      required this.kind,
      required this.unit,
      this.category,
      this.sku,
      this.photoPath,
      this.retailPricePaise,
      this.wholesalePricePaise,
      this.priceSetCostPaise,
      required this.minStockMilli,
      this.notes,
      required this.archived});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    {
      map['kind'] = Variable<String>($ProductsTable.$converterkind.toSql(kind));
    }
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || retailPricePaise != null) {
      map['retail_price_paise'] = Variable<int>(retailPricePaise);
    }
    if (!nullToAbsent || wholesalePricePaise != null) {
      map['wholesale_price_paise'] = Variable<int>(wholesalePricePaise);
    }
    if (!nullToAbsent || priceSetCostPaise != null) {
      map['price_set_cost_paise'] = Variable<int>(priceSetCostPaise);
    }
    map['min_stock_milli'] = Variable<int>(minStockMilli);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      name: Value(name),
      kind: Value(kind),
      unit: Value(unit),
      category: category == null && nullToAbsent ? const Value.absent() : Value(category),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      photoPath: photoPath == null && nullToAbsent ? const Value.absent() : Value(photoPath),
      retailPricePaise: retailPricePaise == null && nullToAbsent ? const Value.absent() : Value(retailPricePaise),
      wholesalePricePaise:
          wholesalePricePaise == null && nullToAbsent ? const Value.absent() : Value(wholesalePricePaise),
      priceSetCostPaise: priceSetCostPaise == null && nullToAbsent ? const Value.absent() : Value(priceSetCostPaise),
      minStockMilli: Value(minStockMilli),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      archived: Value(archived),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      kind: $ProductsTable.$converterkind.fromJson(serializer.fromJson<String>(json['kind'])),
      unit: serializer.fromJson<String>(json['unit']),
      category: serializer.fromJson<String?>(json['category']),
      sku: serializer.fromJson<String?>(json['sku']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      retailPricePaise: serializer.fromJson<int?>(json['retailPricePaise']),
      wholesalePricePaise: serializer.fromJson<int?>(json['wholesalePricePaise']),
      priceSetCostPaise: serializer.fromJson<int?>(json['priceSetCostPaise']),
      minStockMilli: serializer.fromJson<int>(json['minStockMilli']),
      notes: serializer.fromJson<String?>(json['notes']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>($ProductsTable.$converterkind.toJson(kind)),
      'unit': serializer.toJson<String>(unit),
      'category': serializer.toJson<String?>(category),
      'sku': serializer.toJson<String?>(sku),
      'photoPath': serializer.toJson<String?>(photoPath),
      'retailPricePaise': serializer.toJson<int?>(retailPricePaise),
      'wholesalePricePaise': serializer.toJson<int?>(wholesalePricePaise),
      'priceSetCostPaise': serializer.toJson<int?>(priceSetCostPaise),
      'minStockMilli': serializer.toJson<int>(minStockMilli),
      'notes': serializer.toJson<String?>(notes),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  Product copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? name,
          ProductKind? kind,
          String? unit,
          Value<String?> category = const Value.absent(),
          Value<String?> sku = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          Value<int?> retailPricePaise = const Value.absent(),
          Value<int?> wholesalePricePaise = const Value.absent(),
          Value<int?> priceSetCostPaise = const Value.absent(),
          int? minStockMilli,
          Value<String?> notes = const Value.absent(),
          bool? archived}) =>
      Product(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        name: name ?? this.name,
        kind: kind ?? this.kind,
        unit: unit ?? this.unit,
        category: category.present ? category.value : this.category,
        sku: sku.present ? sku.value : this.sku,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        retailPricePaise: retailPricePaise.present ? retailPricePaise.value : this.retailPricePaise,
        wholesalePricePaise: wholesalePricePaise.present ? wholesalePricePaise.value : this.wholesalePricePaise,
        priceSetCostPaise: priceSetCostPaise.present ? priceSetCostPaise.value : this.priceSetCostPaise,
        minStockMilli: minStockMilli ?? this.minStockMilli,
        notes: notes.present ? notes.value : this.notes,
        archived: archived ?? this.archived,
      );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      unit: data.unit.present ? data.unit.value : this.unit,
      category: data.category.present ? data.category.value : this.category,
      sku: data.sku.present ? data.sku.value : this.sku,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      retailPricePaise: data.retailPricePaise.present ? data.retailPricePaise.value : this.retailPricePaise,
      wholesalePricePaise: data.wholesalePricePaise.present ? data.wholesalePricePaise.value : this.wholesalePricePaise,
      priceSetCostPaise: data.priceSetCostPaise.present ? data.priceSetCostPaise.value : this.priceSetCostPaise,
      minStockMilli: data.minStockMilli.present ? data.minStockMilli.value : this.minStockMilli,
      notes: data.notes.present ? data.notes.value : this.notes,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('unit: $unit, ')
          ..write('category: $category, ')
          ..write('sku: $sku, ')
          ..write('photoPath: $photoPath, ')
          ..write('retailPricePaise: $retailPricePaise, ')
          ..write('wholesalePricePaise: $wholesalePricePaise, ')
          ..write('priceSetCostPaise: $priceSetCostPaise, ')
          ..write('minStockMilli: $minStockMilli, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, deletedAt, name, kind, unit, category, sku, photoPath,
      retailPricePaise, wholesalePricePaise, priceSetCostPaise, minStockMilli, notes, archived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.unit == this.unit &&
          other.category == this.category &&
          other.sku == this.sku &&
          other.photoPath == this.photoPath &&
          other.retailPricePaise == this.retailPricePaise &&
          other.wholesalePricePaise == this.wholesalePricePaise &&
          other.priceSetCostPaise == this.priceSetCostPaise &&
          other.minStockMilli == this.minStockMilli &&
          other.notes == this.notes &&
          other.archived == this.archived);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<ProductKind> kind;
  final Value<String> unit;
  final Value<String?> category;
  final Value<String?> sku;
  final Value<String?> photoPath;
  final Value<int?> retailPricePaise;
  final Value<int?> wholesalePricePaise;
  final Value<int?> priceSetCostPaise;
  final Value<int> minStockMilli;
  final Value<String?> notes;
  final Value<bool> archived;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.unit = const Value.absent(),
    this.category = const Value.absent(),
    this.sku = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.retailPricePaise = const Value.absent(),
    this.wholesalePricePaise = const Value.absent(),
    this.priceSetCostPaise = const Value.absent(),
    this.minStockMilli = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    required ProductKind kind,
    this.unit = const Value.absent(),
    this.category = const Value.absent(),
    this.sku = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.retailPricePaise = const Value.absent(),
    this.wholesalePricePaise = const Value.absent(),
    this.priceSetCostPaise = const Value.absent(),
    this.minStockMilli = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        kind = Value(kind);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? unit,
    Expression<String>? category,
    Expression<String>? sku,
    Expression<String>? photoPath,
    Expression<int>? retailPricePaise,
    Expression<int>? wholesalePricePaise,
    Expression<int>? priceSetCostPaise,
    Expression<int>? minStockMilli,
    Expression<String>? notes,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (unit != null) 'unit': unit,
      if (category != null) 'category': category,
      if (sku != null) 'sku': sku,
      if (photoPath != null) 'photo_path': photoPath,
      if (retailPricePaise != null) 'retail_price_paise': retailPricePaise,
      if (wholesalePricePaise != null) 'wholesale_price_paise': wholesalePricePaise,
      if (priceSetCostPaise != null) 'price_set_cost_paise': priceSetCostPaise,
      if (minStockMilli != null) 'min_stock_milli': minStockMilli,
      if (notes != null) 'notes': notes,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? name,
      Value<ProductKind>? kind,
      Value<String>? unit,
      Value<String?>? category,
      Value<String?>? sku,
      Value<String?>? photoPath,
      Value<int?>? retailPricePaise,
      Value<int?>? wholesalePricePaise,
      Value<int?>? priceSetCostPaise,
      Value<int>? minStockMilli,
      Value<String?>? notes,
      Value<bool>? archived,
      Value<int>? rowid}) {
    return ProductsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      sku: sku ?? this.sku,
      photoPath: photoPath ?? this.photoPath,
      retailPricePaise: retailPricePaise ?? this.retailPricePaise,
      wholesalePricePaise: wholesalePricePaise ?? this.wholesalePricePaise,
      priceSetCostPaise: priceSetCostPaise ?? this.priceSetCostPaise,
      minStockMilli: minStockMilli ?? this.minStockMilli,
      notes: notes ?? this.notes,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>($ProductsTable.$converterkind.toSql(kind.value));
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (retailPricePaise.present) {
      map['retail_price_paise'] = Variable<int>(retailPricePaise.value);
    }
    if (wholesalePricePaise.present) {
      map['wholesale_price_paise'] = Variable<int>(wholesalePricePaise.value);
    }
    if (priceSetCostPaise.present) {
      map['price_set_cost_paise'] = Variable<int>(priceSetCostPaise.value);
    }
    if (minStockMilli.present) {
      map['min_stock_milli'] = Variable<int>(minStockMilli.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('unit: $unit, ')
          ..write('category: $category, ')
          ..write('sku: $sku, ')
          ..write('photoPath: $photoPath, ')
          ..write('retailPricePaise: $retailPricePaise, ')
          ..write('wholesalePricePaise: $wholesalePricePaise, ')
          ..write('priceSetCostPaise: $priceSetCostPaise, ')
          ..write('minStockMilli: $minStockMilli, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BulkRulesTable extends BulkRules with TableInfo<$BulkRulesTable, BulkRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BulkRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>('product_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _minQtyMilliMeta = const VerificationMeta('minQtyMilli');
  @override
  late final GeneratedColumn<int> minQtyMilli =
      GeneratedColumn<int>('min_qty_milli', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _discountBpMeta = const VerificationMeta('discountBp');
  @override
  late final GeneratedColumn<int> discountBp =
      GeneratedColumn<int>('discount_bp', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _wholesaleOnlyMeta = const VerificationMeta('wholesaleOnly');
  @override
  late final GeneratedColumn<bool> wholesaleOnly = GeneratedColumn<bool>('wholesale_only', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("wholesale_only" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, deletedAt, productId, minQtyMilli, discountBp, wholesaleOnly];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bulk_rules';
  @override
  VerificationContext validateIntegrity(Insertable<BulkRule> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta, productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('min_qty_milli')) {
      context.handle(_minQtyMilliMeta, minQtyMilli.isAcceptableOrUnknown(data['min_qty_milli']!, _minQtyMilliMeta));
    } else if (isInserting) {
      context.missing(_minQtyMilliMeta);
    }
    if (data.containsKey('discount_bp')) {
      context.handle(_discountBpMeta, discountBp.isAcceptableOrUnknown(data['discount_bp']!, _discountBpMeta));
    } else if (isInserting) {
      context.missing(_discountBpMeta);
    }
    if (data.containsKey('wholesale_only')) {
      context.handle(
          _wholesaleOnlyMeta, wholesaleOnly.isAcceptableOrUnknown(data['wholesale_only']!, _wholesaleOnlyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BulkRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BulkRule(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      productId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}product_id']),
      minQtyMilli: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}min_qty_milli'])!,
      discountBp: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}discount_bp'])!,
      wholesaleOnly: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}wholesale_only'])!,
    );
  }

  @override
  $BulkRulesTable createAlias(String alias) {
    return $BulkRulesTable(attachedDatabase, alias);
  }
}

class BulkRule extends DataClass implements Insertable<BulkRule> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? productId;
  final int minQtyMilli;
  final int discountBp;
  final bool wholesaleOnly;
  const BulkRule(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.productId,
      required this.minQtyMilli,
      required this.discountBp,
      required this.wholesaleOnly});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['min_qty_milli'] = Variable<int>(minQtyMilli);
    map['discount_bp'] = Variable<int>(discountBp);
    map['wholesale_only'] = Variable<bool>(wholesaleOnly);
    return map;
  }

  BulkRulesCompanion toCompanion(bool nullToAbsent) {
    return BulkRulesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      productId: productId == null && nullToAbsent ? const Value.absent() : Value(productId),
      minQtyMilli: Value(minQtyMilli),
      discountBp: Value(discountBp),
      wholesaleOnly: Value(wholesaleOnly),
    );
  }

  factory BulkRule.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BulkRule(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      productId: serializer.fromJson<String?>(json['productId']),
      minQtyMilli: serializer.fromJson<int>(json['minQtyMilli']),
      discountBp: serializer.fromJson<int>(json['discountBp']),
      wholesaleOnly: serializer.fromJson<bool>(json['wholesaleOnly']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'productId': serializer.toJson<String?>(productId),
      'minQtyMilli': serializer.toJson<int>(minQtyMilli),
      'discountBp': serializer.toJson<int>(discountBp),
      'wholesaleOnly': serializer.toJson<bool>(wholesaleOnly),
    };
  }

  BulkRule copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          Value<String?> productId = const Value.absent(),
          int? minQtyMilli,
          int? discountBp,
          bool? wholesaleOnly}) =>
      BulkRule(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        productId: productId.present ? productId.value : this.productId,
        minQtyMilli: minQtyMilli ?? this.minQtyMilli,
        discountBp: discountBp ?? this.discountBp,
        wholesaleOnly: wholesaleOnly ?? this.wholesaleOnly,
      );
  BulkRule copyWithCompanion(BulkRulesCompanion data) {
    return BulkRule(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      productId: data.productId.present ? data.productId.value : this.productId,
      minQtyMilli: data.minQtyMilli.present ? data.minQtyMilli.value : this.minQtyMilli,
      discountBp: data.discountBp.present ? data.discountBp.value : this.discountBp,
      wholesaleOnly: data.wholesaleOnly.present ? data.wholesaleOnly.value : this.wholesaleOnly,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BulkRule(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('minQtyMilli: $minQtyMilli, ')
          ..write('discountBp: $discountBp, ')
          ..write('wholesaleOnly: $wholesaleOnly')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, deletedAt, productId, minQtyMilli, discountBp, wholesaleOnly);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BulkRule &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.productId == this.productId &&
          other.minQtyMilli == this.minQtyMilli &&
          other.discountBp == this.discountBp &&
          other.wholesaleOnly == this.wholesaleOnly);
}

class BulkRulesCompanion extends UpdateCompanion<BulkRule> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> productId;
  final Value<int> minQtyMilli;
  final Value<int> discountBp;
  final Value<bool> wholesaleOnly;
  final Value<int> rowid;
  const BulkRulesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.productId = const Value.absent(),
    this.minQtyMilli = const Value.absent(),
    this.discountBp = const Value.absent(),
    this.wholesaleOnly = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BulkRulesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.productId = const Value.absent(),
    required int minQtyMilli,
    required int discountBp,
    this.wholesaleOnly = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : minQtyMilli = Value(minQtyMilli),
        discountBp = Value(discountBp);
  static Insertable<BulkRule> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? productId,
    Expression<int>? minQtyMilli,
    Expression<int>? discountBp,
    Expression<bool>? wholesaleOnly,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (productId != null) 'product_id': productId,
      if (minQtyMilli != null) 'min_qty_milli': minQtyMilli,
      if (discountBp != null) 'discount_bp': discountBp,
      if (wholesaleOnly != null) 'wholesale_only': wholesaleOnly,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BulkRulesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String?>? productId,
      Value<int>? minQtyMilli,
      Value<int>? discountBp,
      Value<bool>? wholesaleOnly,
      Value<int>? rowid}) {
    return BulkRulesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      productId: productId ?? this.productId,
      minQtyMilli: minQtyMilli ?? this.minQtyMilli,
      discountBp: discountBp ?? this.discountBp,
      wholesaleOnly: wholesaleOnly ?? this.wholesaleOnly,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (minQtyMilli.present) {
      map['min_qty_milli'] = Variable<int>(minQtyMilli.value);
    }
    if (discountBp.present) {
      map['discount_bp'] = Variable<int>(discountBp.value);
    }
    if (wholesaleOnly.present) {
      map['wholesale_only'] = Variable<bool>(wholesaleOnly.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BulkRulesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('minQtyMilli: $minQtyMilli, ')
          ..write('discountBp: $discountBp, ')
          ..write('wholesaleOnly: $wholesaleOnly, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PartiesTable extends Parties with TableInfo<$PartiesTable, Party> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _businessNameMeta = const VerificationMeta('businessName');
  @override
  late final GeneratedColumn<String> businessName = GeneratedColumn<String>('business_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone =
      GeneratedColumn<String>('phone', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email =
      GeneratedColumn<String>('email', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta = const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address =
      GeneratedColumn<String>('address', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<PartyRole, String> role = GeneratedColumn<String>(
          'role', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: false, defaultValue: const Constant('customer'))
      .withConverter<PartyRole>($PartiesTable.$converterrole);
  @override
  late final GeneratedColumnWithTypeConverter<PriceType, String> priceType = GeneratedColumn<String>(
          'price_type', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: false, defaultValue: const Constant('retail'))
      .withConverter<PriceType>($PartiesTable.$converterpriceType);
  @override
  late final GeneratedColumnWithTypeConverter<SalesChannel?, String> defaultChannel = GeneratedColumn<String>(
          'default_channel', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false)
      .withConverter<SalesChannel?>($PartiesTable.$converterdefaultChanneln);
  static const VerificationMeta _creditLimitPaiseMeta = const VerificationMeta('creditLimitPaise');
  @override
  late final GeneratedColumn<int> creditLimitPaise = GeneratedColumn<int>('credit_limit_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _paymentTermsDaysMeta = const VerificationMeta('paymentTermsDays');
  @override
  late final GeneratedColumn<int> paymentTermsDays = GeneratedColumn<int>('payment_terms_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _openingBalancePaiseMeta = const VerificationMeta('openingBalancePaise');
  @override
  late final GeneratedColumn<int> openingBalancePaise = GeneratedColumn<int>(
      'opening_balance_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes =
      GeneratedColumn<String>('notes', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _archivedMeta = const VerificationMeta('archived');
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>('archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        name,
        businessName,
        phone,
        email,
        address,
        role,
        priceType,
        defaultChannel,
        creditLimitPaise,
        paymentTermsDays,
        openingBalancePaise,
        notes,
        archived
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parties';
  @override
  VerificationContext validateIntegrity(Insertable<Party> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('business_name')) {
      context.handle(_businessNameMeta, businessName.isAcceptableOrUnknown(data['business_name']!, _businessNameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(_phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(_emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta, address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('credit_limit_paise')) {
      context.handle(_creditLimitPaiseMeta,
          creditLimitPaise.isAcceptableOrUnknown(data['credit_limit_paise']!, _creditLimitPaiseMeta));
    }
    if (data.containsKey('payment_terms_days')) {
      context.handle(_paymentTermsDaysMeta,
          paymentTermsDays.isAcceptableOrUnknown(data['payment_terms_days']!, _paymentTermsDaysMeta));
    }
    if (data.containsKey('opening_balance_paise')) {
      context.handle(_openingBalancePaiseMeta,
          openingBalancePaise.isAcceptableOrUnknown(data['opening_balance_paise']!, _openingBalancePaiseMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(_notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('archived')) {
      context.handle(_archivedMeta, archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Party map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Party(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      businessName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}business_name']),
      phone: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}address']),
      role: $PartiesTable.$converterrole
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}role'])!),
      priceType: $PartiesTable.$converterpriceType
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}price_type'])!),
      defaultChannel: $PartiesTable.$converterdefaultChanneln
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}default_channel'])),
      creditLimitPaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}credit_limit_paise']),
      paymentTermsDays:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}payment_terms_days']),
      openingBalancePaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}opening_balance_paise'])!,
      notes: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}notes']),
      archived: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}archived'])!,
    );
  }

  @override
  $PartiesTable createAlias(String alias) {
    return $PartiesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PartyRole, String, String> $converterrole =
      const EnumNameConverter<PartyRole>(PartyRole.values);
  static JsonTypeConverter2<PriceType, String, String> $converterpriceType =
      const EnumNameConverter<PriceType>(PriceType.values);
  static JsonTypeConverter2<SalesChannel, String, String> $converterdefaultChannel =
      const EnumNameConverter<SalesChannel>(SalesChannel.values);
  static JsonTypeConverter2<SalesChannel?, String?, String?> $converterdefaultChanneln =
      JsonTypeConverter2.asNullable($converterdefaultChannel);
}

class Party extends DataClass implements Insertable<Party> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String name;
  final String? businessName;
  final String? phone;
  final String? email;
  final String? address;
  final PartyRole role;
  final PriceType priceType;
  final SalesChannel? defaultChannel;

  /// null = no limit.
  final int? creditLimitPaise;

  /// null = use the default from Settings for this price type.
  final int? paymentTermsDays;

  /// Owed at onboarding: positive = they owe her, negative = she owes them.
  final int openingBalancePaise;
  final String? notes;
  final bool archived;
  const Party(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.name,
      this.businessName,
      this.phone,
      this.email,
      this.address,
      required this.role,
      required this.priceType,
      this.defaultChannel,
      this.creditLimitPaise,
      this.paymentTermsDays,
      required this.openingBalancePaise,
      this.notes,
      required this.archived});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || businessName != null) {
      map['business_name'] = Variable<String>(businessName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    {
      map['role'] = Variable<String>($PartiesTable.$converterrole.toSql(role));
    }
    {
      map['price_type'] = Variable<String>($PartiesTable.$converterpriceType.toSql(priceType));
    }
    if (!nullToAbsent || defaultChannel != null) {
      map['default_channel'] = Variable<String>($PartiesTable.$converterdefaultChanneln.toSql(defaultChannel));
    }
    if (!nullToAbsent || creditLimitPaise != null) {
      map['credit_limit_paise'] = Variable<int>(creditLimitPaise);
    }
    if (!nullToAbsent || paymentTermsDays != null) {
      map['payment_terms_days'] = Variable<int>(paymentTermsDays);
    }
    map['opening_balance_paise'] = Variable<int>(openingBalancePaise);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  PartiesCompanion toCompanion(bool nullToAbsent) {
    return PartiesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      name: Value(name),
      businessName: businessName == null && nullToAbsent ? const Value.absent() : Value(businessName),
      phone: phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email: email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent ? const Value.absent() : Value(address),
      role: Value(role),
      priceType: Value(priceType),
      defaultChannel: defaultChannel == null && nullToAbsent ? const Value.absent() : Value(defaultChannel),
      creditLimitPaise: creditLimitPaise == null && nullToAbsent ? const Value.absent() : Value(creditLimitPaise),
      paymentTermsDays: paymentTermsDays == null && nullToAbsent ? const Value.absent() : Value(paymentTermsDays),
      openingBalancePaise: Value(openingBalancePaise),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      archived: Value(archived),
    );
  }

  factory Party.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Party(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      businessName: serializer.fromJson<String?>(json['businessName']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      role: $PartiesTable.$converterrole.fromJson(serializer.fromJson<String>(json['role'])),
      priceType: $PartiesTable.$converterpriceType.fromJson(serializer.fromJson<String>(json['priceType'])),
      defaultChannel:
          $PartiesTable.$converterdefaultChanneln.fromJson(serializer.fromJson<String?>(json['defaultChannel'])),
      creditLimitPaise: serializer.fromJson<int?>(json['creditLimitPaise']),
      paymentTermsDays: serializer.fromJson<int?>(json['paymentTermsDays']),
      openingBalancePaise: serializer.fromJson<int>(json['openingBalancePaise']),
      notes: serializer.fromJson<String?>(json['notes']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'businessName': serializer.toJson<String?>(businessName),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'role': serializer.toJson<String>($PartiesTable.$converterrole.toJson(role)),
      'priceType': serializer.toJson<String>($PartiesTable.$converterpriceType.toJson(priceType)),
      'defaultChannel': serializer.toJson<String?>($PartiesTable.$converterdefaultChanneln.toJson(defaultChannel)),
      'creditLimitPaise': serializer.toJson<int?>(creditLimitPaise),
      'paymentTermsDays': serializer.toJson<int?>(paymentTermsDays),
      'openingBalancePaise': serializer.toJson<int>(openingBalancePaise),
      'notes': serializer.toJson<String?>(notes),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  Party copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? name,
          Value<String?> businessName = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          PartyRole? role,
          PriceType? priceType,
          Value<SalesChannel?> defaultChannel = const Value.absent(),
          Value<int?> creditLimitPaise = const Value.absent(),
          Value<int?> paymentTermsDays = const Value.absent(),
          int? openingBalancePaise,
          Value<String?> notes = const Value.absent(),
          bool? archived}) =>
      Party(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        name: name ?? this.name,
        businessName: businessName.present ? businessName.value : this.businessName,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        role: role ?? this.role,
        priceType: priceType ?? this.priceType,
        defaultChannel: defaultChannel.present ? defaultChannel.value : this.defaultChannel,
        creditLimitPaise: creditLimitPaise.present ? creditLimitPaise.value : this.creditLimitPaise,
        paymentTermsDays: paymentTermsDays.present ? paymentTermsDays.value : this.paymentTermsDays,
        openingBalancePaise: openingBalancePaise ?? this.openingBalancePaise,
        notes: notes.present ? notes.value : this.notes,
        archived: archived ?? this.archived,
      );
  Party copyWithCompanion(PartiesCompanion data) {
    return Party(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      businessName: data.businessName.present ? data.businessName.value : this.businessName,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      role: data.role.present ? data.role.value : this.role,
      priceType: data.priceType.present ? data.priceType.value : this.priceType,
      defaultChannel: data.defaultChannel.present ? data.defaultChannel.value : this.defaultChannel,
      creditLimitPaise: data.creditLimitPaise.present ? data.creditLimitPaise.value : this.creditLimitPaise,
      paymentTermsDays: data.paymentTermsDays.present ? data.paymentTermsDays.value : this.paymentTermsDays,
      openingBalancePaise: data.openingBalancePaise.present ? data.openingBalancePaise.value : this.openingBalancePaise,
      notes: data.notes.present ? data.notes.value : this.notes,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Party(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('businessName: $businessName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('role: $role, ')
          ..write('priceType: $priceType, ')
          ..write('defaultChannel: $defaultChannel, ')
          ..write('creditLimitPaise: $creditLimitPaise, ')
          ..write('paymentTermsDays: $paymentTermsDays, ')
          ..write('openingBalancePaise: $openingBalancePaise, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, deletedAt, name, businessName, phone, email, address, role,
      priceType, defaultChannel, creditLimitPaise, paymentTermsDays, openingBalancePaise, notes, archived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Party &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.businessName == this.businessName &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.role == this.role &&
          other.priceType == this.priceType &&
          other.defaultChannel == this.defaultChannel &&
          other.creditLimitPaise == this.creditLimitPaise &&
          other.paymentTermsDays == this.paymentTermsDays &&
          other.openingBalancePaise == this.openingBalancePaise &&
          other.notes == this.notes &&
          other.archived == this.archived);
}

class PartiesCompanion extends UpdateCompanion<Party> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String?> businessName;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<PartyRole> role;
  final Value<PriceType> priceType;
  final Value<SalesChannel?> defaultChannel;
  final Value<int?> creditLimitPaise;
  final Value<int?> paymentTermsDays;
  final Value<int> openingBalancePaise;
  final Value<String?> notes;
  final Value<bool> archived;
  final Value<int> rowid;
  const PartiesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.businessName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.role = const Value.absent(),
    this.priceType = const Value.absent(),
    this.defaultChannel = const Value.absent(),
    this.creditLimitPaise = const Value.absent(),
    this.paymentTermsDays = const Value.absent(),
    this.openingBalancePaise = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PartiesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    this.businessName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.role = const Value.absent(),
    this.priceType = const Value.absent(),
    this.defaultChannel = const Value.absent(),
    this.creditLimitPaise = const Value.absent(),
    this.paymentTermsDays = const Value.absent(),
    this.openingBalancePaise = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Party> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? businessName,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? role,
    Expression<String>? priceType,
    Expression<String>? defaultChannel,
    Expression<int>? creditLimitPaise,
    Expression<int>? paymentTermsDays,
    Expression<int>? openingBalancePaise,
    Expression<String>? notes,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (businessName != null) 'business_name': businessName,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (role != null) 'role': role,
      if (priceType != null) 'price_type': priceType,
      if (defaultChannel != null) 'default_channel': defaultChannel,
      if (creditLimitPaise != null) 'credit_limit_paise': creditLimitPaise,
      if (paymentTermsDays != null) 'payment_terms_days': paymentTermsDays,
      if (openingBalancePaise != null) 'opening_balance_paise': openingBalancePaise,
      if (notes != null) 'notes': notes,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PartiesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? name,
      Value<String?>? businessName,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? address,
      Value<PartyRole>? role,
      Value<PriceType>? priceType,
      Value<SalesChannel?>? defaultChannel,
      Value<int?>? creditLimitPaise,
      Value<int?>? paymentTermsDays,
      Value<int>? openingBalancePaise,
      Value<String?>? notes,
      Value<bool>? archived,
      Value<int>? rowid}) {
    return PartiesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      businessName: businessName ?? this.businessName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      role: role ?? this.role,
      priceType: priceType ?? this.priceType,
      defaultChannel: defaultChannel ?? this.defaultChannel,
      creditLimitPaise: creditLimitPaise ?? this.creditLimitPaise,
      paymentTermsDays: paymentTermsDays ?? this.paymentTermsDays,
      openingBalancePaise: openingBalancePaise ?? this.openingBalancePaise,
      notes: notes ?? this.notes,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (businessName.present) {
      map['business_name'] = Variable<String>(businessName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (role.present) {
      map['role'] = Variable<String>($PartiesTable.$converterrole.toSql(role.value));
    }
    if (priceType.present) {
      map['price_type'] = Variable<String>($PartiesTable.$converterpriceType.toSql(priceType.value));
    }
    if (defaultChannel.present) {
      map['default_channel'] = Variable<String>($PartiesTable.$converterdefaultChanneln.toSql(defaultChannel.value));
    }
    if (creditLimitPaise.present) {
      map['credit_limit_paise'] = Variable<int>(creditLimitPaise.value);
    }
    if (paymentTermsDays.present) {
      map['payment_terms_days'] = Variable<int>(paymentTermsDays.value);
    }
    if (openingBalancePaise.present) {
      map['opening_balance_paise'] = Variable<int>(openingBalancePaise.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartiesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('businessName: $businessName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('role: $role, ')
          ..write('priceType: $priceType, ')
          ..write('defaultChannel: $defaultChannel, ')
          ..write('creditLimitPaise: $creditLimitPaise, ')
          ..write('paymentTermsDays: $paymentTermsDays, ')
          ..write('openingBalancePaise: $openingBalancePaise, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecipeLinesTable extends RecipeLines with TableInfo<$RecipeLinesTable, RecipeLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>('product_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _materialIdMeta = const VerificationMeta('materialId');
  @override
  late final GeneratedColumn<String> materialId = GeneratedColumn<String>('material_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _qtyMilliMeta = const VerificationMeta('qtyMilli');
  @override
  late final GeneratedColumn<int> qtyMilli =
      GeneratedColumn<int>('qty_milli', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, deletedAt, productId, materialId, qtyMilli];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_lines';
  @override
  VerificationContext validateIntegrity(Insertable<RecipeLine> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta, productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('material_id')) {
      context.handle(_materialIdMeta, materialId.isAcceptableOrUnknown(data['material_id']!, _materialIdMeta));
    } else if (isInserting) {
      context.missing(_materialIdMeta);
    }
    if (data.containsKey('qty_milli')) {
      context.handle(_qtyMilliMeta, qtyMilli.isAcceptableOrUnknown(data['qty_milli']!, _qtyMilliMeta));
    } else if (isInserting) {
      context.missing(_qtyMilliMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeLine(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      productId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      materialId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}material_id'])!,
      qtyMilli: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}qty_milli'])!,
    );
  }

  @override
  $RecipeLinesTable createAlias(String alias) {
    return $RecipeLinesTable(attachedDatabase, alias);
  }
}

class RecipeLine extends DataClass implements Insertable<RecipeLine> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String productId;
  final String materialId;
  final int qtyMilli;
  const RecipeLine(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.productId,
      required this.materialId,
      required this.qtyMilli});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['product_id'] = Variable<String>(productId);
    map['material_id'] = Variable<String>(materialId);
    map['qty_milli'] = Variable<int>(qtyMilli);
    return map;
  }

  RecipeLinesCompanion toCompanion(bool nullToAbsent) {
    return RecipeLinesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      productId: Value(productId),
      materialId: Value(materialId),
      qtyMilli: Value(qtyMilli),
    );
  }

  factory RecipeLine.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeLine(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      productId: serializer.fromJson<String>(json['productId']),
      materialId: serializer.fromJson<String>(json['materialId']),
      qtyMilli: serializer.fromJson<int>(json['qtyMilli']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'productId': serializer.toJson<String>(productId),
      'materialId': serializer.toJson<String>(materialId),
      'qtyMilli': serializer.toJson<int>(qtyMilli),
    };
  }

  RecipeLine copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? productId,
          String? materialId,
          int? qtyMilli}) =>
      RecipeLine(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        productId: productId ?? this.productId,
        materialId: materialId ?? this.materialId,
        qtyMilli: qtyMilli ?? this.qtyMilli,
      );
  RecipeLine copyWithCompanion(RecipeLinesCompanion data) {
    return RecipeLine(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      productId: data.productId.present ? data.productId.value : this.productId,
      materialId: data.materialId.present ? data.materialId.value : this.materialId,
      qtyMilli: data.qtyMilli.present ? data.qtyMilli.value : this.qtyMilli,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeLine(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('materialId: $materialId, ')
          ..write('qtyMilli: $qtyMilli')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, deletedAt, productId, materialId, qtyMilli);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeLine &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.productId == this.productId &&
          other.materialId == this.materialId &&
          other.qtyMilli == this.qtyMilli);
}

class RecipeLinesCompanion extends UpdateCompanion<RecipeLine> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> productId;
  final Value<String> materialId;
  final Value<int> qtyMilli;
  final Value<int> rowid;
  const RecipeLinesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.productId = const Value.absent(),
    this.materialId = const Value.absent(),
    this.qtyMilli = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipeLinesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String productId,
    required String materialId,
    required int qtyMilli,
    this.rowid = const Value.absent(),
  })  : productId = Value(productId),
        materialId = Value(materialId),
        qtyMilli = Value(qtyMilli);
  static Insertable<RecipeLine> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? productId,
    Expression<String>? materialId,
    Expression<int>? qtyMilli,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (productId != null) 'product_id': productId,
      if (materialId != null) 'material_id': materialId,
      if (qtyMilli != null) 'qty_milli': qtyMilli,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipeLinesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? productId,
      Value<String>? materialId,
      Value<int>? qtyMilli,
      Value<int>? rowid}) {
    return RecipeLinesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      productId: productId ?? this.productId,
      materialId: materialId ?? this.materialId,
      qtyMilli: qtyMilli ?? this.qtyMilli,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (materialId.present) {
      map['material_id'] = Variable<String>(materialId.value);
    }
    if (qtyMilli.present) {
      map['qty_milli'] = Variable<int>(qtyMilli.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeLinesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('materialId: $materialId, ')
          ..write('qtyMilli: $qtyMilli, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number =
      GeneratedColumn<String>('number', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _partyIdMeta = const VerificationMeta('partyId');
  @override
  late final GeneratedColumn<String> partyId = GeneratedColumn<String>('party_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES parties (id)'));
  static const VerificationMeta _orderDateMeta = const VerificationMeta('orderDate');
  @override
  late final GeneratedColumn<DateTime> orderDate = GeneratedColumn<DateTime>('order_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<OrderStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<OrderStatus>($OrdersTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<SalesChannel?, String> channel =
      GeneratedColumn<String>('channel', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<SalesChannel?>($OrdersTable.$converterchanneln);
  static const VerificationMeta _promisedDateMeta = const VerificationMeta('promisedDate');
  @override
  late final GeneratedColumn<DateTime> promisedDate = GeneratedColumn<DateTime>('promised_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deliveredAtMeta = const VerificationMeta('deliveredAt');
  @override
  late final GeneratedColumn<DateTime> deliveredAt = GeneratedColumn<DateTime>('delivered_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>('due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deliveryChargePaiseMeta = const VerificationMeta('deliveryChargePaise');
  @override
  late final GeneratedColumn<int> deliveryChargePaise = GeneratedColumn<int>(
      'delivery_charge_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
  static const VerificationMeta _orderDiscountPaiseMeta = const VerificationMeta('orderDiscountPaise');
  @override
  late final GeneratedColumn<int> orderDiscountPaise = GeneratedColumn<int>('order_discount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
  static const VerificationMeta _discountReasonMeta = const VerificationMeta('discountReason');
  @override
  late final GeneratedColumn<String> discountReason = GeneratedColumn<String>('discount_reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes =
      GeneratedColumn<String>('notes', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        number,
        partyId,
        orderDate,
        status,
        channel,
        promisedDate,
        deliveredAt,
        dueDate,
        deliveryChargePaise,
        orderDiscountPaise,
        discountReason,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta, number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('party_id')) {
      context.handle(_partyIdMeta, partyId.isAcceptableOrUnknown(data['party_id']!, _partyIdMeta));
    } else if (isInserting) {
      context.missing(_partyIdMeta);
    }
    if (data.containsKey('order_date')) {
      context.handle(_orderDateMeta, orderDate.isAcceptableOrUnknown(data['order_date']!, _orderDateMeta));
    } else if (isInserting) {
      context.missing(_orderDateMeta);
    }
    if (data.containsKey('promised_date')) {
      context.handle(_promisedDateMeta, promisedDate.isAcceptableOrUnknown(data['promised_date']!, _promisedDateMeta));
    }
    if (data.containsKey('delivered_at')) {
      context.handle(_deliveredAtMeta, deliveredAt.isAcceptableOrUnknown(data['delivered_at']!, _deliveredAtMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta, dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('delivery_charge_paise')) {
      context.handle(_deliveryChargePaiseMeta,
          deliveryChargePaise.isAcceptableOrUnknown(data['delivery_charge_paise']!, _deliveryChargePaiseMeta));
    }
    if (data.containsKey('order_discount_paise')) {
      context.handle(_orderDiscountPaiseMeta,
          orderDiscountPaise.isAcceptableOrUnknown(data['order_discount_paise']!, _orderDiscountPaiseMeta));
    }
    if (data.containsKey('discount_reason')) {
      context.handle(
          _discountReasonMeta, discountReason.isAcceptableOrUnknown(data['discount_reason']!, _discountReasonMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(_notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      number: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      partyId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}party_id'])!,
      orderDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}order_date'])!,
      status: $OrdersTable.$converterstatus
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      channel: $OrdersTable.$converterchanneln
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}channel'])),
      promisedDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}promised_date']),
      deliveredAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}delivered_at']),
      dueDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      deliveryChargePaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}delivery_charge_paise'])!,
      orderDiscountPaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}order_discount_paise'])!,
      discountReason: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}discount_reason']),
      notes: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OrderStatus, String, String> $converterstatus =
      const EnumNameConverter<OrderStatus>(OrderStatus.values);
  static JsonTypeConverter2<SalesChannel, String, String> $converterchannel =
      const EnumNameConverter<SalesChannel>(SalesChannel.values);
  static JsonTypeConverter2<SalesChannel?, String?, String?> $converterchanneln =
      JsonTypeConverter2.asNullable($converterchannel);
}

class Order extends DataClass implements Insertable<Order> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String number;
  final String partyId;
  final DateTime orderDate;
  final OrderStatus status;
  final SalesChannel? channel;
  final DateTime? promisedDate;
  final DateTime? deliveredAt;
  final DateTime? dueDate;
  final int deliveryChargePaise;
  final int orderDiscountPaise;
  final String? discountReason;
  final String? notes;
  const Order(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.number,
      required this.partyId,
      required this.orderDate,
      required this.status,
      this.channel,
      this.promisedDate,
      this.deliveredAt,
      this.dueDate,
      required this.deliveryChargePaise,
      required this.orderDiscountPaise,
      this.discountReason,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['number'] = Variable<String>(number);
    map['party_id'] = Variable<String>(partyId);
    map['order_date'] = Variable<DateTime>(orderDate);
    {
      map['status'] = Variable<String>($OrdersTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || channel != null) {
      map['channel'] = Variable<String>($OrdersTable.$converterchanneln.toSql(channel));
    }
    if (!nullToAbsent || promisedDate != null) {
      map['promised_date'] = Variable<DateTime>(promisedDate);
    }
    if (!nullToAbsent || deliveredAt != null) {
      map['delivered_at'] = Variable<DateTime>(deliveredAt);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['delivery_charge_paise'] = Variable<int>(deliveryChargePaise);
    map['order_discount_paise'] = Variable<int>(orderDiscountPaise);
    if (!nullToAbsent || discountReason != null) {
      map['discount_reason'] = Variable<String>(discountReason);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      number: Value(number),
      partyId: Value(partyId),
      orderDate: Value(orderDate),
      status: Value(status),
      channel: channel == null && nullToAbsent ? const Value.absent() : Value(channel),
      promisedDate: promisedDate == null && nullToAbsent ? const Value.absent() : Value(promisedDate),
      deliveredAt: deliveredAt == null && nullToAbsent ? const Value.absent() : Value(deliveredAt),
      dueDate: dueDate == null && nullToAbsent ? const Value.absent() : Value(dueDate),
      deliveryChargePaise: Value(deliveryChargePaise),
      orderDiscountPaise: Value(orderDiscountPaise),
      discountReason: discountReason == null && nullToAbsent ? const Value.absent() : Value(discountReason),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      number: serializer.fromJson<String>(json['number']),
      partyId: serializer.fromJson<String>(json['partyId']),
      orderDate: serializer.fromJson<DateTime>(json['orderDate']),
      status: $OrdersTable.$converterstatus.fromJson(serializer.fromJson<String>(json['status'])),
      channel: $OrdersTable.$converterchanneln.fromJson(serializer.fromJson<String?>(json['channel'])),
      promisedDate: serializer.fromJson<DateTime?>(json['promisedDate']),
      deliveredAt: serializer.fromJson<DateTime?>(json['deliveredAt']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      deliveryChargePaise: serializer.fromJson<int>(json['deliveryChargePaise']),
      orderDiscountPaise: serializer.fromJson<int>(json['orderDiscountPaise']),
      discountReason: serializer.fromJson<String?>(json['discountReason']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'number': serializer.toJson<String>(number),
      'partyId': serializer.toJson<String>(partyId),
      'orderDate': serializer.toJson<DateTime>(orderDate),
      'status': serializer.toJson<String>($OrdersTable.$converterstatus.toJson(status)),
      'channel': serializer.toJson<String?>($OrdersTable.$converterchanneln.toJson(channel)),
      'promisedDate': serializer.toJson<DateTime?>(promisedDate),
      'deliveredAt': serializer.toJson<DateTime?>(deliveredAt),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'deliveryChargePaise': serializer.toJson<int>(deliveryChargePaise),
      'orderDiscountPaise': serializer.toJson<int>(orderDiscountPaise),
      'discountReason': serializer.toJson<String?>(discountReason),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Order copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? number,
          String? partyId,
          DateTime? orderDate,
          OrderStatus? status,
          Value<SalesChannel?> channel = const Value.absent(),
          Value<DateTime?> promisedDate = const Value.absent(),
          Value<DateTime?> deliveredAt = const Value.absent(),
          Value<DateTime?> dueDate = const Value.absent(),
          int? deliveryChargePaise,
          int? orderDiscountPaise,
          Value<String?> discountReason = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      Order(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        number: number ?? this.number,
        partyId: partyId ?? this.partyId,
        orderDate: orderDate ?? this.orderDate,
        status: status ?? this.status,
        channel: channel.present ? channel.value : this.channel,
        promisedDate: promisedDate.present ? promisedDate.value : this.promisedDate,
        deliveredAt: deliveredAt.present ? deliveredAt.value : this.deliveredAt,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        deliveryChargePaise: deliveryChargePaise ?? this.deliveryChargePaise,
        orderDiscountPaise: orderDiscountPaise ?? this.orderDiscountPaise,
        discountReason: discountReason.present ? discountReason.value : this.discountReason,
        notes: notes.present ? notes.value : this.notes,
      );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      number: data.number.present ? data.number.value : this.number,
      partyId: data.partyId.present ? data.partyId.value : this.partyId,
      orderDate: data.orderDate.present ? data.orderDate.value : this.orderDate,
      status: data.status.present ? data.status.value : this.status,
      channel: data.channel.present ? data.channel.value : this.channel,
      promisedDate: data.promisedDate.present ? data.promisedDate.value : this.promisedDate,
      deliveredAt: data.deliveredAt.present ? data.deliveredAt.value : this.deliveredAt,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      deliveryChargePaise: data.deliveryChargePaise.present ? data.deliveryChargePaise.value : this.deliveryChargePaise,
      orderDiscountPaise: data.orderDiscountPaise.present ? data.orderDiscountPaise.value : this.orderDiscountPaise,
      discountReason: data.discountReason.present ? data.discountReason.value : this.discountReason,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('number: $number, ')
          ..write('partyId: $partyId, ')
          ..write('orderDate: $orderDate, ')
          ..write('status: $status, ')
          ..write('channel: $channel, ')
          ..write('promisedDate: $promisedDate, ')
          ..write('deliveredAt: $deliveredAt, ')
          ..write('dueDate: $dueDate, ')
          ..write('deliveryChargePaise: $deliveryChargePaise, ')
          ..write('orderDiscountPaise: $orderDiscountPaise, ')
          ..write('discountReason: $discountReason, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, deletedAt, number, partyId, orderDate, status, channel,
      promisedDate, deliveredAt, dueDate, deliveryChargePaise, orderDiscountPaise, discountReason, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.number == this.number &&
          other.partyId == this.partyId &&
          other.orderDate == this.orderDate &&
          other.status == this.status &&
          other.channel == this.channel &&
          other.promisedDate == this.promisedDate &&
          other.deliveredAt == this.deliveredAt &&
          other.dueDate == this.dueDate &&
          other.deliveryChargePaise == this.deliveryChargePaise &&
          other.orderDiscountPaise == this.orderDiscountPaise &&
          other.discountReason == this.discountReason &&
          other.notes == this.notes);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> number;
  final Value<String> partyId;
  final Value<DateTime> orderDate;
  final Value<OrderStatus> status;
  final Value<SalesChannel?> channel;
  final Value<DateTime?> promisedDate;
  final Value<DateTime?> deliveredAt;
  final Value<DateTime?> dueDate;
  final Value<int> deliveryChargePaise;
  final Value<int> orderDiscountPaise;
  final Value<String?> discountReason;
  final Value<String?> notes;
  final Value<int> rowid;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.number = const Value.absent(),
    this.partyId = const Value.absent(),
    this.orderDate = const Value.absent(),
    this.status = const Value.absent(),
    this.channel = const Value.absent(),
    this.promisedDate = const Value.absent(),
    this.deliveredAt = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.deliveryChargePaise = const Value.absent(),
    this.orderDiscountPaise = const Value.absent(),
    this.discountReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String number,
    required String partyId,
    required DateTime orderDate,
    required OrderStatus status,
    this.channel = const Value.absent(),
    this.promisedDate = const Value.absent(),
    this.deliveredAt = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.deliveryChargePaise = const Value.absent(),
    this.orderDiscountPaise = const Value.absent(),
    this.discountReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : number = Value(number),
        partyId = Value(partyId),
        orderDate = Value(orderDate),
        status = Value(status);
  static Insertable<Order> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? number,
    Expression<String>? partyId,
    Expression<DateTime>? orderDate,
    Expression<String>? status,
    Expression<String>? channel,
    Expression<DateTime>? promisedDate,
    Expression<DateTime>? deliveredAt,
    Expression<DateTime>? dueDate,
    Expression<int>? deliveryChargePaise,
    Expression<int>? orderDiscountPaise,
    Expression<String>? discountReason,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (number != null) 'number': number,
      if (partyId != null) 'party_id': partyId,
      if (orderDate != null) 'order_date': orderDate,
      if (status != null) 'status': status,
      if (channel != null) 'channel': channel,
      if (promisedDate != null) 'promised_date': promisedDate,
      if (deliveredAt != null) 'delivered_at': deliveredAt,
      if (dueDate != null) 'due_date': dueDate,
      if (deliveryChargePaise != null) 'delivery_charge_paise': deliveryChargePaise,
      if (orderDiscountPaise != null) 'order_discount_paise': orderDiscountPaise,
      if (discountReason != null) 'discount_reason': discountReason,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? number,
      Value<String>? partyId,
      Value<DateTime>? orderDate,
      Value<OrderStatus>? status,
      Value<SalesChannel?>? channel,
      Value<DateTime?>? promisedDate,
      Value<DateTime?>? deliveredAt,
      Value<DateTime?>? dueDate,
      Value<int>? deliveryChargePaise,
      Value<int>? orderDiscountPaise,
      Value<String?>? discountReason,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return OrdersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      number: number ?? this.number,
      partyId: partyId ?? this.partyId,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      channel: channel ?? this.channel,
      promisedDate: promisedDate ?? this.promisedDate,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      dueDate: dueDate ?? this.dueDate,
      deliveryChargePaise: deliveryChargePaise ?? this.deliveryChargePaise,
      orderDiscountPaise: orderDiscountPaise ?? this.orderDiscountPaise,
      discountReason: discountReason ?? this.discountReason,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (partyId.present) {
      map['party_id'] = Variable<String>(partyId.value);
    }
    if (orderDate.present) {
      map['order_date'] = Variable<DateTime>(orderDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>($OrdersTable.$converterstatus.toSql(status.value));
    }
    if (channel.present) {
      map['channel'] = Variable<String>($OrdersTable.$converterchanneln.toSql(channel.value));
    }
    if (promisedDate.present) {
      map['promised_date'] = Variable<DateTime>(promisedDate.value);
    }
    if (deliveredAt.present) {
      map['delivered_at'] = Variable<DateTime>(deliveredAt.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (deliveryChargePaise.present) {
      map['delivery_charge_paise'] = Variable<int>(deliveryChargePaise.value);
    }
    if (orderDiscountPaise.present) {
      map['order_discount_paise'] = Variable<int>(orderDiscountPaise.value);
    }
    if (discountReason.present) {
      map['discount_reason'] = Variable<String>(discountReason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('number: $number, ')
          ..write('partyId: $partyId, ')
          ..write('orderDate: $orderDate, ')
          ..write('status: $status, ')
          ..write('channel: $channel, ')
          ..write('promisedDate: $promisedDate, ')
          ..write('deliveredAt: $deliveredAt, ')
          ..write('dueDate: $dueDate, ')
          ..write('deliveryChargePaise: $deliveryChargePaise, ')
          ..write('orderDiscountPaise: $orderDiscountPaise, ')
          ..write('discountReason: $discountReason, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductionRunsTable extends ProductionRuns with TableInfo<$ProductionRunsTable, ProductionRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductionRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>('product_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _qtyMilliMeta = const VerificationMeta('qtyMilli');
  @override
  late final GeneratedColumn<int> qtyMilli =
      GeneratedColumn<int>('qty_milli', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _madeOnMeta = const VerificationMeta('madeOn');
  @override
  late final GeneratedColumn<DateTime> madeOn =
      GeneratedColumn<DateTime>('made_on', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _batchMinutesMeta = const VerificationMeta('batchMinutes');
  @override
  late final GeneratedColumn<int> batchMinutes = GeneratedColumn<int>('batch_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
  static const VerificationMeta _materialCostPaiseMeta = const VerificationMeta('materialCostPaise');
  @override
  late final GeneratedColumn<int> materialCostPaise = GeneratedColumn<int>('material_cost_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _labourCostPaiseMeta = const VerificationMeta('labourCostPaise');
  @override
  late final GeneratedColumn<int> labourCostPaise =
      GeneratedColumn<int>('labour_cost_paise', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _overheadCostPaiseMeta = const VerificationMeta('overheadCostPaise');
  @override
  late final GeneratedColumn<int> overheadCostPaise = GeneratedColumn<int>('overhead_cost_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note =
      GeneratedColumn<String>('note', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        productId,
        qtyMilli,
        madeOn,
        batchMinutes,
        materialCostPaise,
        labourCostPaise,
        overheadCostPaise,
        note
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'production_runs';
  @override
  VerificationContext validateIntegrity(Insertable<ProductionRun> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta, productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty_milli')) {
      context.handle(_qtyMilliMeta, qtyMilli.isAcceptableOrUnknown(data['qty_milli']!, _qtyMilliMeta));
    } else if (isInserting) {
      context.missing(_qtyMilliMeta);
    }
    if (data.containsKey('made_on')) {
      context.handle(_madeOnMeta, madeOn.isAcceptableOrUnknown(data['made_on']!, _madeOnMeta));
    } else if (isInserting) {
      context.missing(_madeOnMeta);
    }
    if (data.containsKey('batch_minutes')) {
      context.handle(_batchMinutesMeta, batchMinutes.isAcceptableOrUnknown(data['batch_minutes']!, _batchMinutesMeta));
    }
    if (data.containsKey('material_cost_paise')) {
      context.handle(_materialCostPaiseMeta,
          materialCostPaise.isAcceptableOrUnknown(data['material_cost_paise']!, _materialCostPaiseMeta));
    } else if (isInserting) {
      context.missing(_materialCostPaiseMeta);
    }
    if (data.containsKey('labour_cost_paise')) {
      context.handle(_labourCostPaiseMeta,
          labourCostPaise.isAcceptableOrUnknown(data['labour_cost_paise']!, _labourCostPaiseMeta));
    } else if (isInserting) {
      context.missing(_labourCostPaiseMeta);
    }
    if (data.containsKey('overhead_cost_paise')) {
      context.handle(_overheadCostPaiseMeta,
          overheadCostPaise.isAcceptableOrUnknown(data['overhead_cost_paise']!, _overheadCostPaiseMeta));
    } else if (isInserting) {
      context.missing(_overheadCostPaiseMeta);
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductionRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductionRun(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      productId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      qtyMilli: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}qty_milli'])!,
      madeOn: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}made_on'])!,
      batchMinutes: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}batch_minutes'])!,
      materialCostPaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}material_cost_paise'])!,
      labourCostPaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}labour_cost_paise'])!,
      overheadCostPaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}overhead_cost_paise'])!,
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $ProductionRunsTable createAlias(String alias) {
    return $ProductionRunsTable(attachedDatabase, alias);
  }
}

class ProductionRun extends DataClass implements Insertable<ProductionRun> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String productId;
  final int qtyMilli;
  final DateTime madeOn;
  final int batchMinutes;
  final int materialCostPaise;
  final int labourCostPaise;
  final int overheadCostPaise;
  final String? note;
  const ProductionRun(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.productId,
      required this.qtyMilli,
      required this.madeOn,
      required this.batchMinutes,
      required this.materialCostPaise,
      required this.labourCostPaise,
      required this.overheadCostPaise,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['product_id'] = Variable<String>(productId);
    map['qty_milli'] = Variable<int>(qtyMilli);
    map['made_on'] = Variable<DateTime>(madeOn);
    map['batch_minutes'] = Variable<int>(batchMinutes);
    map['material_cost_paise'] = Variable<int>(materialCostPaise);
    map['labour_cost_paise'] = Variable<int>(labourCostPaise);
    map['overhead_cost_paise'] = Variable<int>(overheadCostPaise);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  ProductionRunsCompanion toCompanion(bool nullToAbsent) {
    return ProductionRunsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      productId: Value(productId),
      qtyMilli: Value(qtyMilli),
      madeOn: Value(madeOn),
      batchMinutes: Value(batchMinutes),
      materialCostPaise: Value(materialCostPaise),
      labourCostPaise: Value(labourCostPaise),
      overheadCostPaise: Value(overheadCostPaise),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory ProductionRun.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductionRun(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      productId: serializer.fromJson<String>(json['productId']),
      qtyMilli: serializer.fromJson<int>(json['qtyMilli']),
      madeOn: serializer.fromJson<DateTime>(json['madeOn']),
      batchMinutes: serializer.fromJson<int>(json['batchMinutes']),
      materialCostPaise: serializer.fromJson<int>(json['materialCostPaise']),
      labourCostPaise: serializer.fromJson<int>(json['labourCostPaise']),
      overheadCostPaise: serializer.fromJson<int>(json['overheadCostPaise']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'productId': serializer.toJson<String>(productId),
      'qtyMilli': serializer.toJson<int>(qtyMilli),
      'madeOn': serializer.toJson<DateTime>(madeOn),
      'batchMinutes': serializer.toJson<int>(batchMinutes),
      'materialCostPaise': serializer.toJson<int>(materialCostPaise),
      'labourCostPaise': serializer.toJson<int>(labourCostPaise),
      'overheadCostPaise': serializer.toJson<int>(overheadCostPaise),
      'note': serializer.toJson<String?>(note),
    };
  }

  ProductionRun copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? productId,
          int? qtyMilli,
          DateTime? madeOn,
          int? batchMinutes,
          int? materialCostPaise,
          int? labourCostPaise,
          int? overheadCostPaise,
          Value<String?> note = const Value.absent()}) =>
      ProductionRun(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        productId: productId ?? this.productId,
        qtyMilli: qtyMilli ?? this.qtyMilli,
        madeOn: madeOn ?? this.madeOn,
        batchMinutes: batchMinutes ?? this.batchMinutes,
        materialCostPaise: materialCostPaise ?? this.materialCostPaise,
        labourCostPaise: labourCostPaise ?? this.labourCostPaise,
        overheadCostPaise: overheadCostPaise ?? this.overheadCostPaise,
        note: note.present ? note.value : this.note,
      );
  ProductionRun copyWithCompanion(ProductionRunsCompanion data) {
    return ProductionRun(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      productId: data.productId.present ? data.productId.value : this.productId,
      qtyMilli: data.qtyMilli.present ? data.qtyMilli.value : this.qtyMilli,
      madeOn: data.madeOn.present ? data.madeOn.value : this.madeOn,
      batchMinutes: data.batchMinutes.present ? data.batchMinutes.value : this.batchMinutes,
      materialCostPaise: data.materialCostPaise.present ? data.materialCostPaise.value : this.materialCostPaise,
      labourCostPaise: data.labourCostPaise.present ? data.labourCostPaise.value : this.labourCostPaise,
      overheadCostPaise: data.overheadCostPaise.present ? data.overheadCostPaise.value : this.overheadCostPaise,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductionRun(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('qtyMilli: $qtyMilli, ')
          ..write('madeOn: $madeOn, ')
          ..write('batchMinutes: $batchMinutes, ')
          ..write('materialCostPaise: $materialCostPaise, ')
          ..write('labourCostPaise: $labourCostPaise, ')
          ..write('overheadCostPaise: $overheadCostPaise, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, deletedAt, productId, qtyMilli, madeOn, batchMinutes,
      materialCostPaise, labourCostPaise, overheadCostPaise, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductionRun &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.productId == this.productId &&
          other.qtyMilli == this.qtyMilli &&
          other.madeOn == this.madeOn &&
          other.batchMinutes == this.batchMinutes &&
          other.materialCostPaise == this.materialCostPaise &&
          other.labourCostPaise == this.labourCostPaise &&
          other.overheadCostPaise == this.overheadCostPaise &&
          other.note == this.note);
}

class ProductionRunsCompanion extends UpdateCompanion<ProductionRun> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> productId;
  final Value<int> qtyMilli;
  final Value<DateTime> madeOn;
  final Value<int> batchMinutes;
  final Value<int> materialCostPaise;
  final Value<int> labourCostPaise;
  final Value<int> overheadCostPaise;
  final Value<String?> note;
  final Value<int> rowid;
  const ProductionRunsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.productId = const Value.absent(),
    this.qtyMilli = const Value.absent(),
    this.madeOn = const Value.absent(),
    this.batchMinutes = const Value.absent(),
    this.materialCostPaise = const Value.absent(),
    this.labourCostPaise = const Value.absent(),
    this.overheadCostPaise = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductionRunsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String productId,
    required int qtyMilli,
    required DateTime madeOn,
    this.batchMinutes = const Value.absent(),
    required int materialCostPaise,
    required int labourCostPaise,
    required int overheadCostPaise,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : productId = Value(productId),
        qtyMilli = Value(qtyMilli),
        madeOn = Value(madeOn),
        materialCostPaise = Value(materialCostPaise),
        labourCostPaise = Value(labourCostPaise),
        overheadCostPaise = Value(overheadCostPaise);
  static Insertable<ProductionRun> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? productId,
    Expression<int>? qtyMilli,
    Expression<DateTime>? madeOn,
    Expression<int>? batchMinutes,
    Expression<int>? materialCostPaise,
    Expression<int>? labourCostPaise,
    Expression<int>? overheadCostPaise,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (productId != null) 'product_id': productId,
      if (qtyMilli != null) 'qty_milli': qtyMilli,
      if (madeOn != null) 'made_on': madeOn,
      if (batchMinutes != null) 'batch_minutes': batchMinutes,
      if (materialCostPaise != null) 'material_cost_paise': materialCostPaise,
      if (labourCostPaise != null) 'labour_cost_paise': labourCostPaise,
      if (overheadCostPaise != null) 'overhead_cost_paise': overheadCostPaise,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductionRunsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? productId,
      Value<int>? qtyMilli,
      Value<DateTime>? madeOn,
      Value<int>? batchMinutes,
      Value<int>? materialCostPaise,
      Value<int>? labourCostPaise,
      Value<int>? overheadCostPaise,
      Value<String?>? note,
      Value<int>? rowid}) {
    return ProductionRunsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      productId: productId ?? this.productId,
      qtyMilli: qtyMilli ?? this.qtyMilli,
      madeOn: madeOn ?? this.madeOn,
      batchMinutes: batchMinutes ?? this.batchMinutes,
      materialCostPaise: materialCostPaise ?? this.materialCostPaise,
      labourCostPaise: labourCostPaise ?? this.labourCostPaise,
      overheadCostPaise: overheadCostPaise ?? this.overheadCostPaise,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (qtyMilli.present) {
      map['qty_milli'] = Variable<int>(qtyMilli.value);
    }
    if (madeOn.present) {
      map['made_on'] = Variable<DateTime>(madeOn.value);
    }
    if (batchMinutes.present) {
      map['batch_minutes'] = Variable<int>(batchMinutes.value);
    }
    if (materialCostPaise.present) {
      map['material_cost_paise'] = Variable<int>(materialCostPaise.value);
    }
    if (labourCostPaise.present) {
      map['labour_cost_paise'] = Variable<int>(labourCostPaise.value);
    }
    if (overheadCostPaise.present) {
      map['overhead_cost_paise'] = Variable<int>(overheadCostPaise.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductionRunsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('qtyMilli: $qtyMilli, ')
          ..write('madeOn: $madeOn, ')
          ..write('batchMinutes: $batchMinutes, ')
          ..write('materialCostPaise: $materialCostPaise, ')
          ..write('labourCostPaise: $labourCostPaise, ')
          ..write('overheadCostPaise: $overheadCostPaise, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockMovesTable extends StockMoves with TableInfo<$StockMovesTable, StockMove> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>('product_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _qtyMilliMeta = const VerificationMeta('qtyMilli');
  @override
  late final GeneratedColumn<int> qtyMilli =
      GeneratedColumn<int>('qty_milli', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<StockMoveType, String> type =
      GeneratedColumn<String>('type', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<StockMoveType>($StockMovesTable.$convertertype);
  static const VerificationMeta _valuePaiseMeta = const VerificationMeta('valuePaise');
  @override
  late final GeneratedColumn<int> valuePaise = GeneratedColumn<int>('value_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
  static const VerificationMeta _movedAtMeta = const VerificationMeta('movedAt');
  @override
  late final GeneratedColumn<DateTime> movedAt = GeneratedColumn<DateTime>('moved_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>('order_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'));
  static const VerificationMeta _productionRunIdMeta = const VerificationMeta('productionRunId');
  @override
  late final GeneratedColumn<String> productionRunId = GeneratedColumn<String>('production_run_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES production_runs (id)'));
  static const VerificationMeta _supplierIdMeta = const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>('supplier_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES parties (id)'));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note =
      GeneratedColumn<String>('note', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        productId,
        qtyMilli,
        type,
        valuePaise,
        movedAt,
        orderId,
        productionRunId,
        supplierId,
        note
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_moves';
  @override
  VerificationContext validateIntegrity(Insertable<StockMove> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta, productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty_milli')) {
      context.handle(_qtyMilliMeta, qtyMilli.isAcceptableOrUnknown(data['qty_milli']!, _qtyMilliMeta));
    } else if (isInserting) {
      context.missing(_qtyMilliMeta);
    }
    if (data.containsKey('value_paise')) {
      context.handle(_valuePaiseMeta, valuePaise.isAcceptableOrUnknown(data['value_paise']!, _valuePaiseMeta));
    }
    if (data.containsKey('moved_at')) {
      context.handle(_movedAtMeta, movedAt.isAcceptableOrUnknown(data['moved_at']!, _movedAtMeta));
    } else if (isInserting) {
      context.missing(_movedAtMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta, orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('production_run_id')) {
      context.handle(_productionRunIdMeta,
          productionRunId.isAcceptableOrUnknown(data['production_run_id']!, _productionRunIdMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(_supplierIdMeta, supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMove map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMove(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      productId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      qtyMilli: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}qty_milli'])!,
      type: $StockMovesTable.$convertertype
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      valuePaise: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}value_paise'])!,
      movedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}moved_at'])!,
      orderId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}order_id']),
      productionRunId:
          attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}production_run_id']),
      supplierId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}supplier_id']),
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $StockMovesTable createAlias(String alias) {
    return $StockMovesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StockMoveType, String, String> $convertertype =
      const EnumNameConverter<StockMoveType>(StockMoveType.values);
}

class StockMove extends DataClass implements Insertable<StockMove> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String productId;
  final int qtyMilli;
  final StockMoveType type;
  final int valuePaise;
  final DateTime movedAt;
  final String? orderId;
  final String? productionRunId;
  final String? supplierId;
  final String? note;
  const StockMove(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.productId,
      required this.qtyMilli,
      required this.type,
      required this.valuePaise,
      required this.movedAt,
      this.orderId,
      this.productionRunId,
      this.supplierId,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['product_id'] = Variable<String>(productId);
    map['qty_milli'] = Variable<int>(qtyMilli);
    {
      map['type'] = Variable<String>($StockMovesTable.$convertertype.toSql(type));
    }
    map['value_paise'] = Variable<int>(valuePaise);
    map['moved_at'] = Variable<DateTime>(movedAt);
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<String>(orderId);
    }
    if (!nullToAbsent || productionRunId != null) {
      map['production_run_id'] = Variable<String>(productionRunId);
    }
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<String>(supplierId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  StockMovesCompanion toCompanion(bool nullToAbsent) {
    return StockMovesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      productId: Value(productId),
      qtyMilli: Value(qtyMilli),
      type: Value(type),
      valuePaise: Value(valuePaise),
      movedAt: Value(movedAt),
      orderId: orderId == null && nullToAbsent ? const Value.absent() : Value(orderId),
      productionRunId: productionRunId == null && nullToAbsent ? const Value.absent() : Value(productionRunId),
      supplierId: supplierId == null && nullToAbsent ? const Value.absent() : Value(supplierId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory StockMove.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMove(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      productId: serializer.fromJson<String>(json['productId']),
      qtyMilli: serializer.fromJson<int>(json['qtyMilli']),
      type: $StockMovesTable.$convertertype.fromJson(serializer.fromJson<String>(json['type'])),
      valuePaise: serializer.fromJson<int>(json['valuePaise']),
      movedAt: serializer.fromJson<DateTime>(json['movedAt']),
      orderId: serializer.fromJson<String?>(json['orderId']),
      productionRunId: serializer.fromJson<String?>(json['productionRunId']),
      supplierId: serializer.fromJson<String?>(json['supplierId']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'productId': serializer.toJson<String>(productId),
      'qtyMilli': serializer.toJson<int>(qtyMilli),
      'type': serializer.toJson<String>($StockMovesTable.$convertertype.toJson(type)),
      'valuePaise': serializer.toJson<int>(valuePaise),
      'movedAt': serializer.toJson<DateTime>(movedAt),
      'orderId': serializer.toJson<String?>(orderId),
      'productionRunId': serializer.toJson<String?>(productionRunId),
      'supplierId': serializer.toJson<String?>(supplierId),
      'note': serializer.toJson<String?>(note),
    };
  }

  StockMove copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? productId,
          int? qtyMilli,
          StockMoveType? type,
          int? valuePaise,
          DateTime? movedAt,
          Value<String?> orderId = const Value.absent(),
          Value<String?> productionRunId = const Value.absent(),
          Value<String?> supplierId = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      StockMove(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        productId: productId ?? this.productId,
        qtyMilli: qtyMilli ?? this.qtyMilli,
        type: type ?? this.type,
        valuePaise: valuePaise ?? this.valuePaise,
        movedAt: movedAt ?? this.movedAt,
        orderId: orderId.present ? orderId.value : this.orderId,
        productionRunId: productionRunId.present ? productionRunId.value : this.productionRunId,
        supplierId: supplierId.present ? supplierId.value : this.supplierId,
        note: note.present ? note.value : this.note,
      );
  StockMove copyWithCompanion(StockMovesCompanion data) {
    return StockMove(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      productId: data.productId.present ? data.productId.value : this.productId,
      qtyMilli: data.qtyMilli.present ? data.qtyMilli.value : this.qtyMilli,
      type: data.type.present ? data.type.value : this.type,
      valuePaise: data.valuePaise.present ? data.valuePaise.value : this.valuePaise,
      movedAt: data.movedAt.present ? data.movedAt.value : this.movedAt,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      productionRunId: data.productionRunId.present ? data.productionRunId.value : this.productionRunId,
      supplierId: data.supplierId.present ? data.supplierId.value : this.supplierId,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMove(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('qtyMilli: $qtyMilli, ')
          ..write('type: $type, ')
          ..write('valuePaise: $valuePaise, ')
          ..write('movedAt: $movedAt, ')
          ..write('orderId: $orderId, ')
          ..write('productionRunId: $productionRunId, ')
          ..write('supplierId: $supplierId, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, deletedAt, productId, qtyMilli, type, valuePaise, movedAt,
      orderId, productionRunId, supplierId, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMove &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.productId == this.productId &&
          other.qtyMilli == this.qtyMilli &&
          other.type == this.type &&
          other.valuePaise == this.valuePaise &&
          other.movedAt == this.movedAt &&
          other.orderId == this.orderId &&
          other.productionRunId == this.productionRunId &&
          other.supplierId == this.supplierId &&
          other.note == this.note);
}

class StockMovesCompanion extends UpdateCompanion<StockMove> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> productId;
  final Value<int> qtyMilli;
  final Value<StockMoveType> type;
  final Value<int> valuePaise;
  final Value<DateTime> movedAt;
  final Value<String?> orderId;
  final Value<String?> productionRunId;
  final Value<String?> supplierId;
  final Value<String?> note;
  final Value<int> rowid;
  const StockMovesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.productId = const Value.absent(),
    this.qtyMilli = const Value.absent(),
    this.type = const Value.absent(),
    this.valuePaise = const Value.absent(),
    this.movedAt = const Value.absent(),
    this.orderId = const Value.absent(),
    this.productionRunId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockMovesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String productId,
    required int qtyMilli,
    required StockMoveType type,
    this.valuePaise = const Value.absent(),
    required DateTime movedAt,
    this.orderId = const Value.absent(),
    this.productionRunId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : productId = Value(productId),
        qtyMilli = Value(qtyMilli),
        type = Value(type),
        movedAt = Value(movedAt);
  static Insertable<StockMove> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? productId,
    Expression<int>? qtyMilli,
    Expression<String>? type,
    Expression<int>? valuePaise,
    Expression<DateTime>? movedAt,
    Expression<String>? orderId,
    Expression<String>? productionRunId,
    Expression<String>? supplierId,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (productId != null) 'product_id': productId,
      if (qtyMilli != null) 'qty_milli': qtyMilli,
      if (type != null) 'type': type,
      if (valuePaise != null) 'value_paise': valuePaise,
      if (movedAt != null) 'moved_at': movedAt,
      if (orderId != null) 'order_id': orderId,
      if (productionRunId != null) 'production_run_id': productionRunId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockMovesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? productId,
      Value<int>? qtyMilli,
      Value<StockMoveType>? type,
      Value<int>? valuePaise,
      Value<DateTime>? movedAt,
      Value<String?>? orderId,
      Value<String?>? productionRunId,
      Value<String?>? supplierId,
      Value<String?>? note,
      Value<int>? rowid}) {
    return StockMovesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      productId: productId ?? this.productId,
      qtyMilli: qtyMilli ?? this.qtyMilli,
      type: type ?? this.type,
      valuePaise: valuePaise ?? this.valuePaise,
      movedAt: movedAt ?? this.movedAt,
      orderId: orderId ?? this.orderId,
      productionRunId: productionRunId ?? this.productionRunId,
      supplierId: supplierId ?? this.supplierId,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (qtyMilli.present) {
      map['qty_milli'] = Variable<int>(qtyMilli.value);
    }
    if (type.present) {
      map['type'] = Variable<String>($StockMovesTable.$convertertype.toSql(type.value));
    }
    if (valuePaise.present) {
      map['value_paise'] = Variable<int>(valuePaise.value);
    }
    if (movedAt.present) {
      map['moved_at'] = Variable<DateTime>(movedAt.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (productionRunId.present) {
      map['production_run_id'] = Variable<String>(productionRunId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('qtyMilli: $qtyMilli, ')
          ..write('type: $type, ')
          ..write('valuePaise: $valuePaise, ')
          ..write('movedAt: $movedAt, ')
          ..write('orderId: $orderId, ')
          ..write('productionRunId: $productionRunId, ')
          ..write('supplierId: $supplierId, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderLinesTable extends OrderLines with TableInfo<$OrderLinesTable, OrderLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>('order_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'));
  static const VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>('product_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description =
      GeneratedColumn<String>('description', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _positionMeta = const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>('position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
  static const VerificationMeta _qtyMilliMeta = const VerificationMeta('qtyMilli');
  @override
  late final GeneratedColumn<int> qtyMilli =
      GeneratedColumn<int>('qty_milli', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _unitPricePaiseMeta = const VerificationMeta('unitPricePaise');
  @override
  late final GeneratedColumn<int> unitPricePaise =
      GeneratedColumn<int>('unit_price_paise', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _listPricePaiseMeta = const VerificationMeta('listPricePaise');
  @override
  late final GeneratedColumn<int> listPricePaise =
      GeneratedColumn<int>('list_price_paise', aliasedName, true, type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _lineDiscountPaiseMeta = const VerificationMeta('lineDiscountPaise');
  @override
  late final GeneratedColumn<int> lineDiscountPaise = GeneratedColumn<int>('line_discount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false, defaultValue: const Constant(0));
  static const VerificationMeta _unitCostPaiseMeta = const VerificationMeta('unitCostPaise');
  @override
  late final GeneratedColumn<int> unitCostPaise =
      GeneratedColumn<int>('unit_cost_paise', aliasedName, true, type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _specColourMeta = const VerificationMeta('specColour');
  @override
  late final GeneratedColumn<String> specColour =
      GeneratedColumn<String>('spec_colour', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _specSizeMeta = const VerificationMeta('specSize');
  @override
  late final GeneratedColumn<String> specSize =
      GeneratedColumn<String>('spec_size', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _specTextMeta = const VerificationMeta('specText');
  @override
  late final GeneratedColumn<String> specText =
      GeneratedColumn<String>('spec_text', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes =
      GeneratedColumn<String>('notes', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        orderId,
        productId,
        description,
        position,
        qtyMilli,
        unitPricePaise,
        listPricePaise,
        lineDiscountPaise,
        unitCostPaise,
        specColour,
        specSize,
        specText,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_lines';
  @override
  VerificationContext validateIntegrity(Insertable<OrderLine> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta, orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta, productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta, position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    }
    if (data.containsKey('qty_milli')) {
      context.handle(_qtyMilliMeta, qtyMilli.isAcceptableOrUnknown(data['qty_milli']!, _qtyMilliMeta));
    } else if (isInserting) {
      context.missing(_qtyMilliMeta);
    }
    if (data.containsKey('unit_price_paise')) {
      context.handle(
          _unitPricePaiseMeta, unitPricePaise.isAcceptableOrUnknown(data['unit_price_paise']!, _unitPricePaiseMeta));
    } else if (isInserting) {
      context.missing(_unitPricePaiseMeta);
    }
    if (data.containsKey('list_price_paise')) {
      context.handle(
          _listPricePaiseMeta, listPricePaise.isAcceptableOrUnknown(data['list_price_paise']!, _listPricePaiseMeta));
    }
    if (data.containsKey('line_discount_paise')) {
      context.handle(_lineDiscountPaiseMeta,
          lineDiscountPaise.isAcceptableOrUnknown(data['line_discount_paise']!, _lineDiscountPaiseMeta));
    }
    if (data.containsKey('unit_cost_paise')) {
      context.handle(
          _unitCostPaiseMeta, unitCostPaise.isAcceptableOrUnknown(data['unit_cost_paise']!, _unitCostPaiseMeta));
    }
    if (data.containsKey('spec_colour')) {
      context.handle(_specColourMeta, specColour.isAcceptableOrUnknown(data['spec_colour']!, _specColourMeta));
    }
    if (data.containsKey('spec_size')) {
      context.handle(_specSizeMeta, specSize.isAcceptableOrUnknown(data['spec_size']!, _specSizeMeta));
    }
    if (data.containsKey('spec_text')) {
      context.handle(_specTextMeta, specText.isAcceptableOrUnknown(data['spec_text']!, _specTextMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(_notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderLine(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      orderId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}order_id'])!,
      productId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}product_id']),
      description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}description']),
      position: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      qtyMilli: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}qty_milli'])!,
      unitPricePaise: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}unit_price_paise'])!,
      listPricePaise: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}list_price_paise']),
      lineDiscountPaise:
          attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}line_discount_paise'])!,
      unitCostPaise: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}unit_cost_paise']),
      specColour: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}spec_colour']),
      specSize: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}spec_size']),
      specText: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}spec_text']),
      notes: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $OrderLinesTable createAlias(String alias) {
    return $OrderLinesTable(attachedDatabase, alias);
  }
}

class OrderLine extends DataClass implements Insertable<OrderLine> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String orderId;

  /// null = custom item (made-to-order piece not in the catalogue).
  final String? productId;
  final String? description;
  final int position;
  final int qtyMilli;
  final int unitPricePaise;
  final int? listPricePaise;
  final int lineDiscountPaise;

  /// Full cost per piece (materials + labour + overhead) when the line was made,
  /// for margin colours. For custom items: her estimate, if any.
  final int? unitCostPaise;
  final String? specColour;
  final String? specSize;
  final String? specText;
  final String? notes;
  const OrderLine(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.orderId,
      this.productId,
      this.description,
      required this.position,
      required this.qtyMilli,
      required this.unitPricePaise,
      this.listPricePaise,
      required this.lineDiscountPaise,
      this.unitCostPaise,
      this.specColour,
      this.specSize,
      this.specText,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['order_id'] = Variable<String>(orderId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['position'] = Variable<int>(position);
    map['qty_milli'] = Variable<int>(qtyMilli);
    map['unit_price_paise'] = Variable<int>(unitPricePaise);
    if (!nullToAbsent || listPricePaise != null) {
      map['list_price_paise'] = Variable<int>(listPricePaise);
    }
    map['line_discount_paise'] = Variable<int>(lineDiscountPaise);
    if (!nullToAbsent || unitCostPaise != null) {
      map['unit_cost_paise'] = Variable<int>(unitCostPaise);
    }
    if (!nullToAbsent || specColour != null) {
      map['spec_colour'] = Variable<String>(specColour);
    }
    if (!nullToAbsent || specSize != null) {
      map['spec_size'] = Variable<String>(specSize);
    }
    if (!nullToAbsent || specText != null) {
      map['spec_text'] = Variable<String>(specText);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  OrderLinesCompanion toCompanion(bool nullToAbsent) {
    return OrderLinesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      orderId: Value(orderId),
      productId: productId == null && nullToAbsent ? const Value.absent() : Value(productId),
      description: description == null && nullToAbsent ? const Value.absent() : Value(description),
      position: Value(position),
      qtyMilli: Value(qtyMilli),
      unitPricePaise: Value(unitPricePaise),
      listPricePaise: listPricePaise == null && nullToAbsent ? const Value.absent() : Value(listPricePaise),
      lineDiscountPaise: Value(lineDiscountPaise),
      unitCostPaise: unitCostPaise == null && nullToAbsent ? const Value.absent() : Value(unitCostPaise),
      specColour: specColour == null && nullToAbsent ? const Value.absent() : Value(specColour),
      specSize: specSize == null && nullToAbsent ? const Value.absent() : Value(specSize),
      specText: specText == null && nullToAbsent ? const Value.absent() : Value(specText),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory OrderLine.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderLine(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      orderId: serializer.fromJson<String>(json['orderId']),
      productId: serializer.fromJson<String?>(json['productId']),
      description: serializer.fromJson<String?>(json['description']),
      position: serializer.fromJson<int>(json['position']),
      qtyMilli: serializer.fromJson<int>(json['qtyMilli']),
      unitPricePaise: serializer.fromJson<int>(json['unitPricePaise']),
      listPricePaise: serializer.fromJson<int?>(json['listPricePaise']),
      lineDiscountPaise: serializer.fromJson<int>(json['lineDiscountPaise']),
      unitCostPaise: serializer.fromJson<int?>(json['unitCostPaise']),
      specColour: serializer.fromJson<String?>(json['specColour']),
      specSize: serializer.fromJson<String?>(json['specSize']),
      specText: serializer.fromJson<String?>(json['specText']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'orderId': serializer.toJson<String>(orderId),
      'productId': serializer.toJson<String?>(productId),
      'description': serializer.toJson<String?>(description),
      'position': serializer.toJson<int>(position),
      'qtyMilli': serializer.toJson<int>(qtyMilli),
      'unitPricePaise': serializer.toJson<int>(unitPricePaise),
      'listPricePaise': serializer.toJson<int?>(listPricePaise),
      'lineDiscountPaise': serializer.toJson<int>(lineDiscountPaise),
      'unitCostPaise': serializer.toJson<int?>(unitCostPaise),
      'specColour': serializer.toJson<String?>(specColour),
      'specSize': serializer.toJson<String?>(specSize),
      'specText': serializer.toJson<String?>(specText),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  OrderLine copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? orderId,
          Value<String?> productId = const Value.absent(),
          Value<String?> description = const Value.absent(),
          int? position,
          int? qtyMilli,
          int? unitPricePaise,
          Value<int?> listPricePaise = const Value.absent(),
          int? lineDiscountPaise,
          Value<int?> unitCostPaise = const Value.absent(),
          Value<String?> specColour = const Value.absent(),
          Value<String?> specSize = const Value.absent(),
          Value<String?> specText = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      OrderLine(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        orderId: orderId ?? this.orderId,
        productId: productId.present ? productId.value : this.productId,
        description: description.present ? description.value : this.description,
        position: position ?? this.position,
        qtyMilli: qtyMilli ?? this.qtyMilli,
        unitPricePaise: unitPricePaise ?? this.unitPricePaise,
        listPricePaise: listPricePaise.present ? listPricePaise.value : this.listPricePaise,
        lineDiscountPaise: lineDiscountPaise ?? this.lineDiscountPaise,
        unitCostPaise: unitCostPaise.present ? unitCostPaise.value : this.unitCostPaise,
        specColour: specColour.present ? specColour.value : this.specColour,
        specSize: specSize.present ? specSize.value : this.specSize,
        specText: specText.present ? specText.value : this.specText,
        notes: notes.present ? notes.value : this.notes,
      );
  OrderLine copyWithCompanion(OrderLinesCompanion data) {
    return OrderLine(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      productId: data.productId.present ? data.productId.value : this.productId,
      description: data.description.present ? data.description.value : this.description,
      position: data.position.present ? data.position.value : this.position,
      qtyMilli: data.qtyMilli.present ? data.qtyMilli.value : this.qtyMilli,
      unitPricePaise: data.unitPricePaise.present ? data.unitPricePaise.value : this.unitPricePaise,
      listPricePaise: data.listPricePaise.present ? data.listPricePaise.value : this.listPricePaise,
      lineDiscountPaise: data.lineDiscountPaise.present ? data.lineDiscountPaise.value : this.lineDiscountPaise,
      unitCostPaise: data.unitCostPaise.present ? data.unitCostPaise.value : this.unitCostPaise,
      specColour: data.specColour.present ? data.specColour.value : this.specColour,
      specSize: data.specSize.present ? data.specSize.value : this.specSize,
      specText: data.specText.present ? data.specText.value : this.specText,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderLine(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('position: $position, ')
          ..write('qtyMilli: $qtyMilli, ')
          ..write('unitPricePaise: $unitPricePaise, ')
          ..write('listPricePaise: $listPricePaise, ')
          ..write('lineDiscountPaise: $lineDiscountPaise, ')
          ..write('unitCostPaise: $unitCostPaise, ')
          ..write('specColour: $specColour, ')
          ..write('specSize: $specSize, ')
          ..write('specText: $specText, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      updatedAt,
      deletedAt,
      orderId,
      productId,
      description,
      position,
      qtyMilli,
      unitPricePaise,
      listPricePaise,
      lineDiscountPaise,
      unitCostPaise,
      specColour,
      specSize,
      specText,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLine &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.orderId == this.orderId &&
          other.productId == this.productId &&
          other.description == this.description &&
          other.position == this.position &&
          other.qtyMilli == this.qtyMilli &&
          other.unitPricePaise == this.unitPricePaise &&
          other.listPricePaise == this.listPricePaise &&
          other.lineDiscountPaise == this.lineDiscountPaise &&
          other.unitCostPaise == this.unitCostPaise &&
          other.specColour == this.specColour &&
          other.specSize == this.specSize &&
          other.specText == this.specText &&
          other.notes == this.notes);
}

class OrderLinesCompanion extends UpdateCompanion<OrderLine> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> orderId;
  final Value<String?> productId;
  final Value<String?> description;
  final Value<int> position;
  final Value<int> qtyMilli;
  final Value<int> unitPricePaise;
  final Value<int?> listPricePaise;
  final Value<int> lineDiscountPaise;
  final Value<int?> unitCostPaise;
  final Value<String?> specColour;
  final Value<String?> specSize;
  final Value<String?> specText;
  final Value<String?> notes;
  final Value<int> rowid;
  const OrderLinesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.orderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.description = const Value.absent(),
    this.position = const Value.absent(),
    this.qtyMilli = const Value.absent(),
    this.unitPricePaise = const Value.absent(),
    this.listPricePaise = const Value.absent(),
    this.lineDiscountPaise = const Value.absent(),
    this.unitCostPaise = const Value.absent(),
    this.specColour = const Value.absent(),
    this.specSize = const Value.absent(),
    this.specText = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderLinesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String orderId,
    this.productId = const Value.absent(),
    this.description = const Value.absent(),
    this.position = const Value.absent(),
    required int qtyMilli,
    required int unitPricePaise,
    this.listPricePaise = const Value.absent(),
    this.lineDiscountPaise = const Value.absent(),
    this.unitCostPaise = const Value.absent(),
    this.specColour = const Value.absent(),
    this.specSize = const Value.absent(),
    this.specText = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : orderId = Value(orderId),
        qtyMilli = Value(qtyMilli),
        unitPricePaise = Value(unitPricePaise);
  static Insertable<OrderLine> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? orderId,
    Expression<String>? productId,
    Expression<String>? description,
    Expression<int>? position,
    Expression<int>? qtyMilli,
    Expression<int>? unitPricePaise,
    Expression<int>? listPricePaise,
    Expression<int>? lineDiscountPaise,
    Expression<int>? unitCostPaise,
    Expression<String>? specColour,
    Expression<String>? specSize,
    Expression<String>? specText,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (orderId != null) 'order_id': orderId,
      if (productId != null) 'product_id': productId,
      if (description != null) 'description': description,
      if (position != null) 'position': position,
      if (qtyMilli != null) 'qty_milli': qtyMilli,
      if (unitPricePaise != null) 'unit_price_paise': unitPricePaise,
      if (listPricePaise != null) 'list_price_paise': listPricePaise,
      if (lineDiscountPaise != null) 'line_discount_paise': lineDiscountPaise,
      if (unitCostPaise != null) 'unit_cost_paise': unitCostPaise,
      if (specColour != null) 'spec_colour': specColour,
      if (specSize != null) 'spec_size': specSize,
      if (specText != null) 'spec_text': specText,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderLinesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? orderId,
      Value<String?>? productId,
      Value<String?>? description,
      Value<int>? position,
      Value<int>? qtyMilli,
      Value<int>? unitPricePaise,
      Value<int?>? listPricePaise,
      Value<int>? lineDiscountPaise,
      Value<int?>? unitCostPaise,
      Value<String?>? specColour,
      Value<String?>? specSize,
      Value<String?>? specText,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return OrderLinesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      position: position ?? this.position,
      qtyMilli: qtyMilli ?? this.qtyMilli,
      unitPricePaise: unitPricePaise ?? this.unitPricePaise,
      listPricePaise: listPricePaise ?? this.listPricePaise,
      lineDiscountPaise: lineDiscountPaise ?? this.lineDiscountPaise,
      unitCostPaise: unitCostPaise ?? this.unitCostPaise,
      specColour: specColour ?? this.specColour,
      specSize: specSize ?? this.specSize,
      specText: specText ?? this.specText,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (qtyMilli.present) {
      map['qty_milli'] = Variable<int>(qtyMilli.value);
    }
    if (unitPricePaise.present) {
      map['unit_price_paise'] = Variable<int>(unitPricePaise.value);
    }
    if (listPricePaise.present) {
      map['list_price_paise'] = Variable<int>(listPricePaise.value);
    }
    if (lineDiscountPaise.present) {
      map['line_discount_paise'] = Variable<int>(lineDiscountPaise.value);
    }
    if (unitCostPaise.present) {
      map['unit_cost_paise'] = Variable<int>(unitCostPaise.value);
    }
    if (specColour.present) {
      map['spec_colour'] = Variable<String>(specColour.value);
    }
    if (specSize.present) {
      map['spec_size'] = Variable<String>(specSize.value);
    }
    if (specText.present) {
      map['spec_text'] = Variable<String>(specText.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderLinesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('position: $position, ')
          ..write('qtyMilli: $qtyMilli, ')
          ..write('unitPricePaise: $unitPricePaise, ')
          ..write('listPricePaise: $listPricePaise, ')
          ..write('lineDiscountPaise: $lineDiscountPaise, ')
          ..write('unitCostPaise: $unitCostPaise, ')
          ..write('specColour: $specColour, ')
          ..write('specSize: $specSize, ')
          ..write('specText: $specText, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderPhotosTable extends OrderPhotos with TableInfo<$OrderPhotosTable, OrderPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>('order_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'));
  static const VerificationMeta _orderLineIdMeta = const VerificationMeta('orderLineId');
  @override
  late final GeneratedColumn<String> orderLineId = GeneratedColumn<String>('order_line_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES order_lines (id)'));
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path =
      GeneratedColumn<String>('path', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _captionMeta = const VerificationMeta('caption');
  @override
  late final GeneratedColumn<String> caption =
      GeneratedColumn<String>('caption', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, deletedAt, orderId, orderLineId, path, caption];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_photos';
  @override
  VerificationContext validateIntegrity(Insertable<OrderPhoto> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta, orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('order_line_id')) {
      context.handle(_orderLineIdMeta, orderLineId.isAcceptableOrUnknown(data['order_line_id']!, _orderLineIdMeta));
    }
    if (data.containsKey('path')) {
      context.handle(_pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(_captionMeta, caption.isAcceptableOrUnknown(data['caption']!, _captionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderPhoto(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      orderId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}order_id'])!,
      orderLineId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}order_line_id']),
      path: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      caption: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}caption']),
    );
  }

  @override
  $OrderPhotosTable createAlias(String alias) {
    return $OrderPhotosTable(attachedDatabase, alias);
  }
}

class OrderPhoto extends DataClass implements Insertable<OrderPhoto> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String orderId;
  final String? orderLineId;
  final String path;
  final String? caption;
  const OrderPhoto(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.orderId,
      this.orderLineId,
      required this.path,
      this.caption});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['order_id'] = Variable<String>(orderId);
    if (!nullToAbsent || orderLineId != null) {
      map['order_line_id'] = Variable<String>(orderLineId);
    }
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    return map;
  }

  OrderPhotosCompanion toCompanion(bool nullToAbsent) {
    return OrderPhotosCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      orderId: Value(orderId),
      orderLineId: orderLineId == null && nullToAbsent ? const Value.absent() : Value(orderLineId),
      path: Value(path),
      caption: caption == null && nullToAbsent ? const Value.absent() : Value(caption),
    );
  }

  factory OrderPhoto.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderPhoto(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      orderId: serializer.fromJson<String>(json['orderId']),
      orderLineId: serializer.fromJson<String?>(json['orderLineId']),
      path: serializer.fromJson<String>(json['path']),
      caption: serializer.fromJson<String?>(json['caption']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'orderId': serializer.toJson<String>(orderId),
      'orderLineId': serializer.toJson<String?>(orderLineId),
      'path': serializer.toJson<String>(path),
      'caption': serializer.toJson<String?>(caption),
    };
  }

  OrderPhoto copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? orderId,
          Value<String?> orderLineId = const Value.absent(),
          String? path,
          Value<String?> caption = const Value.absent()}) =>
      OrderPhoto(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        orderId: orderId ?? this.orderId,
        orderLineId: orderLineId.present ? orderLineId.value : this.orderLineId,
        path: path ?? this.path,
        caption: caption.present ? caption.value : this.caption,
      );
  OrderPhoto copyWithCompanion(OrderPhotosCompanion data) {
    return OrderPhoto(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      orderLineId: data.orderLineId.present ? data.orderLineId.value : this.orderLineId,
      path: data.path.present ? data.path.value : this.path,
      caption: data.caption.present ? data.caption.value : this.caption,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderPhoto(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('orderId: $orderId, ')
          ..write('orderLineId: $orderLineId, ')
          ..write('path: $path, ')
          ..write('caption: $caption')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, deletedAt, orderId, orderLineId, path, caption);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderPhoto &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.orderId == this.orderId &&
          other.orderLineId == this.orderLineId &&
          other.path == this.path &&
          other.caption == this.caption);
}

class OrderPhotosCompanion extends UpdateCompanion<OrderPhoto> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> orderId;
  final Value<String?> orderLineId;
  final Value<String> path;
  final Value<String?> caption;
  final Value<int> rowid;
  const OrderPhotosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.orderId = const Value.absent(),
    this.orderLineId = const Value.absent(),
    this.path = const Value.absent(),
    this.caption = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderPhotosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String orderId,
    this.orderLineId = const Value.absent(),
    required String path,
    this.caption = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : orderId = Value(orderId),
        path = Value(path);
  static Insertable<OrderPhoto> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? orderId,
    Expression<String>? orderLineId,
    Expression<String>? path,
    Expression<String>? caption,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (orderId != null) 'order_id': orderId,
      if (orderLineId != null) 'order_line_id': orderLineId,
      if (path != null) 'path': path,
      if (caption != null) 'caption': caption,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderPhotosCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? orderId,
      Value<String?>? orderLineId,
      Value<String>? path,
      Value<String?>? caption,
      Value<int>? rowid}) {
    return OrderPhotosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      orderId: orderId ?? this.orderId,
      orderLineId: orderLineId ?? this.orderLineId,
      path: path ?? this.path,
      caption: caption ?? this.caption,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (orderLineId.present) {
      map['order_line_id'] = Variable<String>(orderLineId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderPhotosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('orderId: $orderId, ')
          ..write('orderLineId: $orderLineId, ')
          ..write('path: $path, ')
          ..write('caption: $caption, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _partyIdMeta = const VerificationMeta('partyId');
  @override
  late final GeneratedColumn<String> partyId = GeneratedColumn<String>('party_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES parties (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<PaymentPurpose, String> purpose =
      GeneratedColumn<String>('purpose', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PaymentPurpose>($PaymentsTable.$converterpurpose);
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise =
      GeneratedColumn<int>('amount_paise', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, String> method =
      GeneratedColumn<String>('method', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PaymentMethod>($PaymentsTable.$convertermethod);
  static const VerificationMeta _paidOnMeta = const VerificationMeta('paidOn');
  @override
  late final GeneratedColumn<DateTime> paidOn =
      GeneratedColumn<DateTime>('paid_on', aliasedName, false, type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta = const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference =
      GeneratedColumn<String>('reference', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note =
      GeneratedColumn<String>('note', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, deletedAt, partyId, purpose, amountPaise, method, paidOn, reference, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<Payment> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('party_id')) {
      context.handle(_partyIdMeta, partyId.isAcceptableOrUnknown(data['party_id']!, _partyIdMeta));
    }
    if (data.containsKey('amount_paise')) {
      context.handle(_amountPaiseMeta, amountPaise.isAcceptableOrUnknown(data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('paid_on')) {
      context.handle(_paidOnMeta, paidOn.isAcceptableOrUnknown(data['paid_on']!, _paidOnMeta));
    } else if (isInserting) {
      context.missing(_paidOnMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta, reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      partyId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}party_id']),
      purpose: $PaymentsTable.$converterpurpose
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}purpose'])!),
      amountPaise: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
      method: $PaymentsTable.$convertermethod
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}method'])!),
      paidOn: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}paid_on'])!,
      reference: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}reference']),
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentPurpose, String, String> $converterpurpose =
      const EnumNameConverter<PaymentPurpose>(PaymentPurpose.values);
  static JsonTypeConverter2<PaymentMethod, String, String> $convertermethod =
      const EnumNameConverter<PaymentMethod>(PaymentMethod.values);
}

class Payment extends DataClass implements Insertable<Payment> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? partyId;
  final PaymentPurpose purpose;
  final int amountPaise;
  final PaymentMethod method;
  final DateTime paidOn;
  final String? reference;
  final String? note;
  const Payment(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.partyId,
      required this.purpose,
      required this.amountPaise,
      required this.method,
      required this.paidOn,
      this.reference,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || partyId != null) {
      map['party_id'] = Variable<String>(partyId);
    }
    {
      map['purpose'] = Variable<String>($PaymentsTable.$converterpurpose.toSql(purpose));
    }
    map['amount_paise'] = Variable<int>(amountPaise);
    {
      map['method'] = Variable<String>($PaymentsTable.$convertermethod.toSql(method));
    }
    map['paid_on'] = Variable<DateTime>(paidOn);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      partyId: partyId == null && nullToAbsent ? const Value.absent() : Value(partyId),
      purpose: Value(purpose),
      amountPaise: Value(amountPaise),
      method: Value(method),
      paidOn: Value(paidOn),
      reference: reference == null && nullToAbsent ? const Value.absent() : Value(reference),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      partyId: serializer.fromJson<String?>(json['partyId']),
      purpose: $PaymentsTable.$converterpurpose.fromJson(serializer.fromJson<String>(json['purpose'])),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      method: $PaymentsTable.$convertermethod.fromJson(serializer.fromJson<String>(json['method'])),
      paidOn: serializer.fromJson<DateTime>(json['paidOn']),
      reference: serializer.fromJson<String?>(json['reference']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'partyId': serializer.toJson<String?>(partyId),
      'purpose': serializer.toJson<String>($PaymentsTable.$converterpurpose.toJson(purpose)),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'method': serializer.toJson<String>($PaymentsTable.$convertermethod.toJson(method)),
      'paidOn': serializer.toJson<DateTime>(paidOn),
      'reference': serializer.toJson<String?>(reference),
      'note': serializer.toJson<String?>(note),
    };
  }

  Payment copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          Value<String?> partyId = const Value.absent(),
          PaymentPurpose? purpose,
          int? amountPaise,
          PaymentMethod? method,
          DateTime? paidOn,
          Value<String?> reference = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      Payment(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        partyId: partyId.present ? partyId.value : this.partyId,
        purpose: purpose ?? this.purpose,
        amountPaise: amountPaise ?? this.amountPaise,
        method: method ?? this.method,
        paidOn: paidOn ?? this.paidOn,
        reference: reference.present ? reference.value : this.reference,
        note: note.present ? note.value : this.note,
      );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      partyId: data.partyId.present ? data.partyId.value : this.partyId,
      purpose: data.purpose.present ? data.purpose.value : this.purpose,
      amountPaise: data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
      method: data.method.present ? data.method.value : this.method,
      paidOn: data.paidOn.present ? data.paidOn.value : this.paidOn,
      reference: data.reference.present ? data.reference.value : this.reference,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('partyId: $partyId, ')
          ..write('purpose: $purpose, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('method: $method, ')
          ..write('paidOn: $paidOn, ')
          ..write('reference: $reference, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, deletedAt, partyId, purpose, amountPaise, method, paidOn, reference, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.partyId == this.partyId &&
          other.purpose == this.purpose &&
          other.amountPaise == this.amountPaise &&
          other.method == this.method &&
          other.paidOn == this.paidOn &&
          other.reference == this.reference &&
          other.note == this.note);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> partyId;
  final Value<PaymentPurpose> purpose;
  final Value<int> amountPaise;
  final Value<PaymentMethod> method;
  final Value<DateTime> paidOn;
  final Value<String?> reference;
  final Value<String?> note;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.partyId = const Value.absent(),
    this.purpose = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.method = const Value.absent(),
    this.paidOn = const Value.absent(),
    this.reference = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.partyId = const Value.absent(),
    required PaymentPurpose purpose,
    required int amountPaise,
    required PaymentMethod method,
    required DateTime paidOn,
    this.reference = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : purpose = Value(purpose),
        amountPaise = Value(amountPaise),
        method = Value(method),
        paidOn = Value(paidOn);
  static Insertable<Payment> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? partyId,
    Expression<String>? purpose,
    Expression<int>? amountPaise,
    Expression<String>? method,
    Expression<DateTime>? paidOn,
    Expression<String>? reference,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (partyId != null) 'party_id': partyId,
      if (purpose != null) 'purpose': purpose,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (method != null) 'method': method,
      if (paidOn != null) 'paid_on': paidOn,
      if (reference != null) 'reference': reference,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String?>? partyId,
      Value<PaymentPurpose>? purpose,
      Value<int>? amountPaise,
      Value<PaymentMethod>? method,
      Value<DateTime>? paidOn,
      Value<String?>? reference,
      Value<String?>? note,
      Value<int>? rowid}) {
    return PaymentsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      partyId: partyId ?? this.partyId,
      purpose: purpose ?? this.purpose,
      amountPaise: amountPaise ?? this.amountPaise,
      method: method ?? this.method,
      paidOn: paidOn ?? this.paidOn,
      reference: reference ?? this.reference,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (partyId.present) {
      map['party_id'] = Variable<String>(partyId.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>($PaymentsTable.$converterpurpose.toSql(purpose.value));
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (method.present) {
      map['method'] = Variable<String>($PaymentsTable.$convertermethod.toSql(method.value));
    }
    if (paidOn.present) {
      map['paid_on'] = Variable<DateTime>(paidOn.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('partyId: $partyId, ')
          ..write('purpose: $purpose, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('method: $method, ')
          ..write('paidOn: $paidOn, ')
          ..write('reference: $reference, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentAllocationsTable extends PaymentAllocations with TableInfo<$PaymentAllocationsTable, PaymentAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _paymentIdMeta = const VerificationMeta('paymentId');
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>('payment_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES payments (id)'));
  static const VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>('order_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'));
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise =
      GeneratedColumn<int>('amount_paise', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, deletedAt, paymentId, orderId, amountPaise];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_allocations';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentAllocation> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('payment_id')) {
      context.handle(_paymentIdMeta, paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta));
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta, orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('amount_paise')) {
      context.handle(_amountPaiseMeta, amountPaise.isAcceptableOrUnknown(data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentAllocation(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      paymentId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}payment_id'])!,
      orderId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}order_id'])!,
      amountPaise: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
    );
  }

  @override
  $PaymentAllocationsTable createAlias(String alias) {
    return $PaymentAllocationsTable(attachedDatabase, alias);
  }
}

class PaymentAllocation extends DataClass implements Insertable<PaymentAllocation> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String paymentId;
  final String orderId;
  final int amountPaise;
  const PaymentAllocation(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.paymentId,
      required this.orderId,
      required this.amountPaise});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['payment_id'] = Variable<String>(paymentId);
    map['order_id'] = Variable<String>(orderId);
    map['amount_paise'] = Variable<int>(amountPaise);
    return map;
  }

  PaymentAllocationsCompanion toCompanion(bool nullToAbsent) {
    return PaymentAllocationsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      paymentId: Value(paymentId),
      orderId: Value(orderId),
      amountPaise: Value(amountPaise),
    );
  }

  factory PaymentAllocation.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentAllocation(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      paymentId: serializer.fromJson<String>(json['paymentId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'paymentId': serializer.toJson<String>(paymentId),
      'orderId': serializer.toJson<String>(orderId),
      'amountPaise': serializer.toJson<int>(amountPaise),
    };
  }

  PaymentAllocation copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? paymentId,
          String? orderId,
          int? amountPaise}) =>
      PaymentAllocation(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        paymentId: paymentId ?? this.paymentId,
        orderId: orderId ?? this.orderId,
        amountPaise: amountPaise ?? this.amountPaise,
      );
  PaymentAllocation copyWithCompanion(PaymentAllocationsCompanion data) {
    return PaymentAllocation(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      amountPaise: data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAllocation(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('paymentId: $paymentId, ')
          ..write('orderId: $orderId, ')
          ..write('amountPaise: $amountPaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, deletedAt, paymentId, orderId, amountPaise);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentAllocation &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.paymentId == this.paymentId &&
          other.orderId == this.orderId &&
          other.amountPaise == this.amountPaise);
}

class PaymentAllocationsCompanion extends UpdateCompanion<PaymentAllocation> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> paymentId;
  final Value<String> orderId;
  final Value<int> amountPaise;
  final Value<int> rowid;
  const PaymentAllocationsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentAllocationsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String paymentId,
    required String orderId,
    required int amountPaise,
    this.rowid = const Value.absent(),
  })  : paymentId = Value(paymentId),
        orderId = Value(orderId),
        amountPaise = Value(amountPaise);
  static Insertable<PaymentAllocation> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? paymentId,
    Expression<String>? orderId,
    Expression<int>? amountPaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (paymentId != null) 'payment_id': paymentId,
      if (orderId != null) 'order_id': orderId,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentAllocationsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? paymentId,
      Value<String>? orderId,
      Value<int>? amountPaise,
      Value<int>? rowid}) {
    return PaymentAllocationsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      paymentId: paymentId ?? this.paymentId,
      orderId: orderId ?? this.orderId,
      amountPaise: amountPaise ?? this.amountPaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('paymentId: $paymentId, ')
          ..write('orderId: $orderId, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category =
      GeneratedColumn<String>('category', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise =
      GeneratedColumn<int>('amount_paise', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, String> method =
      GeneratedColumn<String>('method', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PaymentMethod>($ExpensesTable.$convertermethod);
  static const VerificationMeta _spentOnMeta = const VerificationMeta('spentOn');
  @override
  late final GeneratedColumn<DateTime> spentOn = GeneratedColumn<DateTime>('spent_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _partyIdMeta = const VerificationMeta('partyId');
  @override
  late final GeneratedColumn<String> partyId = GeneratedColumn<String>('party_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES parties (id)'));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note =
      GeneratedColumn<String>('note', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _receiptPathMeta = const VerificationMeta('receiptPath');
  @override
  late final GeneratedColumn<String> receiptPath = GeneratedColumn<String>('receipt_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, deletedAt, category, amountPaise, method, spentOn, partyId, note, receiptPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta, category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount_paise')) {
      context.handle(_amountPaiseMeta, amountPaise.isAcceptableOrUnknown(data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('spent_on')) {
      context.handle(_spentOnMeta, spentOn.isAcceptableOrUnknown(data['spent_on']!, _spentOnMeta));
    } else if (isInserting) {
      context.missing(_spentOnMeta);
    }
    if (data.containsKey('party_id')) {
      context.handle(_partyIdMeta, partyId.isAcceptableOrUnknown(data['party_id']!, _partyIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('receipt_path')) {
      context.handle(_receiptPathMeta, receiptPath.isAcceptableOrUnknown(data['receipt_path']!, _receiptPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      category: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      amountPaise: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
      method: $ExpensesTable.$convertermethod
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}method'])!),
      spentOn: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}spent_on'])!,
      partyId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}party_id']),
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      receiptPath: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}receipt_path']),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentMethod, String, String> $convertermethod =
      const EnumNameConverter<PaymentMethod>(PaymentMethod.values);
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String category;
  final int amountPaise;
  final PaymentMethod method;
  final DateTime spentOn;
  final String? partyId;
  final String? note;
  final String? receiptPath;
  const Expense(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.category,
      required this.amountPaise,
      required this.method,
      required this.spentOn,
      this.partyId,
      this.note,
      this.receiptPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['category'] = Variable<String>(category);
    map['amount_paise'] = Variable<int>(amountPaise);
    {
      map['method'] = Variable<String>($ExpensesTable.$convertermethod.toSql(method));
    }
    map['spent_on'] = Variable<DateTime>(spentOn);
    if (!nullToAbsent || partyId != null) {
      map['party_id'] = Variable<String>(partyId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || receiptPath != null) {
      map['receipt_path'] = Variable<String>(receiptPath);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      category: Value(category),
      amountPaise: Value(amountPaise),
      method: Value(method),
      spentOn: Value(spentOn),
      partyId: partyId == null && nullToAbsent ? const Value.absent() : Value(partyId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      receiptPath: receiptPath == null && nullToAbsent ? const Value.absent() : Value(receiptPath),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      category: serializer.fromJson<String>(json['category']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      method: $ExpensesTable.$convertermethod.fromJson(serializer.fromJson<String>(json['method'])),
      spentOn: serializer.fromJson<DateTime>(json['spentOn']),
      partyId: serializer.fromJson<String?>(json['partyId']),
      note: serializer.fromJson<String?>(json['note']),
      receiptPath: serializer.fromJson<String?>(json['receiptPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'category': serializer.toJson<String>(category),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'method': serializer.toJson<String>($ExpensesTable.$convertermethod.toJson(method)),
      'spentOn': serializer.toJson<DateTime>(spentOn),
      'partyId': serializer.toJson<String?>(partyId),
      'note': serializer.toJson<String?>(note),
      'receiptPath': serializer.toJson<String?>(receiptPath),
    };
  }

  Expense copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? category,
          int? amountPaise,
          PaymentMethod? method,
          DateTime? spentOn,
          Value<String?> partyId = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<String?> receiptPath = const Value.absent()}) =>
      Expense(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        category: category ?? this.category,
        amountPaise: amountPaise ?? this.amountPaise,
        method: method ?? this.method,
        spentOn: spentOn ?? this.spentOn,
        partyId: partyId.present ? partyId.value : this.partyId,
        note: note.present ? note.value : this.note,
        receiptPath: receiptPath.present ? receiptPath.value : this.receiptPath,
      );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      category: data.category.present ? data.category.value : this.category,
      amountPaise: data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
      method: data.method.present ? data.method.value : this.method,
      spentOn: data.spentOn.present ? data.spentOn.value : this.spentOn,
      partyId: data.partyId.present ? data.partyId.value : this.partyId,
      note: data.note.present ? data.note.value : this.note,
      receiptPath: data.receiptPath.present ? data.receiptPath.value : this.receiptPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('category: $category, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('method: $method, ')
          ..write('spentOn: $spentOn, ')
          ..write('partyId: $partyId, ')
          ..write('note: $note, ')
          ..write('receiptPath: $receiptPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, createdAt, updatedAt, deletedAt, category, amountPaise, method, spentOn, partyId, note, receiptPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.category == this.category &&
          other.amountPaise == this.amountPaise &&
          other.method == this.method &&
          other.spentOn == this.spentOn &&
          other.partyId == this.partyId &&
          other.note == this.note &&
          other.receiptPath == this.receiptPath);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> category;
  final Value<int> amountPaise;
  final Value<PaymentMethod> method;
  final Value<DateTime> spentOn;
  final Value<String?> partyId;
  final Value<String?> note;
  final Value<String?> receiptPath;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.category = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.method = const Value.absent(),
    this.spentOn = const Value.absent(),
    this.partyId = const Value.absent(),
    this.note = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String category,
    required int amountPaise,
    required PaymentMethod method,
    required DateTime spentOn,
    this.partyId = const Value.absent(),
    this.note = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : category = Value(category),
        amountPaise = Value(amountPaise),
        method = Value(method),
        spentOn = Value(spentOn);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? category,
    Expression<int>? amountPaise,
    Expression<String>? method,
    Expression<DateTime>? spentOn,
    Expression<String>? partyId,
    Expression<String>? note,
    Expression<String>? receiptPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (category != null) 'category': category,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (method != null) 'method': method,
      if (spentOn != null) 'spent_on': spentOn,
      if (partyId != null) 'party_id': partyId,
      if (note != null) 'note': note,
      if (receiptPath != null) 'receipt_path': receiptPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? category,
      Value<int>? amountPaise,
      Value<PaymentMethod>? method,
      Value<DateTime>? spentOn,
      Value<String?>? partyId,
      Value<String?>? note,
      Value<String?>? receiptPath,
      Value<int>? rowid}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      category: category ?? this.category,
      amountPaise: amountPaise ?? this.amountPaise,
      method: method ?? this.method,
      spentOn: spentOn ?? this.spentOn,
      partyId: partyId ?? this.partyId,
      note: note ?? this.note,
      receiptPath: receiptPath ?? this.receiptPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (method.present) {
      map['method'] = Variable<String>($ExpensesTable.$convertermethod.toSql(method.value));
    }
    if (spentOn.present) {
      map['spent_on'] = Variable<DateTime>(spentOn.value);
    }
    if (partyId.present) {
      map['party_id'] = Variable<String>(partyId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (receiptPath.present) {
      map['receipt_path'] = Variable<String>(receiptPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('category: $category, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('method: $method, ')
          ..write('spentOn: $spentOn, ')
          ..write('partyId: $partyId, ')
          ..write('note: $note, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OwnerWithdrawalsTable extends OwnerWithdrawals with TableInfo<$OwnerWithdrawalsTable, OwnerWithdrawal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OwnerWithdrawalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: false, clientDefault: newId);
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>('created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>('updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: false, clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta = const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>('deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise =
      GeneratedColumn<int>('amount_paise', aliasedName, false, type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, String> method =
      GeneratedColumn<String>('method', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PaymentMethod>($OwnerWithdrawalsTable.$convertermethod);
  static const VerificationMeta _takenOnMeta = const VerificationMeta('takenOn');
  @override
  late final GeneratedColumn<DateTime> takenOn = GeneratedColumn<DateTime>('taken_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note =
      GeneratedColumn<String>('note', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, deletedAt, amountPaise, method, takenOn, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'owner_withdrawals';
  @override
  VerificationContext validateIntegrity(Insertable<OwnerWithdrawal> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('amount_paise')) {
      context.handle(_amountPaiseMeta, amountPaise.isAcceptableOrUnknown(data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('taken_on')) {
      context.handle(_takenOnMeta, takenOn.isAcceptableOrUnknown(data['taken_on']!, _takenOnMeta));
    } else if (isInserting) {
      context.missing(_takenOnMeta);
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OwnerWithdrawal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OwnerWithdrawal(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      amountPaise: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
      method: $OwnerWithdrawalsTable.$convertermethod
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}method'])!),
      takenOn: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}taken_on'])!,
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $OwnerWithdrawalsTable createAlias(String alias) {
    return $OwnerWithdrawalsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentMethod, String, String> $convertermethod =
      const EnumNameConverter<PaymentMethod>(PaymentMethod.values);
}

class OwnerWithdrawal extends DataClass implements Insertable<OwnerWithdrawal> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int amountPaise;
  final PaymentMethod method;
  final DateTime takenOn;
  final String? note;
  const OwnerWithdrawal(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.amountPaise,
      required this.method,
      required this.takenOn,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['amount_paise'] = Variable<int>(amountPaise);
    {
      map['method'] = Variable<String>($OwnerWithdrawalsTable.$convertermethod.toSql(method));
    }
    map['taken_on'] = Variable<DateTime>(takenOn);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  OwnerWithdrawalsCompanion toCompanion(bool nullToAbsent) {
    return OwnerWithdrawalsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent ? const Value.absent() : Value(deletedAt),
      amountPaise: Value(amountPaise),
      method: Value(method),
      takenOn: Value(takenOn),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory OwnerWithdrawal.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OwnerWithdrawal(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      method: $OwnerWithdrawalsTable.$convertermethod.fromJson(serializer.fromJson<String>(json['method'])),
      takenOn: serializer.fromJson<DateTime>(json['takenOn']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'method': serializer.toJson<String>($OwnerWithdrawalsTable.$convertermethod.toJson(method)),
      'takenOn': serializer.toJson<DateTime>(takenOn),
      'note': serializer.toJson<String?>(note),
    };
  }

  OwnerWithdrawal copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          int? amountPaise,
          PaymentMethod? method,
          DateTime? takenOn,
          Value<String?> note = const Value.absent()}) =>
      OwnerWithdrawal(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        amountPaise: amountPaise ?? this.amountPaise,
        method: method ?? this.method,
        takenOn: takenOn ?? this.takenOn,
        note: note.present ? note.value : this.note,
      );
  OwnerWithdrawal copyWithCompanion(OwnerWithdrawalsCompanion data) {
    return OwnerWithdrawal(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      amountPaise: data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
      method: data.method.present ? data.method.value : this.method,
      takenOn: data.takenOn.present ? data.takenOn.value : this.takenOn,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OwnerWithdrawal(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('method: $method, ')
          ..write('takenOn: $takenOn, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, deletedAt, amountPaise, method, takenOn, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OwnerWithdrawal &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.amountPaise == this.amountPaise &&
          other.method == this.method &&
          other.takenOn == this.takenOn &&
          other.note == this.note);
}

class OwnerWithdrawalsCompanion extends UpdateCompanion<OwnerWithdrawal> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> amountPaise;
  final Value<PaymentMethod> method;
  final Value<DateTime> takenOn;
  final Value<String?> note;
  final Value<int> rowid;
  const OwnerWithdrawalsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.method = const Value.absent(),
    this.takenOn = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OwnerWithdrawalsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required int amountPaise,
    required PaymentMethod method,
    required DateTime takenOn,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : amountPaise = Value(amountPaise),
        method = Value(method),
        takenOn = Value(takenOn);
  static Insertable<OwnerWithdrawal> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? amountPaise,
    Expression<String>? method,
    Expression<DateTime>? takenOn,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (method != null) 'method': method,
      if (takenOn != null) 'taken_on': takenOn,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OwnerWithdrawalsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? amountPaise,
      Value<PaymentMethod>? method,
      Value<DateTime>? takenOn,
      Value<String?>? note,
      Value<int>? rowid}) {
    return OwnerWithdrawalsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      amountPaise: amountPaise ?? this.amountPaise,
      method: method ?? this.method,
      takenOn: takenOn ?? this.takenOn,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (method.present) {
      map['method'] = Variable<String>($OwnerWithdrawalsTable.$convertermethod.toSql(method.value));
    }
    if (takenOn.present) {
      map['taken_on'] = Variable<DateTime>(takenOn.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OwnerWithdrawalsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('method: $method, ')
          ..write('takenOn: $takenOn, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $BulkRulesTable bulkRules = $BulkRulesTable(this);
  late final $PartiesTable parties = $PartiesTable(this);
  late final $RecipeLinesTable recipeLines = $RecipeLinesTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $ProductionRunsTable productionRuns = $ProductionRunsTable(this);
  late final $StockMovesTable stockMoves = $StockMovesTable(this);
  late final $OrderLinesTable orderLines = $OrderLinesTable(this);
  late final $OrderPhotosTable orderPhotos = $OrderPhotosTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $PaymentAllocationsTable paymentAllocations = $PaymentAllocationsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $OwnerWithdrawalsTable ownerWithdrawals = $OwnerWithdrawalsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        settings,
        products,
        bulkRules,
        parties,
        recipeLines,
        orders,
        productionRuns,
        stockMoves,
        orderLines,
        orderPhotos,
        payments,
        paymentAllocations,
        expenses,
        ownerWithdrawals
      ];
}

typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> businessName,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> upiId,
  Value<String?> logoPath,
  Value<String> languageCode,
  Value<String> themeMode,
  Value<int> hourlyRatePaise,
  Value<int> overheadBp,
  Value<int> retailMarkupBp,
  Value<int> wholesaleMarkupBp,
  Value<int> defaultWholesaleDiscountBp,
  Value<int> targetMarginBp,
  Value<int> priceReviewThresholdBp,
  Value<int> wholesaleTermsDays,
  Value<int> retailTermsDays,
  Value<String> orderPrefix,
  Value<int> nextOrderNumber,
  Value<DateTime?> startDate,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> businessName,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> upiId,
  Value<String?> logoPath,
  Value<String> languageCode,
  Value<String> themeMode,
  Value<int> hourlyRatePaise,
  Value<int> overheadBp,
  Value<int> retailMarkupBp,
  Value<int> wholesaleMarkupBp,
  Value<int> defaultWholesaleDiscountBp,
  Value<int> targetMarginBp,
  Value<int> priceReviewThresholdBp,
  Value<int> wholesaleTermsDays,
  Value<int> retailTermsDays,
  Value<String> orderPrefix,
  Value<int> nextOrderNumber,
  Value<DateTime?> startDate,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get businessName =>
      $composableBuilder(column: $table.businessName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get upiId =>
      $composableBuilder(column: $table.upiId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageCode =>
      $composableBuilder(column: $table.languageCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hourlyRatePaise =>
      $composableBuilder(column: $table.hourlyRatePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get overheadBp =>
      $composableBuilder(column: $table.overheadBp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retailMarkupBp =>
      $composableBuilder(column: $table.retailMarkupBp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wholesaleMarkupBp =>
      $composableBuilder(column: $table.wholesaleMarkupBp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defaultWholesaleDiscountBp =>
      $composableBuilder(column: $table.defaultWholesaleDiscountBp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetMarginBp =>
      $composableBuilder(column: $table.targetMarginBp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priceReviewThresholdBp =>
      $composableBuilder(column: $table.priceReviewThresholdBp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wholesaleTermsDays =>
      $composableBuilder(column: $table.wholesaleTermsDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retailTermsDays =>
      $composableBuilder(column: $table.retailTermsDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderPrefix =>
      $composableBuilder(column: $table.orderPrefix, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nextOrderNumber =>
      $composableBuilder(column: $table.nextOrderNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => ColumnFilters(column));
}

class $$SettingsTableOrderingComposer extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get businessName =>
      $composableBuilder(column: $table.businessName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get upiId =>
      $composableBuilder(column: $table.upiId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageCode =>
      $composableBuilder(column: $table.languageCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hourlyRatePaise =>
      $composableBuilder(column: $table.hourlyRatePaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get overheadBp =>
      $composableBuilder(column: $table.overheadBp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retailMarkupBp =>
      $composableBuilder(column: $table.retailMarkupBp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wholesaleMarkupBp =>
      $composableBuilder(column: $table.wholesaleMarkupBp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultWholesaleDiscountBp =>
      $composableBuilder(column: $table.defaultWholesaleDiscountBp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetMarginBp =>
      $composableBuilder(column: $table.targetMarginBp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priceReviewThresholdBp =>
      $composableBuilder(column: $table.priceReviewThresholdBp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wholesaleTermsDays =>
      $composableBuilder(column: $table.wholesaleTermsDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retailTermsDays =>
      $composableBuilder(column: $table.retailTermsDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderPrefix =>
      $composableBuilder(column: $table.orderPrefix, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nextOrderNumber =>
      $composableBuilder(column: $table.nextOrderNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => ColumnOrderings(column));
}

class $$SettingsTableAnnotationComposer extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get businessName =>
      $composableBuilder(column: $table.businessName, builder: (column) => column);

  GeneratedColumn<String> get phone => $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address => $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get upiId => $composableBuilder(column: $table.upiId, builder: (column) => column);

  GeneratedColumn<String> get logoPath => $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get languageCode =>
      $composableBuilder(column: $table.languageCode, builder: (column) => column);

  GeneratedColumn<String> get themeMode => $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<int> get hourlyRatePaise =>
      $composableBuilder(column: $table.hourlyRatePaise, builder: (column) => column);

  GeneratedColumn<int> get overheadBp => $composableBuilder(column: $table.overheadBp, builder: (column) => column);

  GeneratedColumn<int> get retailMarkupBp =>
      $composableBuilder(column: $table.retailMarkupBp, builder: (column) => column);

  GeneratedColumn<int> get wholesaleMarkupBp =>
      $composableBuilder(column: $table.wholesaleMarkupBp, builder: (column) => column);

  GeneratedColumn<int> get defaultWholesaleDiscountBp =>
      $composableBuilder(column: $table.defaultWholesaleDiscountBp, builder: (column) => column);

  GeneratedColumn<int> get targetMarginBp =>
      $composableBuilder(column: $table.targetMarginBp, builder: (column) => column);

  GeneratedColumn<int> get priceReviewThresholdBp =>
      $composableBuilder(column: $table.priceReviewThresholdBp, builder: (column) => column);

  GeneratedColumn<int> get wholesaleTermsDays =>
      $composableBuilder(column: $table.wholesaleTermsDays, builder: (column) => column);

  GeneratedColumn<int> get retailTermsDays =>
      $composableBuilder(column: $table.retailTermsDays, builder: (column) => column);

  GeneratedColumn<String> get orderPrefix =>
      $composableBuilder(column: $table.orderPrefix, builder: (column) => column);

  GeneratedColumn<int> get nextOrderNumber =>
      $composableBuilder(column: $table.nextOrderNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate => $composableBuilder(column: $table.startDate, builder: (column) => column);
}

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> businessName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> upiId = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<int> hourlyRatePaise = const Value.absent(),
            Value<int> overheadBp = const Value.absent(),
            Value<int> retailMarkupBp = const Value.absent(),
            Value<int> wholesaleMarkupBp = const Value.absent(),
            Value<int> defaultWholesaleDiscountBp = const Value.absent(),
            Value<int> targetMarginBp = const Value.absent(),
            Value<int> priceReviewThresholdBp = const Value.absent(),
            Value<int> wholesaleTermsDays = const Value.absent(),
            Value<int> retailTermsDays = const Value.absent(),
            Value<String> orderPrefix = const Value.absent(),
            Value<int> nextOrderNumber = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            businessName: businessName,
            phone: phone,
            address: address,
            upiId: upiId,
            logoPath: logoPath,
            languageCode: languageCode,
            themeMode: themeMode,
            hourlyRatePaise: hourlyRatePaise,
            overheadBp: overheadBp,
            retailMarkupBp: retailMarkupBp,
            wholesaleMarkupBp: wholesaleMarkupBp,
            defaultWholesaleDiscountBp: defaultWholesaleDiscountBp,
            targetMarginBp: targetMarginBp,
            priceReviewThresholdBp: priceReviewThresholdBp,
            wholesaleTermsDays: wholesaleTermsDays,
            retailTermsDays: retailTermsDays,
            orderPrefix: orderPrefix,
            nextOrderNumber: nextOrderNumber,
            startDate: startDate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> businessName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> upiId = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<int> hourlyRatePaise = const Value.absent(),
            Value<int> overheadBp = const Value.absent(),
            Value<int> retailMarkupBp = const Value.absent(),
            Value<int> wholesaleMarkupBp = const Value.absent(),
            Value<int> defaultWholesaleDiscountBp = const Value.absent(),
            Value<int> targetMarginBp = const Value.absent(),
            Value<int> priceReviewThresholdBp = const Value.absent(),
            Value<int> wholesaleTermsDays = const Value.absent(),
            Value<int> retailTermsDays = const Value.absent(),
            Value<String> orderPrefix = const Value.absent(),
            Value<int> nextOrderNumber = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            businessName: businessName,
            phone: phone,
            address: address,
            upiId: upiId,
            logoPath: logoPath,
            languageCode: languageCode,
            themeMode: themeMode,
            hourlyRatePaise: hourlyRatePaise,
            overheadBp: overheadBp,
            retailMarkupBp: retailMarkupBp,
            wholesaleMarkupBp: wholesaleMarkupBp,
            defaultWholesaleDiscountBp: defaultWholesaleDiscountBp,
            targetMarginBp: targetMarginBp,
            priceReviewThresholdBp: priceReviewThresholdBp,
            wholesaleTermsDays: wholesaleTermsDays,
            retailTermsDays: retailTermsDays,
            orderPrefix: orderPrefix,
            nextOrderNumber: nextOrderNumber,
            startDate: startDate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SettingsTable, Setting>(table),
                    BaseReferences<_$AppDatabase, $SettingsTable, Setting>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()>;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String name,
  required ProductKind kind,
  Value<String> unit,
  Value<String?> category,
  Value<String?> sku,
  Value<String?> photoPath,
  Value<int?> retailPricePaise,
  Value<int?> wholesalePricePaise,
  Value<int?> priceSetCostPaise,
  Value<int> minStockMilli,
  Value<String?> notes,
  Value<bool> archived,
  Value<int> rowid,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> name,
  Value<ProductKind> kind,
  Value<String> unit,
  Value<String?> category,
  Value<String?> sku,
  Value<String?> photoPath,
  Value<int?> retailPricePaise,
  Value<int?> wholesalePricePaise,
  Value<int?> priceSetCostPaise,
  Value<int> minStockMilli,
  Value<String?> notes,
  Value<bool> archived,
  Value<int> rowid,
});

final class $$ProductsTableReferences extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BulkRulesTable, List<BulkRule>> _bulkRulesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.bulkRules, aliasName: 'products__id__bulk_rules__product_id');

  $$BulkRulesTableProcessedTableManager get bulkRulesRefs {
    final manager = $$BulkRulesTableTableManager($_db, $_db.bulkRules)
        .filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bulkRulesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RecipeLinesTable, List<RecipeLine>> _recipeLinesTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.recipeLines, aliasName: 'products__id__recipe_lines__product_id');

  $$RecipeLinesTableProcessedTableManager get recipeLines {
    final manager = $$RecipeLinesTableTableManager($_db, $_db.recipeLines)
        .filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeLinesTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RecipeLinesTable, List<RecipeLine>> _usedInRecipesTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.recipeLines, aliasName: 'products__id__recipe_lines__material_id');

  $$RecipeLinesTableProcessedTableManager get usedInRecipes {
    final manager = $$RecipeLinesTableTableManager($_db, $_db.recipeLines)
        .filter((f) => f.materialId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_usedInRecipesTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProductionRunsTable, List<ProductionRun>> _productionRunsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.productionRuns, aliasName: 'products__id__production_runs__product_id');

  $$ProductionRunsTableProcessedTableManager get productionRunsRefs {
    final manager = $$ProductionRunsTableTableManager($_db, $_db.productionRuns)
        .filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_productionRunsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StockMovesTable, List<StockMove>> _stockMovesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.stockMoves, aliasName: 'products__id__stock_moves__product_id');

  $$StockMovesTableProcessedTableManager get stockMovesRefs {
    final manager = $$StockMovesTableTableManager($_db, $_db.stockMoves)
        .filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$OrderLinesTable, List<OrderLine>> _orderLinesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.orderLines, aliasName: 'products__id__order_lines__product_id');

  $$OrderLinesTableProcessedTableManager get orderLinesRefs {
    final manager = $$OrderLinesTableTableManager($_db, $_db.orderLines)
        .filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderLinesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProductsTableFilterComposer extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ProductKind, ProductKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retailPricePaise =>
      $composableBuilder(column: $table.retailPricePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wholesalePricePaise =>
      $composableBuilder(column: $table.wholesalePricePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priceSetCostPaise =>
      $composableBuilder(column: $table.priceSetCostPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minStockMilli =>
      $composableBuilder(column: $table.minStockMilli, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => ColumnFilters(column));

  Expression<bool> bulkRulesRefs(Expression<bool> Function($$BulkRulesTableFilterComposer f) f) {
    final $$BulkRulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bulkRules,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$BulkRulesTableFilterComposer(
              $db: $db,
              $table: $db.bulkRules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> recipeLines(Expression<bool> Function($$RecipeLinesTableFilterComposer f) f) {
    final $$RecipeLinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.recipeLines,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$RecipeLinesTableFilterComposer(
              $db: $db,
              $table: $db.recipeLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> usedInRecipes(Expression<bool> Function($$RecipeLinesTableFilterComposer f) f) {
    final $$RecipeLinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.recipeLines,
        getReferencedColumn: (t) => t.materialId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$RecipeLinesTableFilterComposer(
              $db: $db,
              $table: $db.recipeLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> productionRunsRefs(Expression<bool> Function($$ProductionRunsTableFilterComposer f) f) {
    final $$ProductionRunsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productionRuns,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductionRunsTableFilterComposer(
              $db: $db,
              $table: $db.productionRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> stockMovesRefs(Expression<bool> Function($$StockMovesTableFilterComposer f) f) {
    final $$StockMovesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockMoves,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$StockMovesTableFilterComposer(
              $db: $db,
              $table: $db.stockMoves,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> orderLinesRefs(Expression<bool> Function($$OrderLinesTableFilterComposer f) f) {
    final $$OrderLinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderLines,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderLinesTableFilterComposer(
              $db: $db,
              $table: $db.orderLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retailPricePaise =>
      $composableBuilder(column: $table.retailPricePaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wholesalePricePaise =>
      $composableBuilder(column: $table.wholesalePricePaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priceSetCostPaise =>
      $composableBuilder(column: $table.priceSetCostPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minStockMilli =>
      $composableBuilder(column: $table.minStockMilli, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableAnnotationComposer extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProductKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get unit => $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get category => $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get sku => $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get photoPath => $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<int> get retailPricePaise =>
      $composableBuilder(column: $table.retailPricePaise, builder: (column) => column);

  GeneratedColumn<int> get wholesalePricePaise =>
      $composableBuilder(column: $table.wholesalePricePaise, builder: (column) => column);

  GeneratedColumn<int> get priceSetCostPaise =>
      $composableBuilder(column: $table.priceSetCostPaise, builder: (column) => column);

  GeneratedColumn<int> get minStockMilli =>
      $composableBuilder(column: $table.minStockMilli, builder: (column) => column);

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get archived => $composableBuilder(column: $table.archived, builder: (column) => column);

  Expression<T> bulkRulesRefs<T extends Object>(Expression<T> Function($$BulkRulesTableAnnotationComposer a) f) {
    final $$BulkRulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bulkRules,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$BulkRulesTableAnnotationComposer(
              $db: $db,
              $table: $db.bulkRules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> recipeLines<T extends Object>(Expression<T> Function($$RecipeLinesTableAnnotationComposer a) f) {
    final $$RecipeLinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.recipeLines,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$RecipeLinesTableAnnotationComposer(
              $db: $db,
              $table: $db.recipeLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> usedInRecipes<T extends Object>(Expression<T> Function($$RecipeLinesTableAnnotationComposer a) f) {
    final $$RecipeLinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.recipeLines,
        getReferencedColumn: (t) => t.materialId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$RecipeLinesTableAnnotationComposer(
              $db: $db,
              $table: $db.recipeLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> productionRunsRefs<T extends Object>(
      Expression<T> Function($$ProductionRunsTableAnnotationComposer a) f) {
    final $$ProductionRunsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productionRuns,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductionRunsTableAnnotationComposer(
              $db: $db,
              $table: $db.productionRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> stockMovesRefs<T extends Object>(Expression<T> Function($$StockMovesTableAnnotationComposer a) f) {
    final $$StockMovesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockMoves,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$StockMovesTableAnnotationComposer(
              $db: $db,
              $table: $db.stockMoves,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> orderLinesRefs<T extends Object>(Expression<T> Function($$OrderLinesTableAnnotationComposer a) f) {
    final $$OrderLinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderLines,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderLinesTableAnnotationComposer(
              $db: $db,
              $table: $db.orderLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, $$ProductsTableReferences),
    Product,
    PrefetchHooks Function(
        {bool bulkRulesRefs,
        bool recipeLines,
        bool usedInRecipes,
        bool productionRunsRefs,
        bool stockMovesRefs,
        bool orderLinesRefs})> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<ProductKind> kind = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<int?> retailPricePaise = const Value.absent(),
            Value<int?> wholesalePricePaise = const Value.absent(),
            Value<int?> priceSetCostPaise = const Value.absent(),
            Value<int> minStockMilli = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> archived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            name: name,
            kind: kind,
            unit: unit,
            category: category,
            sku: sku,
            photoPath: photoPath,
            retailPricePaise: retailPricePaise,
            wholesalePricePaise: wholesalePricePaise,
            priceSetCostPaise: priceSetCostPaise,
            minStockMilli: minStockMilli,
            notes: notes,
            archived: archived,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String name,
            required ProductKind kind,
            Value<String> unit = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<int?> retailPricePaise = const Value.absent(),
            Value<int?> wholesalePricePaise = const Value.absent(),
            Value<int?> priceSetCostPaise = const Value.absent(),
            Value<int> minStockMilli = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> archived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            name: name,
            kind: kind,
            unit: unit,
            category: category,
            sku: sku,
            photoPath: photoPath,
            retailPricePaise: retailPricePaise,
            wholesalePricePaise: wholesalePricePaise,
            priceSetCostPaise: priceSetCostPaise,
            minStockMilli: minStockMilli,
            notes: notes,
            archived: archived,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$ProductsTable, Product>(table), $$ProductsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {bulkRulesRefs = false,
              recipeLines = false,
              usedInRecipes = false,
              productionRunsRefs = false,
              stockMovesRefs = false,
              orderLinesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bulkRulesRefs) db.bulkRules,
                if (recipeLines) db.recipeLines,
                if (usedInRecipes) db.recipeLines,
                if (productionRunsRefs) db.productionRuns,
                if (stockMovesRefs) db.stockMoves,
                if (orderLinesRefs) db.orderLines
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bulkRulesRefs)
                    await $_getPrefetchedDataByColumns<Product, $ProductsTable, BulkRule, $BulkRulesTable>(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences._bulkRulesRefsTable(db),
                        managerFromTypedResult: (p0) => $$ProductsTableReferences(db, table, p0).bulkRulesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'product_id',
                        typedResults: items),
                  if (recipeLines)
                    await $_getPrefetchedDataByColumns<Product, $ProductsTable, RecipeLine, $RecipeLinesTable>(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences._recipeLinesTable(db),
                        managerFromTypedResult: (p0) => $$ProductsTableReferences(db, table, p0).recipeLines,
                        currentColumn: 'id',
                        referencedColumn: 'product_id',
                        typedResults: items),
                  if (usedInRecipes)
                    await $_getPrefetchedDataByColumns<Product, $ProductsTable, RecipeLine, $RecipeLinesTable>(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences._usedInRecipesTable(db),
                        managerFromTypedResult: (p0) => $$ProductsTableReferences(db, table, p0).usedInRecipes,
                        currentColumn: 'id',
                        referencedColumn: 'material_id',
                        typedResults: items),
                  if (productionRunsRefs)
                    await $_getPrefetchedDataByColumns<Product, $ProductsTable, ProductionRun, $ProductionRunsTable>(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences._productionRunsRefsTable(db),
                        managerFromTypedResult: (p0) => $$ProductsTableReferences(db, table, p0).productionRunsRefs,
                        currentColumn: 'id',
                        referencedColumn: 'product_id',
                        typedResults: items),
                  if (stockMovesRefs)
                    await $_getPrefetchedDataByColumns<Product, $ProductsTable, StockMove, $StockMovesTable>(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences._stockMovesRefsTable(db),
                        managerFromTypedResult: (p0) => $$ProductsTableReferences(db, table, p0).stockMovesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'product_id',
                        typedResults: items),
                  if (orderLinesRefs)
                    await $_getPrefetchedDataByColumns<Product, $ProductsTable, OrderLine, $OrderLinesTable>(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences._orderLinesRefsTable(db),
                        managerFromTypedResult: (p0) => $$ProductsTableReferences(db, table, p0).orderLinesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'product_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, $$ProductsTableReferences),
    Product,
    PrefetchHooks Function(
        {bool bulkRulesRefs,
        bool recipeLines,
        bool usedInRecipes,
        bool productionRunsRefs,
        bool stockMovesRefs,
        bool orderLinesRefs})>;
typedef $$BulkRulesTableCreateCompanionBuilder = BulkRulesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> productId,
  required int minQtyMilli,
  required int discountBp,
  Value<bool> wholesaleOnly,
  Value<int> rowid,
});
typedef $$BulkRulesTableUpdateCompanionBuilder = BulkRulesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> productId,
  Value<int> minQtyMilli,
  Value<int> discountBp,
  Value<bool> wholesaleOnly,
  Value<int> rowid,
});

final class $$BulkRulesTableReferences extends BaseReferences<_$AppDatabase, $BulkRulesTable, BulkRule> {
  $$BulkRulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('bulk_rules__product_id__products__id');

  $$ProductsTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<String>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductsTableTableManager($_db, $_db.products).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BulkRulesTableFilterComposer extends Composer<_$AppDatabase, $BulkRulesTable> {
  $$BulkRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minQtyMilli =>
      $composableBuilder(column: $table.minQtyMilli, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get discountBp =>
      $composableBuilder(column: $table.discountBp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get wholesaleOnly =>
      $composableBuilder(column: $table.wholesaleOnly, builder: (column) => ColumnFilters(column));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BulkRulesTableOrderingComposer extends Composer<_$AppDatabase, $BulkRulesTable> {
  $$BulkRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minQtyMilli =>
      $composableBuilder(column: $table.minQtyMilli, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get discountBp =>
      $composableBuilder(column: $table.discountBp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get wholesaleOnly =>
      $composableBuilder(column: $table.wholesaleOnly, builder: (column) => ColumnOrderings(column));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BulkRulesTableAnnotationComposer extends Composer<_$AppDatabase, $BulkRulesTable> {
  $$BulkRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get minQtyMilli => $composableBuilder(column: $table.minQtyMilli, builder: (column) => column);

  GeneratedColumn<int> get discountBp => $composableBuilder(column: $table.discountBp, builder: (column) => column);

  GeneratedColumn<bool> get wholesaleOnly =>
      $composableBuilder(column: $table.wholesaleOnly, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BulkRulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BulkRulesTable,
    BulkRule,
    $$BulkRulesTableFilterComposer,
    $$BulkRulesTableOrderingComposer,
    $$BulkRulesTableAnnotationComposer,
    $$BulkRulesTableCreateCompanionBuilder,
    $$BulkRulesTableUpdateCompanionBuilder,
    (BulkRule, $$BulkRulesTableReferences),
    BulkRule,
    PrefetchHooks Function({bool productId})> {
  $$BulkRulesTableTableManager(_$AppDatabase db, $BulkRulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BulkRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BulkRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$BulkRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> productId = const Value.absent(),
            Value<int> minQtyMilli = const Value.absent(),
            Value<int> discountBp = const Value.absent(),
            Value<bool> wholesaleOnly = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BulkRulesCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            productId: productId,
            minQtyMilli: minQtyMilli,
            discountBp: discountBp,
            wholesaleOnly: wholesaleOnly,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> productId = const Value.absent(),
            required int minQtyMilli,
            required int discountBp,
            Value<bool> wholesaleOnly = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BulkRulesCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            productId: productId,
            minQtyMilli: minQtyMilli,
            discountBp: discountBp,
            wholesaleOnly: wholesaleOnly,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$BulkRulesTable, BulkRule>(table), $$BulkRulesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable: $$BulkRulesTableReferences._productIdTable(db),
                    referencedColumn: $$BulkRulesTableReferences._productIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BulkRulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BulkRulesTable,
    BulkRule,
    $$BulkRulesTableFilterComposer,
    $$BulkRulesTableOrderingComposer,
    $$BulkRulesTableAnnotationComposer,
    $$BulkRulesTableCreateCompanionBuilder,
    $$BulkRulesTableUpdateCompanionBuilder,
    (BulkRule, $$BulkRulesTableReferences),
    BulkRule,
    PrefetchHooks Function({bool productId})>;
typedef $$PartiesTableCreateCompanionBuilder = PartiesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String name,
  Value<String?> businessName,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<PartyRole> role,
  Value<PriceType> priceType,
  Value<SalesChannel?> defaultChannel,
  Value<int?> creditLimitPaise,
  Value<int?> paymentTermsDays,
  Value<int> openingBalancePaise,
  Value<String?> notes,
  Value<bool> archived,
  Value<int> rowid,
});
typedef $$PartiesTableUpdateCompanionBuilder = PartiesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> name,
  Value<String?> businessName,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<PartyRole> role,
  Value<PriceType> priceType,
  Value<SalesChannel?> defaultChannel,
  Value<int?> creditLimitPaise,
  Value<int?> paymentTermsDays,
  Value<int> openingBalancePaise,
  Value<String?> notes,
  Value<bool> archived,
  Value<int> rowid,
});

final class $$PartiesTableReferences extends BaseReferences<_$AppDatabase, $PartiesTable, Party> {
  $$PartiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdersTable, List<Order>> _ordersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.orders, aliasName: 'parties__id__orders__party_id');

  $$OrdersTableProcessedTableManager get ordersRefs {
    final manager =
        $$OrdersTableTableManager($_db, $_db.orders).filter((f) => f.partyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordersRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StockMovesTable, List<StockMove>> _stockMovesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.stockMoves, aliasName: 'parties__id__stock_moves__supplier_id');

  $$StockMovesTableProcessedTableManager get stockMovesRefs {
    final manager = $$StockMovesTableTableManager($_db, $_db.stockMoves)
        .filter((f) => f.supplierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.payments, aliasName: 'parties__id__payments__party_id');

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager($_db, $_db.payments)
        .filter((f) => f.partyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.expenses, aliasName: 'parties__id__expenses__party_id');

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager($_db, $_db.expenses)
        .filter((f) => f.partyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PartiesTableFilterComposer extends Composer<_$AppDatabase, $PartiesTable> {
  $$PartiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get businessName =>
      $composableBuilder(column: $table.businessName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PartyRole, PartyRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<PriceType, PriceType, String> get priceType =>
      $composableBuilder(column: $table.priceType, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<SalesChannel?, SalesChannel, String> get defaultChannel =>
      $composableBuilder(column: $table.defaultChannel, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get creditLimitPaise =>
      $composableBuilder(column: $table.creditLimitPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentTermsDays =>
      $composableBuilder(column: $table.paymentTermsDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get openingBalancePaise =>
      $composableBuilder(column: $table.openingBalancePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => ColumnFilters(column));

  Expression<bool> ordersRefs(Expression<bool> Function($$OrdersTableFilterComposer f) f) {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.partyId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableFilterComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> stockMovesRefs(Expression<bool> Function($$StockMovesTableFilterComposer f) f) {
    final $$StockMovesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockMoves,
        getReferencedColumn: (t) => t.supplierId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$StockMovesTableFilterComposer(
              $db: $db,
              $table: $db.stockMoves,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> paymentsRefs(Expression<bool> Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.partyId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> expensesRefs(Expression<bool> Function($$ExpensesTableFilterComposer f) f) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.partyId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableFilterComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PartiesTableOrderingComposer extends Composer<_$AppDatabase, $PartiesTable> {
  $$PartiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get businessName =>
      $composableBuilder(column: $table.businessName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priceType =>
      $composableBuilder(column: $table.priceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get defaultChannel =>
      $composableBuilder(column: $table.defaultChannel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get creditLimitPaise =>
      $composableBuilder(column: $table.creditLimitPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentTermsDays =>
      $composableBuilder(column: $table.paymentTermsDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get openingBalancePaise =>
      $composableBuilder(column: $table.openingBalancePaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => ColumnOrderings(column));
}

class $$PartiesTableAnnotationComposer extends Composer<_$AppDatabase, $PartiesTable> {
  $$PartiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get businessName =>
      $composableBuilder(column: $table.businessName, builder: (column) => column);

  GeneratedColumn<String> get phone => $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email => $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address => $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PartyRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PriceType, String> get priceType =>
      $composableBuilder(column: $table.priceType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SalesChannel?, String> get defaultChannel =>
      $composableBuilder(column: $table.defaultChannel, builder: (column) => column);

  GeneratedColumn<int> get creditLimitPaise =>
      $composableBuilder(column: $table.creditLimitPaise, builder: (column) => column);

  GeneratedColumn<int> get paymentTermsDays =>
      $composableBuilder(column: $table.paymentTermsDays, builder: (column) => column);

  GeneratedColumn<int> get openingBalancePaise =>
      $composableBuilder(column: $table.openingBalancePaise, builder: (column) => column);

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get archived => $composableBuilder(column: $table.archived, builder: (column) => column);

  Expression<T> ordersRefs<T extends Object>(Expression<T> Function($$OrdersTableAnnotationComposer a) f) {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.partyId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> stockMovesRefs<T extends Object>(Expression<T> Function($$StockMovesTableAnnotationComposer a) f) {
    final $$StockMovesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockMoves,
        getReferencedColumn: (t) => t.supplierId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$StockMovesTableAnnotationComposer(
              $db: $db,
              $table: $db.stockMoves,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(Expression<T> Function($$PaymentsTableAnnotationComposer a) f) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.partyId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(Expression<T> Function($$ExpensesTableAnnotationComposer a) f) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.partyId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableAnnotationComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PartiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PartiesTable,
    Party,
    $$PartiesTableFilterComposer,
    $$PartiesTableOrderingComposer,
    $$PartiesTableAnnotationComposer,
    $$PartiesTableCreateCompanionBuilder,
    $$PartiesTableUpdateCompanionBuilder,
    (Party, $$PartiesTableReferences),
    Party,
    PrefetchHooks Function({bool ordersRefs, bool stockMovesRefs, bool paymentsRefs, bool expensesRefs})> {
  $$PartiesTableTableManager(_$AppDatabase db, $PartiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PartiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PartiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PartiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> businessName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<PartyRole> role = const Value.absent(),
            Value<PriceType> priceType = const Value.absent(),
            Value<SalesChannel?> defaultChannel = const Value.absent(),
            Value<int?> creditLimitPaise = const Value.absent(),
            Value<int?> paymentTermsDays = const Value.absent(),
            Value<int> openingBalancePaise = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> archived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PartiesCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            name: name,
            businessName: businessName,
            phone: phone,
            email: email,
            address: address,
            role: role,
            priceType: priceType,
            defaultChannel: defaultChannel,
            creditLimitPaise: creditLimitPaise,
            paymentTermsDays: paymentTermsDays,
            openingBalancePaise: openingBalancePaise,
            notes: notes,
            archived: archived,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String name,
            Value<String?> businessName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<PartyRole> role = const Value.absent(),
            Value<PriceType> priceType = const Value.absent(),
            Value<SalesChannel?> defaultChannel = const Value.absent(),
            Value<int?> creditLimitPaise = const Value.absent(),
            Value<int?> paymentTermsDays = const Value.absent(),
            Value<int> openingBalancePaise = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> archived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PartiesCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            name: name,
            businessName: businessName,
            phone: phone,
            email: email,
            address: address,
            role: role,
            priceType: priceType,
            defaultChannel: defaultChannel,
            creditLimitPaise: creditLimitPaise,
            paymentTermsDays: paymentTermsDays,
            openingBalancePaise: openingBalancePaise,
            notes: notes,
            archived: archived,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$PartiesTable, Party>(table), $$PartiesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {ordersRefs = false, stockMovesRefs = false, paymentsRefs = false, expensesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (ordersRefs) db.orders,
                if (stockMovesRefs) db.stockMoves,
                if (paymentsRefs) db.payments,
                if (expensesRefs) db.expenses
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordersRefs)
                    await $_getPrefetchedDataByColumns<Party, $PartiesTable, Order, $OrdersTable>(
                        currentTable: table,
                        referencedTable: $$PartiesTableReferences._ordersRefsTable(db),
                        managerFromTypedResult: (p0) => $$PartiesTableReferences(db, table, p0).ordersRefs,
                        currentColumn: 'id',
                        referencedColumn: 'party_id',
                        typedResults: items),
                  if (stockMovesRefs)
                    await $_getPrefetchedDataByColumns<Party, $PartiesTable, StockMove, $StockMovesTable>(
                        currentTable: table,
                        referencedTable: $$PartiesTableReferences._stockMovesRefsTable(db),
                        managerFromTypedResult: (p0) => $$PartiesTableReferences(db, table, p0).stockMovesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'supplier_id',
                        typedResults: items),
                  if (paymentsRefs)
                    await $_getPrefetchedDataByColumns<Party, $PartiesTable, Payment, $PaymentsTable>(
                        currentTable: table,
                        referencedTable: $$PartiesTableReferences._paymentsRefsTable(db),
                        managerFromTypedResult: (p0) => $$PartiesTableReferences(db, table, p0).paymentsRefs,
                        currentColumn: 'id',
                        referencedColumn: 'party_id',
                        typedResults: items),
                  if (expensesRefs)
                    await $_getPrefetchedDataByColumns<Party, $PartiesTable, Expense, $ExpensesTable>(
                        currentTable: table,
                        referencedTable: $$PartiesTableReferences._expensesRefsTable(db),
                        managerFromTypedResult: (p0) => $$PartiesTableReferences(db, table, p0).expensesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'party_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PartiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PartiesTable,
    Party,
    $$PartiesTableFilterComposer,
    $$PartiesTableOrderingComposer,
    $$PartiesTableAnnotationComposer,
    $$PartiesTableCreateCompanionBuilder,
    $$PartiesTableUpdateCompanionBuilder,
    (Party, $$PartiesTableReferences),
    Party,
    PrefetchHooks Function({bool ordersRefs, bool stockMovesRefs, bool paymentsRefs, bool expensesRefs})>;
typedef $$RecipeLinesTableCreateCompanionBuilder = RecipeLinesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String productId,
  required String materialId,
  required int qtyMilli,
  Value<int> rowid,
});
typedef $$RecipeLinesTableUpdateCompanionBuilder = RecipeLinesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> productId,
  Value<String> materialId,
  Value<int> qtyMilli,
  Value<int> rowid,
});

final class $$RecipeLinesTableReferences extends BaseReferences<_$AppDatabase, $RecipeLinesTable, RecipeLine> {
  $$RecipeLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('recipe_lines__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager($_db, $_db.products).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductsTable _materialIdTable(_$AppDatabase db) =>
      db.products.createAlias('recipe_lines__material_id__products__id');

  $$ProductsTableProcessedTableManager get materialId {
    final $_column = $_itemColumn<String>('material_id')!;

    final manager = $$ProductsTableTableManager($_db, $_db.products).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_materialIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RecipeLinesTableFilterComposer extends Composer<_$AppDatabase, $RecipeLinesTable> {
  $$RecipeLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get qtyMilli =>
      $composableBuilder(column: $table.qtyMilli, builder: (column) => ColumnFilters(column));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableFilterComposer get materialId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.materialId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RecipeLinesTableOrderingComposer extends Composer<_$AppDatabase, $RecipeLinesTable> {
  $$RecipeLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qtyMilli =>
      $composableBuilder(column: $table.qtyMilli, builder: (column) => ColumnOrderings(column));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableOrderingComposer get materialId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.materialId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RecipeLinesTableAnnotationComposer extends Composer<_$AppDatabase, $RecipeLinesTable> {
  $$RecipeLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get qtyMilli => $composableBuilder(column: $table.qtyMilli, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableAnnotationComposer get materialId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.materialId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RecipeLinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecipeLinesTable,
    RecipeLine,
    $$RecipeLinesTableFilterComposer,
    $$RecipeLinesTableOrderingComposer,
    $$RecipeLinesTableAnnotationComposer,
    $$RecipeLinesTableCreateCompanionBuilder,
    $$RecipeLinesTableUpdateCompanionBuilder,
    (RecipeLine, $$RecipeLinesTableReferences),
    RecipeLine,
    PrefetchHooks Function({bool productId, bool materialId})> {
  $$RecipeLinesTableTableManager(_$AppDatabase db, $RecipeLinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$RecipeLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$RecipeLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$RecipeLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<String> materialId = const Value.absent(),
            Value<int> qtyMilli = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecipeLinesCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            productId: productId,
            materialId: materialId,
            qtyMilli: qtyMilli,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String productId,
            required String materialId,
            required int qtyMilli,
            Value<int> rowid = const Value.absent(),
          }) =>
              RecipeLinesCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            productId: productId,
            materialId: materialId,
            qtyMilli: qtyMilli,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable<$RecipeLinesTable, RecipeLine>(table), $$RecipeLinesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({productId = false, materialId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable: $$RecipeLinesTableReferences._productIdTable(db),
                    referencedColumn: $$RecipeLinesTableReferences._productIdTable(db).id,
                  ) as T;
                }
                if (materialId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.materialId,
                    referencedTable: $$RecipeLinesTableReferences._materialIdTable(db),
                    referencedColumn: $$RecipeLinesTableReferences._materialIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RecipeLinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecipeLinesTable,
    RecipeLine,
    $$RecipeLinesTableFilterComposer,
    $$RecipeLinesTableOrderingComposer,
    $$RecipeLinesTableAnnotationComposer,
    $$RecipeLinesTableCreateCompanionBuilder,
    $$RecipeLinesTableUpdateCompanionBuilder,
    (RecipeLine, $$RecipeLinesTableReferences),
    RecipeLine,
    PrefetchHooks Function({bool productId, bool materialId})>;
typedef $$OrdersTableCreateCompanionBuilder = OrdersCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String number,
  required String partyId,
  required DateTime orderDate,
  required OrderStatus status,
  Value<SalesChannel?> channel,
  Value<DateTime?> promisedDate,
  Value<DateTime?> deliveredAt,
  Value<DateTime?> dueDate,
  Value<int> deliveryChargePaise,
  Value<int> orderDiscountPaise,
  Value<String?> discountReason,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$OrdersTableUpdateCompanionBuilder = OrdersCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> number,
  Value<String> partyId,
  Value<DateTime> orderDate,
  Value<OrderStatus> status,
  Value<SalesChannel?> channel,
  Value<DateTime?> promisedDate,
  Value<DateTime?> deliveredAt,
  Value<DateTime?> dueDate,
  Value<int> deliveryChargePaise,
  Value<int> orderDiscountPaise,
  Value<String?> discountReason,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$OrdersTableReferences extends BaseReferences<_$AppDatabase, $OrdersTable, Order> {
  $$OrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartiesTable _partyIdTable(_$AppDatabase db) => db.parties.createAlias('orders__party_id__parties__id');

  $$PartiesTableProcessedTableManager get partyId {
    final $_column = $_itemColumn<String>('party_id')!;

    final manager = $$PartiesTableTableManager($_db, $_db.parties).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StockMovesTable, List<StockMove>> _stockMovesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.stockMoves, aliasName: 'orders__id__stock_moves__order_id');

  $$StockMovesTableProcessedTableManager get stockMovesRefs {
    final manager = $$StockMovesTableTableManager($_db, $_db.stockMoves)
        .filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$OrderLinesTable, List<OrderLine>> _orderLinesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.orderLines, aliasName: 'orders__id__order_lines__order_id');

  $$OrderLinesTableProcessedTableManager get orderLinesRefs {
    final manager = $$OrderLinesTableTableManager($_db, $_db.orderLines)
        .filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderLinesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$OrderPhotosTable, List<OrderPhoto>> _orderPhotosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.orderPhotos, aliasName: 'orders__id__order_photos__order_id');

  $$OrderPhotosTableProcessedTableManager get orderPhotosRefs {
    final manager = $$OrderPhotosTableTableManager($_db, $_db.orderPhotos)
        .filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderPhotosRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PaymentAllocationsTable, List<PaymentAllocation>> _paymentAllocationsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.paymentAllocations, aliasName: 'orders__id__payment_allocations__order_id');

  $$PaymentAllocationsTableProcessedTableManager get paymentAllocationsRefs {
    final manager = $$PaymentAllocationsTableTableManager($_db, $_db.paymentAllocations)
        .filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentAllocationsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrdersTableFilterComposer extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get orderDate =>
      $composableBuilder(column: $table.orderDate, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<OrderStatus, OrderStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<SalesChannel?, SalesChannel, String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get promisedDate =>
      $composableBuilder(column: $table.promisedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deliveredAt =>
      $composableBuilder(column: $table.deliveredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deliveryChargePaise =>
      $composableBuilder(column: $table.deliveryChargePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderDiscountPaise =>
      $composableBuilder(column: $table.orderDiscountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get discountReason =>
      $composableBuilder(column: $table.discountReason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnFilters(column));

  $$PartiesTableFilterComposer get partyId {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableFilterComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> stockMovesRefs(Expression<bool> Function($$StockMovesTableFilterComposer f) f) {
    final $$StockMovesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockMoves,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$StockMovesTableFilterComposer(
              $db: $db,
              $table: $db.stockMoves,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> orderLinesRefs(Expression<bool> Function($$OrderLinesTableFilterComposer f) f) {
    final $$OrderLinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderLines,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderLinesTableFilterComposer(
              $db: $db,
              $table: $db.orderLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> orderPhotosRefs(Expression<bool> Function($$OrderPhotosTableFilterComposer f) f) {
    final $$OrderPhotosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderPhotos,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderPhotosTableFilterComposer(
              $db: $db,
              $table: $db.orderPhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> paymentAllocationsRefs(Expression<bool> Function($$PaymentAllocationsTableFilterComposer f) f) {
    final $$PaymentAllocationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.paymentAllocations,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PaymentAllocationsTableFilterComposer(
              $db: $db,
              $table: $db.paymentAllocations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrdersTableOrderingComposer extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get orderDate =>
      $composableBuilder(column: $table.orderDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get promisedDate =>
      $composableBuilder(column: $table.promisedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deliveredAt =>
      $composableBuilder(column: $table.deliveredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deliveryChargePaise =>
      $composableBuilder(column: $table.deliveryChargePaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderDiscountPaise =>
      $composableBuilder(column: $table.orderDiscountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get discountReason =>
      $composableBuilder(column: $table.discountReason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnOrderings(column));

  $$PartiesTableOrderingComposer get partyId {
    final $$PartiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableOrderingComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrdersTableAnnotationComposer extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get number => $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<DateTime> get orderDate => $composableBuilder(column: $table.orderDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OrderStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SalesChannel?, String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);

  GeneratedColumn<DateTime> get promisedDate =>
      $composableBuilder(column: $table.promisedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get deliveredAt =>
      $composableBuilder(column: $table.deliveredAt, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate => $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get deliveryChargePaise =>
      $composableBuilder(column: $table.deliveryChargePaise, builder: (column) => column);

  GeneratedColumn<int> get orderDiscountPaise =>
      $composableBuilder(column: $table.orderDiscountPaise, builder: (column) => column);

  GeneratedColumn<String> get discountReason =>
      $composableBuilder(column: $table.discountReason, builder: (column) => column);

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PartiesTableAnnotationComposer get partyId {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableAnnotationComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> stockMovesRefs<T extends Object>(Expression<T> Function($$StockMovesTableAnnotationComposer a) f) {
    final $$StockMovesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockMoves,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$StockMovesTableAnnotationComposer(
              $db: $db,
              $table: $db.stockMoves,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> orderLinesRefs<T extends Object>(Expression<T> Function($$OrderLinesTableAnnotationComposer a) f) {
    final $$OrderLinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderLines,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderLinesTableAnnotationComposer(
              $db: $db,
              $table: $db.orderLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> orderPhotosRefs<T extends Object>(Expression<T> Function($$OrderPhotosTableAnnotationComposer a) f) {
    final $$OrderPhotosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderPhotos,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderPhotosTableAnnotationComposer(
              $db: $db,
              $table: $db.orderPhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> paymentAllocationsRefs<T extends Object>(
      Expression<T> Function($$PaymentAllocationsTableAnnotationComposer a) f) {
    final $$PaymentAllocationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.paymentAllocations,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PaymentAllocationsTableAnnotationComposer(
              $db: $db,
              $table: $db.paymentAllocations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersTable,
    Order,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableAnnotationComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder,
    (Order, $$OrdersTableReferences),
    Order,
    PrefetchHooks Function(
        {bool partyId, bool stockMovesRefs, bool orderLinesRefs, bool orderPhotosRefs, bool paymentAllocationsRefs})> {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> number = const Value.absent(),
            Value<String> partyId = const Value.absent(),
            Value<DateTime> orderDate = const Value.absent(),
            Value<OrderStatus> status = const Value.absent(),
            Value<SalesChannel?> channel = const Value.absent(),
            Value<DateTime?> promisedDate = const Value.absent(),
            Value<DateTime?> deliveredAt = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<int> deliveryChargePaise = const Value.absent(),
            Value<int> orderDiscountPaise = const Value.absent(),
            Value<String?> discountReason = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            number: number,
            partyId: partyId,
            orderDate: orderDate,
            status: status,
            channel: channel,
            promisedDate: promisedDate,
            deliveredAt: deliveredAt,
            dueDate: dueDate,
            deliveryChargePaise: deliveryChargePaise,
            orderDiscountPaise: orderDiscountPaise,
            discountReason: discountReason,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String number,
            required String partyId,
            required DateTime orderDate,
            required OrderStatus status,
            Value<SalesChannel?> channel = const Value.absent(),
            Value<DateTime?> promisedDate = const Value.absent(),
            Value<DateTime?> deliveredAt = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<int> deliveryChargePaise = const Value.absent(),
            Value<int> orderDiscountPaise = const Value.absent(),
            Value<String?> discountReason = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            number: number,
            partyId: partyId,
            orderDate: orderDate,
            status: status,
            channel: channel,
            promisedDate: promisedDate,
            deliveredAt: deliveredAt,
            dueDate: dueDate,
            deliveryChargePaise: deliveryChargePaise,
            orderDiscountPaise: orderDiscountPaise,
            discountReason: discountReason,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable<$OrdersTable, Order>(table), $$OrdersTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: (
              {partyId = false,
              stockMovesRefs = false,
              orderLinesRefs = false,
              orderPhotosRefs = false,
              paymentAllocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (stockMovesRefs) db.stockMoves,
                if (orderLinesRefs) db.orderLines,
                if (orderPhotosRefs) db.orderPhotos,
                if (paymentAllocationsRefs) db.paymentAllocations
              ],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (partyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.partyId,
                    referencedTable: $$OrdersTableReferences._partyIdTable(db),
                    referencedColumn: $$OrdersTableReferences._partyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stockMovesRefs)
                    await $_getPrefetchedDataByColumns<Order, $OrdersTable, StockMove, $StockMovesTable>(
                        currentTable: table,
                        referencedTable: $$OrdersTableReferences._stockMovesRefsTable(db),
                        managerFromTypedResult: (p0) => $$OrdersTableReferences(db, table, p0).stockMovesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'order_id',
                        typedResults: items),
                  if (orderLinesRefs)
                    await $_getPrefetchedDataByColumns<Order, $OrdersTable, OrderLine, $OrderLinesTable>(
                        currentTable: table,
                        referencedTable: $$OrdersTableReferences._orderLinesRefsTable(db),
                        managerFromTypedResult: (p0) => $$OrdersTableReferences(db, table, p0).orderLinesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'order_id',
                        typedResults: items),
                  if (orderPhotosRefs)
                    await $_getPrefetchedDataByColumns<Order, $OrdersTable, OrderPhoto, $OrderPhotosTable>(
                        currentTable: table,
                        referencedTable: $$OrdersTableReferences._orderPhotosRefsTable(db),
                        managerFromTypedResult: (p0) => $$OrdersTableReferences(db, table, p0).orderPhotosRefs,
                        currentColumn: 'id',
                        referencedColumn: 'order_id',
                        typedResults: items),
                  if (paymentAllocationsRefs)
                    await $_getPrefetchedDataByColumns<Order, $OrdersTable, PaymentAllocation,
                            $PaymentAllocationsTable>(
                        currentTable: table,
                        referencedTable: $$OrdersTableReferences._paymentAllocationsRefsTable(db),
                        managerFromTypedResult: (p0) => $$OrdersTableReferences(db, table, p0).paymentAllocationsRefs,
                        currentColumn: 'id',
                        referencedColumn: 'order_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OrdersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdersTable,
    Order,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableAnnotationComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder,
    (Order, $$OrdersTableReferences),
    Order,
    PrefetchHooks Function(
        {bool partyId, bool stockMovesRefs, bool orderLinesRefs, bool orderPhotosRefs, bool paymentAllocationsRefs})>;
typedef $$ProductionRunsTableCreateCompanionBuilder = ProductionRunsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String productId,
  required int qtyMilli,
  required DateTime madeOn,
  Value<int> batchMinutes,
  required int materialCostPaise,
  required int labourCostPaise,
  required int overheadCostPaise,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$ProductionRunsTableUpdateCompanionBuilder = ProductionRunsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> productId,
  Value<int> qtyMilli,
  Value<DateTime> madeOn,
  Value<int> batchMinutes,
  Value<int> materialCostPaise,
  Value<int> labourCostPaise,
  Value<int> overheadCostPaise,
  Value<String?> note,
  Value<int> rowid,
});

final class $$ProductionRunsTableReferences extends BaseReferences<_$AppDatabase, $ProductionRunsTable, ProductionRun> {
  $$ProductionRunsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('production_runs__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager($_db, $_db.products).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StockMovesTable, List<StockMove>> _stockMovesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.stockMoves, aliasName: 'production_runs__id__stock_moves__production_run_id');

  $$StockMovesTableProcessedTableManager get stockMovesRefs {
    final manager = $$StockMovesTableTableManager($_db, $_db.stockMoves)
        .filter((f) => f.productionRunId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProductionRunsTableFilterComposer extends Composer<_$AppDatabase, $ProductionRunsTable> {
  $$ProductionRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get qtyMilli =>
      $composableBuilder(column: $table.qtyMilli, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get madeOn =>
      $composableBuilder(column: $table.madeOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get batchMinutes =>
      $composableBuilder(column: $table.batchMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get materialCostPaise =>
      $composableBuilder(column: $table.materialCostPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get labourCostPaise =>
      $composableBuilder(column: $table.labourCostPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get overheadCostPaise =>
      $composableBuilder(column: $table.overheadCostPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> stockMovesRefs(Expression<bool> Function($$StockMovesTableFilterComposer f) f) {
    final $$StockMovesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockMoves,
        getReferencedColumn: (t) => t.productionRunId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$StockMovesTableFilterComposer(
              $db: $db,
              $table: $db.stockMoves,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductionRunsTableOrderingComposer extends Composer<_$AppDatabase, $ProductionRunsTable> {
  $$ProductionRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qtyMilli =>
      $composableBuilder(column: $table.qtyMilli, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get madeOn =>
      $composableBuilder(column: $table.madeOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get batchMinutes =>
      $composableBuilder(column: $table.batchMinutes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get materialCostPaise =>
      $composableBuilder(column: $table.materialCostPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get labourCostPaise =>
      $composableBuilder(column: $table.labourCostPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get overheadCostPaise =>
      $composableBuilder(column: $table.overheadCostPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductionRunsTableAnnotationComposer extends Composer<_$AppDatabase, $ProductionRunsTable> {
  $$ProductionRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get qtyMilli => $composableBuilder(column: $table.qtyMilli, builder: (column) => column);

  GeneratedColumn<DateTime> get madeOn => $composableBuilder(column: $table.madeOn, builder: (column) => column);

  GeneratedColumn<int> get batchMinutes => $composableBuilder(column: $table.batchMinutes, builder: (column) => column);

  GeneratedColumn<int> get materialCostPaise =>
      $composableBuilder(column: $table.materialCostPaise, builder: (column) => column);

  GeneratedColumn<int> get labourCostPaise =>
      $composableBuilder(column: $table.labourCostPaise, builder: (column) => column);

  GeneratedColumn<int> get overheadCostPaise =>
      $composableBuilder(column: $table.overheadCostPaise, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> stockMovesRefs<T extends Object>(Expression<T> Function($$StockMovesTableAnnotationComposer a) f) {
    final $$StockMovesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.stockMoves,
        getReferencedColumn: (t) => t.productionRunId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$StockMovesTableAnnotationComposer(
              $db: $db,
              $table: $db.stockMoves,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductionRunsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductionRunsTable,
    ProductionRun,
    $$ProductionRunsTableFilterComposer,
    $$ProductionRunsTableOrderingComposer,
    $$ProductionRunsTableAnnotationComposer,
    $$ProductionRunsTableCreateCompanionBuilder,
    $$ProductionRunsTableUpdateCompanionBuilder,
    (ProductionRun, $$ProductionRunsTableReferences),
    ProductionRun,
    PrefetchHooks Function({bool productId, bool stockMovesRefs})> {
  $$ProductionRunsTableTableManager(_$AppDatabase db, $ProductionRunsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ProductionRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ProductionRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ProductionRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<int> qtyMilli = const Value.absent(),
            Value<DateTime> madeOn = const Value.absent(),
            Value<int> batchMinutes = const Value.absent(),
            Value<int> materialCostPaise = const Value.absent(),
            Value<int> labourCostPaise = const Value.absent(),
            Value<int> overheadCostPaise = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductionRunsCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            productId: productId,
            qtyMilli: qtyMilli,
            madeOn: madeOn,
            batchMinutes: batchMinutes,
            materialCostPaise: materialCostPaise,
            labourCostPaise: labourCostPaise,
            overheadCostPaise: overheadCostPaise,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String productId,
            required int qtyMilli,
            required DateTime madeOn,
            Value<int> batchMinutes = const Value.absent(),
            required int materialCostPaise,
            required int labourCostPaise,
            required int overheadCostPaise,
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductionRunsCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            productId: productId,
            qtyMilli: qtyMilli,
            madeOn: madeOn,
            batchMinutes: batchMinutes,
            materialCostPaise: materialCostPaise,
            labourCostPaise: labourCostPaise,
            overheadCostPaise: overheadCostPaise,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ProductionRunsTable, ProductionRun>(table),
                    $$ProductionRunsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({productId = false, stockMovesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (stockMovesRefs) db.stockMoves],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable: $$ProductionRunsTableReferences._productIdTable(db),
                    referencedColumn: $$ProductionRunsTableReferences._productIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stockMovesRefs)
                    await $_getPrefetchedDataByColumns<ProductionRun, $ProductionRunsTable, StockMove,
                            $StockMovesTable>(
                        currentTable: table,
                        referencedTable: $$ProductionRunsTableReferences._stockMovesRefsTable(db),
                        managerFromTypedResult: (p0) => $$ProductionRunsTableReferences(db, table, p0).stockMovesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'production_run_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProductionRunsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductionRunsTable,
    ProductionRun,
    $$ProductionRunsTableFilterComposer,
    $$ProductionRunsTableOrderingComposer,
    $$ProductionRunsTableAnnotationComposer,
    $$ProductionRunsTableCreateCompanionBuilder,
    $$ProductionRunsTableUpdateCompanionBuilder,
    (ProductionRun, $$ProductionRunsTableReferences),
    ProductionRun,
    PrefetchHooks Function({bool productId, bool stockMovesRefs})>;
typedef $$StockMovesTableCreateCompanionBuilder = StockMovesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String productId,
  required int qtyMilli,
  required StockMoveType type,
  Value<int> valuePaise,
  required DateTime movedAt,
  Value<String?> orderId,
  Value<String?> productionRunId,
  Value<String?> supplierId,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$StockMovesTableUpdateCompanionBuilder = StockMovesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> productId,
  Value<int> qtyMilli,
  Value<StockMoveType> type,
  Value<int> valuePaise,
  Value<DateTime> movedAt,
  Value<String?> orderId,
  Value<String?> productionRunId,
  Value<String?> supplierId,
  Value<String?> note,
  Value<int> rowid,
});

final class $$StockMovesTableReferences extends BaseReferences<_$AppDatabase, $StockMovesTable, StockMove> {
  $$StockMovesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('stock_moves__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager($_db, $_db.products).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders.createAlias('stock_moves__order_id__orders__id');

  $$OrdersTableProcessedTableManager? get orderId {
    final $_column = $_itemColumn<String>('order_id');
    if ($_column == null) return null;
    final manager = $$OrdersTableTableManager($_db, $_db.orders).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductionRunsTable _productionRunIdTable(_$AppDatabase db) =>
      db.productionRuns.createAlias('stock_moves__production_run_id__production_runs__id');

  $$ProductionRunsTableProcessedTableManager? get productionRunId {
    final $_column = $_itemColumn<String>('production_run_id');
    if ($_column == null) return null;
    final manager =
        $$ProductionRunsTableTableManager($_db, $_db.productionRuns).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productionRunIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PartiesTable _supplierIdTable(_$AppDatabase db) =>
      db.parties.createAlias('stock_moves__supplier_id__parties__id');

  $$PartiesTableProcessedTableManager? get supplierId {
    final $_column = $_itemColumn<String>('supplier_id');
    if ($_column == null) return null;
    final manager = $$PartiesTableTableManager($_db, $_db.parties).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StockMovesTableFilterComposer extends Composer<_$AppDatabase, $StockMovesTable> {
  $$StockMovesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get qtyMilli =>
      $composableBuilder(column: $table.qtyMilli, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<StockMoveType, StockMoveType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get valuePaise =>
      $composableBuilder(column: $table.valuePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get movedAt =>
      $composableBuilder(column: $table.movedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableFilterComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductionRunsTableFilterComposer get productionRunId {
    final $$ProductionRunsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productionRunId,
        referencedTable: $db.productionRuns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductionRunsTableFilterComposer(
              $db: $db,
              $table: $db.productionRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartiesTableFilterComposer get supplierId {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableFilterComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockMovesTableOrderingComposer extends Composer<_$AppDatabase, $StockMovesTable> {
  $$StockMovesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qtyMilli =>
      $composableBuilder(column: $table.qtyMilli, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get valuePaise =>
      $composableBuilder(column: $table.valuePaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get movedAt =>
      $composableBuilder(column: $table.movedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableOrderingComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductionRunsTableOrderingComposer get productionRunId {
    final $$ProductionRunsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productionRunId,
        referencedTable: $db.productionRuns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductionRunsTableOrderingComposer(
              $db: $db,
              $table: $db.productionRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartiesTableOrderingComposer get supplierId {
    final $$PartiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableOrderingComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockMovesTableAnnotationComposer extends Composer<_$AppDatabase, $StockMovesTable> {
  $$StockMovesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get qtyMilli => $composableBuilder(column: $table.qtyMilli, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StockMoveType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get valuePaise => $composableBuilder(column: $table.valuePaise, builder: (column) => column);

  GeneratedColumn<DateTime> get movedAt => $composableBuilder(column: $table.movedAt, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductionRunsTableAnnotationComposer get productionRunId {
    final $$ProductionRunsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productionRunId,
        referencedTable: $db.productionRuns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductionRunsTableAnnotationComposer(
              $db: $db,
              $table: $db.productionRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PartiesTableAnnotationComposer get supplierId {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableAnnotationComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StockMovesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StockMovesTable,
    StockMove,
    $$StockMovesTableFilterComposer,
    $$StockMovesTableOrderingComposer,
    $$StockMovesTableAnnotationComposer,
    $$StockMovesTableCreateCompanionBuilder,
    $$StockMovesTableUpdateCompanionBuilder,
    (StockMove, $$StockMovesTableReferences),
    StockMove,
    PrefetchHooks Function({bool productId, bool orderId, bool productionRunId, bool supplierId})> {
  $$StockMovesTableTableManager(_$AppDatabase db, $StockMovesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$StockMovesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$StockMovesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$StockMovesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<int> qtyMilli = const Value.absent(),
            Value<StockMoveType> type = const Value.absent(),
            Value<int> valuePaise = const Value.absent(),
            Value<DateTime> movedAt = const Value.absent(),
            Value<String?> orderId = const Value.absent(),
            Value<String?> productionRunId = const Value.absent(),
            Value<String?> supplierId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StockMovesCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            productId: productId,
            qtyMilli: qtyMilli,
            type: type,
            valuePaise: valuePaise,
            movedAt: movedAt,
            orderId: orderId,
            productionRunId: productionRunId,
            supplierId: supplierId,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String productId,
            required int qtyMilli,
            required StockMoveType type,
            Value<int> valuePaise = const Value.absent(),
            required DateTime movedAt,
            Value<String?> orderId = const Value.absent(),
            Value<String?> productionRunId = const Value.absent(),
            Value<String?> supplierId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StockMovesCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            productId: productId,
            qtyMilli: qtyMilli,
            type: type,
            valuePaise: valuePaise,
            movedAt: movedAt,
            orderId: orderId,
            productionRunId: productionRunId,
            supplierId: supplierId,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$StockMovesTable, StockMove>(table), $$StockMovesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({productId = false, orderId = false, productionRunId = false, supplierId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable: $$StockMovesTableReferences._productIdTable(db),
                    referencedColumn: $$StockMovesTableReferences._productIdTable(db).id,
                  ) as T;
                }
                if (orderId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orderId,
                    referencedTable: $$StockMovesTableReferences._orderIdTable(db),
                    referencedColumn: $$StockMovesTableReferences._orderIdTable(db).id,
                  ) as T;
                }
                if (productionRunId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productionRunId,
                    referencedTable: $$StockMovesTableReferences._productionRunIdTable(db),
                    referencedColumn: $$StockMovesTableReferences._productionRunIdTable(db).id,
                  ) as T;
                }
                if (supplierId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.supplierId,
                    referencedTable: $$StockMovesTableReferences._supplierIdTable(db),
                    referencedColumn: $$StockMovesTableReferences._supplierIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StockMovesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StockMovesTable,
    StockMove,
    $$StockMovesTableFilterComposer,
    $$StockMovesTableOrderingComposer,
    $$StockMovesTableAnnotationComposer,
    $$StockMovesTableCreateCompanionBuilder,
    $$StockMovesTableUpdateCompanionBuilder,
    (StockMove, $$StockMovesTableReferences),
    StockMove,
    PrefetchHooks Function({bool productId, bool orderId, bool productionRunId, bool supplierId})>;
typedef $$OrderLinesTableCreateCompanionBuilder = OrderLinesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String orderId,
  Value<String?> productId,
  Value<String?> description,
  Value<int> position,
  required int qtyMilli,
  required int unitPricePaise,
  Value<int?> listPricePaise,
  Value<int> lineDiscountPaise,
  Value<int?> unitCostPaise,
  Value<String?> specColour,
  Value<String?> specSize,
  Value<String?> specText,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$OrderLinesTableUpdateCompanionBuilder = OrderLinesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> orderId,
  Value<String?> productId,
  Value<String?> description,
  Value<int> position,
  Value<int> qtyMilli,
  Value<int> unitPricePaise,
  Value<int?> listPricePaise,
  Value<int> lineDiscountPaise,
  Value<int?> unitCostPaise,
  Value<String?> specColour,
  Value<String?> specSize,
  Value<String?> specText,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$OrderLinesTableReferences extends BaseReferences<_$AppDatabase, $OrderLinesTable, OrderLine> {
  $$OrderLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders.createAlias('order_lines__order_id__orders__id');

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$OrdersTableTableManager($_db, $_db.orders).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('order_lines__product_id__products__id');

  $$ProductsTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<String>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductsTableTableManager($_db, $_db.products).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$OrderPhotosTable, List<OrderPhoto>> _orderPhotosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.orderPhotos, aliasName: 'order_lines__id__order_photos__order_line_id');

  $$OrderPhotosTableProcessedTableManager get orderPhotosRefs {
    final manager = $$OrderPhotosTableTableManager($_db, $_db.orderPhotos)
        .filter((f) => f.orderLineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderPhotosRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrderLinesTableFilterComposer extends Composer<_$AppDatabase, $OrderLinesTable> {
  $$OrderLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description =>
      $composableBuilder(column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get qtyMilli =>
      $composableBuilder(column: $table.qtyMilli, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unitPricePaise =>
      $composableBuilder(column: $table.unitPricePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get listPricePaise =>
      $composableBuilder(column: $table.listPricePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lineDiscountPaise =>
      $composableBuilder(column: $table.lineDiscountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unitCostPaise =>
      $composableBuilder(column: $table.unitCostPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specColour =>
      $composableBuilder(column: $table.specColour, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specSize =>
      $composableBuilder(column: $table.specSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specText =>
      $composableBuilder(column: $table.specText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnFilters(column));

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableFilterComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> orderPhotosRefs(Expression<bool> Function($$OrderPhotosTableFilterComposer f) f) {
    final $$OrderPhotosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderPhotos,
        getReferencedColumn: (t) => t.orderLineId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderPhotosTableFilterComposer(
              $db: $db,
              $table: $db.orderPhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrderLinesTableOrderingComposer extends Composer<_$AppDatabase, $OrderLinesTable> {
  $$OrderLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description =>
      $composableBuilder(column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qtyMilli =>
      $composableBuilder(column: $table.qtyMilli, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unitPricePaise =>
      $composableBuilder(column: $table.unitPricePaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get listPricePaise =>
      $composableBuilder(column: $table.listPricePaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lineDiscountPaise =>
      $composableBuilder(column: $table.lineDiscountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unitCostPaise =>
      $composableBuilder(column: $table.unitCostPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specColour =>
      $composableBuilder(column: $table.specColour, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specSize =>
      $composableBuilder(column: $table.specSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specText =>
      $composableBuilder(column: $table.specText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnOrderings(column));

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableOrderingComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrderLinesTableAnnotationComposer extends Composer<_$AppDatabase, $OrderLinesTable> {
  $$OrderLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get description =>
      $composableBuilder(column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get position => $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get qtyMilli => $composableBuilder(column: $table.qtyMilli, builder: (column) => column);

  GeneratedColumn<int> get unitPricePaise =>
      $composableBuilder(column: $table.unitPricePaise, builder: (column) => column);

  GeneratedColumn<int> get listPricePaise =>
      $composableBuilder(column: $table.listPricePaise, builder: (column) => column);

  GeneratedColumn<int> get lineDiscountPaise =>
      $composableBuilder(column: $table.lineDiscountPaise, builder: (column) => column);

  GeneratedColumn<int> get unitCostPaise =>
      $composableBuilder(column: $table.unitCostPaise, builder: (column) => column);

  GeneratedColumn<String> get specColour => $composableBuilder(column: $table.specColour, builder: (column) => column);

  GeneratedColumn<String> get specSize => $composableBuilder(column: $table.specSize, builder: (column) => column);

  GeneratedColumn<String> get specText => $composableBuilder(column: $table.specText, builder: (column) => column);

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> orderPhotosRefs<T extends Object>(Expression<T> Function($$OrderPhotosTableAnnotationComposer a) f) {
    final $$OrderPhotosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderPhotos,
        getReferencedColumn: (t) => t.orderLineId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderPhotosTableAnnotationComposer(
              $db: $db,
              $table: $db.orderPhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrderLinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrderLinesTable,
    OrderLine,
    $$OrderLinesTableFilterComposer,
    $$OrderLinesTableOrderingComposer,
    $$OrderLinesTableAnnotationComposer,
    $$OrderLinesTableCreateCompanionBuilder,
    $$OrderLinesTableUpdateCompanionBuilder,
    (OrderLine, $$OrderLinesTableReferences),
    OrderLine,
    PrefetchHooks Function({bool orderId, bool productId, bool orderPhotosRefs})> {
  $$OrderLinesTableTableManager(_$AppDatabase db, $OrderLinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$OrderLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$OrderLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$OrderLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> orderId = const Value.absent(),
            Value<String?> productId = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> qtyMilli = const Value.absent(),
            Value<int> unitPricePaise = const Value.absent(),
            Value<int?> listPricePaise = const Value.absent(),
            Value<int> lineDiscountPaise = const Value.absent(),
            Value<int?> unitCostPaise = const Value.absent(),
            Value<String?> specColour = const Value.absent(),
            Value<String?> specSize = const Value.absent(),
            Value<String?> specText = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderLinesCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            orderId: orderId,
            productId: productId,
            description: description,
            position: position,
            qtyMilli: qtyMilli,
            unitPricePaise: unitPricePaise,
            listPricePaise: listPricePaise,
            lineDiscountPaise: lineDiscountPaise,
            unitCostPaise: unitCostPaise,
            specColour: specColour,
            specSize: specSize,
            specText: specText,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String orderId,
            Value<String?> productId = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> position = const Value.absent(),
            required int qtyMilli,
            required int unitPricePaise,
            Value<int?> listPricePaise = const Value.absent(),
            Value<int> lineDiscountPaise = const Value.absent(),
            Value<int?> unitCostPaise = const Value.absent(),
            Value<String?> specColour = const Value.absent(),
            Value<String?> specSize = const Value.absent(),
            Value<String?> specText = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderLinesCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            orderId: orderId,
            productId: productId,
            description: description,
            position: position,
            qtyMilli: qtyMilli,
            unitPricePaise: unitPricePaise,
            listPricePaise: listPricePaise,
            lineDiscountPaise: lineDiscountPaise,
            unitCostPaise: unitCostPaise,
            specColour: specColour,
            specSize: specSize,
            specText: specText,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$OrderLinesTable, OrderLine>(table), $$OrderLinesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({orderId = false, productId = false, orderPhotosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (orderPhotosRefs) db.orderPhotos],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (orderId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orderId,
                    referencedTable: $$OrderLinesTableReferences._orderIdTable(db),
                    referencedColumn: $$OrderLinesTableReferences._orderIdTable(db).id,
                  ) as T;
                }
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable: $$OrderLinesTableReferences._productIdTable(db),
                    referencedColumn: $$OrderLinesTableReferences._productIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (orderPhotosRefs)
                    await $_getPrefetchedDataByColumns<OrderLine, $OrderLinesTable, OrderPhoto, $OrderPhotosTable>(
                        currentTable: table,
                        referencedTable: $$OrderLinesTableReferences._orderPhotosRefsTable(db),
                        managerFromTypedResult: (p0) => $$OrderLinesTableReferences(db, table, p0).orderPhotosRefs,
                        currentColumn: 'id',
                        referencedColumn: 'order_line_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OrderLinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrderLinesTable,
    OrderLine,
    $$OrderLinesTableFilterComposer,
    $$OrderLinesTableOrderingComposer,
    $$OrderLinesTableAnnotationComposer,
    $$OrderLinesTableCreateCompanionBuilder,
    $$OrderLinesTableUpdateCompanionBuilder,
    (OrderLine, $$OrderLinesTableReferences),
    OrderLine,
    PrefetchHooks Function({bool orderId, bool productId, bool orderPhotosRefs})>;
typedef $$OrderPhotosTableCreateCompanionBuilder = OrderPhotosCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String orderId,
  Value<String?> orderLineId,
  required String path,
  Value<String?> caption,
  Value<int> rowid,
});
typedef $$OrderPhotosTableUpdateCompanionBuilder = OrderPhotosCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> orderId,
  Value<String?> orderLineId,
  Value<String> path,
  Value<String?> caption,
  Value<int> rowid,
});

final class $$OrderPhotosTableReferences extends BaseReferences<_$AppDatabase, $OrderPhotosTable, OrderPhoto> {
  $$OrderPhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders.createAlias('order_photos__order_id__orders__id');

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$OrdersTableTableManager($_db, $_db.orders).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $OrderLinesTable _orderLineIdTable(_$AppDatabase db) =>
      db.orderLines.createAlias('order_photos__order_line_id__order_lines__id');

  $$OrderLinesTableProcessedTableManager? get orderLineId {
    final $_column = $_itemColumn<String>('order_line_id');
    if ($_column == null) return null;
    final manager = $$OrderLinesTableTableManager($_db, $_db.orderLines).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderLineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$OrderPhotosTableFilterComposer extends Composer<_$AppDatabase, $OrderPhotosTable> {
  $$OrderPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => ColumnFilters(column));

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableFilterComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrderLinesTableFilterComposer get orderLineId {
    final $$OrderLinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderLineId,
        referencedTable: $db.orderLines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderLinesTableFilterComposer(
              $db: $db,
              $table: $db.orderLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrderPhotosTableOrderingComposer extends Composer<_$AppDatabase, $OrderPhotosTable> {
  $$OrderPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => ColumnOrderings(column));

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableOrderingComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrderLinesTableOrderingComposer get orderLineId {
    final $$OrderLinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderLineId,
        referencedTable: $db.orderLines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderLinesTableOrderingComposer(
              $db: $db,
              $table: $db.orderLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrderPhotosTableAnnotationComposer extends Composer<_$AppDatabase, $OrderPhotosTable> {
  $$OrderPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get path => $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get caption => $composableBuilder(column: $table.caption, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrderLinesTableAnnotationComposer get orderLineId {
    final $$OrderLinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderLineId,
        referencedTable: $db.orderLines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrderLinesTableAnnotationComposer(
              $db: $db,
              $table: $db.orderLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrderPhotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrderPhotosTable,
    OrderPhoto,
    $$OrderPhotosTableFilterComposer,
    $$OrderPhotosTableOrderingComposer,
    $$OrderPhotosTableAnnotationComposer,
    $$OrderPhotosTableCreateCompanionBuilder,
    $$OrderPhotosTableUpdateCompanionBuilder,
    (OrderPhoto, $$OrderPhotosTableReferences),
    OrderPhoto,
    PrefetchHooks Function({bool orderId, bool orderLineId})> {
  $$OrderPhotosTableTableManager(_$AppDatabase db, $OrderPhotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$OrderPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$OrderPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$OrderPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> orderId = const Value.absent(),
            Value<String?> orderLineId = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String?> caption = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderPhotosCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            orderId: orderId,
            orderLineId: orderLineId,
            path: path,
            caption: caption,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String orderId,
            Value<String?> orderLineId = const Value.absent(),
            required String path,
            Value<String?> caption = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderPhotosCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            orderId: orderId,
            orderLineId: orderLineId,
            path: path,
            caption: caption,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable<$OrderPhotosTable, OrderPhoto>(table), $$OrderPhotosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({orderId = false, orderLineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (orderId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orderId,
                    referencedTable: $$OrderPhotosTableReferences._orderIdTable(db),
                    referencedColumn: $$OrderPhotosTableReferences._orderIdTable(db).id,
                  ) as T;
                }
                if (orderLineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orderLineId,
                    referencedTable: $$OrderPhotosTableReferences._orderLineIdTable(db),
                    referencedColumn: $$OrderPhotosTableReferences._orderLineIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$OrderPhotosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrderPhotosTable,
    OrderPhoto,
    $$OrderPhotosTableFilterComposer,
    $$OrderPhotosTableOrderingComposer,
    $$OrderPhotosTableAnnotationComposer,
    $$OrderPhotosTableCreateCompanionBuilder,
    $$OrderPhotosTableUpdateCompanionBuilder,
    (OrderPhoto, $$OrderPhotosTableReferences),
    OrderPhoto,
    PrefetchHooks Function({bool orderId, bool orderLineId})>;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> partyId,
  required PaymentPurpose purpose,
  required int amountPaise,
  required PaymentMethod method,
  required DateTime paidOn,
  Value<String?> reference,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String?> partyId,
  Value<PaymentPurpose> purpose,
  Value<int> amountPaise,
  Value<PaymentMethod> method,
  Value<DateTime> paidOn,
  Value<String?> reference,
  Value<String?> note,
  Value<int> rowid,
});

final class $$PaymentsTableReferences extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartiesTable _partyIdTable(_$AppDatabase db) => db.parties.createAlias('payments__party_id__parties__id');

  $$PartiesTableProcessedTableManager? get partyId {
    final $_column = $_itemColumn<String>('party_id');
    if ($_column == null) return null;
    final manager = $$PartiesTableTableManager($_db, $_db.parties).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PaymentAllocationsTable, List<PaymentAllocation>> _paymentAllocationsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.paymentAllocations, aliasName: 'payments__id__payment_allocations__payment_id');

  $$PaymentAllocationsTableProcessedTableManager get paymentAllocationsRefs {
    final manager = $$PaymentAllocationsTableTableManager($_db, $_db.paymentAllocations)
        .filter((f) => f.paymentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentAllocationsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PaymentsTableFilterComposer extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentPurpose, PaymentPurpose, String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get amountPaise =>
      $composableBuilder(column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get paidOn =>
      $composableBuilder(column: $table.paidOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  $$PartiesTableFilterComposer get partyId {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableFilterComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> paymentAllocationsRefs(Expression<bool> Function($$PaymentAllocationsTableFilterComposer f) f) {
    final $$PaymentAllocationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.paymentAllocations,
        getReferencedColumn: (t) => t.paymentId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PaymentAllocationsTableFilterComposer(
              $db: $db,
              $table: $db.paymentAllocations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PaymentsTableOrderingComposer extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise =>
      $composableBuilder(column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paidOn =>
      $composableBuilder(column: $table.paidOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  $$PartiesTableOrderingComposer get partyId {
    final $$PartiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableOrderingComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentPurpose, String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(column: $table.amountPaise, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get paidOn => $composableBuilder(column: $table.paidOn, builder: (column) => column);

  GeneratedColumn<String> get reference => $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  $$PartiesTableAnnotationComposer get partyId {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableAnnotationComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> paymentAllocationsRefs<T extends Object>(
      Expression<T> Function($$PaymentAllocationsTableAnnotationComposer a) f) {
    final $$PaymentAllocationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.paymentAllocations,
        getReferencedColumn: (t) => t.paymentId,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PaymentAllocationsTableAnnotationComposer(
              $db: $db,
              $table: $db.paymentAllocations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool partyId, bool paymentAllocationsRefs})> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> partyId = const Value.absent(),
            Value<PaymentPurpose> purpose = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<PaymentMethod> method = const Value.absent(),
            Value<DateTime> paidOn = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            partyId: partyId,
            purpose: purpose,
            amountPaise: amountPaise,
            method: method,
            paidOn: paidOn,
            reference: reference,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String?> partyId = const Value.absent(),
            required PaymentPurpose purpose,
            required int amountPaise,
            required PaymentMethod method,
            required DateTime paidOn,
            Value<String?> reference = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            partyId: partyId,
            purpose: purpose,
            amountPaise: amountPaise,
            method: method,
            paidOn: paidOn,
            reference: reference,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$PaymentsTable, Payment>(table), $$PaymentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({partyId = false, paymentAllocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (paymentAllocationsRefs) db.paymentAllocations],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (partyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.partyId,
                    referencedTable: $$PaymentsTableReferences._partyIdTable(db),
                    referencedColumn: $$PaymentsTableReferences._partyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (paymentAllocationsRefs)
                    await $_getPrefetchedDataByColumns<Payment, $PaymentsTable, PaymentAllocation,
                            $PaymentAllocationsTable>(
                        currentTable: table,
                        referencedTable: $$PaymentsTableReferences._paymentAllocationsRefsTable(db),
                        managerFromTypedResult: (p0) => $$PaymentsTableReferences(db, table, p0).paymentAllocationsRefs,
                        currentColumn: 'id',
                        referencedColumn: 'payment_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool partyId, bool paymentAllocationsRefs})>;
typedef $$PaymentAllocationsTableCreateCompanionBuilder = PaymentAllocationsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String paymentId,
  required String orderId,
  required int amountPaise,
  Value<int> rowid,
});
typedef $$PaymentAllocationsTableUpdateCompanionBuilder = PaymentAllocationsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> paymentId,
  Value<String> orderId,
  Value<int> amountPaise,
  Value<int> rowid,
});

final class $$PaymentAllocationsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentAllocationsTable, PaymentAllocation> {
  $$PaymentAllocationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PaymentsTable _paymentIdTable(_$AppDatabase db) =>
      db.payments.createAlias('payment_allocations__payment_id__payments__id');

  $$PaymentsTableProcessedTableManager get paymentId {
    final $_column = $_itemColumn<String>('payment_id')!;

    final manager = $$PaymentsTableTableManager($_db, $_db.payments).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $OrdersTable _orderIdTable(_$AppDatabase db) =>
      db.orders.createAlias('payment_allocations__order_id__orders__id');

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$OrdersTableTableManager($_db, $_db.orders).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PaymentAllocationsTableFilterComposer extends Composer<_$AppDatabase, $PaymentAllocationsTable> {
  $$PaymentAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountPaise =>
      $composableBuilder(column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  $$PaymentsTableFilterComposer get paymentId {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentId,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableFilterComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentAllocationsTableOrderingComposer extends Composer<_$AppDatabase, $PaymentAllocationsTable> {
  $$PaymentAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise =>
      $composableBuilder(column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  $$PaymentsTableOrderingComposer get paymentId {
    final $$PaymentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentId,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableOrderingComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableOrderingComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentAllocationsTableAnnotationComposer extends Composer<_$AppDatabase, $PaymentAllocationsTable> {
  $$PaymentAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(column: $table.amountPaise, builder: (column) => column);

  $$PaymentsTableAnnotationComposer get paymentId {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentId,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentAllocationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentAllocationsTable,
    PaymentAllocation,
    $$PaymentAllocationsTableFilterComposer,
    $$PaymentAllocationsTableOrderingComposer,
    $$PaymentAllocationsTableAnnotationComposer,
    $$PaymentAllocationsTableCreateCompanionBuilder,
    $$PaymentAllocationsTableUpdateCompanionBuilder,
    (PaymentAllocation, $$PaymentAllocationsTableReferences),
    PaymentAllocation,
    PrefetchHooks Function({bool paymentId, bool orderId})> {
  $$PaymentAllocationsTableTableManager(_$AppDatabase db, $PaymentAllocationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PaymentAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PaymentAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PaymentAllocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> paymentId = const Value.absent(),
            Value<String> orderId = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentAllocationsCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            paymentId: paymentId,
            orderId: orderId,
            amountPaise: amountPaise,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String paymentId,
            required String orderId,
            required int amountPaise,
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentAllocationsCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            paymentId: paymentId,
            orderId: orderId,
            amountPaise: amountPaise,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PaymentAllocationsTable, PaymentAllocation>(table),
                    $$PaymentAllocationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({paymentId = false, orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (paymentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.paymentId,
                    referencedTable: $$PaymentAllocationsTableReferences._paymentIdTable(db),
                    referencedColumn: $$PaymentAllocationsTableReferences._paymentIdTable(db).id,
                  ) as T;
                }
                if (orderId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orderId,
                    referencedTable: $$PaymentAllocationsTableReferences._orderIdTable(db),
                    referencedColumn: $$PaymentAllocationsTableReferences._orderIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PaymentAllocationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentAllocationsTable,
    PaymentAllocation,
    $$PaymentAllocationsTableFilterComposer,
    $$PaymentAllocationsTableOrderingComposer,
    $$PaymentAllocationsTableAnnotationComposer,
    $$PaymentAllocationsTableCreateCompanionBuilder,
    $$PaymentAllocationsTableUpdateCompanionBuilder,
    (PaymentAllocation, $$PaymentAllocationsTableReferences),
    PaymentAllocation,
    PrefetchHooks Function({bool paymentId, bool orderId})>;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String category,
  required int amountPaise,
  required PaymentMethod method,
  required DateTime spentOn,
  Value<String?> partyId,
  Value<String?> note,
  Value<String?> receiptPath,
  Value<int> rowid,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> category,
  Value<int> amountPaise,
  Value<PaymentMethod> method,
  Value<DateTime> spentOn,
  Value<String?> partyId,
  Value<String?> note,
  Value<String?> receiptPath,
  Value<int> rowid,
});

final class $$ExpensesTableReferences extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PartiesTable _partyIdTable(_$AppDatabase db) => db.parties.createAlias('expenses__party_id__parties__id');

  $$PartiesTableProcessedTableManager? get partyId {
    final $_column = $_itemColumn<String>('party_id');
    if ($_column == null) return null;
    final manager = $$PartiesTableTableManager($_db, $_db.parties).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExpensesTableFilterComposer extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountPaise =>
      $composableBuilder(column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get spentOn =>
      $composableBuilder(column: $table.spentOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get receiptPath =>
      $composableBuilder(column: $table.receiptPath, builder: (column) => ColumnFilters(column));

  $$PartiesTableFilterComposer get partyId {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableFilterComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableOrderingComposer extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise =>
      $composableBuilder(column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get spentOn =>
      $composableBuilder(column: $table.spentOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get receiptPath =>
      $composableBuilder(column: $table.receiptPath, builder: (column) => ColumnOrderings(column));

  $$PartiesTableOrderingComposer get partyId {
    final $$PartiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableOrderingComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get category => $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(column: $table.amountPaise, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get spentOn => $composableBuilder(column: $table.spentOn, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get receiptPath =>
      $composableBuilder(column: $table.receiptPath, builder: (column) => column);

  $$PartiesTableAnnotationComposer get partyId {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableAnnotationComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, $$ExpensesTableReferences),
    Expense,
    PrefetchHooks Function({bool partyId})> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<PaymentMethod> method = const Value.absent(),
            Value<DateTime> spentOn = const Value.absent(),
            Value<String?> partyId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> receiptPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            category: category,
            amountPaise: amountPaise,
            method: method,
            spentOn: spentOn,
            partyId: partyId,
            note: note,
            receiptPath: receiptPath,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required String category,
            required int amountPaise,
            required PaymentMethod method,
            required DateTime spentOn,
            Value<String?> partyId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> receiptPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            category: category,
            amountPaise: amountPaise,
            method: method,
            spentOn: spentOn,
            partyId: partyId,
            note: note,
            receiptPath: receiptPath,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$ExpensesTable, Expense>(table), $$ExpensesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({partyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic, dynamic,
                      dynamic, dynamic, dynamic>>(state) {
                if (partyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.partyId,
                    referencedTable: $$ExpensesTableReferences._partyIdTable(db),
                    referencedColumn: $$ExpensesTableReferences._partyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, $$ExpensesTableReferences),
    Expense,
    PrefetchHooks Function({bool partyId})>;
typedef $$OwnerWithdrawalsTableCreateCompanionBuilder = OwnerWithdrawalsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required int amountPaise,
  required PaymentMethod method,
  required DateTime takenOn,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$OwnerWithdrawalsTableUpdateCompanionBuilder = OwnerWithdrawalsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> amountPaise,
  Value<PaymentMethod> method,
  Value<DateTime> takenOn,
  Value<String?> note,
  Value<int> rowid,
});

class $$OwnerWithdrawalsTableFilterComposer extends Composer<_$AppDatabase, $OwnerWithdrawalsTable> {
  $$OwnerWithdrawalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountPaise =>
      $composableBuilder(column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get takenOn =>
      $composableBuilder(column: $table.takenOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));
}

class $$OwnerWithdrawalsTableOrderingComposer extends Composer<_$AppDatabase, $OwnerWithdrawalsTable> {
  $$OwnerWithdrawalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise =>
      $composableBuilder(column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get takenOn =>
      $composableBuilder(column: $table.takenOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$OwnerWithdrawalsTableAnnotationComposer extends Composer<_$AppDatabase, $OwnerWithdrawalsTable> {
  $$OwnerWithdrawalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt => $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(column: $table.amountPaise, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get takenOn => $composableBuilder(column: $table.takenOn, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$OwnerWithdrawalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OwnerWithdrawalsTable,
    OwnerWithdrawal,
    $$OwnerWithdrawalsTableFilterComposer,
    $$OwnerWithdrawalsTableOrderingComposer,
    $$OwnerWithdrawalsTableAnnotationComposer,
    $$OwnerWithdrawalsTableCreateCompanionBuilder,
    $$OwnerWithdrawalsTableUpdateCompanionBuilder,
    (OwnerWithdrawal, BaseReferences<_$AppDatabase, $OwnerWithdrawalsTable, OwnerWithdrawal>),
    OwnerWithdrawal,
    PrefetchHooks Function()> {
  $$OwnerWithdrawalsTableTableManager(_$AppDatabase db, $OwnerWithdrawalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$OwnerWithdrawalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$OwnerWithdrawalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$OwnerWithdrawalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<PaymentMethod> method = const Value.absent(),
            Value<DateTime> takenOn = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OwnerWithdrawalsCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            amountPaise: amountPaise,
            method: method,
            takenOn: takenOn,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            required int amountPaise,
            required PaymentMethod method,
            required DateTime takenOn,
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OwnerWithdrawalsCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            amountPaise: amountPaise,
            method: method,
            takenOn: takenOn,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$OwnerWithdrawalsTable, OwnerWithdrawal>(table),
                    BaseReferences<_$AppDatabase, $OwnerWithdrawalsTable, OwnerWithdrawal>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OwnerWithdrawalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OwnerWithdrawalsTable,
    OwnerWithdrawal,
    $$OwnerWithdrawalsTableFilterComposer,
    $$OwnerWithdrawalsTableOrderingComposer,
    $$OwnerWithdrawalsTableAnnotationComposer,
    $$OwnerWithdrawalsTableCreateCompanionBuilder,
    $$OwnerWithdrawalsTableUpdateCompanionBuilder,
    (OwnerWithdrawal, BaseReferences<_$AppDatabase, $OwnerWithdrawalsTable, OwnerWithdrawal>),
    OwnerWithdrawal,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsTableTableManager get settings => $$SettingsTableTableManager(_db, _db.settings);
  $$ProductsTableTableManager get products => $$ProductsTableTableManager(_db, _db.products);
  $$BulkRulesTableTableManager get bulkRules => $$BulkRulesTableTableManager(_db, _db.bulkRules);
  $$PartiesTableTableManager get parties => $$PartiesTableTableManager(_db, _db.parties);
  $$RecipeLinesTableTableManager get recipeLines => $$RecipeLinesTableTableManager(_db, _db.recipeLines);
  $$OrdersTableTableManager get orders => $$OrdersTableTableManager(_db, _db.orders);
  $$ProductionRunsTableTableManager get productionRuns => $$ProductionRunsTableTableManager(_db, _db.productionRuns);
  $$StockMovesTableTableManager get stockMoves => $$StockMovesTableTableManager(_db, _db.stockMoves);
  $$OrderLinesTableTableManager get orderLines => $$OrderLinesTableTableManager(_db, _db.orderLines);
  $$OrderPhotosTableTableManager get orderPhotos => $$OrderPhotosTableTableManager(_db, _db.orderPhotos);
  $$PaymentsTableTableManager get payments => $$PaymentsTableTableManager(_db, _db.payments);
  $$PaymentAllocationsTableTableManager get paymentAllocations =>
      $$PaymentAllocationsTableTableManager(_db, _db.paymentAllocations);
  $$ExpensesTableTableManager get expenses => $$ExpensesTableTableManager(_db, _db.expenses);
  $$OwnerWithdrawalsTableTableManager get ownerWithdrawals =>
      $$OwnerWithdrawalsTableTableManager(_db, _db.ownerWithdrawals);
}
