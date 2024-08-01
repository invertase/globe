// ignore_for_file: type=lint
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
    if (!(other is Input$ProjectSettingsInput) ||
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
    if (!(other is Input$ProjectConnectionInput) ||
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
    if (!(other is Input$CreateProjectInput) ||
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
    if (!(other is Input$UpdateProjectSlugInput) ||
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
