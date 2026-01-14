import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';

import '../exit.dart';
import '../package_info.dart' as package_info;
import 'auth.dart';
import 'metadata.dart';
import 'project_settings.dart';
import 'scope.dart';

class ApiException implements Exception {
  ApiException._(this.statusCode, this.message, {this.headers});

  final int statusCode;
  final String message;
  final Map<String, String>? headers;

  @override
  String toString() => 'ApiException: [$statusCode] $message';
}

class GlobeApi {
  GlobeApi({
    required this.metadata,
    required this.auth,
    required this.logger,
  }) {
    FutureExtension.logger = logger;
  }

  List<Project>? _projectsCache;
  List<Organization>? _orgsCache;

  Map<String, String> get headers {
    final currentSession = auth.currentSession;
    final currentScope = GlobeScope.value;
    final templateInfo = GetIt.instance.get<GlobeScope>().templateInfo;

    return {
      'X-Globe-Platform': 'globe_cli',
      'X-Globe-Platform-Version': package_info.version,
      if (currentScope != null) ...{
        'X-Globe-Organization-Id': currentScope.orgId,
        'X-Globe-Project-Id': currentScope.projectId,
        'X-Globe-Project-Slug': currentScope.projectSlug,
      },
      if (templateInfo != null) ...{
        'X-Globe-Template-Id': templateInfo.$1,
        'X-Globe-Template-Source': templateInfo.$2,
      },
      if (currentSession != null &&
          currentSession.authenticationMethod == AuthenticationMethod.jwt)
        'Authorization': 'Bearer ${currentSession.jwt}',
      if (currentSession != null &&
          currentSession.authenticationMethod == AuthenticationMethod.apiToken)
        'x-api-token': currentSession.jwt,
    };
  }

  final GlobeMetadata metadata;
  final GlobeAuth auth;
  final Logger logger;

  /// Creates a [Uri] from the given [path], using the [GlobeMetadata.endpoint] as the base.
  Uri _buildUri(String path) {
    assert(path.startsWith('/'), 'path must start with a /.');
    return Uri.parse('${metadata.endpoint}/api$path');
  }

  /// Handles an [http.Response], throwing an [ApiException] if the response
  /// is not successful.
  Future<T> _callGlobeApi<T>(
    FutureOr<http.Response> Function() apiCall, {
    bool needsAuth = true,
    bool canRetry = true,
  }) async {
    if (needsAuth) requireAuth();

    Future<({int status, T data})> makeApiCall() async {
      final response = await apiCall.call();

      Map<String, Object?> json;
      try {
        json = jsonDecode(response.body) as Map<String, Object?>;
      } catch (_) {
        json = {'message': 'Invalid JSON response from Globe API'};
      }

      if (response.statusCode > 399) {
        throw ApiException._(
          response.statusCode,
          json['message']! as String,
          headers: response.headers,
        );
      }

      return (
        status: response.statusCode,
        data: json['data'] as T,
      );
    }

    try {
      final task = canRetry
          ? makeApiCall().retry(debugLabel: 'Globe API')
          : makeApiCall();
      final result = await task;

      return result.data;
    } catch (e) {
      var message =
          'Globe API Error.\nThere was an issue calling the Globe API, please try again.\n';
      logger.err(
        '$message Use verbose mode using the --verbose flag for more details.',
      );

      if (e is ApiException) {
        message = [
          'If this issue persists please contact support and provide these logs.',
          '---',
          '"Status Code": ${e.statusCode}',
          '',
          '"Headers":${e.headers?.entries.fold('', (acc, v) => '$acc\n${v.key}: ${v.value}')}',
        ].join('\n');

        logger.detail(message);
      } else {
        logger.err('Unexpected Error: $e');
      }

      rethrow;
    }
  }

  /// Throws an exception if the user is not authenticated.
  void requireAuth() {
    if (auth.currentSession == null) {
      throw Exception('The user is not authenticated.');
    }
  }

