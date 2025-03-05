// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package
class Input$BillingPagination {
  factory Input$BillingPagination({
    required int perPage,
    String? next,
  }) =>
      Input$BillingPagination._({
        r'perPage': perPage,
        if (next != null) r'next': next,
      });

  Input$BillingPagination._(this._$data);

  factory Input$BillingPagination.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$perPage = data['perPage'];
    result$data['perPage'] = (l$perPage as int);
    if (data.containsKey('next')) {
      final l$next = data['next'];
      result$data['next'] = (l$next as String?);
    }
    return Input$BillingPagination._(result$data);
  }

  Map<String, dynamic> _$data;

  int get perPage => (_$data['perPage'] as int);

  String? get next => (_$data['next'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$perPage = perPage;
    result$data['perPage'] = l$perPage;
    if (_$data.containsKey('next')) {
      final l$next = next;
      result$data['next'] = l$next;
    }
    return result$data;
  }

  CopyWith$Input$BillingPagination<Input$BillingPagination> get copyWith =>
      CopyWith$Input$BillingPagination(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$BillingPagination || runtimeType != other.runtimeType) {
      return false;
    }
    final l$perPage = perPage;
    final lOther$perPage = other.perPage;
    if (l$perPage != lOther$perPage) {
      return false;
    }
    final l$next = next;
    final lOther$next = other.next;
    if (_$data.containsKey('next') != other._$data.containsKey('next')) {
      return false;
    }
    if (l$next != lOther$next) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$perPage = perPage;
    final l$next = next;
    return Object.hashAll([
      l$perPage,
      _$data.containsKey('next') ? l$next : const {},
    ]);
  }
}

abstract class CopyWith$Input$BillingPagination<TRes> {
  factory CopyWith$Input$BillingPagination(
    Input$BillingPagination instance,
    TRes Function(Input$BillingPagination) then,
  ) = _CopyWithImpl$Input$BillingPagination;

  factory CopyWith$Input$BillingPagination.stub(TRes res) =
      _CopyWithStubImpl$Input$BillingPagination;

  TRes call({
    int? perPage,
    String? next,
  });
}

class _CopyWithImpl$Input$BillingPagination<TRes>
    implements CopyWith$Input$BillingPagination<TRes> {
  _CopyWithImpl$Input$BillingPagination(
    this._instance,
    this._then,
  );

  final Input$BillingPagination _instance;

  final TRes Function(Input$BillingPagination) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? perPage = _undefined,
    Object? next = _undefined,
  }) =>
      _then(Input$BillingPagination._({
        ..._instance._$data,
        if (perPage != _undefined && perPage != null)
          'perPage': (perPage as int),
        if (next != _undefined) 'next': (next as String?),
      }));
}

class _CopyWithStubImpl$Input$BillingPagination<TRes>
    implements CopyWith$Input$BillingPagination<TRes> {
  _CopyWithStubImpl$Input$BillingPagination(this._res);

  TRes _res;

  call({
    int? perPage,
    String? next,
  }) =>
      _res;
}

class Input$BillingProductItemInfoFeaturesInput {
  factory Input$BillingProductItemInfoFeaturesInput({
    required String body,
    required bool checked,
  }) =>
      Input$BillingProductItemInfoFeaturesInput._({
        r'body': body,
        r'checked': checked,
      });

  Input$BillingProductItemInfoFeaturesInput._(this._$data);

  factory Input$BillingProductItemInfoFeaturesInput.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$body = data['body'];
    result$data['body'] = (l$body as String);
    final l$checked = data['checked'];
    result$data['checked'] = (l$checked as bool);
    return Input$BillingProductItemInfoFeaturesInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get body => (_$data['body'] as String);

  bool get checked => (_$data['checked'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$body = body;
    result$data['body'] = l$body;
    final l$checked = checked;
    result$data['checked'] = l$checked;
    return result$data;
  }

  CopyWith$Input$BillingProductItemInfoFeaturesInput<
          Input$BillingProductItemInfoFeaturesInput>
      get copyWith => CopyWith$Input$BillingProductItemInfoFeaturesInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$BillingProductItemInfoFeaturesInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$checked = checked;
    final lOther$checked = other.checked;
    if (l$checked != lOther$checked) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$body = body;
    final l$checked = checked;
    return Object.hashAll([
      l$body,
      l$checked,
    ]);
  }
}

abstract class CopyWith$Input$BillingProductItemInfoFeaturesInput<TRes> {
  factory CopyWith$Input$BillingProductItemInfoFeaturesInput(
    Input$BillingProductItemInfoFeaturesInput instance,
    TRes Function(Input$BillingProductItemInfoFeaturesInput) then,
  ) = _CopyWithImpl$Input$BillingProductItemInfoFeaturesInput;

  factory CopyWith$Input$BillingProductItemInfoFeaturesInput.stub(TRes res) =
      _CopyWithStubImpl$Input$BillingProductItemInfoFeaturesInput;

  TRes call({
    String? body,
    bool? checked,
  });
}

class _CopyWithImpl$Input$BillingProductItemInfoFeaturesInput<TRes>
    implements CopyWith$Input$BillingProductItemInfoFeaturesInput<TRes> {
  _CopyWithImpl$Input$BillingProductItemInfoFeaturesInput(
    this._instance,
    this._then,
  );

  final Input$BillingProductItemInfoFeaturesInput _instance;

  final TRes Function(Input$BillingProductItemInfoFeaturesInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? body = _undefined,
    Object? checked = _undefined,
  }) =>
      _then(Input$BillingProductItemInfoFeaturesInput._({
        ..._instance._$data,
        if (body != _undefined && body != null) 'body': (body as String),
        if (checked != _undefined && checked != null)
          'checked': (checked as bool),
      }));
}

class _CopyWithStubImpl$Input$BillingProductItemInfoFeaturesInput<TRes>
    implements CopyWith$Input$BillingProductItemInfoFeaturesInput<TRes> {
  _CopyWithStubImpl$Input$BillingProductItemInfoFeaturesInput(this._res);

  TRes _res;

  call({
    String? body,
    bool? checked,
  }) =>
      _res;
}

class Input$BillingProductItemInfoInput {
  factory Input$BillingProductItemInfoInput(
          {required List<Input$BillingProductItemInfoFeaturesInput>
              features}) =>
      Input$BillingProductItemInfoInput._({
        r'features': features,
      });

  Input$BillingProductItemInfoInput._(this._$data);

  factory Input$BillingProductItemInfoInput.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$features = data['features'];
    result$data['features'] = (l$features as List<dynamic>)
        .map((e) => Input$BillingProductItemInfoFeaturesInput.fromJson(
            (e as Map<String, dynamic>)))
        .toList();
    return Input$BillingProductItemInfoInput._(result$data);
  }

  Map<String, dynamic> _$data;

  List<Input$BillingProductItemInfoFeaturesInput> get features =>
      (_$data['features'] as List<Input$BillingProductItemInfoFeaturesInput>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$features = features;
    result$data['features'] = l$features.map((e) => e.toJson()).toList();
    return result$data;
  }

  CopyWith$Input$BillingProductItemInfoInput<Input$BillingProductItemInfoInput>
      get copyWith => CopyWith$Input$BillingProductItemInfoInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$BillingProductItemInfoInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$features = features;
    final lOther$features = other.features;
    if (l$features.length != lOther$features.length) {
      return false;
    }
    for (int i = 0; i < l$features.length; i++) {
      final l$features$entry = l$features[i];
      final lOther$features$entry = lOther$features[i];
      if (l$features$entry != lOther$features$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$features = features;
    return Object.hashAll([Object.hashAll(l$features.map((v) => v))]);
  }
}

abstract class CopyWith$Input$BillingProductItemInfoInput<TRes> {
  factory CopyWith$Input$BillingProductItemInfoInput(
    Input$BillingProductItemInfoInput instance,
    TRes Function(Input$BillingProductItemInfoInput) then,
  ) = _CopyWithImpl$Input$BillingProductItemInfoInput;

  factory CopyWith$Input$BillingProductItemInfoInput.stub(TRes res) =
      _CopyWithStubImpl$Input$BillingProductItemInfoInput;

  TRes call({List<Input$BillingProductItemInfoFeaturesInput>? features});
  TRes features(
      Iterable<Input$BillingProductItemInfoFeaturesInput> Function(
              Iterable<
                  CopyWith$Input$BillingProductItemInfoFeaturesInput<
                      Input$BillingProductItemInfoFeaturesInput>>)
          _fn);
}

