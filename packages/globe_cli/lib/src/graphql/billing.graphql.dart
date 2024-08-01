// ignore_for_file: type=lint
class Input$BillingProductItemInput {
  factory Input$BillingProductItemInput({
    required String providerId,
    required String name,
    required List<Input$BillingProductItemUsageInput> usages,
  }) =>
      Input$BillingProductItemInput._({
        r'providerId': providerId,
        r'name': name,
        r'usages': usages,
      });

  Input$BillingProductItemInput._(this._$data);

  factory Input$BillingProductItemInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$providerId = data['providerId'];
    result$data['providerId'] = (l$providerId as String);
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$usages = data['usages'];
    result$data['usages'] = (l$usages as List<dynamic>)
        .map((e) => Input$BillingProductItemUsageInput.fromJson(
            (e as Map<String, dynamic>)))
        .toList();
    return Input$BillingProductItemInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get providerId => (_$data['providerId'] as String);

  String get name => (_$data['name'] as String);

  List<Input$BillingProductItemUsageInput> get usages =>
      (_$data['usages'] as List<Input$BillingProductItemUsageInput>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$providerId = providerId;
    result$data['providerId'] = l$providerId;
    final l$name = name;
    result$data['name'] = l$name;
    final l$usages = usages;
    result$data['usages'] = l$usages.map((e) => e.toJson()).toList();
    return result$data;
  }

  CopyWith$Input$BillingProductItemInput<Input$BillingProductItemInput>
      get copyWith => CopyWith$Input$BillingProductItemInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$BillingProductItemInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$providerId = providerId;
    final lOther$providerId = other.providerId;
    if (l$providerId != lOther$providerId) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$usages = usages;
    final lOther$usages = other.usages;
    if (l$usages.length != lOther$usages.length) {
      return false;
    }
    for (int i = 0; i < l$usages.length; i++) {
      final l$usages$entry = l$usages[i];
      final lOther$usages$entry = lOther$usages[i];
      if (l$usages$entry != lOther$usages$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$providerId = providerId;
    final l$name = name;
    final l$usages = usages;
    return Object.hashAll([
      l$providerId,
      l$name,
      Object.hashAll(l$usages.map((v) => v)),
    ]);
  }
}

abstract class CopyWith$Input$BillingProductItemInput<TRes> {
  factory CopyWith$Input$BillingProductItemInput(
    Input$BillingProductItemInput instance,
    TRes Function(Input$BillingProductItemInput) then,
  ) = _CopyWithImpl$Input$BillingProductItemInput;

  factory CopyWith$Input$BillingProductItemInput.stub(TRes res) =
      _CopyWithStubImpl$Input$BillingProductItemInput;

  TRes call({
    String? providerId,
    String? name,
    List<Input$BillingProductItemUsageInput>? usages,
  });
  TRes usages(
      Iterable<Input$BillingProductItemUsageInput> Function(
              Iterable<
                  CopyWith$Input$BillingProductItemUsageInput<
                      Input$BillingProductItemUsageInput>>)
          _fn);
}

class _CopyWithImpl$Input$BillingProductItemInput<TRes>
    implements CopyWith$Input$BillingProductItemInput<TRes> {
  _CopyWithImpl$Input$BillingProductItemInput(
    this._instance,
    this._then,
  );

  final Input$BillingProductItemInput _instance;

  final TRes Function(Input$BillingProductItemInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? providerId = _undefined,
    Object? name = _undefined,
    Object? usages = _undefined,
  }) =>
      _then(Input$BillingProductItemInput._({
        ..._instance._$data,
        if (providerId != _undefined && providerId != null)
          'providerId': (providerId as String),
        if (name != _undefined && name != null) 'name': (name as String),
        if (usages != _undefined && usages != null)
          'usages': (usages as List<Input$BillingProductItemUsageInput>),
      }));