  Future<void> updateSettings({
    required String orgId,
    required String projectId,
    required ProjectSettings settings,
  }) async {
    final path = '/orgs/$orgId/projects/$projectId/settings';
    final uri = _buildUri(path);
    logger.detail('API Request: PUT $path');

    final request = http.Request('PUT', uri);
    request.headers.addAll(headers);

    request.body = jsonEncode(settings.toJson());

    await _callGlobeApi<Map<String, Object?>>(
      () => request.send().then(http.Response.fromStream),
    );
  }

  /// Gets all of the organizations that the current user is a member of.
  Future<List<Organization>> getOrganizations() async {
    if (_orgsCache != null && _orgsCache!.isNotEmpty) {
      logger.detail('Cached API Request: GET /user/orgs');
      return _orgsCache!;
    }

    logger.detail('API Request: GET /user/orgs');
    final response = await _callGlobeApi<List<Object?>>(
      () => http.get(_buildUri('/user/orgs'), headers: headers),
    );

    return _orgsCache = response
        .cast<Map<String, Object?>>()
        .map(Organization.fromJson)
        .toList();
  }

  /// Gets all of the projects that the current user is a member of.
  Future<List<Project>> getProjects({
    required String org,
  }) async {
    if (_projectsCache != null && _projectsCache!.isNotEmpty) {
      logger.detail('Cached API Request: GET /orgs/$org/projects');
      return _projectsCache!;
    }

    logger.detail('API Request: GET /orgs/$org/projects');
    final response = await _callGlobeApi<List<Object?>>(
      () => http.get(_buildUri('/orgs/$org/projects'), headers: headers),
    );

    return _projectsCache =
        response.cast<Map<String, Object?>>().map(Project.fromJson).toList();
  }

  /// Creates a new project and returns it.
  Future<Project> createProject({
    required String orgId,
    required String name,
  }) async {
    logger.detail('API Request: POST /orgs/$orgId/projects');
    final request = http.Request('POST', _buildUri('/orgs/$orgId/projects'));
    request.headers.addAll(headers);

    request.body = jsonEncode({'name': name});

    final response = await _callGlobeApi<Map<Object?, Object?>>(
      () => request.send().then(http.Response.fromStream),
    );

    _projectsCache = null;
    _orgsCache = null;

    return Project.fromJson(response);
  }

  Future<void> pauseProject({
    required String orgId,
    required String projectId,
  }) async {
    final url = '/orgs/$orgId/projects/$projectId/pause';
    logger.detail('API Request: PUT $url');
    final request = http.Request('PUT', _buildUri(url));
    request.headers.addAll(headers);

    await _callGlobeApi<dynamic>(
      () => request.send().then(http.Response.fromStream),
    );
  }

  Future<void> resumeProject({
    required String orgId,
    required String projectId,
  }) async {
    final url = '/orgs/$orgId/projects/$projectId/resume';
    logger.detail('API Request: PUT $url');
    final request = http.Request('PUT', _buildUri(url));
    request.headers.addAll(headers);

    await _callGlobeApi<dynamic>(
      () => request.send().then(http.Response.fromStream),
    );
  }

  Future<FrameworkPresetOptions?> discoverPreset(String pubspecContent) async {
    const path = '/preset-discovery';
    logger.detail('API Request: POST $path');
    final request = http.Request('POST', _buildUri(path));

    request.headers.addAll(headers);
    request.headers['Content-Type'] = 'text/plain';
    request.body = pubspecContent;

    final response = await _callGlobeApi<Map<Object?, Object?>?>(
      () => request.send().then(http.Response.fromStream),
    );

    if (response == null) return null;

    return FrameworkPresetOptions.fromJson(response);
  }