class _CopyWithImpl$Input$BillingProductItemInfoInput<TRes>
    implements CopyWith$Input$BillingProductItemInfoInput<TRes> {
  _CopyWithImpl$Input$BillingProductItemInfoInput(
    this._instance,
    this._then,
  );

  final Input$BillingProductItemInfoInput _instance;

  final TRes Function(Input$BillingProductItemInfoInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? features = _undefined}) =>
      _then(Input$BillingProductItemInfoInput._({
        ..._instance._$data,
        if (features != _undefined && features != null)
          'features':
              (features as List<Input$BillingProductItemInfoFeaturesInput>),
      }));

  TRes features(
          Iterable<Input$BillingProductItemInfoFeaturesInput> Function(
                  Iterable<
                      CopyWith$Input$BillingProductItemInfoFeaturesInput<
                          Input$BillingProductItemInfoFeaturesInput>>)
              _fn) =>
      call(
          features: _fn(_instance.features
              .map((e) => CopyWith$Input$BillingProductItemInfoFeaturesInput(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Input$BillingProductItemInfoInput<TRes>
    implements CopyWith$Input$BillingProductItemInfoInput<TRes> {
  _CopyWithStubImpl$Input$BillingProductItemInfoInput(this._res);

  TRes _res;

  call({List<Input$BillingProductItemInfoFeaturesInput>? features}) => _res;

  features(_fn) => _res;
}

class Input$BillingProductItemInput {
  factory Input$BillingProductItemInput({
    required String providerId,
    required String name,
    required List<Input$BillingProductItemUsageInput> usages,
    required Input$BillingProductItemInfoInput info,
  }) =>
      Input$BillingProductItemInput._({
        r'providerId': providerId,
        r'name': name,
        r'usages': usages,
        r'info': info,
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
    final l$info = data['info'];
    result$data['info'] = Input$BillingProductItemInfoInput.fromJson(
        (l$info as Map<String, dynamic>));
    return Input$BillingProductItemInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get providerId => (_$data['providerId'] as String);

  String get name => (_$data['name'] as String);

  List<Input$BillingProductItemUsageInput> get usages =>
      (_$data['usages'] as List<Input$BillingProductItemUsageInput>);

  Input$BillingProductItemInfoInput get info =>
      (_$data['info'] as Input$BillingProductItemInfoInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$providerId = providerId;
    result$data['providerId'] = l$providerId;
    final l$name = name;
    result$data['name'] = l$name;
    final l$usages = usages;
    result$data['usages'] = l$usages.map((e) => e.toJson()).toList();
    final l$info = info;
    result$data['info'] = l$info.toJson();
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
    if (other is! Input$BillingProductItemInput ||
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
    final l$info = info;
    final lOther$info = other.info;
    if (l$info != lOther$info) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$providerId = providerId;
    final l$name = name;
    final l$usages = usages;
    final l$info = info;
    return Object.hashAll([
      l$providerId,
      l$name,
      Object.hashAll(l$usages.map((v) => v)),
      l$info,
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
    Input$BillingProductItemInfoInput? info,
  });
  TRes usages(
      Iterable<Input$BillingProductItemUsageInput> Function(
              Iterable<
                  CopyWith$Input$BillingProductItemUsageInput<
                      Input$BillingProductItemUsageInput>>)
          _fn);
  CopyWith$Input$BillingProductItemInfoInput<TRes> get info;
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
    Object? info = _undefined,
  }) =>
      _then(Input$BillingProductItemInput._({
        ..._instance._$data,
        if (providerId != _undefined && providerId != null)
          'providerId': (providerId as String),
        if (name != _undefined && name != null) 'name': (name as String),
        if (usages != _undefined && usages != null)
          'usages': (usages as List<Input$BillingProductItemUsageInput>),
        if (info != _undefined && info != null)
          'info': (info as Input$BillingProductItemInfoInput),
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

  CopyWith$Input$BillingProductItemInfoInput<TRes> get info {
    final local$info = _instance.info;
    return CopyWith$Input$BillingProductItemInfoInput(
        local$info, (e) => call(info: e));
  }
}

class _CopyWithStubImpl$Input$BillingProductItemInput<TRes>
    implements CopyWith$Input$BillingProductItemInput<TRes> {
  _CopyWithStubImpl$Input$BillingProductItemInput(this._res);

  TRes _res;

  call({
    String? providerId,
    String? name,
    List<Input$BillingProductItemUsageInput>? usages,
    Input$BillingProductItemInfoInput? info,
  }) =>
      _res;

  usages(_fn) => _res;

  CopyWith$Input$BillingProductItemInfoInput<TRes> get info =>
      CopyWith$Input$BillingProductItemInfoInput.stub(_res);
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
    if (other is! Input$BillingProductItemUsageInput ||
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

class Input$BillingTransactionFilterInput {
  factory Input$BillingTransactionFilterInput({
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      Input$BillingTransactionFilterInput._({
        if (startDate != null) r'startDate': startDate,
        if (endDate != null) r'endDate': endDate,
      });

  Input$BillingTransactionFilterInput._(this._$data);

  factory Input$BillingTransactionFilterInput.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('startDate')) {
      final l$startDate = data['startDate'];
      result$data['startDate'] =
          l$startDate == null ? null : DateTime.parse((l$startDate as String));
    }
    if (data.containsKey('endDate')) {
      final l$endDate = data['endDate'];
      result$data['endDate'] =
          l$endDate == null ? null : DateTime.parse((l$endDate as String));
    }
    return Input$BillingTransactionFilterInput._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime? get startDate => (_$data['startDate'] as DateTime?);

  DateTime? get endDate => (_$data['endDate'] as DateTime?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('startDate')) {
      final l$startDate = startDate;
      result$data['startDate'] = l$startDate?.toIso8601String();
    }
    if (_$data.containsKey('endDate')) {
      final l$endDate = endDate;
      result$data['endDate'] = l$endDate?.toIso8601String();
    }
    return result$data;
  }

  CopyWith$Input$BillingTransactionFilterInput<
          Input$BillingTransactionFilterInput>
      get copyWith => CopyWith$Input$BillingTransactionFilterInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$BillingTransactionFilterInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$startDate = startDate;
    final lOther$startDate = other.startDate;
    if (_$data.containsKey('startDate') !=
        other._$data.containsKey('startDate')) {
      return false;
    }
    if (l$startDate != lOther$startDate) {
      return false;
    }
    final l$endDate = endDate;
    final lOther$endDate = other.endDate;
    if (_$data.containsKey('endDate') != other._$data.containsKey('endDate')) {
      return false;
    }
    if (l$endDate != lOther$endDate) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$startDate = startDate;
    final l$endDate = endDate;
    return Object.hashAll([
      _$data.containsKey('startDate') ? l$startDate : const {},
      _$data.containsKey('endDate') ? l$endDate : const {},
    ]);
  }
}

abstract class CopyWith$Input$BillingTransactionFilterInput<TRes> {
  factory CopyWith$Input$BillingTransactionFilterInput(
    Input$BillingTransactionFilterInput instance,
    TRes Function(Input$BillingTransactionFilterInput) then,
  ) = _CopyWithImpl$Input$BillingTransactionFilterInput;

  factory CopyWith$Input$BillingTransactionFilterInput.stub(TRes res) =
      _CopyWithStubImpl$Input$BillingTransactionFilterInput;

  TRes call({
    DateTime? startDate,
    DateTime? endDate,
  });
}

class _CopyWithImpl$Input$BillingTransactionFilterInput<TRes>
    implements CopyWith$Input$BillingTransactionFilterInput<TRes> {
  _CopyWithImpl$Input$BillingTransactionFilterInput(
    this._instance,
    this._then,
  );

  final Input$BillingTransactionFilterInput _instance;

  final TRes Function(Input$BillingTransactionFilterInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? startDate = _undefined,
    Object? endDate = _undefined,
  }) =>
      _then(Input$BillingTransactionFilterInput._({
        ..._instance._$data,
        if (startDate != _undefined) 'startDate': (startDate as DateTime?),
        if (endDate != _undefined) 'endDate': (endDate as DateTime?),
      }));
}

class _CopyWithStubImpl$Input$BillingTransactionFilterInput<TRes>
    implements CopyWith$Input$BillingTransactionFilterInput<TRes> {
  _CopyWithStubImpl$Input$BillingTransactionFilterInput(this._res);

  TRes _res;

  call({
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      _res;
}

class Input$CliDeploymentSourceInput {
  factory Input$CliDeploymentSourceInput({required String type}) =>
      Input$CliDeploymentSourceInput._({
        r'type': type,
      });

  Input$CliDeploymentSourceInput._(this._$data);

  factory Input$CliDeploymentSourceInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$type = data['type'];
    result$data['type'] = (l$type as String);
    return Input$CliDeploymentSourceInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get type => (_$data['type'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$type = type;
    result$data['type'] = l$type;
    return result$data;
  }

  CopyWith$Input$CliDeploymentSourceInput<Input$CliDeploymentSourceInput>
      get copyWith => CopyWith$Input$CliDeploymentSourceInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CliDeploymentSourceInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$type = type;
    return Object.hashAll([l$type]);
  }
}

abstract class CopyWith$Input$CliDeploymentSourceInput<TRes> {
  factory CopyWith$Input$CliDeploymentSourceInput(
    Input$CliDeploymentSourceInput instance,
    TRes Function(Input$CliDeploymentSourceInput) then,
  ) = _CopyWithImpl$Input$CliDeploymentSourceInput;

  factory CopyWith$Input$CliDeploymentSourceInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CliDeploymentSourceInput;

  TRes call({String? type});
}

class _CopyWithImpl$Input$CliDeploymentSourceInput<TRes>
    implements CopyWith$Input$CliDeploymentSourceInput<TRes> {
  _CopyWithImpl$Input$CliDeploymentSourceInput(
    this._instance,
    this._then,
  );

  final Input$CliDeploymentSourceInput _instance;

  final TRes Function(Input$CliDeploymentSourceInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? type = _undefined}) =>
      _then(Input$CliDeploymentSourceInput._({
        ..._instance._$data,
        if (type != _undefined && type != null) 'type': (type as String),
      }));
}

class _CopyWithStubImpl$Input$CliDeploymentSourceInput<TRes>
    implements CopyWith$Input$CliDeploymentSourceInput<TRes> {
  _CopyWithStubImpl$Input$CliDeploymentSourceInput(this._res);

  TRes _res;

  call({String? type}) => _res;
}

class Input$CreateDeploymentInput {
  factory Input$CreateDeploymentInput({
    required Enum$DeploymentEnvironment environment,
    required Input$DeploymentSourceInput source,
  }) =>
      Input$CreateDeploymentInput._({
        r'environment': environment,
        r'source': source,
      });

  Input$CreateDeploymentInput._(this._$data);

  factory Input$CreateDeploymentInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$environment = data['environment'];
    result$data['environment'] =
        fromJson$Enum$DeploymentEnvironment((l$environment as String));
    final l$source = data['source'];
    result$data['source'] = Input$DeploymentSourceInput.fromJson(
        (l$source as Map<String, dynamic>));
    return Input$CreateDeploymentInput._(result$data);
  }

  Map<String, dynamic> _$data;

  Enum$DeploymentEnvironment get environment =>
      (_$data['environment'] as Enum$DeploymentEnvironment);

  Input$DeploymentSourceInput get source =>
      (_$data['source'] as Input$DeploymentSourceInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$environment = environment;
    result$data['environment'] =
        toJson$Enum$DeploymentEnvironment(l$environment);
    final l$source = source;
    result$data['source'] = l$source.toJson();
    return result$data;
  }

  CopyWith$Input$CreateDeploymentInput<Input$CreateDeploymentInput>
      get copyWith => CopyWith$Input$CreateDeploymentInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateDeploymentInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$environment = environment;
    final lOther$environment = other.environment;
    if (l$environment != lOther$environment) {
      return false;
    }
    final l$source = source;
    final lOther$source = other.source;
    if (l$source != lOther$source) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$environment = environment;
    final l$source = source;
    return Object.hashAll([
      l$environment,
      l$source,
    ]);
  }
}

abstract class CopyWith$Input$CreateDeploymentInput<TRes> {
  factory CopyWith$Input$CreateDeploymentInput(
    Input$CreateDeploymentInput instance,
    TRes Function(Input$CreateDeploymentInput) then,
  ) = _CopyWithImpl$Input$CreateDeploymentInput;

  factory CopyWith$Input$CreateDeploymentInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateDeploymentInput;

  TRes call({
    Enum$DeploymentEnvironment? environment,
    Input$DeploymentSourceInput? source,
  });
  CopyWith$Input$DeploymentSourceInput<TRes> get source;
}

class _CopyWithImpl$Input$CreateDeploymentInput<TRes>
    implements CopyWith$Input$CreateDeploymentInput<TRes> {
  _CopyWithImpl$Input$CreateDeploymentInput(
    this._instance,
    this._then,
  );

  final Input$CreateDeploymentInput _instance;

  final TRes Function(Input$CreateDeploymentInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? environment = _undefined,
    Object? source = _undefined,
  }) =>
      _then(Input$CreateDeploymentInput._({
        ..._instance._$data,
        if (environment != _undefined && environment != null)
          'environment': (environment as Enum$DeploymentEnvironment),
        if (source != _undefined && source != null)
          'source': (source as Input$DeploymentSourceInput),
      }));

  CopyWith$Input$DeploymentSourceInput<TRes> get source {
    final local$source = _instance.source;
    return CopyWith$Input$DeploymentSourceInput(
        local$source, (e) => call(source: e));
  }
}

class _CopyWithStubImpl$Input$CreateDeploymentInput<TRes>
    implements CopyWith$Input$CreateDeploymentInput<TRes> {
  _CopyWithStubImpl$Input$CreateDeploymentInput(this._res);

  TRes _res;

  call({
    Enum$DeploymentEnvironment? environment,
    Input$DeploymentSourceInput? source,
  }) =>
      _res;

  CopyWith$Input$DeploymentSourceInput<TRes> get source =>
      CopyWith$Input$DeploymentSourceInput.stub(_res);
}

class Input$CreateOrganizationInput {
  factory Input$CreateOrganizationInput({
    required Enum$OrganizationType type,
    required String name,
    required Input$CreateUserInput user,
  }) =>
      Input$CreateOrganizationInput._({
        r'type': type,
        r'name': name,
        r'user': user,
      });

  Input$CreateOrganizationInput._(this._$data);

  factory Input$CreateOrganizationInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$type = data['type'];
    result$data['type'] = fromJson$Enum$OrganizationType((l$type as String));
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$user = data['user'];
    result$data['user'] =
        Input$CreateUserInput.fromJson((l$user as Map<String, dynamic>));
    return Input$CreateOrganizationInput._(result$data);
  }

  Map<String, dynamic> _$data;

  Enum$OrganizationType get type => (_$data['type'] as Enum$OrganizationType);

  String get name => (_$data['name'] as String);

  Input$CreateUserInput get user => (_$data['user'] as Input$CreateUserInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$type = type;
    result$data['type'] = toJson$Enum$OrganizationType(l$type);
    final l$name = name;
    result$data['name'] = l$name;
    final l$user = user;
    result$data['user'] = l$user.toJson();
    return result$data;
  }

  CopyWith$Input$CreateOrganizationInput<Input$CreateOrganizationInput>
      get copyWith => CopyWith$Input$CreateOrganizationInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateOrganizationInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$type = type;
    final l$name = name;
    final l$user = user;
    return Object.hashAll([
      l$type,
      l$name,
      l$user,
    ]);
  }
}

abstract class CopyWith$Input$CreateOrganizationInput<TRes> {
  factory CopyWith$Input$CreateOrganizationInput(
    Input$CreateOrganizationInput instance,
    TRes Function(Input$CreateOrganizationInput) then,
  ) = _CopyWithImpl$Input$CreateOrganizationInput;

  factory CopyWith$Input$CreateOrganizationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateOrganizationInput;

  TRes call({
    Enum$OrganizationType? type,
    String? name,
    Input$CreateUserInput? user,
  });
  CopyWith$Input$CreateUserInput<TRes> get user;
}

class _CopyWithImpl$Input$CreateOrganizationInput<TRes>
    implements CopyWith$Input$CreateOrganizationInput<TRes> {
  _CopyWithImpl$Input$CreateOrganizationInput(
    this._instance,
    this._then,
  );

  final Input$CreateOrganizationInput _instance;

  final TRes Function(Input$CreateOrganizationInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? type = _undefined,
    Object? name = _undefined,
    Object? user = _undefined,
  }) =>
      _then(Input$CreateOrganizationInput._({
        ..._instance._$data,
        if (type != _undefined && type != null)
          'type': (type as Enum$OrganizationType),
        if (name != _undefined && name != null) 'name': (name as String),
        if (user != _undefined && user != null)
          'user': (user as Input$CreateUserInput),
      }));

  CopyWith$Input$CreateUserInput<TRes> get user {
    final local$user = _instance.user;
    return CopyWith$Input$CreateUserInput(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Input$CreateOrganizationInput<TRes>
    implements CopyWith$Input$CreateOrganizationInput<TRes> {
  _CopyWithStubImpl$Input$CreateOrganizationInput(this._res);

  TRes _res;

  call({
    Enum$OrganizationType? type,
    String? name,
    Input$CreateUserInput? user,
  }) =>
      _res;

  CopyWith$Input$CreateUserInput<TRes> get user =>
      CopyWith$Input$CreateUserInput.stub(_res);
}

class Input$CreateProjectInput {
  factory Input$CreateProjectInput({
    required String orgSlug,
    required String slug,
    Input$ProjectSettingsInput? settings,
    Input$ProjectConnectionInput? connection,
  }) =>
      Input$CreateProjectInput._({
        r'orgSlug': orgSlug,
        r'slug': slug,
        if (settings != null) r'settings': settings,
        if (connection != null) r'connection': connection,
      });

  Input$CreateProjectInput._(this._$data);

  factory Input$CreateProjectInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orgSlug = data['orgSlug'];
    result$data['orgSlug'] = (l$orgSlug as String);
    final l$slug = data['slug'];
    result$data['slug'] = (l$slug as String);
    if (data.containsKey('settings')) {
      final l$settings = data['settings'];
      result$data['settings'] = l$settings == null
          ? null
          : Input$ProjectSettingsInput.fromJson(
              (l$settings as Map<String, dynamic>));
    }
    if (data.containsKey('connection')) {
      final l$connection = data['connection'];
      result$data['connection'] = l$connection == null
          ? null
          : Input$ProjectConnectionInput.fromJson(
              (l$connection as Map<String, dynamic>));
    }
    return Input$CreateProjectInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orgSlug => (_$data['orgSlug'] as String);

  String get slug => (_$data['slug'] as String);

  Input$ProjectSettingsInput? get settings =>
      (_$data['settings'] as Input$ProjectSettingsInput?);

  Input$ProjectConnectionInput? get connection =>
      (_$data['connection'] as Input$ProjectConnectionInput?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orgSlug = orgSlug;
    result$data['orgSlug'] = l$orgSlug;
    final l$slug = slug;
    result$data['slug'] = l$slug;
    if (_$data.containsKey('settings')) {
      final l$settings = settings;
      result$data['settings'] = l$settings?.toJson();
    }
    if (_$data.containsKey('connection')) {
      final l$connection = connection;
      result$data['connection'] = l$connection?.toJson();
    }
    return result$data;
  }

  CopyWith$Input$CreateProjectInput<Input$CreateProjectInput> get copyWith =>
      CopyWith$Input$CreateProjectInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateProjectInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$orgSlug = orgSlug;
    final lOther$orgSlug = other.orgSlug;
    if (l$orgSlug != lOther$orgSlug) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (_$data.containsKey('settings') !=
        other._$data.containsKey('settings')) {
      return false;
    }
    if (l$settings != lOther$settings) {
      return false;
    }
    final l$connection = connection;
    final lOther$connection = other.connection;
    if (_$data.containsKey('connection') !=
        other._$data.containsKey('connection')) {
      return false;
    }
    if (l$connection != lOther$connection) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$orgSlug = orgSlug;
    final l$slug = slug;
    final l$settings = settings;
    final l$connection = connection;
    return Object.hashAll([
      l$orgSlug,
      l$slug,
      _$data.containsKey('settings') ? l$settings : const {},
      _$data.containsKey('connection') ? l$connection : const {},
    ]);
  }
}

abstract class CopyWith$Input$CreateProjectInput<TRes> {
  factory CopyWith$Input$CreateProjectInput(
    Input$CreateProjectInput instance,
    TRes Function(Input$CreateProjectInput) then,
  ) = _CopyWithImpl$Input$CreateProjectInput;

  factory CopyWith$Input$CreateProjectInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateProjectInput;

  TRes call({
    String? orgSlug,
    String? slug,
    Input$ProjectSettingsInput? settings,
    Input$ProjectConnectionInput? connection,
  });
  CopyWith$Input$ProjectSettingsInput<TRes> get settings;
  CopyWith$Input$ProjectConnectionInput<TRes> get connection;
}

class _CopyWithImpl$Input$CreateProjectInput<TRes>
    implements CopyWith$Input$CreateProjectInput<TRes> {
  _CopyWithImpl$Input$CreateProjectInput(
    this._instance,
    this._then,
  );

  final Input$CreateProjectInput _instance;

  final TRes Function(Input$CreateProjectInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? orgSlug = _undefined,
    Object? slug = _undefined,
    Object? settings = _undefined,
    Object? connection = _undefined,
  }) =>
      _then(Input$CreateProjectInput._({
        ..._instance._$data,
        if (orgSlug != _undefined && orgSlug != null)
          'orgSlug': (orgSlug as String),
        if (slug != _undefined && slug != null) 'slug': (slug as String),
        if (settings != _undefined)
          'settings': (settings as Input$ProjectSettingsInput?),
        if (connection != _undefined)
          'connection': (connection as Input$ProjectConnectionInput?),
      }));

  CopyWith$Input$ProjectSettingsInput<TRes> get settings {
    final local$settings = _instance.settings;
    return local$settings == null
        ? CopyWith$Input$ProjectSettingsInput.stub(_then(_instance))
        : CopyWith$Input$ProjectSettingsInput(
            local$settings, (e) => call(settings: e));
  }

  CopyWith$Input$ProjectConnectionInput<TRes> get connection {
    final local$connection = _instance.connection;
    return local$connection == null
        ? CopyWith$Input$ProjectConnectionInput.stub(_then(_instance))
        : CopyWith$Input$ProjectConnectionInput(
            local$connection, (e) => call(connection: e));
  }
}

class _CopyWithStubImpl$Input$CreateProjectInput<TRes>
    implements CopyWith$Input$CreateProjectInput<TRes> {
  _CopyWithStubImpl$Input$CreateProjectInput(this._res);

  TRes _res;

  call({
    String? orgSlug,
    String? slug,
    Input$ProjectSettingsInput? settings,
    Input$ProjectConnectionInput? connection,
  }) =>
      _res;

  CopyWith$Input$ProjectSettingsInput<TRes> get settings =>
      CopyWith$Input$ProjectSettingsInput.stub(_res);

  CopyWith$Input$ProjectConnectionInput<TRes> get connection =>
      CopyWith$Input$ProjectConnectionInput.stub(_res);
}

class Input$CreateUserInput {
  factory Input$CreateUserInput({
    required String email,
    required String name,
  }) =>
      Input$CreateUserInput._({
        r'email': email,
        r'name': name,
      });

  Input$CreateUserInput._(this._$data);

  factory Input$CreateUserInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    return Input$CreateUserInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  String get name => (_$data['name'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    final l$name = name;
    result$data['name'] = l$name;
    return result$data;
  }

  CopyWith$Input$CreateUserInput<Input$CreateUserInput> get copyWith =>
      CopyWith$Input$CreateUserInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CreateUserInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    final l$name = name;
    return Object.hashAll([
      l$email,
      l$name,
    ]);
  }
}

abstract class CopyWith$Input$CreateUserInput<TRes> {
  factory CopyWith$Input$CreateUserInput(
    Input$CreateUserInput instance,
    TRes Function(Input$CreateUserInput) then,
  ) = _CopyWithImpl$Input$CreateUserInput;

  factory CopyWith$Input$CreateUserInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CreateUserInput;

  TRes call({
    String? email,
    String? name,
  });
}

class _CopyWithImpl$Input$CreateUserInput<TRes>
    implements CopyWith$Input$CreateUserInput<TRes> {
  _CopyWithImpl$Input$CreateUserInput(
    this._instance,
    this._then,
  );

  final Input$CreateUserInput _instance;

  final TRes Function(Input$CreateUserInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? email = _undefined,
    Object? name = _undefined,
  }) =>
      _then(Input$CreateUserInput._({
        ..._instance._$data,
        if (email != _undefined && email != null) 'email': (email as String),
        if (name != _undefined && name != null) 'name': (name as String),
      }));
}

class _CopyWithStubImpl$Input$CreateUserInput<TRes>
    implements CopyWith$Input$CreateUserInput<TRes> {
  _CopyWithStubImpl$Input$CreateUserInput(this._res);

  TRes _res;

  call({
    String? email,
    String? name,
  }) =>
      _res;
}

class Input$DeploymentSourceInput {
  factory Input$DeploymentSourceInput({
    Input$CliDeploymentSourceInput? cli,
    Input$RedeployDeploymentSourceInput? redeploy,
    Input$GitHubDeploymentSourceInput? github,
  }) =>
      Input$DeploymentSourceInput._({
        if (cli != null) r'cli': cli,
        if (redeploy != null) r'redeploy': redeploy,
        if (github != null) r'github': github,
      });

  Input$DeploymentSourceInput._(this._$data);

  factory Input$DeploymentSourceInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('cli')) {
      final l$cli = data['cli'];
      result$data['cli'] = l$cli == null
          ? null
          : Input$CliDeploymentSourceInput.fromJson(
              (l$cli as Map<String, dynamic>));
    }
    if (data.containsKey('redeploy')) {
      final l$redeploy = data['redeploy'];
      result$data['redeploy'] = l$redeploy == null
          ? null
          : Input$RedeployDeploymentSourceInput.fromJson(
              (l$redeploy as Map<String, dynamic>));
    }
    if (data.containsKey('github')) {
      final l$github = data['github'];
      result$data['github'] = l$github == null
          ? null
          : Input$GitHubDeploymentSourceInput.fromJson(
              (l$github as Map<String, dynamic>));
    }
    return Input$DeploymentSourceInput._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$CliDeploymentSourceInput? get cli =>
      (_$data['cli'] as Input$CliDeploymentSourceInput?);

  Input$RedeployDeploymentSourceInput? get redeploy =>
      (_$data['redeploy'] as Input$RedeployDeploymentSourceInput?);

  Input$GitHubDeploymentSourceInput? get github =>
      (_$data['github'] as Input$GitHubDeploymentSourceInput?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('cli')) {
      final l$cli = cli;
      result$data['cli'] = l$cli?.toJson();
    }
    if (_$data.containsKey('redeploy')) {
      final l$redeploy = redeploy;
      result$data['redeploy'] = l$redeploy?.toJson();
    }
    if (_$data.containsKey('github')) {
      final l$github = github;
      result$data['github'] = l$github?.toJson();
    }
    return result$data;
  }

  CopyWith$Input$DeploymentSourceInput<Input$DeploymentSourceInput>
      get copyWith => CopyWith$Input$DeploymentSourceInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$DeploymentSourceInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$cli = cli;
    final lOther$cli = other.cli;
    if (_$data.containsKey('cli') != other._$data.containsKey('cli')) {
      return false;
    }
    if (l$cli != lOther$cli) {
      return false;
    }
    final l$redeploy = redeploy;
    final lOther$redeploy = other.redeploy;
    if (_$data.containsKey('redeploy') !=
        other._$data.containsKey('redeploy')) {
      return false;
    }
    if (l$redeploy != lOther$redeploy) {
      return false;
    }
    final l$github = github;
    final lOther$github = other.github;
    if (_$data.containsKey('github') != other._$data.containsKey('github')) {
      return false;
    }
    if (l$github != lOther$github) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$cli = cli;
    final l$redeploy = redeploy;
    final l$github = github;
    return Object.hashAll([
      _$data.containsKey('cli') ? l$cli : const {},
      _$data.containsKey('redeploy') ? l$redeploy : const {},
      _$data.containsKey('github') ? l$github : const {},
    ]);
  }
}

abstract class CopyWith$Input$DeploymentSourceInput<TRes> {
  factory CopyWith$Input$DeploymentSourceInput(
    Input$DeploymentSourceInput instance,
    TRes Function(Input$DeploymentSourceInput) then,
  ) = _CopyWithImpl$Input$DeploymentSourceInput;

  factory CopyWith$Input$DeploymentSourceInput.stub(TRes res) =
      _CopyWithStubImpl$Input$DeploymentSourceInput;

  TRes call({
    Input$CliDeploymentSourceInput? cli,
    Input$RedeployDeploymentSourceInput? redeploy,
    Input$GitHubDeploymentSourceInput? github,
  });
  CopyWith$Input$CliDeploymentSourceInput<TRes> get cli;
  CopyWith$Input$RedeployDeploymentSourceInput<TRes> get redeploy;
  CopyWith$Input$GitHubDeploymentSourceInput<TRes> get github;
}

class _CopyWithImpl$Input$DeploymentSourceInput<TRes>
    implements CopyWith$Input$DeploymentSourceInput<TRes> {
  _CopyWithImpl$Input$DeploymentSourceInput(
    this._instance,
    this._then,
  );

  final Input$DeploymentSourceInput _instance;

  final TRes Function(Input$DeploymentSourceInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? cli = _undefined,
    Object? redeploy = _undefined,
    Object? github = _undefined,
  }) =>
      _then(Input$DeploymentSourceInput._({
        ..._instance._$data,
        if (cli != _undefined) 'cli': (cli as Input$CliDeploymentSourceInput?),
        if (redeploy != _undefined)
          'redeploy': (redeploy as Input$RedeployDeploymentSourceInput?),
        if (github != _undefined)
          'github': (github as Input$GitHubDeploymentSourceInput?),
      }));

  CopyWith$Input$CliDeploymentSourceInput<TRes> get cli {
    final local$cli = _instance.cli;
    return local$cli == null
        ? CopyWith$Input$CliDeploymentSourceInput.stub(_then(_instance))
        : CopyWith$Input$CliDeploymentSourceInput(
            local$cli, (e) => call(cli: e));
  }

  CopyWith$Input$RedeployDeploymentSourceInput<TRes> get redeploy {
    final local$redeploy = _instance.redeploy;
    return local$redeploy == null
        ? CopyWith$Input$RedeployDeploymentSourceInput.stub(_then(_instance))
        : CopyWith$Input$RedeployDeploymentSourceInput(
            local$redeploy, (e) => call(redeploy: e));
  }

  CopyWith$Input$GitHubDeploymentSourceInput<TRes> get github {
    final local$github = _instance.github;
    return local$github == null
        ? CopyWith$Input$GitHubDeploymentSourceInput.stub(_then(_instance))
        : CopyWith$Input$GitHubDeploymentSourceInput(
            local$github, (e) => call(github: e));
  }
}

