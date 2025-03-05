// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package
import 'dart:async';
import 'dart:core';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Variables$Query$Projects {
  factory Variables$Query$Projects({required String organizationId}) =>
      Variables$Query$Projects._({
        r'organizationId': organizationId,
      });

  Variables$Query$Projects._(this._$data);

  factory Variables$Query$Projects.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$organizationId = data['organizationId'];
    result$data['organizationId'] = (l$organizationId as String);
    return Variables$Query$Projects._(result$data);
  }

  Map<String, dynamic> _$data;

  String get organizationId => (_$data['organizationId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$organizationId = organizationId;
    result$data['organizationId'] = l$organizationId;
    return result$data;
  }

  CopyWith$Variables$Query$Projects<Variables$Query$Projects> get copyWith =>
      CopyWith$Variables$Query$Projects(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$Projects ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$organizationId = organizationId;
    final lOther$organizationId = other.organizationId;
    if (l$organizationId != lOther$organizationId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$organizationId = organizationId;
    return Object.hashAll([l$organizationId]);
  }
}

abstract class CopyWith$Variables$Query$Projects<TRes> {
  factory CopyWith$Variables$Query$Projects(
    Variables$Query$Projects instance,
    TRes Function(Variables$Query$Projects) then,
  ) = _CopyWithImpl$Variables$Query$Projects;

  factory CopyWith$Variables$Query$Projects.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Projects;

  TRes call({String? organizationId});
}

class _CopyWithImpl$Variables$Query$Projects<TRes>
    implements CopyWith$Variables$Query$Projects<TRes> {
  _CopyWithImpl$Variables$Query$Projects(
    this._instance,
    this._then,
  );

  final Variables$Query$Projects _instance;

  final TRes Function(Variables$Query$Projects) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? organizationId = _undefined}) =>
      _then(Variables$Query$Projects._({
        ..._instance._$data,
        if (organizationId != _undefined && organizationId != null)
          'organizationId': (organizationId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$Projects<TRes>
    implements CopyWith$Variables$Query$Projects<TRes> {
  _CopyWithStubImpl$Variables$Query$Projects(this._res);

  TRes _res;

  call({String? organizationId}) => _res;
}

class Query$Projects {
  Query$Projects({
    this.projects,
    this.$__typename = 'Query',
  });

  factory Query$Projects.fromJson(Map<String, dynamic> json) {
    final l$projects = json['projects'];
    final l$$__typename = json['__typename'];
    return Query$Projects(
      projects: (l$projects as List<dynamic>?)
          ?.map((e) =>
              Query$Projects$projects.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$Projects$projects>? projects;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$projects = projects;
    _resultData['projects'] = l$projects?.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$projects = projects;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$projects == null ? null : Object.hashAll(l$projects.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Projects || runtimeType != other.runtimeType) {
      return false;
    }
    final l$projects = projects;
    final lOther$projects = other.projects;
    if (l$projects != null && lOther$projects != null) {
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
    } else if (l$projects != lOther$projects) {
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

extension UtilityExtension$Query$Projects on Query$Projects {
  CopyWith$Query$Projects<Query$Projects> get copyWith =>
      CopyWith$Query$Projects(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Projects<TRes> {
  factory CopyWith$Query$Projects(
    Query$Projects instance,
    TRes Function(Query$Projects) then,
  ) = _CopyWithImpl$Query$Projects;

  factory CopyWith$Query$Projects.stub(TRes res) =
      _CopyWithStubImpl$Query$Projects;

  TRes call({
    List<Query$Projects$projects>? projects,
    String? $__typename,
  });
  TRes projects(
      Iterable<Query$Projects$projects>? Function(
              Iterable<
                  CopyWith$Query$Projects$projects<Query$Projects$projects>>?)
          _fn);
}

class _CopyWithImpl$Query$Projects<TRes>
    implements CopyWith$Query$Projects<TRes> {
  _CopyWithImpl$Query$Projects(
    this._instance,
    this._then,
  );

  final Query$Projects _instance;

  final TRes Function(Query$Projects) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? projects = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Projects(
        projects: projects == _undefined
            ? _instance.projects
            : (projects as List<Query$Projects$projects>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes projects(
          Iterable<Query$Projects$projects>? Function(
                  Iterable<
                      CopyWith$Query$Projects$projects<
                          Query$Projects$projects>>?)
              _fn) =>
      call(
          projects: _fn(
              _instance.projects?.map((e) => CopyWith$Query$Projects$projects(
                    e,
                    (i) => i,
                  )))?.toList());
}

class _CopyWithStubImpl$Query$Projects<TRes>
    implements CopyWith$Query$Projects<TRes> {
  _CopyWithStubImpl$Query$Projects(this._res);

  TRes _res;

  call({
    List<Query$Projects$projects>? projects,
    String? $__typename,
  }) =>
      _res;

  projects(_fn) => _res;
}

const documentNodeQueryProjects = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Projects'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'organizationId')),
        type: NamedTypeNode(
          name: NameNode(value: 'ID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'projects'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'organizationId'),
            value: VariableNode(name: NameNode(value: 'organizationId')),
          )
        ],
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
            name: NameNode(value: 'organizationId'),
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
Query$Projects _parserFn$Query$Projects(Map<String, dynamic> data) =>
    Query$Projects.fromJson(data);
typedef OnQueryComplete$Query$Projects = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$Projects?,
);

class Options$Query$Projects extends graphql.QueryOptions<Query$Projects> {
  Options$Query$Projects({
    String? operationName,
    required Variables$Query$Projects variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Projects? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$Projects? onComplete,
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
                    data == null ? null : _parserFn$Query$Projects(data),
                  ),
          onError: onError,
          document: documentNodeQueryProjects,
          parserFn: _parserFn$Query$Projects,
        );

  final OnQueryComplete$Query$Projects? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$Projects
    extends graphql.WatchQueryOptions<Query$Projects> {
  WatchOptions$Query$Projects({
    String? operationName,
    required Variables$Query$Projects variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Projects? typedOptimisticResult,
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
          document: documentNodeQueryProjects,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$Projects,
        );
}

class FetchMoreOptions$Query$Projects extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$Projects({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$Projects variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryProjects,
        );
}

extension ClientExtension$Query$Projects on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$Projects>> query$Projects(
          Options$Query$Projects options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$Projects> watchQuery$Projects(
          WatchOptions$Query$Projects options) =>
      this.watchQuery(options);
  void writeQuery$Projects({
    required Query$Projects data,
    required Variables$Query$Projects variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryProjects),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$Projects? readQuery$Projects({
    required Variables$Query$Projects variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryProjects),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$Projects.fromJson(result);
  }
}

class Query$Projects$projects {
  Query$Projects$projects({
    required this.id,
    required this.name,
    required this.slug,
    required this.organizationId,
    required this.createdAt,
    this.$__typename = 'Project',
  });

  factory Query$Projects$projects.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$slug = json['slug'];
    final l$organizationId = json['organizationId'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return Query$Projects$projects(
      id: (l$id as String),
      name: (l$name as String),
      slug: (l$slug as String),
      organizationId: (l$organizationId as String),
      createdAt: DateTime.parse(l$createdAt),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String slug;

  final String organizationId;

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
    final l$organizationId = organizationId;
    _resultData['organizationId'] = l$organizationId;
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
    final l$organizationId = organizationId;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$slug,
      l$organizationId,
      l$createdAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Projects$projects || runtimeType != other.runtimeType) {
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
    final l$organizationId = organizationId;
    final lOther$organizationId = other.organizationId;
    if (l$organizationId != lOther$organizationId) {
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

extension UtilityExtension$Query$Projects$projects on Query$Projects$projects {
  CopyWith$Query$Projects$projects<Query$Projects$projects> get copyWith =>
      CopyWith$Query$Projects$projects(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Projects$projects<TRes> {
  factory CopyWith$Query$Projects$projects(
    Query$Projects$projects instance,
    TRes Function(Query$Projects$projects) then,
  ) = _CopyWithImpl$Query$Projects$projects;

  factory CopyWith$Query$Projects$projects.stub(TRes res) =
      _CopyWithStubImpl$Query$Projects$projects;

  TRes call({
    String? id,
    String? name,
    String? slug,
    String? organizationId,
    DateTime? createdAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Projects$projects<TRes>
    implements CopyWith$Query$Projects$projects<TRes> {
  _CopyWithImpl$Query$Projects$projects(
    this._instance,
    this._then,
  );

  final Query$Projects$projects _instance;

  final TRes Function(Query$Projects$projects) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? slug = _undefined,
    Object? organizationId = _undefined,
    Object? createdAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Projects$projects(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        slug: slug == _undefined || slug == null
            ? _instance.slug
            : (slug as String),
        organizationId: organizationId == _undefined || organizationId == null
            ? _instance.organizationId
            : (organizationId as String),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as DateTime),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Projects$projects<TRes>
    implements CopyWith$Query$Projects$projects<TRes> {
  _CopyWithStubImpl$Query$Projects$projects(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? slug,
    String? organizationId,
    DateTime? createdAt,
    String? $__typename,
  }) =>
      _res;
}