  Future<Deployment> getDeployment({
    required String orgId,
    required String projectId,
    required String deploymentId,
  }) async {
    logger.detail(
      'API Request: GET /orgs/$orgId/projects/$projectId/deployments/$deploymentId',
    );
    final response = await _callGlobeApi<Map<Object?, Object?>>(
      () => http.get(
        _buildUri('/orgs/$orgId/projects/$projectId/deployments/$deploymentId'),
        headers: headers,
      ),
    );

    return Deployment.fromJson(response);
  }

  /// Deploy the current project to the given project.
  Future<Deployment> deploy({
    required String orgId,
    required String projectId,
    required DeploymentEnvironment environment,
    required List<int> archive,
  }) async {
    logger.detail('API Request: POST /orgs/$orgId/projects/$projectId/deploy');
    final request = http.MultipartRequest(
      'POST',
      _buildUri('/orgs/$orgId/projects/$projectId/deploy'),
    );

    request.headers.addAll(headers);
    request.fields['environment'] = environment.name;

    request.files.add(
      http.MultipartFile.fromBytes(
        'projectArchive',
        archive,
        filename: 'archive.zip',
      ),
    );

    final response = await _callGlobeApi<Map<Object?, Object?>>(
      () async {
        try {
          final stream = await request.send();
          return http.Response.fromStream(stream);
        } on SocketException catch (e) {
          throw ApiException._(413, e.message);
        }
      },
      canRetry: false,
    );

    return Deployment.fromJson(response);
  }

  Future<({String id, String value})> createToken({
    required String orgId,
    required String name,
    required List<String> projectUuids,
    required DateTime expiresAt,
  }) async {
    final createTokenPath = '/orgs/$orgId/api-tokens';
    logger.detail('API Request: POST $createTokenPath');

    final body = json.encode({
      'name': name,
      'projectUuids': projectUuids,
      'expiresAt': expiresAt.toUtc().toIso8601String(),
    });

    // create token
    final response = await _callGlobeApi<Map<String, Object?>>(
      () => http.post(_buildUri(createTokenPath), headers: headers, body: body),
    );
    final token = Token.fromJson(response);

    return (id: token.uuid, value: token.value!);
  }