class _CopyWithStubImpl$Input$DeploymentSourceInput<TRes>
    implements CopyWith$Input$DeploymentSourceInput<TRes> {
  _CopyWithStubImpl$Input$DeploymentSourceInput(this._res);

  TRes _res;

  call({
    Input$CliDeploymentSourceInput? cli,
    Input$RedeployDeploymentSourceInput? redeploy,
    Input$GitHubDeploymentSourceInput? github,
  }) =>
      _res;

  CopyWith$Input$CliDeploymentSourceInput<TRes> get cli =>
      CopyWith$Input$CliDeploymentSourceInput.stub(_res);

  CopyWith$Input$RedeployDeploymentSourceInput<TRes> get redeploy =>
      CopyWith$Input$RedeployDeploymentSourceInput.stub(_res);

  CopyWith$Input$GitHubDeploymentSourceInput<TRes> get github =>
      CopyWith$Input$GitHubDeploymentSourceInput.stub(_res);
}

class Input$GitHubDeploymentSourceInput {
  factory Input$GitHubDeploymentSourceInput({
    required String type,
    required String owner,
    required String repository,
    required int repositoryId,
    required String ref,
    required String commit,
    required String message,
    required int installationId,
  }) =>
      Input$GitHubDeploymentSourceInput._({
        r'type': type,
        r'owner': owner,
        r'repository': repository,
        r'repositoryId': repositoryId,
        r'ref': ref,
        r'commit': commit,
        r'message': message,
        r'installationId': installationId,
      });

