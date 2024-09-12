// ignore_for_file: type=lint
import '../../graphql/project.graphql.dart';
import 'dart:async';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Variables$Mutation$Pause {
  factory Variables$Mutation$Pause({
    required String orgSlug,
    required String projectId,
  }) =>
      Variables$Mutation$Pause._({
        r'orgSlug': orgSlug,
        r'projectId': projectId,
      });

  Variables$Mutation$Pause._(this._$data);

  factory Variables$Mutation$Pause.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orgSlug = data['orgSlug'];
    result$data['orgSlug'] = (l$orgSlug as String);
    final l$projectId = data['projectId'];
    result$data['projectId'] = (l$projectId as String);
    return Variables$Mutation$Pause._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orgSlug => (_$data['orgSlug'] as String);

  String get projectId => (_$data['projectId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orgSlug = orgSlug;
    result$data['orgSlug'] = l$orgSlug;
    final l$projectId = projectId;
    result$data['projectId'] = l$projectId;
    return result$data;
  }

  CopyWith$Variables$Mutation$Pause<Variables$Mutation$Pause> get copyWith =>
      CopyWith$Variables$Mutation$Pause(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$Pause) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$orgSlug = orgSlug;
    final lOther$orgSlug = other.orgSlug;
    if (l$orgSlug != lOther$orgSlug) {
      return false;
    }
    final l$projectId = projectId;
    final lOther$projectId = other.projectId;
    if (l$projectId != lOther$projectId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$orgSlug = orgSlug;
    final l$projectId = projectId;
    return Object.hashAll([
      l$orgSlug,
      l$projectId,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$Pause<TRes> {
  factory CopyWith$Variables$Mutation$Pause(
    Variables$Mutation$Pause instance,
    TRes Function(Variables$Mutation$Pause) then,
  ) = _CopyWithImpl$Variables$Mutation$Pause;

  factory CopyWith$Variables$Mutation$Pause.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$Pause;

  TRes call({
    String? orgSlug,
    String? projectId,
  });
}

class _CopyWithImpl$Variables$Mutation$Pause<TRes>
    implements CopyWith$Variables$Mutation$Pause<TRes> {
  _CopyWithImpl$Variables$Mutation$Pause(
    this._instance,
    this._then,
  );

  final Variables$Mutation$Pause _instance;

  final TRes Function(Variables$Mutation$Pause) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? orgSlug = _undefined,
    Object? projectId = _undefined,
  }) =>
      _then(Variables$Mutation$Pause._({
        ..._instance._$data,
        if (orgSlug != _undefined && orgSlug != null)
          'orgSlug': (orgSlug as String),
        if (projectId != _undefined && projectId != null)
          'projectId': (projectId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$Pause<TRes>
    implements CopyWith$Variables$Mutation$Pause<TRes> {
  _CopyWithStubImpl$Variables$Mutation$Pause(this._res);

  TRes _res;

  call({
    String? orgSlug,
    String? projectId,
  }) =>
      _res;
}

class Mutation$Pause {
  Mutation$Pause({
    required this.pauseProject,
    this.$__typename = 'Mutation',
  });

  factory Mutation$Pause.fromJson(Map<String, dynamic> json) {
    final l$pauseProject = json['pauseProject'];
    final l$$__typename = json['__typename'];
    return Mutation$Pause(
      pauseProject: Mutation$Pause$pauseProject.fromJson(
          (l$pauseProject as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$Pause$pauseProject pauseProject;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$pauseProject = pauseProject;
    _resultData['pauseProject'] = l$pauseProject.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$pauseProject = pauseProject;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$pauseProject,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$Pause) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$pauseProject = pauseProject;
    final lOther$pauseProject = other.pauseProject;
    if (l$pauseProject != lOther$pauseProject) {
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

extension UtilityExtension$Mutation$Pause on Mutation$Pause {
  CopyWith$Mutation$Pause<Mutation$Pause> get copyWith =>
      CopyWith$Mutation$Pause(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$Pause<TRes> {
  factory CopyWith$Mutation$Pause(
    Mutation$Pause instance,
    TRes Function(Mutation$Pause) then,
  ) = _CopyWithImpl$Mutation$Pause;

  factory CopyWith$Mutation$Pause.stub(TRes res) =
      _CopyWithStubImpl$Mutation$Pause;

  TRes call({
    Mutation$Pause$pauseProject? pauseProject,
    String? $__typename,
  });
  CopyWith$Mutation$Pause$pauseProject<TRes> get pauseProject;
}

class _CopyWithImpl$Mutation$Pause<TRes>
    implements CopyWith$Mutation$Pause<TRes> {
  _CopyWithImpl$Mutation$Pause(
    this._instance,
    this._then,
  );

  final Mutation$Pause _instance;

  final TRes Function(Mutation$Pause) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? pauseProject = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$Pause(
        pauseProject: pauseProject == _undefined || pauseProject == null
            ? _instance.pauseProject
            : (pauseProject as Mutation$Pause$pauseProject),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$Pause$pauseProject<TRes> get pauseProject {
    final local$pauseProject = _instance.pauseProject;
    return CopyWith$Mutation$Pause$pauseProject(
        local$pauseProject, (e) => call(pauseProject: e));
  }
}

class _CopyWithStubImpl$Mutation$Pause<TRes>
    implements CopyWith$Mutation$Pause<TRes> {
  _CopyWithStubImpl$Mutation$Pause(this._res);

  TRes _res;

  call({
    Mutation$Pause$pauseProject? pauseProject,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$Pause$pauseProject<TRes> get pauseProject =>
      CopyWith$Mutation$Pause$pauseProject.stub(_res);
}

const documentNodeMutationPause = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'Pause'),
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
        variable: VariableNode(name: NameNode(value: 'projectId')),
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
        name: NameNode(value: 'pauseProject'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'orgSlug'),
            value: VariableNode(name: NameNode(value: 'orgSlug')),
          ),
          ArgumentNode(
            name: NameNode(value: 'projectId'),
            value: VariableNode(name: NameNode(value: 'projectId')),
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
Mutation$Pause _parserFn$Mutation$Pause(Map<String, dynamic> data) =>
    Mutation$Pause.fromJson(data);
typedef OnMutationCompleted$Mutation$Pause = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$Pause?,
);

class Options$Mutation$Pause extends graphql.MutationOptions<Mutation$Pause> {
  Options$Mutation$Pause({
    String? operationName,
    required Variables$Mutation$Pause variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$Pause? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$Pause? onCompleted,
    graphql.OnMutationUpdate<Mutation$Pause>? update,
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
                    data == null ? null : _parserFn$Mutation$Pause(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationPause,
          parserFn: _parserFn$Mutation$Pause,
        );

  final OnMutationCompleted$Mutation$Pause? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$Pause
    extends graphql.WatchQueryOptions<Mutation$Pause> {
  WatchOptions$Mutation$Pause({
    String? operationName,
    required Variables$Mutation$Pause variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$Pause? typedOptimisticResult,
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
          document: documentNodeMutationPause,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$Pause,
        );
}

extension ClientExtension$Mutation$Pause on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$Pause>> mutate$Pause(
          Options$Mutation$Pause options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$Pause> watchMutation$Pause(
          WatchOptions$Mutation$Pause options) =>
      this.watchMutation(options);
}

class Mutation$Pause$pauseProject {
  Mutation$Pause$pauseProject({
    required this.message,
    this.$__typename = 'SuccessResponse',
  });

  factory Mutation$Pause$pauseProject.fromJson(Map<String, dynamic> json) {
    final l$message = json['message'];
    final l$$__typename = json['__typename'];
    return Mutation$Pause$pauseProject(
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
    if (!(other is Mutation$Pause$pauseProject) ||
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

extension UtilityExtension$Mutation$Pause$pauseProject
    on Mutation$Pause$pauseProject {
  CopyWith$Mutation$Pause$pauseProject<Mutation$Pause$pauseProject>
      get copyWith => CopyWith$Mutation$Pause$pauseProject(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$Pause$pauseProject<TRes> {
  factory CopyWith$Mutation$Pause$pauseProject(
    Mutation$Pause$pauseProject instance,
    TRes Function(Mutation$Pause$pauseProject) then,
  ) = _CopyWithImpl$Mutation$Pause$pauseProject;

  factory CopyWith$Mutation$Pause$pauseProject.stub(TRes res) =
      _CopyWithStubImpl$Mutation$Pause$pauseProject;

  TRes call({
    String? message,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$Pause$pauseProject<TRes>
    implements CopyWith$Mutation$Pause$pauseProject<TRes> {
  _CopyWithImpl$Mutation$Pause$pauseProject(
    this._instance,
    this._then,
  );

  final Mutation$Pause$pauseProject _instance;

  final TRes Function(Mutation$Pause$pauseProject) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$Pause$pauseProject(
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$Pause$pauseProject<TRes>
    implements CopyWith$Mutation$Pause$pauseProject<TRes> {
  _CopyWithStubImpl$Mutation$Pause$pauseProject(this._res);

  TRes _res;

  call({
    String? message,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$Resume {
  factory Variables$Mutation$Resume({
    required String orgSlug,
    required String projectId,
  }) =>
      Variables$Mutation$Resume._({
        r'orgSlug': orgSlug,
        r'projectId': projectId,
      });

  Variables$Mutation$Resume._(this._$data);

  factory Variables$Mutation$Resume.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orgSlug = data['orgSlug'];
    result$data['orgSlug'] = (l$orgSlug as String);
    final l$projectId = data['projectId'];
    result$data['projectId'] = (l$projectId as String);
    return Variables$Mutation$Resume._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orgSlug => (_$data['orgSlug'] as String);

  String get projectId => (_$data['projectId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orgSlug = orgSlug;
    result$data['orgSlug'] = l$orgSlug;
    final l$projectId = projectId;
    result$data['projectId'] = l$projectId;
    return result$data;
  }

  CopyWith$Variables$Mutation$Resume<Variables$Mutation$Resume> get copyWith =>
      CopyWith$Variables$Mutation$Resume(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$Resume) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$orgSlug = orgSlug;
    final lOther$orgSlug = other.orgSlug;
    if (l$orgSlug != lOther$orgSlug) {
      return false;
    }
    final l$projectId = projectId;
    final lOther$projectId = other.projectId;
    if (l$projectId != lOther$projectId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$orgSlug = orgSlug;
    final l$projectId = projectId;
    return Object.hashAll([
      l$orgSlug,
      l$projectId,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$Resume<TRes> {
  factory CopyWith$Variables$Mutation$Resume(
    Variables$Mutation$Resume instance,
    TRes Function(Variables$Mutation$Resume) then,
  ) = _CopyWithImpl$Variables$Mutation$Resume;

  factory CopyWith$Variables$Mutation$Resume.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$Resume;

  TRes call({
    String? orgSlug,
    String? projectId,
  });
}

class _CopyWithImpl$Variables$Mutation$Resume<TRes>
    implements CopyWith$Variables$Mutation$Resume<TRes> {
  _CopyWithImpl$Variables$Mutation$Resume(
    this._instance,
    this._then,
  );

  final Variables$Mutation$Resume _instance;

  final TRes Function(Variables$Mutation$Resume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? orgSlug = _undefined,
    Object? projectId = _undefined,
  }) =>
      _then(Variables$Mutation$Resume._({
        ..._instance._$data,
        if (orgSlug != _undefined && orgSlug != null)
          'orgSlug': (orgSlug as String),
        if (projectId != _undefined && projectId != null)
          'projectId': (projectId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$Resume<TRes>
    implements CopyWith$Variables$Mutation$Resume<TRes> {
  _CopyWithStubImpl$Variables$Mutation$Resume(this._res);

  TRes _res;

  call({
    String? orgSlug,
    String? projectId,
  }) =>
      _res;
}

class Mutation$Resume {
  Mutation$Resume({
    required this.resumeProject,
    this.$__typename = 'Mutation',
  });

  factory Mutation$Resume.fromJson(Map<String, dynamic> json) {
    final l$resumeProject = json['resumeProject'];
    final l$$__typename = json['__typename'];
    return Mutation$Resume(
      resumeProject: Mutation$Resume$resumeProject.fromJson(
          (l$resumeProject as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$Resume$resumeProject resumeProject;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$resumeProject = resumeProject;
    _resultData['resumeProject'] = l$resumeProject.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$resumeProject = resumeProject;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$resumeProject,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$Resume) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$resumeProject = resumeProject;
    final lOther$resumeProject = other.resumeProject;
    if (l$resumeProject != lOther$resumeProject) {
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

extension UtilityExtension$Mutation$Resume on Mutation$Resume {
  CopyWith$Mutation$Resume<Mutation$Resume> get copyWith =>
      CopyWith$Mutation$Resume(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$Resume<TRes> {
  factory CopyWith$Mutation$Resume(
    Mutation$Resume instance,
    TRes Function(Mutation$Resume) then,
  ) = _CopyWithImpl$Mutation$Resume;

  factory CopyWith$Mutation$Resume.stub(TRes res) =
      _CopyWithStubImpl$Mutation$Resume;

  TRes call({
    Mutation$Resume$resumeProject? resumeProject,
    String? $__typename,
  });
  CopyWith$Mutation$Resume$resumeProject<TRes> get resumeProject;
}

class _CopyWithImpl$Mutation$Resume<TRes>
    implements CopyWith$Mutation$Resume<TRes> {
  _CopyWithImpl$Mutation$Resume(
    this._instance,
    this._then,
  );

  final Mutation$Resume _instance;

  final TRes Function(Mutation$Resume) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? resumeProject = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$Resume(
        resumeProject: resumeProject == _undefined || resumeProject == null
            ? _instance.resumeProject
            : (resumeProject as Mutation$Resume$resumeProject),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$Resume$resumeProject<TRes> get resumeProject {
    final local$resumeProject = _instance.resumeProject;
    return CopyWith$Mutation$Resume$resumeProject(
        local$resumeProject, (e) => call(resumeProject: e));
  }
}

class _CopyWithStubImpl$Mutation$Resume<TRes>
    implements CopyWith$Mutation$Resume<TRes> {
  _CopyWithStubImpl$Mutation$Resume(this._res);

  TRes _res;

  call({
    Mutation$Resume$resumeProject? resumeProject,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$Resume$resumeProject<TRes> get resumeProject =>
      CopyWith$Mutation$Resume$resumeProject.stub(_res);
}

const documentNodeMutationResume = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'Resume'),
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
        variable: VariableNode(name: NameNode(value: 'projectId')),
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
        name: NameNode(value: 'resumeProject'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'orgSlug'),
            value: VariableNode(name: NameNode(value: 'orgSlug')),
          ),
          ArgumentNode(
            name: NameNode(value: 'projectId'),
            value: VariableNode(name: NameNode(value: 'projectId')),
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
Mutation$Resume _parserFn$Mutation$Resume(Map<String, dynamic> data) =>
    Mutation$Resume.fromJson(data);
typedef OnMutationCompleted$Mutation$Resume = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$Resume?,
);

class Options$Mutation$Resume extends graphql.MutationOptions<Mutation$Resume> {
  Options$Mutation$Resume({
    String? operationName,
    required Variables$Mutation$Resume variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$Resume? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$Resume? onCompleted,
    graphql.OnMutationUpdate<Mutation$Resume>? update,
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
                    data == null ? null : _parserFn$Mutation$Resume(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationResume,
          parserFn: _parserFn$Mutation$Resume,
        );

  final OnMutationCompleted$Mutation$Resume? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$Resume
    extends graphql.WatchQueryOptions<Mutation$Resume> {
  WatchOptions$Mutation$Resume({
    String? operationName,
    required Variables$Mutation$Resume variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$Resume? typedOptimisticResult,
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
          document: documentNodeMutationResume,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$Resume,
        );
}

extension ClientExtension$Mutation$Resume on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$Resume>> mutate$Resume(
          Options$Mutation$Resume options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$Resume> watchMutation$Resume(
          WatchOptions$Mutation$Resume options) =>
      this.watchMutation(options);
}

class Mutation$Resume$resumeProject {
  Mutation$Resume$resumeProject({
    required this.message,
    this.$__typename = 'SuccessResponse',
  });

  factory Mutation$Resume$resumeProject.fromJson(Map<String, dynamic> json) {
    final l$message = json['message'];
    final l$$__typename = json['__typename'];
    return Mutation$Resume$resumeProject(
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
    if (!(other is Mutation$Resume$resumeProject) ||
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

extension UtilityExtension$Mutation$Resume$resumeProject
    on Mutation$Resume$resumeProject {
  CopyWith$Mutation$Resume$resumeProject<Mutation$Resume$resumeProject>
      get copyWith => CopyWith$Mutation$Resume$resumeProject(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$Resume$resumeProject<TRes> {
  factory CopyWith$Mutation$Resume$resumeProject(
    Mutation$Resume$resumeProject instance,
    TRes Function(Mutation$Resume$resumeProject) then,
  ) = _CopyWithImpl$Mutation$Resume$resumeProject;

  factory CopyWith$Mutation$Resume$resumeProject.stub(TRes res) =
      _CopyWithStubImpl$Mutation$Resume$resumeProject;

  TRes call({
    String? message,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$Resume$resumeProject<TRes>
    implements CopyWith$Mutation$Resume$resumeProject<TRes> {
  _CopyWithImpl$Mutation$Resume$resumeProject(
    this._instance,
    this._then,
  );

  final Mutation$Resume$resumeProject _instance;

  final TRes Function(Mutation$Resume$resumeProject) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$Resume$resumeProject(
        message: message == _undefined || message == null
            ? _instance.message
            : (message as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$Resume$resumeProject<TRes>
    implements CopyWith$Mutation$Resume$resumeProject<TRes> {
  _CopyWithStubImpl$Mutation$Resume$resumeProject(this._res);

  TRes _res;

  call({
    String? message,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$CreateProject {
  factory Variables$Mutation$CreateProject({
    required String orgSlug,
    required String name,
  }) =>
      Variables$Mutation$CreateProject._({
        r'orgSlug': orgSlug,
        r'name': name,
      });

  Variables$Mutation$CreateProject._(this._$data);

  factory Variables$Mutation$CreateProject.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orgSlug = data['orgSlug'];
    result$data['orgSlug'] = (l$orgSlug as String);
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    return Variables$Mutation$CreateProject._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orgSlug => (_$data['orgSlug'] as String);

  String get name => (_$data['name'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orgSlug = orgSlug;
    result$data['orgSlug'] = l$orgSlug;
    final l$name = name;
    result$data['name'] = l$name;
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateProject<Variables$Mutation$CreateProject>
      get copyWith => CopyWith$Variables$Mutation$CreateProject(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateProject) ||
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
    return true;
  }

  @override
  int get hashCode {
    final l$orgSlug = orgSlug;
    final l$name = name;
    return Object.hashAll([
      l$orgSlug,
      l$name,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateProject<TRes> {
  factory CopyWith$Variables$Mutation$CreateProject(
    Variables$Mutation$CreateProject instance,
    TRes Function(Variables$Mutation$CreateProject) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateProject;

  factory CopyWith$Variables$Mutation$CreateProject.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateProject;

  TRes call({
    String? orgSlug,
    String? name,
  });
}

class _CopyWithImpl$Variables$Mutation$CreateProject<TRes>
    implements CopyWith$Variables$Mutation$CreateProject<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateProject(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateProject _instance;

  final TRes Function(Variables$Mutation$CreateProject) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? orgSlug = _undefined,
    Object? name = _undefined,
  }) =>
      _then(Variables$Mutation$CreateProject._({
        ..._instance._$data,
        if (orgSlug != _undefined && orgSlug != null)
          'orgSlug': (orgSlug as String),
        if (name != _undefined && name != null) 'name': (name as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateProject<TRes>
    implements CopyWith$Variables$Mutation$CreateProject<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateProject(this._res);

  TRes _res;

  call({
    String? orgSlug,
    String? name,
  }) =>
      _res;
}

class Mutation$CreateProject {
  Mutation$CreateProject({
    required this.createProject,
    this.$__typename = 'Mutation',
  });

  factory Mutation$CreateProject.fromJson(Map<String, dynamic> json) {
    final l$createProject = json['createProject'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateProject(
      createProject: Mutation$CreateProject$createProject.fromJson(
          (l$createProject as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$CreateProject$createProject createProject;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createProject = createProject;
    _resultData['createProject'] = l$createProject.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createProject = createProject;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createProject,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateProject) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$createProject = createProject;
    final lOther$createProject = other.createProject;
    if (l$createProject != lOther$createProject) {
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

extension UtilityExtension$Mutation$CreateProject on Mutation$CreateProject {
  CopyWith$Mutation$CreateProject<Mutation$CreateProject> get copyWith =>
      CopyWith$Mutation$CreateProject(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreateProject<TRes> {
  factory CopyWith$Mutation$CreateProject(
    Mutation$CreateProject instance,
    TRes Function(Mutation$CreateProject) then,
  ) = _CopyWithImpl$Mutation$CreateProject;

  factory CopyWith$Mutation$CreateProject.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateProject;

  TRes call({
    Mutation$CreateProject$createProject? createProject,
    String? $__typename,
  });
  CopyWith$Mutation$CreateProject$createProject<TRes> get createProject;
}

class _CopyWithImpl$Mutation$CreateProject<TRes>
    implements CopyWith$Mutation$CreateProject<TRes> {
  _CopyWithImpl$Mutation$CreateProject(
    this._instance,
    this._then,
  );

  final Mutation$CreateProject _instance;

  final TRes Function(Mutation$CreateProject) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createProject = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateProject(
        createProject: createProject == _undefined || createProject == null
            ? _instance.createProject
            : (createProject as Mutation$CreateProject$createProject),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$CreateProject$createProject<TRes> get createProject {
    final local$createProject = _instance.createProject;
    return CopyWith$Mutation$CreateProject$createProject(
        local$createProject, (e) => call(createProject: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateProject<TRes>
    implements CopyWith$Mutation$CreateProject<TRes> {
  _CopyWithStubImpl$Mutation$CreateProject(this._res);

  TRes _res;

  call({
    Mutation$CreateProject$createProject? createProject,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$CreateProject$createProject<TRes> get createProject =>
      CopyWith$Mutation$CreateProject$createProject.stub(_res);
}

const documentNodeMutationCreateProject = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateProject'),
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
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createProject'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'input'),
            value: ObjectValueNode(fields: [
              ObjectFieldNode(
                name: NameNode(value: 'slug'),
                value: VariableNode(name: NameNode(value: 'name')),
              ),
              ObjectFieldNode(
                name: NameNode(value: 'orgSlug'),
                value: VariableNode(name: NameNode(value: 'orgSlug')),
              ),
            ]),
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
            name: NameNode(value: 'slug'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'status'),
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
Mutation$CreateProject _parserFn$Mutation$CreateProject(
        Map<String, dynamic> data) =>
    Mutation$CreateProject.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateProject = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreateProject?,
);

class Options$Mutation$CreateProject
    extends graphql.MutationOptions<Mutation$CreateProject> {
  Options$Mutation$CreateProject({
    String? operationName,
    required Variables$Mutation$CreateProject variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateProject? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateProject? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateProject>? update,
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
                    data == null
                        ? null
                        : _parserFn$Mutation$CreateProject(data),
                  ),
          update: update,
          onError: onError,
          document: documentNodeMutationCreateProject,
          parserFn: _parserFn$Mutation$CreateProject,
        );

  final OnMutationCompleted$Mutation$CreateProject? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onCompleted == null
            ? super.properties
            : super.properties.where((property) => property != onCompleted),
        onCompletedWithParsed,
      ];
}

class WatchOptions$Mutation$CreateProject
    extends graphql.WatchQueryOptions<Mutation$CreateProject> {
  WatchOptions$Mutation$CreateProject({
    String? operationName,
    required Variables$Mutation$CreateProject variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateProject? typedOptimisticResult,
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
          document: documentNodeMutationCreateProject,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Mutation$CreateProject,
        );
}

extension ClientExtension$Mutation$CreateProject on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateProject>> mutate$CreateProject(
          Options$Mutation$CreateProject options) async =>
      await this.mutate(options);
  graphql.ObservableQuery<Mutation$CreateProject> watchMutation$CreateProject(
          WatchOptions$Mutation$CreateProject options) =>
      this.watchMutation(options);
}

class Mutation$CreateProject$createProject {
  Mutation$CreateProject$createProject({
    required this.id,
    required this.slug,
    required this.status,
    this.$__typename = 'Project',
  });

  factory Mutation$CreateProject$createProject.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$slug = json['slug'];
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateProject$createProject(
      id: (l$id as String),
      slug: (l$slug as String),
      status: fromJson$Enum$ProjectStatus((l$status as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String slug;

  final Enum$ProjectStatus status;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$status = status;
    _resultData['status'] = toJson$Enum$ProjectStatus(l$status);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$slug = slug;
    final l$status = status;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$slug,
      l$status,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateProject$createProject) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
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

extension UtilityExtension$Mutation$CreateProject$createProject
    on Mutation$CreateProject$createProject {
  CopyWith$Mutation$CreateProject$createProject<
          Mutation$CreateProject$createProject>
      get copyWith => CopyWith$Mutation$CreateProject$createProject(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$CreateProject$createProject<TRes> {
  factory CopyWith$Mutation$CreateProject$createProject(
    Mutation$CreateProject$createProject instance,
    TRes Function(Mutation$CreateProject$createProject) then,
  ) = _CopyWithImpl$Mutation$CreateProject$createProject;

  factory CopyWith$Mutation$CreateProject$createProject.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateProject$createProject;

  TRes call({
    String? id,
    String? slug,
    Enum$ProjectStatus? status,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$CreateProject$createProject<TRes>
    implements CopyWith$Mutation$CreateProject$createProject<TRes> {
  _CopyWithImpl$Mutation$CreateProject$createProject(
    this._instance,
    this._then,
  );

  final Mutation$CreateProject$createProject _instance;

  final TRes Function(Mutation$CreateProject$createProject) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? slug = _undefined,
    Object? status = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateProject$createProject(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        slug: slug == _undefined || slug == null
            ? _instance.slug
            : (slug as String),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as Enum$ProjectStatus),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$CreateProject$createProject<TRes>
    implements CopyWith$Mutation$CreateProject$createProject<TRes> {
  _CopyWithStubImpl$Mutation$CreateProject$createProject(this._res);

  TRes _res;

  call({
    String? id,
    String? slug,
    Enum$ProjectStatus? status,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$Projects {
  factory Variables$Query$Projects({required String orgSlug}) =>
      Variables$Query$Projects._({
        r'orgSlug': orgSlug,
      });

  Variables$Query$Projects._(this._$data);

  factory Variables$Query$Projects.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orgSlug = data['orgSlug'];
    result$data['orgSlug'] = (l$orgSlug as String);
    return Variables$Query$Projects._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orgSlug => (_$data['orgSlug'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orgSlug = orgSlug;
    result$data['orgSlug'] = l$orgSlug;
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
    if (!(other is Variables$Query$Projects) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$orgSlug = orgSlug;
    final lOther$orgSlug = other.orgSlug;
    if (l$orgSlug != lOther$orgSlug) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$orgSlug = orgSlug;
    return Object.hashAll([l$orgSlug]);
  }
}

abstract class CopyWith$Variables$Query$Projects<TRes> {
  factory CopyWith$Variables$Query$Projects(
    Variables$Query$Projects instance,
    TRes Function(Variables$Query$Projects) then,
  ) = _CopyWithImpl$Variables$Query$Projects;

  factory CopyWith$Variables$Query$Projects.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Projects;

  TRes call({String? orgSlug});
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

  TRes call({Object? orgSlug = _undefined}) =>
      _then(Variables$Query$Projects._({
        ..._instance._$data,
        if (orgSlug != _undefined && orgSlug != null)
          'orgSlug': (orgSlug as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$Projects<TRes>
    implements CopyWith$Variables$Query$Projects<TRes> {
  _CopyWithStubImpl$Variables$Query$Projects(this._res);

  TRes _res;

  call({String? orgSlug}) => _res;
}

class Query$Projects {
  Query$Projects({
    required this.projects,
    this.$__typename = 'Query',
  });

  factory Query$Projects.fromJson(Map<String, dynamic> json) {
    final l$projects = json['projects'];
    final l$$__typename = json['__typename'];
    return Query$Projects(
      projects: (l$projects as List<dynamic>)
          .map((e) =>
              Query$Projects$projects.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$Projects$projects> projects;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$projects = projects;
    _resultData['projects'] = l$projects.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$projects = projects;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$projects.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Projects) || runtimeType != other.runtimeType) {
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
      Iterable<Query$Projects$projects> Function(
              Iterable<
                  CopyWith$Query$Projects$projects<Query$Projects$projects>>)
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
        projects: projects == _undefined || projects == null
            ? _instance.projects
            : (projects as List<Query$Projects$projects>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes projects(
          Iterable<Query$Projects$projects> Function(
                  Iterable<
                      CopyWith$Query$Projects$projects<
                          Query$Projects$projects>>)
              _fn) =>
      call(
          projects: _fn(
              _instance.projects.map((e) => CopyWith$Query$Projects$projects(
                    e,
                    (i) => i,
                  ))).toList());
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
        variable: VariableNode(name: NameNode(value: 'orgSlug')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
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
            name: NameNode(value: 'orgSlug'),
            value: VariableNode(name: NameNode(value: 'orgSlug')),
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
            name: NameNode(value: 'slug'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'status'),
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
    required this.slug,
    required this.status,
    this.$__typename = 'Project',
  });

  factory Query$Projects$projects.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$slug = json['slug'];
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return Query$Projects$projects(
      id: (l$id as String),
      slug: (l$slug as String),
      status: fromJson$Enum$ProjectStatus((l$status as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String slug;

  final Enum$ProjectStatus status;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$status = status;
    _resultData['status'] = toJson$Enum$ProjectStatus(l$status);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$slug = slug;
    final l$status = status;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$slug,
      l$status,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Projects$projects) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
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
    String? slug,
    Enum$ProjectStatus? status,
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
    Object? slug = _undefined,
    Object? status = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Projects$projects(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        slug: slug == _undefined || slug == null
            ? _instance.slug
            : (slug as String),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as Enum$ProjectStatus),
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
    String? slug,
    Enum$ProjectStatus? status,
    String? $__typename,
  }) =>
      _res;
}