  Future<List<Token>> listTokens({
    required String orgId,
    required List<String> projectUuids,
  }) async {
    final fullUri = _buildUri('/orgs/$orgId/api-tokens')
        .replace(queryParameters: {'projects': projectUuids});

    logger.detail('API Request: GET /orgs/$orgId/api-tokens');
    final response = await _callGlobeApi<List<dynamic>>(
      () => http.get(fullUri, headers: headers),
    );

    return response
        .map((e) => Token.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteToken({
    required String orgId,
    required String tokenId,
  }) async {
    final deleteTokenPath = '/orgs/$orgId/api-tokens/$tokenId';
    logger.detail('API Request: DELETE $deleteTokenPath');

    await _callGlobeApi<Map<String, Object?>>(
      () => http.delete(_buildUri(deleteTokenPath), headers: headers),
    );
  }
}

class Settings {
  Settings._({
    required this.entrypoint,
    required this.buildCommand,
    required this.rootDirectory,
    required this.connection,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    switch (json) {
      case {
          'entrypoint': final String entrypoint,
          'buildCommand': final String buildCommand,
          'rootDirectory': final String rootDirectory,
          'connection': final Map<String, Object?>? rawConnection,
        }:
        final connection = rawConnection == null
            ? null
            : SettingsConnection.fromJson(rawConnection);

        /// If the project is linked with a git repository, "rootDirectory"
        /// is relative to the root of the git repository.
        /// Otherwise it is relative to the current directory.
        final projectRootDir = connection != null
            ? _findEnclosingGitDirectory(Directory.current)
            : Directory.current;

        final rootDir = Directory(join(projectRootDir.path, rootDirectory));

        return Settings._(
          entrypoint: File(join(rootDir.path, entrypoint)),
          buildCommand: buildCommand,
          rootDirectory: rootDir,
          connection: connection,
        );
      case _:
        throw FormatException('Settings', json);
    }
  }

  static Directory _findEnclosingGitDirectory(Directory directory) {
    if (Directory(join(directory.path, '.git')).existsSync()) return directory;

    if (directory.path == directory.parent.path) {
      throw Exception('Could not find a git directory.');
    }

    return _findEnclosingGitDirectory(directory.parent);
  }

  final File entrypoint;
  final String buildCommand;
  final Directory rootDirectory;
  final SettingsConnection? connection;

  void validate({required Logger logger}) {
    if (!rootDirectory.existsSync()) {
      logger.err(
        'The root directory for this project does not exist: ${rootDirectory.path}',
      );
      exitOverride(ExitCode.software.code);
    }
    if (!File(join(rootDirectory.path, 'pubspec.yaml')).existsSync()) {
      logger.err('No pubspec.yaml found at: ${rootDirectory.path}');
      exitOverride(ExitCode.software.code);
    }
    if (!entrypoint.existsSync()) {
      logger.err(
        "The project's entrypoint does not exist: ${entrypoint.path}",
      );
      exitOverride(ExitCode.software.code);
    }
  }
}

class SettingsConnection {
  SettingsConnection._({
    required this.owner,
    required this.repository,
    required this.branch,
  });

  factory SettingsConnection.fromJson(Map<String, dynamic> json) {
    switch (json) {
      case {
          'owner': final String owner,
          'repository': final String repository,
          'branch': final String branch,
        }:
        return SettingsConnection._(
          owner: owner,
          repository: repository,
          branch: branch,
        );
      case _:
        throw FormatException('SettingsConnection', json);
    }
  }

  final String owner;
  final String repository;
  final String branch;
}

class Organization {
  Organization({
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
    // required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Organization.fromJson(Map<dynamic, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'name': final String name,
        'type': final String type,
        // 'role': final String role,
        'slug': final String slug,
        'createdAt': final String createdAt,
        'updatedAt': final String updatedAt,
      } =>
        Organization(
          id: id,
          name: name,
          slug: slug,
          type: OrganizationType.fromString(type),
          // role: Role.fromString(role),
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        ),
      _ => throw FormatException('Organization', json),
    };
  }

  final String id;
  final String name;
  final String slug;
  final OrganizationType type;
  // final Role role;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class Project {
  Project({
    required this.id,
    required this.orgId,
    required this.slug,
    required this.paused,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project.fromJson(Map<dynamic, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'organizationId': final String organizationId,
        'slug': final String slug,
        'paused': final bool paused,
        'createdAt': final String createdAt,
        'updatedAt': final String updatedAt,
      } =>
        Project(
          id: id,
          orgId: organizationId,
          slug: slug,
          paused: paused,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        ),
      {
        'id': final String id,
        'organizationId': final String organizationId,
        'slug': final String slug,
        'createdAt': final String createdAt,
        'updatedAt': final String updatedAt,
      } =>
        Project(
          id: id,
          orgId: organizationId,
          slug: slug,
          paused: false,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        ),
      _ => throw FormatException('Project', json),
    };
  }

  final String id;
  final String orgId;
  final String slug;
  final bool paused;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class Deployment {
  Deployment._({
    required this.id,
    required this.projectId,
    required this.environment,
    required this.status,
    required this.state,
    this.message,
    required this.url,
    required this.hash,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.buildId,
  });

  factory Deployment.fromJson(Map<dynamic, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'projectId': final String projectId,
        'environment': final String environment,
        'status': final String status,
        'state': final String state,
        'message': final String? message,
        'url': final String url,
        'hash': final String hash,
        'active': final bool active,
        'createdAt': final String createdAt,
        'updatedAt': final String updatedAt,
        'buildId': final String? buildId,
      } =>
        Deployment._(
          id: id,
          projectId: projectId,
          environment: DeploymentEnvironment.values.firstWhere(
            (e) => e.name == environment,
            orElse: () => DeploymentEnvironment.invalid,
          ),
          status: status,
          state: DeploymentState.values.firstWhere(
            (e) => e.name == state,
            orElse: () => DeploymentState.invalid,
          ),
          message: message,
          url: url,
          hash: hash,
          active: active,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
          buildId: buildId,
        ),
      _ => throw FormatException('Deployment', json),
    };
  }

  final String id;
  final String projectId;
  final DeploymentEnvironment environment;
  final String status;
  final DeploymentState state;
  final String? message;
  final String url;
  final String hash;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? buildId;
}

enum DeploymentState {
  pending('Queued'),
  working('In progress'),
  deploying('Deploying'),
  success('Deployment successful'),
  error('Deployment failed'),
  cancelled('Deployment cancelled'),
  // state is not a valid state, but is used to represent an invalid state.
  invalid('Invalid');