  Input$GitHubDeploymentSourceInput._(this._$data);

  factory Input$GitHubDeploymentSourceInput.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$type = data['type'];
    result$data['type'] = (l$type as String);
    final l$owner = data['owner'];
    result$data['owner'] = (l$owner as String);
    final l$repository = data['repository'];
    result$data['repository'] = (l$repository as String);
    final l$repositoryId = data['repositoryId'];
    result$data['repositoryId'] = (l$repositoryId as int);
    final l$ref = data['ref'];
    result$data['ref'] = (l$ref as String);
    final l$commit = data['commit'];
    result$data['commit'] = (l$commit as String);
    final l$message = data['message'];
    result$data['message'] = (l$message as String);
    final l$installationId = data['installationId'];
    result$data['installationId'] = (l$installationId as int);
    return Input$GitHubDeploymentSourceInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get type => (_$data['type'] as String);

  String get owner => (_$data['owner'] as String);

  String get repository => (_$data['repository'] as String);

  int get repositoryId => (_$data['repositoryId'] as int);

  String get ref => (_$data['ref'] as String);

  String get commit => (_$data['commit'] as String);

  String get message => (_$data['message'] as String);

  int get installationId => (_$data['installationId'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$type = type;
    result$data['type'] = l$type;
    final l$owner = owner;
    result$data['owner'] = l$owner;
    final l$repository = repository;
    result$data['repository'] = l$repository;
    final l$repositoryId = repositoryId;
    result$data['repositoryId'] = l$repositoryId;
    final l$ref = ref;
    result$data['ref'] = l$ref;
    final l$commit = commit;
    result$data['commit'] = l$commit;
    final l$message = message;
    result$data['message'] = l$message;
    final l$installationId = installationId;
    result$data['installationId'] = l$installationId;
    return result$data;
  }

  CopyWith$Input$GitHubDeploymentSourceInput<Input$GitHubDeploymentSourceInput>
      get copyWith => CopyWith$Input$GitHubDeploymentSourceInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$GitHubDeploymentSourceInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$owner = owner;
    final lOther$owner = other.owner;
    if (l$owner != lOther$owner) {
      return false;
    }
    final l$repository = repository;
    final lOther$repository = other.repository;
    if (l$repository != lOther$repository) {
      return false;
    }
    final l$repositoryId = repositoryId;
    final lOther$repositoryId = other.repositoryId;
    if (l$repositoryId != lOther$repositoryId) {
      return false;
    }
    final l$ref = ref;
    final lOther$ref = other.ref;
    if (l$ref != lOther$ref) {
      return false;
    }
    final l$commit = commit;
    final lOther$commit = other.commit;
    if (l$commit != lOther$commit) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$installationId = installationId;
    final lOther$installationId = other.installationId;
    if (l$installationId != lOther$installationId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$type = type;
    final l$owner = owner;
    final l$repository = repository;
    final l$repositoryId = repositoryId;
    final l$ref = ref;
    final l$commit = commit;
    final l$message = message;
    final l$installationId = installationId;
    return Object.hashAll([
      l$type,
      l$owner,
      l$repository,
      l$repositoryId,
      l$ref,
      l$commit,
      l$message,
      l$installationId,
    ]);
  }
}

abstract class CopyWith$Input$GitHubDeploymentSourceInput<TRes> {
  factory CopyWith$Input$GitHubDeploymentSourceInput(
    Input$GitHubDeploymentSourceInput instance,
    TRes Function(Input$GitHubDeploymentSourceInput) then,
  ) = _CopyWithImpl$Input$GitHubDeploymentSourceInput;

  factory CopyWith$Input$GitHubDeploymentSourceInput.stub(TRes res) =
      _CopyWithStubImpl$Input$GitHubDeploymentSourceInput;

  TRes call({
    String? type,
    String? owner,
    String? repository,
    int? repositoryId,
    String? ref,
    String? commit,
    String? message,
    int? installationId,
  });
}

class _CopyWithImpl$Input$GitHubDeploymentSourceInput<TRes>
    implements CopyWith$Input$GitHubDeploymentSourceInput<TRes> {
  _CopyWithImpl$Input$GitHubDeploymentSourceInput(
    this._instance,
    this._then,
  );

  final Input$GitHubDeploymentSourceInput _instance;

  final TRes Function(Input$GitHubDeploymentSourceInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? type = _undefined,
    Object? owner = _undefined,
    Object? repository = _undefined,
    Object? repositoryId = _undefined,
    Object? ref = _undefined,
    Object? commit = _undefined,
    Object? message = _undefined,
    Object? installationId = _undefined,
  }) =>
      _then(Input$GitHubDeploymentSourceInput._({
        ..._instance._$data,
        if (type != _undefined && type != null) 'type': (type as String),
        if (owner != _undefined && owner != null) 'owner': (owner as String),
        if (repository != _undefined && repository != null)
          'repository': (repository as String),
        if (repositoryId != _undefined && repositoryId != null)
          'repositoryId': (repositoryId as int),
        if (ref != _undefined && ref != null) 'ref': (ref as String),
        if (commit != _undefined && commit != null)
          'commit': (commit as String),
        if (message != _undefined && message != null)
          'message': (message as String),
        if (installationId != _undefined && installationId != null)
          'installationId': (installationId as int),
      }));
}

class _CopyWithStubImpl$Input$GitHubDeploymentSourceInput<TRes>
    implements CopyWith$Input$GitHubDeploymentSourceInput<TRes> {
  _CopyWithStubImpl$Input$GitHubDeploymentSourceInput(this._res);

  TRes _res;

  call({
    String? type,
    String? owner,
    String? repository,
    int? repositoryId,
    String? ref,
    String? commit,
    String? message,
    int? installationId,
  }) =>
      _res;
}

class Input$PaddleCheckoutBillingItemInput {
  factory Input$PaddleCheckoutBillingItemInput({
    required String billingProductItemId,
    required int quantity,
  }) =>
      Input$PaddleCheckoutBillingItemInput._({
        r'billingProductItemId': billingProductItemId,
        r'quantity': quantity,
      });

  Input$PaddleCheckoutBillingItemInput._(this._$data);

  factory Input$PaddleCheckoutBillingItemInput.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$billingProductItemId = data['billingProductItemId'];
    result$data['billingProductItemId'] = (l$billingProductItemId as String);
    final l$quantity = data['quantity'];
    result$data['quantity'] = (l$quantity as int);
    return Input$PaddleCheckoutBillingItemInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get billingProductItemId => (_$data['billingProductItemId'] as String);

  int get quantity => (_$data['quantity'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$billingProductItemId = billingProductItemId;
    result$data['billingProductItemId'] = l$billingProductItemId;
    final l$quantity = quantity;
    result$data['quantity'] = l$quantity;
    return result$data;
  }

  CopyWith$Input$PaddleCheckoutBillingItemInput<
          Input$PaddleCheckoutBillingItemInput>
      get copyWith => CopyWith$Input$PaddleCheckoutBillingItemInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$PaddleCheckoutBillingItemInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$billingProductItemId = billingProductItemId;
    final lOther$billingProductItemId = other.billingProductItemId;
    if (l$billingProductItemId != lOther$billingProductItemId) {
      return false;
    }
    final l$quantity = quantity;
    final lOther$quantity = other.quantity;
    if (l$quantity != lOther$quantity) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$billingProductItemId = billingProductItemId;
    final l$quantity = quantity;
    return Object.hashAll([
      l$billingProductItemId,
      l$quantity,
    ]);
  }
}

abstract class CopyWith$Input$PaddleCheckoutBillingItemInput<TRes> {
  factory CopyWith$Input$PaddleCheckoutBillingItemInput(
    Input$PaddleCheckoutBillingItemInput instance,
    TRes Function(Input$PaddleCheckoutBillingItemInput) then,
  ) = _CopyWithImpl$Input$PaddleCheckoutBillingItemInput;

  factory CopyWith$Input$PaddleCheckoutBillingItemInput.stub(TRes res) =
      _CopyWithStubImpl$Input$PaddleCheckoutBillingItemInput;

  TRes call({
    String? billingProductItemId,
    int? quantity,
  });
}

class _CopyWithImpl$Input$PaddleCheckoutBillingItemInput<TRes>
    implements CopyWith$Input$PaddleCheckoutBillingItemInput<TRes> {
  _CopyWithImpl$Input$PaddleCheckoutBillingItemInput(
    this._instance,
    this._then,
  );

  final Input$PaddleCheckoutBillingItemInput _instance;

  final TRes Function(Input$PaddleCheckoutBillingItemInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? billingProductItemId = _undefined,
    Object? quantity = _undefined,
  }) =>
      _then(Input$PaddleCheckoutBillingItemInput._({
        ..._instance._$data,
        if (billingProductItemId != _undefined && billingProductItemId != null)
          'billingProductItemId': (billingProductItemId as String),
        if (quantity != _undefined && quantity != null)
          'quantity': (quantity as int),
      }));
}

class _CopyWithStubImpl$Input$PaddleCheckoutBillingItemInput<TRes>
    implements CopyWith$Input$PaddleCheckoutBillingItemInput<TRes> {
  _CopyWithStubImpl$Input$PaddleCheckoutBillingItemInput(this._res);

  TRes _res;

  call({
    String? billingProductItemId,
    int? quantity,
  }) =>
      _res;
}

class Input$PaginatedQueryInput {
  factory Input$PaginatedQueryInput({
    required int limit,
    required int offset,
  }) =>
      Input$PaginatedQueryInput._({
        r'limit': limit,
        r'offset': offset,
      });

