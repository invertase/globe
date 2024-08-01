// ignore_for_file: type=lint
import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Variables$Mutation$CreateToken {
  factory Variables$Mutation$CreateToken({
    required String orgSlug,
    required String name,
    required String expiresAt,
    required List<String> projects,
  }) =>
      Variables$Mutation$CreateToken._({
        r'orgSlug': orgSlug,
        r'name': name,
        r'expiresAt': expiresAt,
        r'projects': projects,
      });

  Variables$Mutation$CreateToken._(this._$data);

  factory Variables$Mutation$CreateToken.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orgSlug = data['orgSlug'];
    result$data['orgSlug'] = (l$orgSlug as String);
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$expiresAt = data['expiresAt'];
    result$data['expiresAt'] = (l$expiresAt as String);
    final l$projects = data['projects'];
    result$data['projects'] =
        (l$projects as List<dynamic>).map((e) => (e as String)).toList();
    return Variables$Mutation$CreateToken._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orgSlug => (_$data['orgSlug'] as String);

  String get name => (_$data['name'] as String);

  String get expiresAt => (_$data['expiresAt'] as String);

  List<String> get projects => (_$data['projects'] as List<String>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orgSlug = orgSlug;
    result$data['orgSlug'] = l$orgSlug;
    final l$name = name;
    result$data['name'] = l$name;
    final l$expiresAt = expiresAt;
    result$data['expiresAt'] = l$expiresAt;
    final l$projects = projects;
    result$data['projects'] = l$projects.map((e) => e).toList();
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateToken<Variables$Mutation$CreateToken>
      get copyWith => CopyWith$Variables$Mutation$CreateToken(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateToken) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$orgSlug = orgSlug;
    final lOther$orgSlug = other.orgSlug;
    if (l$orgSlug != lOther$orgSlug) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$expiresAt = expiresAt;
    final lOther$expiresAt = other.expiresAt;
    if (l$expiresAt != lOther$expiresAt) {
      return false;
    }
    final l$projects = projects;
    final lOther$projects = other.projects;
    if (l$projects.length != lOther$projects.length) {
      return false;
    }
    for (int i = 0; i < l$projects.length; i++) {
      final l$projects$entry = l$projects[i];
      final lOther$projects$entry = lOther$projects[i];
      if (l$projects$entry != lOther$projects$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$orgSlug = orgSlug;
    final l$name = name;
    final l$expiresAt = expiresAt;
    final l$projects = projects;
    return Object.hashAll([
      l$orgSlug,
      l$name,
      l$expiresAt,
      Object.hashAll(l$projects.map((v) => v)),
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateToken<TRes> {
  factory CopyWith$Variables$Mutation$CreateToken(
    Variables$Mutation$CreateToken instance,
    TRes Function(Variables$Mutation$CreateToken) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateToken;

  factory CopyWith$Variables$Mutation$CreateToken.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateToken;

  TRes call({
    String? orgSlug,
    String? name,
    String? expiresAt,
    List<String>? projects,
  });
}

class _CopyWithImpl$Variables$Mutation$CreateToken<TRes>
    implements CopyWith$Variables$Mutation$CreateToken<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateToken(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateToken _instance;

  final TRes Function(Variables$Mutation$CreateToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? orgSlug = _undefined,
    Object? name = _undefined,
    Object? expiresAt = _undefined,
    Object? projects = _undefined,
  }) =>
      _then(Variables$Mutation$CreateToken._({
        ..._instance._$data,
        if (orgSlug != _undefined && orgSlug != null)
          'orgSlug': (orgSlug as String),
        if (name != _undefined && name != null) 'name': (name as String),
        if (expiresAt != _undefined && expiresAt != null)
          'expiresAt': (expiresAt as String),
        if (projects != _undefined && projects != null)
          'projects': (projects as List<String>),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateToken<TRes>
    implements CopyWith$Variables$Mutation$CreateToken<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateToken(this._res);

  TRes _res;

  call({
    String? orgSlug,
    String? name,
    String? expiresAt,
    List<String>? projects,
  }) =>
      _res;
}

class Mutation$CreateToken {
  Mutation$CreateToken({
    required this.createToken,
    this.$__typename = 'Mutation',
  });

  factory Mutation$CreateToken.fromJson(Map<String, dynamic> json) {
    final l$createToken = json['createToken'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateToken(
      createToken: Mutation$CreateToken$createToken.fromJson(
          (l$createToken as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateToken$createToken createToken;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createToken = createToken;
    _resultData['createToken'] = l$createToken.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createToken = createToken;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createToken,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateToken) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createToken = createToken;
    final lOther$createToken = other.createToken;
    if (l$createToken != lOther$createToken) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$CreateToken on Mutation$CreateToken {
  CopyWith$Mutation$CreateToken<Mutation$CreateToken> get copyWith =>
      CopyWith$Mutation$CreateToken(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreateToken<TRes> {
  factory CopyWith$Mutation$CreateToken(
    Mutation$CreateToken instance,
    TRes Function(Mutation$CreateToken) then,
  ) = _CopyWithImpl$Mutation$CreateToken;

  factory CopyWith$Mutation$CreateToken.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateToken;

  TRes call({
    Mutation$CreateToken$createToken? createToken,
    String? $__typename,
  });
  CopyWith$Mutation$CreateToken$createToken<TRes> get createToken;
}

class _CopyWithImpl$Mutation$CreateToken<TRes>
    implements CopyWith$Mutation$CreateToken<TRes> {
  _CopyWithImpl$Mutation$CreateToken(
    this._instance,
    this._then,
  );

  final Mutation$CreateToken _instance;

  final TRes Function(Mutation$CreateToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createToken = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateToken(
        createToken: createToken == _undefined || createToken == null
            ? _instance.createToken
            : (createToken as Mutation$CreateToken$createToken),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreateToken$createToken<TRes> get createToken {
    final local$createToken = _instance.createToken;
    return CopyWith$Mutation$CreateToken$createToken(
        local$createToken, (e) => call(createToken: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateToken<TRes>
    implements CopyWith$Mutation$CreateToken<TRes> {
  _CopyWithStubImpl$Mutation$CreateToken(this._res);

  TRes _res;

  call({
    Mutation$CreateToken$createToken? createToken,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreateToken$createToken<TRes> get createToken =>
      CopyWith$Mutation$CreateToken$createToken.stub(_res);
}

const documentNodeMutationCreateToken = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateToken'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orgSlug')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'name')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'expiresAt')),
        type: NamedTypeNode(
          name: NameNode(value: 'DateTime'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'projects')),
        type: ListTypeNode(
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: true,
          ),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createToken'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'orgSlug'),
            value: VariableNode(name: NameNode(value: 'orgSlug')),
          ),
          ArgumentNode(
            name: NameNode(value: 'name'),
            value: VariableNode(name: NameNode(value: 'name')),
          ),
          ArgumentNode(
            name: NameNode(value: 'expiresAt'),
            value: VariableNode(name: NameNode(value: 'expiresAt')),
          ),
          ArgumentNode(
            name: NameNode(value: 'projects'),
            value: VariableNode(name: NameNode(value: 'projects')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'uuid'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'value'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Mutation$CreateToken _parserFn$Mutation$CreateToken(
        Map<String, dynamic> data) =>
    Mutation$CreateToken.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateToken = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreateToken?,
);

class Options$Mutation$CreateToken
    extends graphql.MutationOptions<Mutation$CreateToken> {
  Options$Mutation$CreateToken({
    String? operationName,
    required Variables$Mutation$CreateToken variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateToken? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateToken? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateToken>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$CreateToken(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateToken,
          parserFn: _parserFn$Mutation$CreateToken,
        );

  final OnMutationCompleted$Mutation$CreateToken? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateToken
    extends graphql.WatchQueryOptions<Mutation$CreateToken> {
  WatchOptions$Mutation$CreateToken({
    String? operationName,
    required Variables$Mutation$CreateToken variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateToken? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeMutationCreateToken,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateToken,
        );
}

extension ClientExtension$Mutation$CreateToken on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateToken>> mutate$CreateToken(
          Options$Mutation$CreateToken options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateToken> watchMutation$CreateToken(
          WatchOptions$Mutation$CreateToken options) =>
      this.watchMutation(options);
}

class Mutation$CreateToken$createToken {
  Mutation$CreateToken$createToken({
    required this.uuid,
    required this.value,
    this.$__typename = 'TokenWithValue',
  });

  factory Mutation$CreateToken$createToken.fromJson(Map<String, dynamic> json) {
    final l$uuid = json['uuid'];
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateToken$createToken(
      uuid: (l$uuid as String),
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String uuid;

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$uuid = uuid;
    _resultData['uuid'] = l$uuid;
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$uuid = uuid;
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$uuid,
      l$value,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateToken$createToken) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$uuid = uuid;
    final lOther$uuid = other.uuid;
    if (l$uuid != lOther$uuid) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$CreateToken$createToken
    on Mutation$CreateToken$createToken {
  CopyWith$Mutation$CreateToken$createToken<Mutation$CreateToken$createToken>
      get copyWith => CopyWith$Mutation$CreateToken$createToken(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateToken$createToken<TRes> {
  factory CopyWith$Mutation$CreateToken$createToken(
    Mutation$CreateToken$createToken instance,
    TRes Function(Mutation$CreateToken$createToken) then,
  ) = _CopyWithImpl$Mutation$CreateToken$createToken;

  factory CopyWith$Mutation$CreateToken$createToken.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateToken$createToken;

  TRes call({
    String? uuid,
    String? value,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreateToken$createToken<TRes>
    implements CopyWith$Mutation$CreateToken$createToken<TRes> {
  _CopyWithImpl$Mutation$CreateToken$createToken(
    this._instance,
    this._then,
  );

  final Mutation$CreateToken$createToken _instance;

  final TRes Function(Mutation$CreateToken$createToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? uuid = _undefined,
    Object? value = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateToken$createToken(
        uuid: uuid == _undefined || uuid == null
            ? _instance.uuid
            : (uuid as String),
        value: value == _undefined || value == null
            ? _instance.value
            : (value as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$CreateToken$createToken<TRes>
    implements CopyWith$Mutation$CreateToken$createToken<TRes> {
  _CopyWithStubImpl$Mutation$CreateToken$createToken(this._res);

  TRes _res;

  call({
    String? uuid,
    String? value,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$DeleteToken {
  factory Variables$Mutation$DeleteToken({
    required String orgSlug,
    required String tokenUuid,
  }) =>
      Variables$Mutation$DeleteToken._({
        r'orgSlug': orgSlug,
        r'tokenUuid': tokenUuid,
      });

  Variables$Mutation$DeleteToken._(this._$data);

  factory Variables$Mutation$DeleteToken.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orgSlug = data['orgSlug'];
    result$data['orgSlug'] = (l$orgSlug as String);
    final l$tokenUuid = data['tokenUuid'];
    result$data['tokenUuid'] = (l$tokenUuid as String);
    return Variables$Mutation$DeleteToken._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orgSlug => (_$data['orgSlug'] as String);

  String get tokenUuid => (_$data['tokenUuid'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orgSlug = orgSlug;
    result$data['orgSlug'] = l$orgSlug;
    final l$tokenUuid = tokenUuid;
    result$data['tokenUuid'] = l$tokenUuid;
    return result$data;
  }

  CopyWith$Variables$Mutation$DeleteToken<Variables$Mutation$DeleteToken>
      get copyWith => CopyWith$Variables$Mutation$DeleteToken(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$DeleteToken) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$orgSlug = orgSlug;
    final lOther$orgSlug = other.orgSlug;
    if (l$orgSlug != lOther$orgSlug) {
      return false;
    }
    final l$tokenUuid = tokenUuid;
    final lOther$tokenUuid = other.tokenUuid;
    if (l$tokenUuid != lOther$tokenUuid) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$orgSlug = orgSlug;
    final l$tokenUuid = tokenUuid;
    return Object.hashAll([
      l$orgSlug,
      l$tokenUuid,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$DeleteToken<TRes> {
  factory CopyWith$Variables$Mutation$DeleteToken(
    Variables$Mutation$DeleteToken instance,
    TRes Function(Variables$Mutation$DeleteToken) then,
  ) = _CopyWithImpl$Variables$Mutation$DeleteToken;

  factory CopyWith$Variables$Mutation$DeleteToken.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DeleteToken;

  TRes call({
    String? orgSlug,
    String? tokenUuid,
  });
}

class _CopyWithImpl$Variables$Mutation$DeleteToken<TRes>
    implements CopyWith$Variables$Mutation$DeleteToken<TRes> {
  _CopyWithImpl$Variables$Mutation$DeleteToken(
    this._instance,
    this._then,
  );

  final Variables$Mutation$DeleteToken _instance;

  final TRes Function(Variables$Mutation$DeleteToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? orgSlug = _undefined,
    Object? tokenUuid = _undefined,
  }) =>
      _then(Variables$Mutation$DeleteToken._({
        ..._instance._$data,
        if (orgSlug != _undefined && orgSlug != null)
          'orgSlug': (orgSlug as String),
        if (tokenUuid != _undefined && tokenUuid != null)
          'tokenUuid': (tokenUuid as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$DeleteToken<TRes>
    implements CopyWith$Variables$Mutation$DeleteToken<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DeleteToken(this._res);

  TRes _res;

  call({
    String? orgSlug,
    String? tokenUuid,
  }) =>
      _res;
}

class Mutation$DeleteToken {
  Mutation$DeleteToken({
    required this.deleteToken,
    this.$__typename = 'Mutation',
  });

  factory Mutation$DeleteToken.fromJson(Map<String, dynamic> json) {
    final l$deleteToken = json['deleteToken'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteToken(
      deleteToken: Mutation$DeleteToken$deleteToken.fromJson(
          (l$deleteToken as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$DeleteToken$deleteToken deleteToken;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteToken = deleteToken;
    _resultData['deleteToken'] = l$deleteToken.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteToken = deleteToken;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$deleteToken,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteToken) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteToken = deleteToken;
    final lOther$deleteToken = other.deleteToken;
    if (l$deleteToken != lOther$deleteToken) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$DeleteToken on Mutation$DeleteToken {
  CopyWith$Mutation$DeleteToken<Mutation$DeleteToken> get copyWith =>
      CopyWith$Mutation$DeleteToken(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$DeleteToken<TRes> {
  factory CopyWith$Mutation$DeleteToken(
    Mutation$DeleteToken instance,
    TRes Function(Mutation$DeleteToken) then,
  ) = _CopyWithImpl$Mutation$DeleteToken;

  factory CopyWith$Mutation$DeleteToken.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteToken;

  TRes call({
    Mutation$DeleteToken$deleteToken? deleteToken,
    String? $__typename,
  });
  CopyWith$Mutation$DeleteToken$deleteToken<TRes> get deleteToken;
}

class _CopyWithImpl$Mutation$DeleteToken<TRes>
    implements CopyWith$Mutation$DeleteToken<TRes> {
  _CopyWithImpl$Mutation$DeleteToken(
    this._instance,
    this._then,
  );

  final Mutation$DeleteToken _instance;

  final TRes Function(Mutation$DeleteToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? deleteToken = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteToken(
        deleteToken: deleteToken == _undefined || deleteToken == null
            ? _instance.deleteToken
            : (deleteToken as Mutation$DeleteToken$deleteToken),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$DeleteToken$deleteToken<TRes> get deleteToken {
    final local$deleteToken = _instance.deleteToken;
    return CopyWith$Mutation$DeleteToken$deleteToken(
        local$deleteToken, (e) => call(deleteToken: e));
  }
}

class _CopyWithStubImpl$Mutation$DeleteToken<TRes>
    implements CopyWith$Mutation$DeleteToken<TRes> {
  _CopyWithStubImpl$Mutation$DeleteToken(this._res);

  TRes _res;

  call({
    Mutation$DeleteToken$deleteToken? deleteToken,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$DeleteToken$deleteToken<TRes> get deleteToken =>
      CopyWith$Mutation$DeleteToken$deleteToken.stub(_res);
}

const documentNodeMutationDeleteToken = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'DeleteToken'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orgSlug')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'tokenUuid')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'deleteToken'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'uuid'),
            value: VariableNode(name: NameNode(value: 'tokenUuid')),
          ),
          ArgumentNode(
            name: NameNode(value: 'orgSlug'),
            value: VariableNode(name: NameNode(value: 'orgSlug')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Mutation$DeleteToken _parserFn$Mutation$DeleteToken(
        Map<String, dynamic> data) =>
    Mutation$DeleteToken.fromJson(data);
typedef OnMutationCompleted$Mutation$DeleteToken = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$DeleteToken?,
);

class Options$Mutation$DeleteToken
    extends graphql.MutationOptions<Mutation$DeleteToken> {
  Options$Mutation$DeleteToken({
    String? operationName,
    required Variables$Mutation$DeleteToken variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteToken? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$DeleteToken? onCompleted,
    graphql.OnMutationUpdate<Mutation$DeleteToken>? update,
    graphql.OnError? onError,
  })  : onCompletedWithParsed = onCompleted,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          onCompleted: onCompleted == null
              ? null
              : (data) => onCompleted(
                    data,
                    data == null ? null : _parserFn$Mutation$DeleteToken(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationDeleteToken,
          parserFn: _parserFn$Mutation$DeleteToken,
        );

  final OnMutationCompleted$Mutation$DeleteToken? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$DeleteToken
    extends graphql.WatchQueryOptions<Mutation$DeleteToken> {
  WatchOptions$Mutation$DeleteToken({
    String? operationName,
    required Variables$Mutation$DeleteToken variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$DeleteToken? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeMutationDeleteToken,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$DeleteToken,
        );
}

extension ClientExtension$Mutation$DeleteToken on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$DeleteToken>> mutate$DeleteToken(
          Options$Mutation$DeleteToken options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$DeleteToken> watchMutation$DeleteToken(
          WatchOptions$Mutation$DeleteToken options) =>
      this.watchMutation(options);
}

class Mutation$DeleteToken$deleteToken {
  Mutation$DeleteToken$deleteToken({
    required this.message,
    this.$__typename = 'SuccessResponse',
  });

  factory Mutation$DeleteToken$deleteToken.fromJson(Map<String, dynamic> json) {
    final l$message = json['message'];
    final l$$__typename = json['__typename'];
    return Mutation$DeleteToken$deleteToken(
      message: (l$message as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String message;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$message = message;
    _resultData['message'] = l$message;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$message = message;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$message,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DeleteToken$deleteToken) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$DeleteToken$deleteToken
    on Mutation$DeleteToken$deleteToken {
  CopyWith$Mutation$DeleteToken$deleteToken<Mutation$DeleteToken$deleteToken>
      get copyWith => CopyWith$Mutation$DeleteToken$deleteToken(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$DeleteToken$deleteToken<TRes> {
  factory CopyWith$Mutation$DeleteToken$deleteToken(
    Mutation$DeleteToken$deleteToken instance,
    TRes Function(Mutation$DeleteToken$deleteToken) then,
  ) = _CopyWithImpl$Mutation$DeleteToken$deleteToken;

  factory CopyWith$Mutation$DeleteToken$deleteToken.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DeleteToken$deleteToken;

  TRes call({
    String? message,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$DeleteToken$deleteToken<TRes>
    implements CopyWith$Mutation$DeleteToken$deleteToken<TRes> {
  _CopyWithImpl$Mutation$DeleteToken$deleteToken(
    this._instance,
    this._then,
  );

  final Mutation$DeleteToken$deleteToken _instance;

  final TRes Function(Mutation$DeleteToken$deleteToken) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DeleteToken$deleteToken(
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$DeleteToken$deleteToken<TRes>
    implements CopyWith$Mutation$DeleteToken$deleteToken<TRes> {
  _CopyWithStubImpl$Mutation$DeleteToken$deleteToken(this._res);

  TRes _res;

  call({
    String? message,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$ListTokens {
  factory Variables$Query$ListTokens({
    required String orgSlug,
    required List<String> projects,
  }) =>
      Variables$Query$ListTokens._({
        r'orgSlug': orgSlug,
        r'projects': projects,
      });

  Variables$Query$ListTokens._(this._$data);

  factory Variables$Query$ListTokens.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orgSlug = data['orgSlug'];
    result$data['orgSlug'] = (l$orgSlug as String);
    final l$projects = data['projects'];
    result$data['projects'] =
        (l$projects as List<dynamic>).map((e) => (e as String)).toList();
    return Variables$Query$ListTokens._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orgSlug => (_$data['orgSlug'] as String);

  List<String> get projects => (_$data['projects'] as List<String>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orgSlug = orgSlug;
    result$data['orgSlug'] = l$orgSlug;
    final l$projects = projects;
    result$data['projects'] = l$projects.map((e) => e).toList();
    return result$data;
  }

  CopyWith$Variables$Query$ListTokens<Variables$Query$ListTokens>
      get copyWith => CopyWith$Variables$Query$ListTokens(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$ListTokens) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$orgSlug = orgSlug;
    final lOther$orgSlug = other.orgSlug;
    if (l$orgSlug != lOther$orgSlug) {
      return false;
    }
    final l$projects = projects;
    final lOther$projects = other.projects;
    if (l$projects.length != lOther$projects.length) {
      return false;
    }
    for (int i = 0; i < l$projects.length; i++) {
      final l$projects$entry = l$projects[i];
      final lOther$projects$entry = lOther$projects[i];
      if (l$projects$entry != lOther$projects$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$orgSlug = orgSlug;
    final l$projects = projects;
    return Object.hashAll([
      l$orgSlug,
      Object.hashAll(l$projects.map((v) => v)),
    ]);
  }
}

abstract class CopyWith$Variables$Query$ListTokens<TRes> {
  factory CopyWith$Variables$Query$ListTokens(
    Variables$Query$ListTokens instance,
    TRes Function(Variables$Query$ListTokens) then,
  ) = _CopyWithImpl$Variables$Query$ListTokens;

  factory CopyWith$Variables$Query$ListTokens.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$ListTokens;

  TRes call({
    String? orgSlug,
    List<String>? projects,
  });
}

class _CopyWithImpl$Variables$Query$ListTokens<TRes>
    implements CopyWith$Variables$Query$ListTokens<TRes> {
  _CopyWithImpl$Variables$Query$ListTokens(
    this._instance,
    this._then,
  );

  final Variables$Query$ListTokens _instance;

  final TRes Function(Variables$Query$ListTokens) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? orgSlug = _undefined,
    Object? projects = _undefined,
  }) =>
      _then(Variables$Query$ListTokens._({
        ..._instance._$data,
        if (orgSlug != _undefined && orgSlug != null)
          'orgSlug': (orgSlug as String),
        if (projects != _undefined && projects != null)
          'projects': (projects as List<String>),
      }));
}

class _CopyWithStubImpl$Variables$Query$ListTokens<TRes>
    implements CopyWith$Variables$Query$ListTokens<TRes> {
  _CopyWithStubImpl$Variables$Query$ListTokens(this._res);

  TRes _res;

  call({
    String? orgSlug,
    List<String>? projects,
  }) =>
      _res;
}

class Query$ListTokens {
  Query$ListTokens({
    required this.tokens,
    this.$__typename = 'Query',
  });

  factory Query$ListTokens.fromJson(Map<String, dynamic> json) {
    final l$tokens = json['tokens'];
    final l$$__typename = json['__typename'];
    return Query$ListTokens(
      tokens: (l$tokens as List<dynamic>)
          .map((e) =>
              Query$ListTokens$tokens.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$ListTokens$tokens> tokens;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$tokens = tokens;
    _resultData['tokens'] = l$tokens.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$tokens = tokens;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$tokens.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$ListTokens) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$tokens = tokens;
    final lOther$tokens = other.tokens;
    if (l$tokens.length != lOther$tokens.length) {
      return false;
    }
    for (int i = 0; i < l$tokens.length; i++) {
      final l$tokens$entry = l$tokens[i];
      final lOther$tokens$entry = lOther$tokens[i];
      if (l$tokens$entry != lOther$tokens$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$ListTokens on Query$ListTokens {
  CopyWith$Query$ListTokens<Query$ListTokens> get copyWith =>
      CopyWith$Query$ListTokens(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$ListTokens<TRes> {
  factory CopyWith$Query$ListTokens(
    Query$ListTokens instance,
    TRes Function(Query$ListTokens) then,
  ) = _CopyWithImpl$Query$ListTokens;

  factory CopyWith$Query$ListTokens.stub(TRes res) =
      _CopyWithStubImpl$Query$ListTokens;

  TRes call({
    List<Query$ListTokens$tokens>? tokens,
    String? $__typename,
  });
  TRes tokens(
      Iterable<Query$ListTokens$tokens> Function(
              Iterable<
                  CopyWith$Query$ListTokens$tokens<Query$ListTokens$tokens>>)
          _fn);
}

class _CopyWithImpl$Query$ListTokens<TRes>
    implements CopyWith$Query$ListTokens<TRes> {
  _CopyWithImpl$Query$ListTokens(
    this._instance,
    this._then,
  );

  final Query$ListTokens _instance;

  final TRes Function(Query$ListTokens) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? tokens = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$ListTokens(
        tokens: tokens == _undefined || tokens == null
            ? _instance.tokens
            : (tokens as List<Query$ListTokens$tokens>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes tokens(
          Iterable<Query$ListTokens$tokens> Function(
                  Iterable<
                      CopyWith$Query$ListTokens$tokens<
                          Query$ListTokens$tokens>>)
              _fn) =>
      call(
          tokens:
              _fn(_instance.tokens.map((e) => CopyWith$Query$ListTokens$tokens(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$ListTokens<TRes>
    implements CopyWith$Query$ListTokens<TRes> {
  _CopyWithStubImpl$Query$ListTokens(this._res);

  TRes _res;

  call({
    List<Query$ListTokens$tokens>? tokens,
    String? $__typename,
  }) =>
      _res;

  tokens(_fn) => _res;
}

const documentNodeQueryListTokens = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'ListTokens'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orgSlug')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'projects')),
        type: ListTypeNode(
          type: NamedTypeNode(
            name: NameNode(value: 'String'),
            isNonNull: true,
          ),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'tokens'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'orgSlug'),
            value: VariableNode(name: NameNode(value: 'orgSlug')),
          ),
          ArgumentNode(
            name: NameNode(value: 'projects'),
            value: VariableNode(name: NameNode(value: 'projects')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'uuid'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'expiresAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$ListTokens _parserFn$Query$ListTokens(Map<String, dynamic> data) =>
    Query$ListTokens.fromJson(data);
typedef OnQueryComplete$Query$ListTokens = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$ListTokens?,
);

class Options$Query$ListTokens extends graphql.QueryOptions<Query$ListTokens> {
  Options$Query$ListTokens({
    String? operationName,
    required Variables$Query$ListTokens variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$ListTokens? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$ListTokens? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$ListTokens(data),
                  ),
          onError: onError,
          document: documentNodeQueryListTokens,
          parserFn: _parserFn$Query$ListTokens,
        );

  final OnQueryComplete$Query$ListTokens? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$ListTokens
    extends graphql.WatchQueryOptions<Query$ListTokens> {
  WatchOptions$Query$ListTokens({
    String? operationName,
    required Variables$Query$ListTokens variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$ListTokens? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryListTokens,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$ListTokens,
        );
}

class FetchMoreOptions$Query$ListTokens extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$ListTokens({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$ListTokens variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryListTokens,
        );
}

extension ClientExtension$Query$ListTokens on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$ListTokens>> query$ListTokens(
          Options$Query$ListTokens options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$ListTokens> watchQuery$ListTokens(
          WatchOptions$Query$ListTokens options) =>
      this.watchQuery(options);
  void writeQuery$ListTokens({
    required Query$ListTokens data,
    required Variables$Query$ListTokens variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryListTokens),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$ListTokens? readQuery$ListTokens({
    required Variables$Query$ListTokens variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryListTokens),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$ListTokens.fromJson(result);
  }
}

class Query$ListTokens$tokens {
  Query$ListTokens$tokens({
    required this.uuid,
    required this.name,
    required this.expiresAt,
    this.$__typename = 'Token',
  });

  factory Query$ListTokens$tokens.fromJson(Map<String, dynamic> json) {
    final l$uuid = json['uuid'];
    final l$name = json['name'];
    final l$expiresAt = json['expiresAt'];
    final l$$__typename = json['__typename'];
    return Query$ListTokens$tokens(
      uuid: (l$uuid as String),
      name: (l$name as String),
      expiresAt: (l$expiresAt as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String uuid;

  final String name;

  final String expiresAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$uuid = uuid;
    _resultData['uuid'] = l$uuid;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$expiresAt = expiresAt;
    _resultData['expiresAt'] = l$expiresAt;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$uuid = uuid;
    final l$name = name;
    final l$expiresAt = expiresAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$uuid,
      l$name,
      l$expiresAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$ListTokens$tokens) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$uuid = uuid;
    final lOther$uuid = other.uuid;
    if (l$uuid != lOther$uuid) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$expiresAt = expiresAt;
    final lOther$expiresAt = other.expiresAt;
    if (l$expiresAt != lOther$expiresAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$ListTokens$tokens on Query$ListTokens$tokens {
  CopyWith$Query$ListTokens$tokens<Query$ListTokens$tokens> get copyWith =>
      CopyWith$Query$ListTokens$tokens(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$ListTokens$tokens<TRes> {
  factory CopyWith$Query$ListTokens$tokens(
    Query$ListTokens$tokens instance,
    TRes Function(Query$ListTokens$tokens) then,
  ) = _CopyWithImpl$Query$ListTokens$tokens;

  factory CopyWith$Query$ListTokens$tokens.stub(TRes res) =
      _CopyWithStubImpl$Query$ListTokens$tokens;

  TRes call({
    String? uuid,
    String? name,
    String? expiresAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$ListTokens$tokens<TRes>
    implements CopyWith$Query$ListTokens$tokens<TRes> {
  _CopyWithImpl$Query$ListTokens$tokens(
    this._instance,
    this._then,
  );

  final Query$ListTokens$tokens _instance;

  final TRes Function(Query$ListTokens$tokens) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? uuid = _undefined,
    Object? name = _undefined,
    Object? expiresAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$ListTokens$tokens(
        uuid: uuid == _undefined || uuid == null
            ? _instance.uuid
            : (uuid as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        expiresAt: expiresAt == _undefined || expiresAt == null
            ? _instance.expiresAt
            : (expiresAt as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$ListTokens$tokens<TRes>
    implements CopyWith$Query$ListTokens$tokens<TRes> {
  _CopyWithStubImpl$Query$ListTokens$tokens(this._res);

  TRes _res;

  call({
    String? uuid,
    String? name,
    String? expiresAt,
    String? $__typename,
  }) =>
      _res;
}