  const DeploymentState(this.message);

  final String message;
}

class FrameworkPresetOptions {
  FrameworkPresetOptions({
    required this.id,
    required this.name,
    required this.buildCommand,
    required this.entrypoint,
    this.buildRunnerDetection,
  });

  factory FrameworkPresetOptions.fromJson(Map<dynamic, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'name': final String name,
        'entrypoint': final String entrypoint,
        'buildCommand': final String? buildCommand,
      } =>
        FrameworkPresetOptions(
          id: id,
          name: name,
          buildCommand: buildCommand,
          entrypoint: entrypoint,
          buildRunnerDetection: json['buildRunnerDetection'] as bool?,
        ),
      _ => throw FormatException('FrameworkPresetOptions', json),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'buildCommand': buildCommand,
      'entrypoint': entrypoint,
      if (buildRunnerDetection != null)
        'buildRunnerDetection': buildRunnerDetection,
    };
  }

  final String id;
  final String name;
  final String? buildCommand;
  final String entrypoint;
  final bool? buildRunnerDetection;
}

enum DeploymentEnvironment {
  preview,
  production,
  invalid;
}

enum Role {
  admin,
  basicMember;

  static Role fromString(String role) {
    switch (role) {
      case 'admin':
        return Role.admin;
      case 'basic_member':
        return Role.basicMember;
      default:
        throw ArgumentError.value(role, 'role');
    }
  }
}

enum OrganizationType {
  personal,
  organization;

  static OrganizationType fromString(String type) {
    switch (type) {
      case 'personal':
        return OrganizationType.personal;
      case 'organization':
        return OrganizationType.organization;
      default:
        throw ArgumentError.value(type, 'type');
    }
  }
}

class Token {
  final String uuid;
  final String name;
  final String organizationUuid;
  final DateTime expiresAt;
  final List<String> cliTokenClaimProject;
  final String? value;

  const Token._({
    required this.uuid,
    required this.name,
    required this.organizationUuid,
    required this.expiresAt,
    required this.cliTokenClaimProject,
    required this.value,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'uuid': final String uuid,
        'name': final String name,
        'organizationUuid': final String organizationUuid,
        'expiresAt': final String expiresAt,
        'projects': final List<dynamic> projects,
      } =>
        Token._(
          uuid: uuid,
          name: name,
          organizationUuid: organizationUuid,
          expiresAt: DateTime.parse(expiresAt),
          cliTokenClaimProject: projects
              .map((e) => (e as Map)['projectUuid'].toString())
              .toList(),
          value: json['value']?.toString(),
        ),
      _ => throw FormatException('Token', json),
    };
  }
}

extension FutureExtension<T> on Future<T> {
  static late Logger logger;

  Future<T> retry({
    int retries = 3,
    Duration delay = const Duration(seconds: 1),
    String? debugLabel,
  }) async {
    try {
      return await this;
    } catch (e) {
      if (retries > 1) {
        if (debugLabel != null) {
          FutureExtension.logger.detail('$debugLabel: retrying future');
        }
        await Future<void>.delayed(delay);
        return retry(
          retries: retries - 1,
          delay: delay,
          debugLabel: debugLabel,
        );
      }
      rethrow;
    }
  }
}