  Input$PaginatedQueryInput._(this._$data);

  factory Input$PaginatedQueryInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$limit = data['limit'];
    result$data['limit'] = (l$limit as int);
    final l$offset = data['offset'];
    result$data['offset'] = (l$offset as int);
    return Input$PaginatedQueryInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int get limit => (_$data['limit'] as int);

  int get offset => (_$data['offset'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$limit = limit;
    result$data['limit'] = l$limit;
    final l$offset = offset;
    result$data['offset'] = l$offset;
    return result$data;
  }

  CopyWith$Input$PaginatedQueryInput<Input$PaginatedQueryInput> get copyWith =>
      CopyWith$Input$PaginatedQueryInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$PaginatedQueryInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$limit = limit;
    final lOther$limit = other.limit;
    if (l$limit != lOther$limit) {
      return false;
    }
    final l$offset = offset;
    final lOther$offset = other.offset;
    if (l$offset != lOther$offset) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$limit = limit;
    final l$offset = offset;
    return Object.hashAll([
      l$limit,
      l$offset,
    ]);
  }
}

abstract class CopyWith$Input$PaginatedQueryInput<TRes> {
  factory CopyWith$Input$PaginatedQueryInput(
    Input$PaginatedQueryInput instance,
    TRes Function(Input$PaginatedQueryInput) then,
  ) = _CopyWithImpl$Input$PaginatedQueryInput;

  factory CopyWith$Input$PaginatedQueryInput.stub(TRes res) =
      _CopyWithStubImpl$Input$PaginatedQueryInput;

  TRes call({
    int? limit,
    int? offset,
  });
}

class _CopyWithImpl$Input$PaginatedQueryInput<TRes>
    implements CopyWith$Input$PaginatedQueryInput<TRes> {
  _CopyWithImpl$Input$PaginatedQueryInput(
    this._instance,
    this._then,
  );

  final Input$PaginatedQueryInput _instance;

  final TRes Function(Input$PaginatedQueryInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? limit = _undefined,
    Object? offset = _undefined,
  }) =>
      _then(Input$PaginatedQueryInput._({
        ..._instance._$data,
        if (limit != _undefined && limit != null) 'limit': (limit as int),
        if (offset != _undefined && offset != null) 'offset': (offset as int),
      }));
}

class _CopyWithStubImpl$Input$PaginatedQueryInput<TRes>
    implements CopyWith$Input$PaginatedQueryInput<TRes> {
  _CopyWithStubImpl$Input$PaginatedQueryInput(this._res);

  TRes _res;

  call({
    int? limit,
    int? offset,
  }) =>
      _res;
}

class Input$ProjectConnectionInput {
  factory Input$ProjectConnectionInput({
    required String provider,
    required String owner,
    required String repository,
    required int installationId,
    required int repositoryId,
    required String branch,
  }) =>
      Input$ProjectConnectionInput._({
        r'provider': provider,
        r'owner': owner,
        r'repository': repository,
        r'installationId': installationId,
        r'repositoryId': repositoryId,
        r'branch': branch,
      });

  Input$ProjectConnectionInput._(this._$data);

  factory Input$ProjectConnectionInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$provider = data['provider'];
    result$data['provider'] = (l$provider as String);
    final l$owner = data['owner'];
    result$data['owner'] = (l$owner as String);
    final l$repository = data['repository'];
    result$data['repository'] = (l$repository as String);
    final l$installationId = data['installationId'];
    result$data['installationId'] = (l$installationId as int);
    final l$repositoryId = data['repositoryId'];
    result$data['repositoryId'] = (l$repositoryId as int);
    final l$branch = data['branch'];
    result$data['branch'] = (l$branch as String);
    return Input$ProjectConnectionInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get provider => (_$data['provider'] as String);

  String get owner => (_$data['owner'] as String);

  String get repository => (_$data['repository'] as String);

  int get installationId => (_$data['installationId'] as int);

  int get repositoryId => (_$data['repositoryId'] as int);

  String get branch => (_$data['branch'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$provider = provider;
    result$data['provider'] = l$provider;
    final l$owner = owner;
    result$data['owner'] = l$owner;
    final l$repository = repository;
    result$data['repository'] = l$repository;
    final l$installationId = installationId;
    result$data['installationId'] = l$installationId;
    final l$repositoryId = repositoryId;
    result$data['repositoryId'] = l$repositoryId;
    final l$branch = branch;
    result$data['branch'] = l$branch;
    return result$data;
  }

  CopyWith$Input$ProjectConnectionInput<Input$ProjectConnectionInput>
      get copyWith => CopyWith$Input$ProjectConnectionInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ProjectConnectionInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$provider = provider;
    final lOther$provider = other.provider;
    if (l$provider != lOther$provider) {
      return false;
    }
    final l$owner = owner;
    final lOther$owner = other.owner;
    if (l$owner != lOther$owner) {
      return false;
    }
    final l$repository = repository;
    final lOther$repository = other.repository;
    if (l$repository != lOther$repository) {
      return false;
    }
    final l$installationId = installationId;
    final lOther$installationId = other.installationId;
    if (l$installationId != lOther$installationId) {
      return false;
    }
    final l$repositoryId = repositoryId;
    final lOther$repositoryId = other.repositoryId;
    if (l$repositoryId != lOther$repositoryId) {
      return false;
    }
    final l$branch = branch;
    final lOther$branch = other.branch;
    if (l$branch != lOther$branch) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$provider = provider;
    final l$owner = owner;
    final l$repository = repository;
    final l$installationId = installationId;
    final l$repositoryId = repositoryId;
    final l$branch = branch;
    return Object.hashAll([
      l$provider,
      l$owner,
      l$repository,
      l$installationId,
      l$repositoryId,
      l$branch,
    ]);
  }
}

abstract class CopyWith$Input$ProjectConnectionInput<TRes> {
  factory CopyWith$Input$ProjectConnectionInput(
    Input$ProjectConnectionInput instance,
    TRes Function(Input$ProjectConnectionInput) then,
  ) = _CopyWithImpl$Input$ProjectConnectionInput;

  factory CopyWith$Input$ProjectConnectionInput.stub(TRes res) =
      _CopyWithStubImpl$Input$ProjectConnectionInput;

  TRes call({
    String? provider,
    String? owner,
    String? repository,
    int? installationId,
    int? repositoryId,
    String? branch,
  });
}

class _CopyWithImpl$Input$ProjectConnectionInput<TRes>
    implements CopyWith$Input$ProjectConnectionInput<TRes> {
  _CopyWithImpl$Input$ProjectConnectionInput(
    this._instance,
    this._then,
  );

  final Input$ProjectConnectionInput _instance;

  final TRes Function(Input$ProjectConnectionInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? provider = _undefined,
    Object? owner = _undefined,
    Object? repository = _undefined,
    Object? installationId = _undefined,
    Object? repositoryId = _undefined,
    Object? branch = _undefined,
  }) =>
      _then(Input$ProjectConnectionInput._({
        ..._instance._$data,
        if (provider != _undefined && provider != null)
          'provider': (provider as String),
        if (owner != _undefined && owner != null) 'owner': (owner as String),
        if (repository != _undefined && repository != null)
          'repository': (repository as String),
        if (installationId != _undefined && installationId != null)
          'installationId': (installationId as int),
        if (repositoryId != _undefined && repositoryId != null)
          'repositoryId': (repositoryId as int),
        if (branch != _undefined && branch != null)
          'branch': (branch as String),
      }));
}

class _CopyWithStubImpl$Input$ProjectConnectionInput<TRes>
    implements CopyWith$Input$ProjectConnectionInput<TRes> {
  _CopyWithStubImpl$Input$ProjectConnectionInput(this._res);

  TRes _res;

  call({
    String? provider,
    String? owner,
    String? repository,
    int? installationId,
    int? repositoryId,
    String? branch,
  }) =>
      _res;
}

class Input$ProjectSettingsInput {
  factory Input$ProjectSettingsInput({
    Enum$FrameworkPreset? preset,
    String? presetVersion,
    String? presetBuildCommand,
    String? buildImage,
    String? buildCommand,
    String? entrypoint,
    String? rootDirectory,
    bool? melosDetection,
    String? melosCommand,
    String? melosVersion,
    bool? buildRunnerDetection,
    String? buildRunnerCommand,
    List<String>? preferredRegions,
    bool? flutterWebResourcesCdn,
  }) =>
      Input$ProjectSettingsInput._({
        if (preset != null) r'preset': preset,
        if (presetVersion != null) r'presetVersion': presetVersion,
        if (presetBuildCommand != null)
          r'presetBuildCommand': presetBuildCommand,
        if (buildImage != null) r'buildImage': buildImage,
        if (buildCommand != null) r'buildCommand': buildCommand,
        if (entrypoint != null) r'entrypoint': entrypoint,
        if (rootDirectory != null) r'rootDirectory': rootDirectory,
        if (melosDetection != null) r'melosDetection': melosDetection,
        if (melosCommand != null) r'melosCommand': melosCommand,
        if (melosVersion != null) r'melosVersion': melosVersion,
        if (buildRunnerDetection != null)
          r'buildRunnerDetection': buildRunnerDetection,
        if (buildRunnerCommand != null)
          r'buildRunnerCommand': buildRunnerCommand,
        if (preferredRegions != null) r'preferredRegions': preferredRegions,
        if (flutterWebResourcesCdn != null)
          r'flutterWebResourcesCdn': flutterWebResourcesCdn,
      });

  Input$ProjectSettingsInput._(this._$data);