  TRes usages(
          Iterable<Input$BillingProductItemUsageInput> Function(
                  Iterable<
                      CopyWith$Input$BillingProductItemUsageInput<
                          Input$BillingProductItemUsageInput>>)
              _fn) =>
      call(
          usages: _fn(_instance.usages
              .map((e) => CopyWith$Input$BillingProductItemUsageInput(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Input$BillingProductItemInput<TRes>
    implements CopyWith$Input$BillingProductItemInput<TRes> {
  _CopyWithStubImpl$Input$BillingProductItemInput(this._res);

  TRes _res;

  call({
    String? providerId,
    String? name,
    List<Input$BillingProductItemUsageInput>? usages,
  }) =>
      _res;

  usages(_fn) => _res;
}

class Input$BillingProductItemUsageInput {
  factory Input$BillingProductItemUsageInput({
    required Enum$BillingProductUsageTypeEnum usageType,
    required int usageLimit,
  }) =>
      Input$BillingProductItemUsageInput._({
        r'usageType': usageType,
        r'usageLimit': usageLimit,
      });

  Input$BillingProductItemUsageInput._(this._$data);

  factory Input$BillingProductItemUsageInput.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$usageType = data['usageType'];
    result$data['usageType'] =
        fromJson$Enum$BillingProductUsageTypeEnum((l$usageType as String));
    final l$usageLimit = data['usageLimit'];
    result$data['usageLimit'] = (l$usageLimit as int);
    return Input$BillingProductItemUsageInput._(result$data);
  }

  Map<String, dynamic> _$data;

  Enum$BillingProductUsageTypeEnum get usageType =>
      (_$data['usageType'] as Enum$BillingProductUsageTypeEnum);

  int get usageLimit => (_$data['usageLimit'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$usageType = usageType;
    result$data['usageType'] =
        toJson$Enum$BillingProductUsageTypeEnum(l$usageType);
    final l$usageLimit = usageLimit;
    result$data['usageLimit'] = l$usageLimit;
    return result$data;
  }

  CopyWith$Input$BillingProductItemUsageInput<
          Input$BillingProductItemUsageInput>
      get copyWith => CopyWith$Input$BillingProductItemUsageInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$BillingProductItemUsageInput) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$usageType = usageType;
    final lOther$usageType = other.usageType;
    if (l$usageType != lOther$usageType) {
      return false;
    }
    final l$usageLimit = usageLimit;
    final lOther$usageLimit = other.usageLimit;
    if (l$usageLimit != lOther$usageLimit) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$usageType = usageType;
    final l$usageLimit = usageLimit;
    return Object.hashAll([
      l$usageType,
      l$usageLimit,
    ]);
  }
}

abstract class CopyWith$Input$BillingProductItemUsageInput<TRes> {
  factory CopyWith$Input$BillingProductItemUsageInput(
    Input$BillingProductItemUsageInput instance,
    TRes Function(Input$BillingProductItemUsageInput) then,
  ) = _CopyWithImpl$Input$BillingProductItemUsageInput;

  factory CopyWith$Input$BillingProductItemUsageInput.stub(TRes res) =
      _CopyWithStubImpl$Input$BillingProductItemUsageInput;

  TRes call({
    Enum$BillingProductUsageTypeEnum? usageType,
    int? usageLimit,
  });
}

class _CopyWithImpl$Input$BillingProductItemUsageInput<TRes>
    implements CopyWith$Input$BillingProductItemUsageInput<TRes> {
  _CopyWithImpl$Input$BillingProductItemUsageInput(
    this._instance,
    this._then,
  );

  final Input$BillingProductItemUsageInput _instance;

  final TRes Function(Input$BillingProductItemUsageInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? usageType = _undefined,
    Object? usageLimit = _undefined,
  }) =>
      _then(Input$BillingProductItemUsageInput._({
        ..._instance._$data,
        if (usageType != _undefined && usageType != null)
          'usageType': (usageType as Enum$BillingProductUsageTypeEnum),
        if (usageLimit != _undefined && usageLimit != null)
          'usageLimit': (usageLimit as int),
      }));
}

class _CopyWithStubImpl$Input$BillingProductItemUsageInput<TRes>
    implements CopyWith$Input$BillingProductItemUsageInput<TRes> {
  _CopyWithStubImpl$Input$BillingProductItemUsageInput(this._res);

  TRes _res;

  call({
    Enum$BillingProductUsageTypeEnum? usageType,
    int? usageLimit,
  }) =>
      _res;
}

enum Enum$BillingProductTypeEnum {
  subscription,
  $unknown;

  factory Enum$BillingProductTypeEnum.fromJson(String value) =>
      fromJson$Enum$BillingProductTypeEnum(value);

  String toJson() => toJson$Enum$BillingProductTypeEnum(this);
}

String toJson$Enum$BillingProductTypeEnum(Enum$BillingProductTypeEnum e) {
  switch (e) {
    case Enum$BillingProductTypeEnum.subscription:
      return r'subscription';
    case Enum$BillingProductTypeEnum.$unknown:
      return r'$unknown';
  }
}

Enum$BillingProductTypeEnum fromJson$Enum$BillingProductTypeEnum(String value) {
  switch (value) {
    case r'subscription':
      return Enum$BillingProductTypeEnum.subscription;
    default:
      return Enum$BillingProductTypeEnum.$unknown;
  }
}

enum Enum$BillingProductDataDurationEnum {
  once,
  day,
  week,
  month,
  year,
  $unknown;

  factory Enum$BillingProductDataDurationEnum.fromJson(String value) =>
      fromJson$Enum$BillingProductDataDurationEnum(value);

  String toJson() => toJson$Enum$BillingProductDataDurationEnum(this);
}

String toJson$Enum$BillingProductDataDurationEnum(
    Enum$BillingProductDataDurationEnum e) {
  switch (e) {
    case Enum$BillingProductDataDurationEnum.once:
      return r'once';
    case Enum$BillingProductDataDurationEnum.day:
      return r'day';
    case Enum$BillingProductDataDurationEnum.week:
      return r'week';
    case Enum$BillingProductDataDurationEnum.month:
      return r'month';
    case Enum$BillingProductDataDurationEnum.year:
      return r'year';
    case Enum$BillingProductDataDurationEnum.$unknown:
      return r'$unknown';
  }
}

Enum$BillingProductDataDurationEnum
    fromJson$Enum$BillingProductDataDurationEnum(String value) {
  switch (value) {
    case r'once':
      return Enum$BillingProductDataDurationEnum.once;
    case r'day':
      return Enum$BillingProductDataDurationEnum.day;
    case r'week':
      return Enum$BillingProductDataDurationEnum.week;
    case r'month':
      return Enum$BillingProductDataDurationEnum.month;
    case r'year':
      return Enum$BillingProductDataDurationEnum.year;
    default:
      return Enum$BillingProductDataDurationEnum.$unknown;
  }
}

enum Enum$BillingProductUsageTypeEnum {
  request,
  bandwidth,
  $unknown;

  factory Enum$BillingProductUsageTypeEnum.fromJson(String value) =>
      fromJson$Enum$BillingProductUsageTypeEnum(value);

  String toJson() => toJson$Enum$BillingProductUsageTypeEnum(this);
}

String toJson$Enum$BillingProductUsageTypeEnum(
    Enum$BillingProductUsageTypeEnum e) {
  switch (e) {
    case Enum$BillingProductUsageTypeEnum.request:
      return r'request';
    case Enum$BillingProductUsageTypeEnum.bandwidth:
      return r'bandwidth';
    case Enum$BillingProductUsageTypeEnum.$unknown:
      return r'$unknown';
  }
}

Enum$BillingProductUsageTypeEnum fromJson$Enum$BillingProductUsageTypeEnum(
    String value) {
  switch (value) {
    case r'request':
      return Enum$BillingProductUsageTypeEnum.request;
    case r'bandwidth':
      return Enum$BillingProductUsageTypeEnum.bandwidth;
    default:
      return Enum$BillingProductUsageTypeEnum.$unknown;
  }
}
