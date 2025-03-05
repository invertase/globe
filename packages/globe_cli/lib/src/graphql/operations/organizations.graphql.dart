// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package
import 'dart:async';
import 'dart:core';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Query$Organizations {
  Query$Organizations({
    this.organizations,
    this.$__typename = 'Query',
  });

  factory Query$Organizations.fromJson(Map<String, dynamic> json) {
    final l$organizations = json['organizations'];
    final l$$__typename = json['__typename'];
    return Query$Organizations(
      organizations: (l$organizations as List<dynamic>?)
          ?.map((e) => Query$Organizations$organizations.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$Organizations$organizations>? organizations;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$organizations = organizations;
    _resultData['organizations'] =
        l$organizations?.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$organizations = organizations;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$organizations == null
          ? null
          : Object.hashAll(l$organizations.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Organizations || runtimeType != other.runtimeType) {
      return false;
    }
    final l$organizations = organizations;
    final lOther$organizations = other.organizations;
    if (l$organizations != null && lOther$organizations != null) {
      if (l$organizations.length != lOther$organizations.length) {
        return false;
      }
      for (int i = 0; i < l$organizations.length; i++) {
        final l$organizations$entry = l$organizations[i];
        final lOther$organizations$entry = lOther$organizations[i];
        if (l$organizations$entry != lOther$organizations$entry) {
          return false;
        }
      }
    } else if (l$organizations != lOther$organizations) {
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

extension UtilityExtension$Query$Organizations on Query$Organizations {
  CopyWith$Query$Organizations<Query$Organizations> get copyWith =>
      CopyWith$Query$Organizations(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Organizations<TRes> {
  factory CopyWith$Query$Organizations(
    Query$Organizations instance,
    TRes Function(Query$Organizations) then,
  ) = _CopyWithImpl$Query$Organizations;

  factory CopyWith$Query$Organizations.stub(TRes res) =
      _CopyWithStubImpl$Query$Organizations;

  TRes call({
    List<Query$Organizations$organizations>? organizations,
    String? $__typename,
  });
  TRes organizations(
      Iterable<Query$Organizations$organizations>? Function(
              Iterable<
                  CopyWith$Query$Organizations$organizations<
                      Query$Organizations$organizations>>?)
          _fn);
}

class _CopyWithImpl$Query$Organizations<TRes>
    implements CopyWith$Query$Organizations<TRes> {
  _CopyWithImpl$Query$Organizations(
    this._instance,
    this._then,
  );

  final Query$Organizations _instance;

  final TRes Function(Query$Organizations) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? organizations = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Organizations(
        organizations: organizations == _undefined
            ? _instance.organizations
            : (organizations as List<Query$Organizations$organizations>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes organizations(
          Iterable<Query$Organizations$organizations>? Function(
                  Iterable<
                      CopyWith$Query$Organizations$organizations<
                          Query$Organizations$organizations>>?)
              _fn) =>
      call(
          organizations: _fn(_instance.organizations
              ?.map((e) => CopyWith$Query$Organizations$organizations(
                    e,
                    (i) => i,
                  )))?.toList());
}

class _CopyWithStubImpl$Query$Organizations<TRes>
    implements CopyWith$Query$Organizations<TRes> {
  _CopyWithStubImpl$Query$Organizations(this._res);

  TRes _res;

  call({
    List<Query$Organizations$organizations>? organizations,
    String? $__typename,
  }) =>
      _res;

  organizations(_fn) => _res;
}

const documentNodeQueryOrganizations = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Organizations'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'organizations'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
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
            name: NameNode(value: 'slug'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'createdAt'),
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
Query$Organizations _parserFn$Query$Organizations(Map<String, dynamic> data) =>
    Query$Organizations.fromJson(data);
typedef OnQueryComplete$Query$Organizations = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$Organizations?,
);

class Options$Query$Organizations
    extends graphql.QueryOptions<Query$Organizations> {
  Options$Query$Organizations({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Organizations? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$Organizations? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
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
                    data == null ? null : _parserFn$Query$Organizations(data),
                  ),
          onError: onError,
          document: documentNodeQueryOrganizations,
          parserFn: _parserFn$Query$Organizations,
        );

  final OnQueryComplete$Query$Organizations? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$Organizations
    extends graphql.WatchQueryOptions<Query$Organizations> {
  WatchOptions$Query$Organizations({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Organizations? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryOrganizations,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$Organizations,
        );
}

class FetchMoreOptions$Query$Organizations extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$Organizations(
      {required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryOrganizations,
        );
}

extension ClientExtension$Query$Organizations on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$Organizations>> query$Organizations(
          [Options$Query$Organizations? options]) async =>
      await this.query(options ?? Options$Query$Organizations());
  graphql.ObservableQuery<Query$Organizations> watchQuery$Organizations(
          [WatchOptions$Query$Organizations? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$Organizations());
  void writeQuery$Organizations({
    required Query$Organizations data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryOrganizations)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$Organizations? readQuery$Organizations({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQueryOrganizations)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$Organizations.fromJson(result);
  }
}

class Query$Organizations$organizations {
  Query$Organizations$organizations({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    this.$__typename = 'Organization',
  });

  factory Query$Organizations$organizations.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$slug = json['slug'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return Query$Organizations$organizations(
      id: (l$id as String),
      name: (l$name as String),
      slug: (l$slug as String),
      createdAt: DateTime.parse(l$createdAt),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String slug;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = toString(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$slug = slug;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$slug,
      l$createdAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Organizations$organizations ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
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

extension UtilityExtension$Query$Organizations$organizations
    on Query$Organizations$organizations {
  CopyWith$Query$Organizations$organizations<Query$Organizations$organizations>
      get copyWith => CopyWith$Query$Organizations$organizations(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Organizations$organizations<TRes> {
  factory CopyWith$Query$Organizations$organizations(
    Query$Organizations$organizations instance,
    TRes Function(Query$Organizations$organizations) then,
  ) = _CopyWithImpl$Query$Organizations$organizations;

  factory CopyWith$Query$Organizations$organizations.stub(TRes res) =
      _CopyWithStubImpl$Query$Organizations$organizations;

  TRes call({
    String? id,
    String? name,
    String? slug,
    DateTime? createdAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Organizations$organizations<TRes>
    implements CopyWith$Query$Organizations$organizations<TRes> {
  _CopyWithImpl$Query$Organizations$organizations(
    this._instance,
    this._then,
  );

  final Query$Organizations$organizations _instance;

  final TRes Function(Query$Organizations$organizations) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? slug = _undefined,
    Object? createdAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Organizations$organizations(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        slug: slug == _undefined || slug == null
            ? _instance.slug
            : (slug as String),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as DateTime),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Organizations$organizations<TRes>
    implements CopyWith$Query$Organizations$organizations<TRes> {
  _CopyWithStubImpl$Query$Organizations$organizations(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? slug,
    DateTime? createdAt,
    String? $__typename,
  }) =>
      _res;
}