  factory Input$ProjectSettingsInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('preset')) {
      final l$preset = data['preset'];
      result$data['preset'] = l$preset == null
          ? null
          : fromJson$Enum$FrameworkPreset((l$preset as String));
    }
    if (data.containsKey('presetVersion')) {
      final l$presetVersion = data['presetVersion'];
      result$data['presetVersion'] = (l$presetVersion as String?);
    }
    if (data.containsKey('presetBuildCommand')) {
      final l$presetBuildCommand = data['presetBuildCommand'];
      result$data['presetBuildCommand'] = (l$presetBuildCommand as String?);
    }
    if (data.containsKey('buildImage')) {
      final l$buildImage = data['buildImage'];
      result$data['buildImage'] = (l$buildImage as String?);
    }
    if (data.containsKey('buildCommand')) {
      final l$buildCommand = data['buildCommand'];
      result$data['buildCommand'] = (l$buildCommand as String?);
    }
    if (data.containsKey('entrypoint')) {
      final l$entrypoint = data['entrypoint'];
      result$data['entrypoint'] = (l$entrypoint as String?);
    }
    if (data.containsKey('rootDirectory')) {
      final l$rootDirectory = data['rootDirectory'];
      result$data['rootDirectory'] = (l$rootDirectory as String?);
    }
    if (data.containsKey('melosDetection')) {
      final l$melosDetection = data['melosDetection'];
      result$data['melosDetection'] = (l$melosDetection as bool?);
    }
    if (data.containsKey('melosCommand')) {
      final l$melosCommand = data['melosCommand'];
      result$data['melosCommand'] = (l$melosCommand as String?);
    }
    if (data.containsKey('melosVersion')) {
      final l$melosVersion = data['melosVersion'];
      result$data['melosVersion'] = (l$melosVersion as String?);
    }
    if (data.containsKey('buildRunnerDetection')) {
      final l$buildRunnerDetection = data['buildRunnerDetection'];
      result$data['buildRunnerDetection'] = (l$buildRunnerDetection as bool?);
    }
    if (data.containsKey('buildRunnerCommand')) {
      final l$buildRunnerCommand = data['buildRunnerCommand'];
      result$data['buildRunnerCommand'] = (l$buildRunnerCommand as String?);
    }
    if (data.containsKey('preferredRegions')) {
      final l$preferredRegions = data['preferredRegions'];
      result$data['preferredRegions'] = (l$preferredRegions as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('flutterWebResourcesCdn')) {
      final l$flutterWebResourcesCdn = data['flutterWebResourcesCdn'];
      result$data['flutterWebResourcesCdn'] =
          (l$flutterWebResourcesCdn as bool?);
    }
    return Input$ProjectSettingsInput._(result$data);
  }

  Map<String, dynamic> _$data;

  Enum$FrameworkPreset? get preset =>
      (_$data['preset'] as Enum$FrameworkPreset?);

  String? get presetVersion => (_$data['presetVersion'] as String?);

  String? get presetBuildCommand => (_$data['presetBuildCommand'] as String?);

  String? get buildImage => (_$data['buildImage'] as String?);

  String? get buildCommand => (_$data['buildCommand'] as String?);

  String? get entrypoint => (_$data['entrypoint'] as String?);

  String? get rootDirectory => (_$data['rootDirectory'] as String?);

  bool? get melosDetection => (_$data['melosDetection'] as bool?);

  String? get melosCommand => (_$data['melosCommand'] as String?);

  String? get melosVersion => (_$data['melosVersion'] as String?);

  bool? get buildRunnerDetection => (_$data['buildRunnerDetection'] as bool?);

  String? get buildRunnerCommand => (_$data['buildRunnerCommand'] as String?);

  List<String>? get preferredRegions =>
      (_$data['preferredRegions'] as List<String>?);

  bool? get flutterWebResourcesCdn =>
      (_$data['flutterWebResourcesCdn'] as bool?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('preset')) {
      final l$preset = preset;
      result$data['preset'] =
          l$preset == null ? null : toJson$Enum$FrameworkPreset(l$preset);
    }
    if (_$data.containsKey('presetVersion')) {
      final l$presetVersion = presetVersion;
      result$data['presetVersion'] = l$presetVersion;
    }
    if (_$data.containsKey('presetBuildCommand')) {
      final l$presetBuildCommand = presetBuildCommand;
      result$data['presetBuildCommand'] = l$presetBuildCommand;
    }
    if (_$data.containsKey('buildImage')) {
      final l$buildImage = buildImage;
      result$data['buildImage'] = l$buildImage;
    }
    if (_$data.containsKey('buildCommand')) {
      final l$buildCommand = buildCommand;
      result$data['buildCommand'] = l$buildCommand;
    }
    if (_$data.containsKey('entrypoint')) {
      final l$entrypoint = entrypoint;
      result$data['entrypoint'] = l$entrypoint;
    }
    if (_$data.containsKey('rootDirectory')) {
      final l$rootDirectory = rootDirectory;
      result$data['rootDirectory'] = l$rootDirectory;
    }
    if (_$data.containsKey('melosDetection')) {
      final l$melosDetection = melosDetection;
      result$data['melosDetection'] = l$melosDetection;
    }
    if (_$data.containsKey('melosCommand')) {
      final l$melosCommand = melosCommand;
      result$data['melosCommand'] = l$melosCommand;
    }
    if (_$data.containsKey('melosVersion')) {
      final l$melosVersion = melosVersion;
      result$data['melosVersion'] = l$melosVersion;
    }
    if (_$data.containsKey('buildRunnerDetection')) {
      final l$buildRunnerDetection = buildRunnerDetection;
      result$data['buildRunnerDetection'] = l$buildRunnerDetection;
    }
    if (_$data.containsKey('buildRunnerCommand')) {
      final l$buildRunnerCommand = buildRunnerCommand;
      result$data['buildRunnerCommand'] = l$buildRunnerCommand;
    }
    if (_$data.containsKey('preferredRegions')) {
      final l$preferredRegions = preferredRegions;
      result$data['preferredRegions'] =
          l$preferredRegions?.map((e) => e).toList();
    }
    if (_$data.containsKey('flutterWebResourcesCdn')) {
      final l$flutterWebResourcesCdn = flutterWebResourcesCdn;
      result$data['flutterWebResourcesCdn'] = l$flutterWebResourcesCdn;
    }
    return result$data;
  }

  CopyWith$Input$ProjectSettingsInput<Input$ProjectSettingsInput>
      get copyWith => CopyWith$Input$ProjectSettingsInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ProjectSettingsInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$preset = preset;
    final lOther$preset = other.preset;
    if (_$data.containsKey('preset') != other._$data.containsKey('preset')) {
      return false;
    }
    if (l$preset != lOther$preset) {
      return false;
    }
    final l$presetVersion = presetVersion;
    final lOther$presetVersion = other.presetVersion;
    if (_$data.containsKey('presetVersion') !=
        other._$data.containsKey('presetVersion')) {
      return false;
    }
    if (l$presetVersion != lOther$presetVersion) {
      return false;
    }
    final l$presetBuildCommand = presetBuildCommand;
    final lOther$presetBuildCommand = other.presetBuildCommand;
    if (_$data.containsKey('presetBuildCommand') !=
        other._$data.containsKey('presetBuildCommand')) {
      return false;
    }
    if (l$presetBuildCommand != lOther$presetBuildCommand) {
      return false;
    }
    final l$buildImage = buildImage;
    final lOther$buildImage = other.buildImage;
    if (_$data.containsKey('buildImage') !=
        other._$data.containsKey('buildImage')) {
      return false;
    }
    if (l$buildImage != lOther$buildImage) {
      return false;
    }
    final l$buildCommand = buildCommand;
    final lOther$buildCommand = other.buildCommand;
    if (_$data.containsKey('buildCommand') !=
        other._$data.containsKey('buildCommand')) {
      return false;
    }
    if (l$buildCommand != lOther$buildCommand) {
      return false;
    }
    final l$entrypoint = entrypoint;
    final lOther$entrypoint = other.entrypoint;
    if (_$data.containsKey('entrypoint') !=
        other._$data.containsKey('entrypoint')) {
      return false;
    }
    if (l$entrypoint != lOther$entrypoint) {
      return false;
    }
    final l$rootDirectory = rootDirectory;
    final lOther$rootDirectory = other.rootDirectory;
    if (_$data.containsKey('rootDirectory') !=
        other._$data.containsKey('rootDirectory')) {
      return false;
    }
    if (l$rootDirectory != lOther$rootDirectory) {
      return false;
    }
    final l$melosDetection = melosDetection;
    final lOther$melosDetection = other.melosDetection;
    if (_$data.containsKey('melosDetection') !=
        other._$data.containsKey('melosDetection')) {
      return false;
    }
    if (l$melosDetection != lOther$melosDetection) {
      return false;
    }
    final l$melosCommand = melosCommand;
    final lOther$melosCommand = other.melosCommand;
    if (_$data.containsKey('melosCommand') !=
        other._$data.containsKey('melosCommand')) {
      return false;
    }
    if (l$melosCommand != lOther$melosCommand) {
      return false;
    }
    final l$melosVersion = melosVersion;
    final lOther$melosVersion = other.melosVersion;
    if (_$data.containsKey('melosVersion') !=
        other._$data.containsKey('melosVersion')) {
      return false;
    }
    if (l$melosVersion != lOther$melosVersion) {
      return false;
    }
    final l$buildRunnerDetection = buildRunnerDetection;
    final lOther$buildRunnerDetection = other.buildRunnerDetection;
    if (_$data.containsKey('buildRunnerDetection') !=
        other._$data.containsKey('buildRunnerDetection')) {
      return false;
    }
    if (l$buildRunnerDetection != lOther$buildRunnerDetection) {
      return false;
    }
    final l$buildRunnerCommand = buildRunnerCommand;
    final lOther$buildRunnerCommand = other.buildRunnerCommand;
    if (_$data.containsKey('buildRunnerCommand') !=
        other._$data.containsKey('buildRunnerCommand')) {
      return false;
    }
    if (l$buildRunnerCommand != lOther$buildRunnerCommand) {
      return false;
    }
    final l$preferredRegions = preferredRegions;
    final lOther$preferredRegions = other.preferredRegions;
    if (_$data.containsKey('preferredRegions') !=
        other._$data.containsKey('preferredRegions')) {
      return false;
    }
    if (l$preferredRegions != null && lOther$preferredRegions != null) {
      if (l$preferredRegions.length != lOther$preferredRegions.length) {
        return false;
      }
      for (int i = 0; i < l$preferredRegions.length; i++) {
        final l$preferredRegions$entry = l$preferredRegions[i];
        final lOther$preferredRegions$entry = lOther$preferredRegions[i];
        if (l$preferredRegions$entry != lOther$preferredRegions$entry) {
          return false;
        }
      }
    } else if (l$preferredRegions != lOther$preferredRegions) {
      return false;
    }
    final l$flutterWebResourcesCdn = flutterWebResourcesCdn;
    final lOther$flutterWebResourcesCdn = other.flutterWebResourcesCdn;
    if (_$data.containsKey('flutterWebResourcesCdn') !=
        other._$data.containsKey('flutterWebResourcesCdn')) {
      return false;
    }
    if (l$flutterWebResourcesCdn != lOther$flutterWebResourcesCdn) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$preset = preset;
    final l$presetVersion = presetVersion;
    final l$presetBuildCommand = presetBuildCommand;
    final l$buildImage = buildImage;
    final l$buildCommand = buildCommand;
    final l$entrypoint = entrypoint;
    final l$rootDirectory = rootDirectory;
    final l$melosDetection = melosDetection;
    final l$melosCommand = melosCommand;
    final l$melosVersion = melosVersion;
    final l$buildRunnerDetection = buildRunnerDetection;
    final l$buildRunnerCommand = buildRunnerCommand;
    final l$preferredRegions = preferredRegions;
    final l$flutterWebResourcesCdn = flutterWebResourcesCdn;
    return Object.hashAll([
      _$data.containsKey('preset') ? l$preset : const {},
      _$data.containsKey('presetVersion') ? l$presetVersion : const {},
      _$data.containsKey('presetBuildCommand')
          ? l$presetBuildCommand
          : const {},
      _$data.containsKey('buildImage') ? l$buildImage : const {},
      _$data.containsKey('buildCommand') ? l$buildCommand : const {},
      _$data.containsKey('entrypoint') ? l$entrypoint : const {},
      _$data.containsKey('rootDirectory') ? l$rootDirectory : const {},
      _$data.containsKey('melosDetection') ? l$melosDetection : const {},
      _$data.containsKey('melosCommand') ? l$melosCommand : const {},
      _$data.containsKey('melosVersion') ? l$melosVersion : const {},
      _$data.containsKey('buildRunnerDetection')
          ? l$buildRunnerDetection
          : const {},
      _$data.containsKey('buildRunnerCommand')
          ? l$buildRunnerCommand
          : const {},
      _$data.containsKey('preferredRegions')
          ? l$preferredRegions == null
              ? null
              : Object.hashAll(l$preferredRegions.map((v) => v))
          : const {},
      _$data.containsKey('flutterWebResourcesCdn')
          ? l$flutterWebResourcesCdn
          : const {},
    ]);
  }
}

abstract class CopyWith$Input$ProjectSettingsInput<TRes> {
  factory CopyWith$Input$ProjectSettingsInput(
    Input$ProjectSettingsInput instance,
    TRes Function(Input$ProjectSettingsInput) then,
  ) = _CopyWithImpl$Input$ProjectSettingsInput;

  factory CopyWith$Input$ProjectSettingsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$ProjectSettingsInput;

  TRes call({
    Enum$FrameworkPreset? preset,
    String? presetVersion,
    String? presetBuildCommand,
    String? buildImage,
    String? buildCommand,
    String? entrypoint,
    String? rootDirectory,
    bool? melosDetection,
    String? melosCommand,
    String? melosVersion,
    bool? buildRunnerDetection,
    String? buildRunnerCommand,
    List<String>? preferredRegions,
    bool? flutterWebResourcesCdn,
  });
}

class _CopyWithImpl$Input$ProjectSettingsInput<TRes>
    implements CopyWith$Input$ProjectSettingsInput<TRes> {
  _CopyWithImpl$Input$ProjectSettingsInput(
    this._instance,
    this._then,
  );

  final Input$ProjectSettingsInput _instance;

  final TRes Function(Input$ProjectSettingsInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? preset = _undefined,
    Object? presetVersion = _undefined,
    Object? presetBuildCommand = _undefined,
    Object? buildImage = _undefined,
    Object? buildCommand = _undefined,
    Object? entrypoint = _undefined,
    Object? rootDirectory = _undefined,
    Object? melosDetection = _undefined,
    Object? melosCommand = _undefined,
    Object? melosVersion = _undefined,
    Object? buildRunnerDetection = _undefined,
    Object? buildRunnerCommand = _undefined,
    Object? preferredRegions = _undefined,
    Object? flutterWebResourcesCdn = _undefined,
  }) =>
      _then(Input$ProjectSettingsInput._({
        ..._instance._$data,
        if (preset != _undefined) 'preset': (preset as Enum$FrameworkPreset?),
        if (presetVersion != _undefined)
          'presetVersion': (presetVersion as String?),
        if (presetBuildCommand != _undefined)
          'presetBuildCommand': (presetBuildCommand as String?),
        if (buildImage != _undefined) 'buildImage': (buildImage as String?),
        if (buildCommand != _undefined)
          'buildCommand': (buildCommand as String?),
        if (entrypoint != _undefined) 'entrypoint': (entrypoint as String?),
        if (rootDirectory != _undefined)
          'rootDirectory': (rootDirectory as String?),
        if (melosDetection != _undefined)
          'melosDetection': (melosDetection as bool?),
        if (melosCommand != _undefined)
          'melosCommand': (melosCommand as String?),
        if (melosVersion != _undefined)
          'melosVersion': (melosVersion as String?),
        if (buildRunnerDetection != _undefined)
          'buildRunnerDetection': (buildRunnerDetection as bool?),
        if (buildRunnerCommand != _undefined)
          'buildRunnerCommand': (buildRunnerCommand as String?),
        if (preferredRegions != _undefined)
          'preferredRegions': (preferredRegions as List<String>?),
        if (flutterWebResourcesCdn != _undefined)
          'flutterWebResourcesCdn': (flutterWebResourcesCdn as bool?),
      }));
}

class _CopyWithStubImpl$Input$ProjectSettingsInput<TRes>
    implements CopyWith$Input$ProjectSettingsInput<TRes> {
  _CopyWithStubImpl$Input$ProjectSettingsInput(this._res);

  TRes _res;

  call({
    Enum$FrameworkPreset? preset,
    String? presetVersion,
    String? presetBuildCommand,
    String? buildImage,
    String? buildCommand,
    String? entrypoint,
    String? rootDirectory,
    bool? melosDetection,
    String? melosCommand,
    String? melosVersion,
    bool? buildRunnerDetection,
    String? buildRunnerCommand,
    List<String>? preferredRegions,
    bool? flutterWebResourcesCdn,
  }) =>
      _res;
}

class Input$RedeployDeploymentSourceInput {
  factory Input$RedeployDeploymentSourceInput({
    required String type,
    required String deploymentId,
    required String deploymentHash,
    required bool usesBuildCache,
    required bool usesSettings,
  }) =>
      Input$RedeployDeploymentSourceInput._({
        r'type': type,
        r'deploymentId': deploymentId,
        r'deploymentHash': deploymentHash,
        r'usesBuildCache': usesBuildCache,
        r'usesSettings': usesSettings,
      });

  Input$RedeployDeploymentSourceInput._(this._$data);

  factory Input$RedeployDeploymentSourceInput.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$type = data['type'];
    result$data['type'] = (l$type as String);
    final l$deploymentId = data['deploymentId'];
    result$data['deploymentId'] = (l$deploymentId as String);
    final l$deploymentHash = data['deploymentHash'];
    result$data['deploymentHash'] = (l$deploymentHash as String);
    final l$usesBuildCache = data['usesBuildCache'];
    result$data['usesBuildCache'] = (l$usesBuildCache as bool);
    final l$usesSettings = data['usesSettings'];
    result$data['usesSettings'] = (l$usesSettings as bool);
    return Input$RedeployDeploymentSourceInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get type => (_$data['type'] as String);

  String get deploymentId => (_$data['deploymentId'] as String);

  String get deploymentHash => (_$data['deploymentHash'] as String);

  bool get usesBuildCache => (_$data['usesBuildCache'] as bool);

  bool get usesSettings => (_$data['usesSettings'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$type = type;
    result$data['type'] = l$type;
    final l$deploymentId = deploymentId;
    result$data['deploymentId'] = l$deploymentId;
    final l$deploymentHash = deploymentHash;
    result$data['deploymentHash'] = l$deploymentHash;
    final l$usesBuildCache = usesBuildCache;
    result$data['usesBuildCache'] = l$usesBuildCache;
    final l$usesSettings = usesSettings;
    result$data['usesSettings'] = l$usesSettings;
    return result$data;
  }

  CopyWith$Input$RedeployDeploymentSourceInput<
          Input$RedeployDeploymentSourceInput>
      get copyWith => CopyWith$Input$RedeployDeploymentSourceInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RedeployDeploymentSourceInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$deploymentId = deploymentId;
    final lOther$deploymentId = other.deploymentId;
    if (l$deploymentId != lOther$deploymentId) {
      return false;
    }
    final l$deploymentHash = deploymentHash;
    final lOther$deploymentHash = other.deploymentHash;
    if (l$deploymentHash != lOther$deploymentHash) {
      return false;
    }
    final l$usesBuildCache = usesBuildCache;
    final lOther$usesBuildCache = other.usesBuildCache;
    if (l$usesBuildCache != lOther$usesBuildCache) {
      return false;
    }
    final l$usesSettings = usesSettings;
    final lOther$usesSettings = other.usesSettings;
    if (l$usesSettings != lOther$usesSettings) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$type = type;
    final l$deploymentId = deploymentId;
    final l$deploymentHash = deploymentHash;
    final l$usesBuildCache = usesBuildCache;
    final l$usesSettings = usesSettings;
    return Object.hashAll([
      l$type,
      l$deploymentId,
      l$deploymentHash,
      l$usesBuildCache,
      l$usesSettings,
    ]);
  }
}

abstract class CopyWith$Input$RedeployDeploymentSourceInput<TRes> {
  factory CopyWith$Input$RedeployDeploymentSourceInput(
    Input$RedeployDeploymentSourceInput instance,
    TRes Function(Input$RedeployDeploymentSourceInput) then,
  ) = _CopyWithImpl$Input$RedeployDeploymentSourceInput;

  factory CopyWith$Input$RedeployDeploymentSourceInput.stub(TRes res) =
      _CopyWithStubImpl$Input$RedeployDeploymentSourceInput;

  TRes call({
    String? type,
    String? deploymentId,
    String? deploymentHash,
    bool? usesBuildCache,
    bool? usesSettings,
  });
}

class _CopyWithImpl$Input$RedeployDeploymentSourceInput<TRes>
    implements CopyWith$Input$RedeployDeploymentSourceInput<TRes> {
  _CopyWithImpl$Input$RedeployDeploymentSourceInput(
    this._instance,
    this._then,
  );

  final Input$RedeployDeploymentSourceInput _instance;

  final TRes Function(Input$RedeployDeploymentSourceInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? type = _undefined,
    Object? deploymentId = _undefined,
    Object? deploymentHash = _undefined,
    Object? usesBuildCache = _undefined,
    Object? usesSettings = _undefined,
  }) =>
      _then(Input$RedeployDeploymentSourceInput._({
        ..._instance._$data,
        if (type != _undefined && type != null) 'type': (type as String),
        if (deploymentId != _undefined && deploymentId != null)
          'deploymentId': (deploymentId as String),
        if (deploymentHash != _undefined && deploymentHash != null)
          'deploymentHash': (deploymentHash as String),
        if (usesBuildCache != _undefined && usesBuildCache != null)
          'usesBuildCache': (usesBuildCache as bool),
        if (usesSettings != _undefined && usesSettings != null)
          'usesSettings': (usesSettings as bool),
      }));
}

class _CopyWithStubImpl$Input$RedeployDeploymentSourceInput<TRes>
    implements CopyWith$Input$RedeployDeploymentSourceInput<TRes> {
  _CopyWithStubImpl$Input$RedeployDeploymentSourceInput(this._res);

  TRes _res;

  call({
    String? type,
    String? deploymentId,
    String? deploymentHash,
    bool? usesBuildCache,
    bool? usesSettings,
  }) =>
      _res;
}

class Input$UpdateProjectSlugInput {
  factory Input$UpdateProjectSlugInput({
    required String orgSlug,
    required String slug,
  }) =>
      Input$UpdateProjectSlugInput._({
        r'orgSlug': orgSlug,
        r'slug': slug,
      });

  Input$UpdateProjectSlugInput._(this._$data);

  factory Input$UpdateProjectSlugInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orgSlug = data['orgSlug'];
    result$data['orgSlug'] = (l$orgSlug as String);
    final l$slug = data['slug'];
    result$data['slug'] = (l$slug as String);
    return Input$UpdateProjectSlugInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orgSlug => (_$data['orgSlug'] as String);

  String get slug => (_$data['slug'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orgSlug = orgSlug;
    result$data['orgSlug'] = l$orgSlug;
    final l$slug = slug;
    result$data['slug'] = l$slug;
    return result$data;
  }

  CopyWith$Input$UpdateProjectSlugInput<Input$UpdateProjectSlugInput>
      get copyWith => CopyWith$Input$UpdateProjectSlugInput(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateProjectSlugInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$orgSlug = orgSlug;
    final lOther$orgSlug = other.orgSlug;
    if (l$orgSlug != lOther$orgSlug) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$orgSlug = orgSlug;
    final l$slug = slug;
    return Object.hashAll([
      l$orgSlug,
      l$slug,
    ]);
  }
}

abstract class CopyWith$Input$UpdateProjectSlugInput<TRes> {
  factory CopyWith$Input$UpdateProjectSlugInput(
    Input$UpdateProjectSlugInput instance,
    TRes Function(Input$UpdateProjectSlugInput) then,
  ) = _CopyWithImpl$Input$UpdateProjectSlugInput;

  factory CopyWith$Input$UpdateProjectSlugInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateProjectSlugInput;

  TRes call({
    String? orgSlug,
    String? slug,
  });
}

class _CopyWithImpl$Input$UpdateProjectSlugInput<TRes>
    implements CopyWith$Input$UpdateProjectSlugInput<TRes> {
  _CopyWithImpl$Input$UpdateProjectSlugInput(
    this._instance,
    this._then,
  );

  final Input$UpdateProjectSlugInput _instance;

  final TRes Function(Input$UpdateProjectSlugInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? orgSlug = _undefined,
    Object? slug = _undefined,
  }) =>
      _then(Input$UpdateProjectSlugInput._({
        ..._instance._$data,
        if (orgSlug != _undefined && orgSlug != null)
          'orgSlug': (orgSlug as String),
        if (slug != _undefined && slug != null) 'slug': (slug as String),
      }));
}

class _CopyWithStubImpl$Input$UpdateProjectSlugInput<TRes>
    implements CopyWith$Input$UpdateProjectSlugInput<TRes> {
  _CopyWithStubImpl$Input$UpdateProjectSlugInput(this._res);

  TRes _res;

  call({
    String? orgSlug,
    String? slug,
  }) =>
      _res;
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

enum Enum$BillingProductUsageTypeEnum {
  REQUESTS,
  BANDWIDTH,
  $unknown;

  factory Enum$BillingProductUsageTypeEnum.fromJson(String value) =>
      fromJson$Enum$BillingProductUsageTypeEnum(value);

  String toJson() => toJson$Enum$BillingProductUsageTypeEnum(this);
}

String toJson$Enum$BillingProductUsageTypeEnum(
    Enum$BillingProductUsageTypeEnum e) {
  switch (e) {
    case Enum$BillingProductUsageTypeEnum.REQUESTS:
      return r'REQUESTS';
    case Enum$BillingProductUsageTypeEnum.BANDWIDTH:
      return r'BANDWIDTH';
    case Enum$BillingProductUsageTypeEnum.$unknown:
      return r'$unknown';
  }
}

Enum$BillingProductUsageTypeEnum fromJson$Enum$BillingProductUsageTypeEnum(
    String value) {
  switch (value) {
    case r'REQUESTS':
      return Enum$BillingProductUsageTypeEnum.REQUESTS;
    case r'BANDWIDTH':
      return Enum$BillingProductUsageTypeEnum.BANDWIDTH;
    default:
      return Enum$BillingProductUsageTypeEnum.$unknown;
  }
}

enum Enum$BillingUsageSubscriptionEnum {
  free,
  paid,
  enterprise,
  $unknown;

  factory Enum$BillingUsageSubscriptionEnum.fromJson(String value) =>
      fromJson$Enum$BillingUsageSubscriptionEnum(value);

  String toJson() => toJson$Enum$BillingUsageSubscriptionEnum(this);
}

String toJson$Enum$BillingUsageSubscriptionEnum(
    Enum$BillingUsageSubscriptionEnum e) {
  switch (e) {
    case Enum$BillingUsageSubscriptionEnum.free:
      return r'free';
    case Enum$BillingUsageSubscriptionEnum.paid:
      return r'paid';
    case Enum$BillingUsageSubscriptionEnum.enterprise:
      return r'enterprise';
    case Enum$BillingUsageSubscriptionEnum.$unknown:
      return r'$unknown';
  }
}

Enum$BillingUsageSubscriptionEnum fromJson$Enum$BillingUsageSubscriptionEnum(
    String value) {
  switch (value) {
    case r'free':
      return Enum$BillingUsageSubscriptionEnum.free;
    case r'paid':
      return Enum$BillingUsageSubscriptionEnum.paid;
    case r'enterprise':
      return Enum$BillingUsageSubscriptionEnum.enterprise;
    default:
      return Enum$BillingUsageSubscriptionEnum.$unknown;
  }
}

enum Enum$DeploymentEnvironment {
  production,
  preview,
  $unknown;

  factory Enum$DeploymentEnvironment.fromJson(String value) =>
      fromJson$Enum$DeploymentEnvironment(value);

  String toJson() => toJson$Enum$DeploymentEnvironment(this);
}

String toJson$Enum$DeploymentEnvironment(Enum$DeploymentEnvironment e) {
  switch (e) {
    case Enum$DeploymentEnvironment.production:
      return r'production';
    case Enum$DeploymentEnvironment.preview:
      return r'preview';
    case Enum$DeploymentEnvironment.$unknown:
      return r'$unknown';
  }
}

Enum$DeploymentEnvironment fromJson$Enum$DeploymentEnvironment(String value) {
  switch (value) {
    case r'production':
      return Enum$DeploymentEnvironment.production;
    case r'preview':
      return Enum$DeploymentEnvironment.preview;
    default:
      return Enum$DeploymentEnvironment.$unknown;
  }
}

enum Enum$DeploymentState {
  pending,
  working,
  deploying,
  success,
  error,
  cancelled,
  $unknown;

  factory Enum$DeploymentState.fromJson(String value) =>
      fromJson$Enum$DeploymentState(value);

  String toJson() => toJson$Enum$DeploymentState(this);
}

String toJson$Enum$DeploymentState(Enum$DeploymentState e) {
  switch (e) {
    case Enum$DeploymentState.pending:
      return r'pending';
    case Enum$DeploymentState.working:
      return r'working';
    case Enum$DeploymentState.deploying:
      return r'deploying';
    case Enum$DeploymentState.success:
      return r'success';
    case Enum$DeploymentState.error:
      return r'error';
    case Enum$DeploymentState.cancelled:
      return r'cancelled';
    case Enum$DeploymentState.$unknown:
      return r'$unknown';
  }
}

Enum$DeploymentState fromJson$Enum$DeploymentState(String value) {
  switch (value) {
    case r'pending':
      return Enum$DeploymentState.pending;
    case r'working':
      return Enum$DeploymentState.working;
    case r'deploying':
      return Enum$DeploymentState.deploying;
    case r'success':
      return Enum$DeploymentState.success;
    case r'error':
      return Enum$DeploymentState.error;
    case r'cancelled':
      return Enum$DeploymentState.cancelled;
    default:
      return Enum$DeploymentState.$unknown;
  }
}

enum Enum$DeploymentStatus {
  triggered,
  build_api_error,
  github_api_error,
  queue_api_error,
  deployed,
  pending,
  queued,
  working,
  success,
  status_unknown,
  failure,
  internal_error,
  timeout,
  cancelled,
  expired,
  $unknown;

  factory Enum$DeploymentStatus.fromJson(String value) =>
      fromJson$Enum$DeploymentStatus(value);

  String toJson() => toJson$Enum$DeploymentStatus(this);
}

String toJson$Enum$DeploymentStatus(Enum$DeploymentStatus e) {
  switch (e) {
    case Enum$DeploymentStatus.triggered:
      return r'triggered';
    case Enum$DeploymentStatus.build_api_error:
      return r'build_api_error';
    case Enum$DeploymentStatus.github_api_error:
      return r'github_api_error';
    case Enum$DeploymentStatus.queue_api_error:
      return r'queue_api_error';
    case Enum$DeploymentStatus.deployed:
      return r'deployed';
    case Enum$DeploymentStatus.pending:
      return r'pending';
    case Enum$DeploymentStatus.queued:
      return r'queued';
    case Enum$DeploymentStatus.working:
      return r'working';
    case Enum$DeploymentStatus.success:
      return r'success';
    case Enum$DeploymentStatus.status_unknown:
      return r'status_unknown';
    case Enum$DeploymentStatus.failure:
      return r'failure';
    case Enum$DeploymentStatus.internal_error:
      return r'internal_error';
    case Enum$DeploymentStatus.timeout:
      return r'timeout';
    case Enum$DeploymentStatus.cancelled:
      return r'cancelled';
    case Enum$DeploymentStatus.expired:
      return r'expired';
    case Enum$DeploymentStatus.$unknown:
      return r'$unknown';
  }
}

Enum$DeploymentStatus fromJson$Enum$DeploymentStatus(String value) {
  switch (value) {
    case r'triggered':
      return Enum$DeploymentStatus.triggered;
    case r'build_api_error':
      return Enum$DeploymentStatus.build_api_error;
    case r'github_api_error':
      return Enum$DeploymentStatus.github_api_error;
    case r'queue_api_error':
      return Enum$DeploymentStatus.queue_api_error;
    case r'deployed':
      return Enum$DeploymentStatus.deployed;
    case r'pending':
      return Enum$DeploymentStatus.pending;
    case r'queued':
      return Enum$DeploymentStatus.queued;
    case r'working':
      return Enum$DeploymentStatus.working;
    case r'success':
      return Enum$DeploymentStatus.success;
    case r'status_unknown':
      return Enum$DeploymentStatus.status_unknown;
    case r'failure':
      return Enum$DeploymentStatus.failure;
    case r'internal_error':
      return Enum$DeploymentStatus.internal_error;
    case r'timeout':
      return Enum$DeploymentStatus.timeout;
    case r'cancelled':
      return Enum$DeploymentStatus.cancelled;
    case r'expired':
      return Enum$DeploymentStatus.expired;
    default:
      return Enum$DeploymentStatus.$unknown;
  }
}

enum Enum$EntityType {
  Organization,
  Deployment,
  Project,
  UserId,
  BuildId,
  $unknown;

  factory Enum$EntityType.fromJson(String value) =>
      fromJson$Enum$EntityType(value);

  String toJson() => toJson$Enum$EntityType(this);
}

String toJson$Enum$EntityType(Enum$EntityType e) {
  switch (e) {
    case Enum$EntityType.Organization:
      return r'Organization';
    case Enum$EntityType.Deployment:
      return r'Deployment';
    case Enum$EntityType.Project:
      return r'Project';
    case Enum$EntityType.UserId:
      return r'UserId';
    case Enum$EntityType.BuildId:
      return r'BuildId';
    case Enum$EntityType.$unknown:
      return r'$unknown';
  }
}

Enum$EntityType fromJson$Enum$EntityType(String value) {
  switch (value) {
    case r'Organization':
      return Enum$EntityType.Organization;
    case r'Deployment':
      return Enum$EntityType.Deployment;
    case r'Project':
      return Enum$EntityType.Project;
    case r'UserId':
      return Enum$EntityType.UserId;
    case r'BuildId':
      return Enum$EntityType.BuildId;
    default:
      return Enum$EntityType.$unknown;
  }
}

enum Enum$FrameworkPreset {
  dart_frog,
  flutter,
  serverpod,
  $unknown;

  factory Enum$FrameworkPreset.fromJson(String value) =>
      fromJson$Enum$FrameworkPreset(value);

  String toJson() => toJson$Enum$FrameworkPreset(this);
}

String toJson$Enum$FrameworkPreset(Enum$FrameworkPreset e) {
  switch (e) {
    case Enum$FrameworkPreset.dart_frog:
      return r'dart_frog';
    case Enum$FrameworkPreset.flutter:
      return r'flutter';
    case Enum$FrameworkPreset.serverpod:
      return r'serverpod';
    case Enum$FrameworkPreset.$unknown:
      return r'$unknown';
  }
}

Enum$FrameworkPreset fromJson$Enum$FrameworkPreset(String value) {
  switch (value) {
    case r'dart_frog':
      return Enum$FrameworkPreset.dart_frog;
    case r'flutter':
      return Enum$FrameworkPreset.flutter;
    case r'serverpod':
      return Enum$FrameworkPreset.serverpod;
    default:
      return Enum$FrameworkPreset.$unknown;
  }
}

enum Enum$GlobeApiErrorCode {
  INTERNAL_SERVER_ERROR,
  UNAUTHORIZED,
  FORBIDDEN,
  NOT_FOUND,
  BAD_REQUEST,
  $unknown;

  factory Enum$GlobeApiErrorCode.fromJson(String value) =>
      fromJson$Enum$GlobeApiErrorCode(value);

  String toJson() => toJson$Enum$GlobeApiErrorCode(this);
}

String toJson$Enum$GlobeApiErrorCode(Enum$GlobeApiErrorCode e) {
  switch (e) {
    case Enum$GlobeApiErrorCode.INTERNAL_SERVER_ERROR:
      return r'INTERNAL_SERVER_ERROR';
    case Enum$GlobeApiErrorCode.UNAUTHORIZED:
      return r'UNAUTHORIZED';
    case Enum$GlobeApiErrorCode.FORBIDDEN:
      return r'FORBIDDEN';
    case Enum$GlobeApiErrorCode.NOT_FOUND:
      return r'NOT_FOUND';
    case Enum$GlobeApiErrorCode.BAD_REQUEST:
      return r'BAD_REQUEST';
    case Enum$GlobeApiErrorCode.$unknown:
      return r'$unknown';
  }
}

Enum$GlobeApiErrorCode fromJson$Enum$GlobeApiErrorCode(String value) {
  switch (value) {
    case r'INTERNAL_SERVER_ERROR':
      return Enum$GlobeApiErrorCode.INTERNAL_SERVER_ERROR;
    case r'UNAUTHORIZED':
      return Enum$GlobeApiErrorCode.UNAUTHORIZED;
    case r'FORBIDDEN':
      return Enum$GlobeApiErrorCode.FORBIDDEN;
    case r'NOT_FOUND':
      return Enum$GlobeApiErrorCode.NOT_FOUND;
    case r'BAD_REQUEST':
      return Enum$GlobeApiErrorCode.BAD_REQUEST;
    default:
      return Enum$GlobeApiErrorCode.$unknown;
  }
}

enum Enum$Interval {
  Day,
  Week,
  Month,
  $unknown;

  factory Enum$Interval.fromJson(String value) => fromJson$Enum$Interval(value);

  String toJson() => toJson$Enum$Interval(this);
}

String toJson$Enum$Interval(Enum$Interval e) {
  switch (e) {
    case Enum$Interval.Day:
      return r'Day';
    case Enum$Interval.Week:
      return r'Week';
    case Enum$Interval.Month:
      return r'Month';
    case Enum$Interval.$unknown:
      return r'$unknown';
  }
}

Enum$Interval fromJson$Enum$Interval(String value) {
  switch (value) {
    case r'Day':
      return Enum$Interval.Day;
    case r'Week':
      return Enum$Interval.Week;
    case r'Month':
      return Enum$Interval.Month;
    default:
      return Enum$Interval.$unknown;
  }
}

enum Enum$OrganizationType {
  personal,
  organization,
  $unknown;

  factory Enum$OrganizationType.fromJson(String value) =>
      fromJson$Enum$OrganizationType(value);

  String toJson() => toJson$Enum$OrganizationType(this);
}

String toJson$Enum$OrganizationType(Enum$OrganizationType e) {
  switch (e) {
    case Enum$OrganizationType.personal:
      return r'personal';
    case Enum$OrganizationType.organization:
      return r'organization';
    case Enum$OrganizationType.$unknown:
      return r'$unknown';
  }
}

Enum$OrganizationType fromJson$Enum$OrganizationType(String value) {
  switch (value) {
    case r'personal':
      return Enum$OrganizationType.personal;
    case r'organization':
      return Enum$OrganizationType.organization;
    default:
      return Enum$OrganizationType.$unknown;
  }
}

enum Enum$ProjectStatus {
  active,
  paused,
  marked_for_deletion,
  deletion_in_progress,
  $unknown;

  factory Enum$ProjectStatus.fromJson(String value) =>
      fromJson$Enum$ProjectStatus(value);

  String toJson() => toJson$Enum$ProjectStatus(this);
}

String toJson$Enum$ProjectStatus(Enum$ProjectStatus e) {
  switch (e) {
    case Enum$ProjectStatus.active:
      return r'active';
    case Enum$ProjectStatus.paused:
      return r'paused';
    case Enum$ProjectStatus.marked_for_deletion:
      return r'marked_for_deletion';
    case Enum$ProjectStatus.deletion_in_progress:
      return r'deletion_in_progress';
    case Enum$ProjectStatus.$unknown:
      return r'$unknown';
  }
}

Enum$ProjectStatus fromJson$Enum$ProjectStatus(String value) {
  switch (value) {
    case r'active':
      return Enum$ProjectStatus.active;
    case r'paused':
      return Enum$ProjectStatus.paused;
    case r'marked_for_deletion':
      return Enum$ProjectStatus.marked_for_deletion;
    case r'deletion_in_progress':
      return Enum$ProjectStatus.deletion_in_progress;
    default:
      return Enum$ProjectStatus.$unknown;
  }
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{
  'OrganizationOperations': {'AdminMutation'},
  'DeploymentSource': {
    'CliDeploymentSource',
    'RedeployDeploymentSource',
    'GitHubDeploymentSource',
  },
  'Entity': {
    'Project',
    'Organization',
    'Deployment',
    'GlobeUser',
  },
  'User': {
    'GlobeUser',
    'Me',
    'OrganizationMember',
  },
  'IToken': {
    'Token',
    'TokenWithValue',
  },
};
