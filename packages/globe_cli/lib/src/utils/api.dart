import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';

import '../exit.dart';
import '../package_info.dart' as package_info;
import 'auth.dart';
import 'metadata.dart';
import 'project_settings.dart';

class ApiException implements Exception {
  ApiException._(this.statusCode, this.message);

  final int statusCode;
  final String message;
}

class GlobeApi {
  GlobeApi({
    required this.metadata,
    required this.auth,
    required this.logger,
  });

  Map<String, String> get headers {
    final currentSession = auth.currentSession;

    return {
      'X-Globe-Platform': 'globe_cli',
      'X-Globe-Platform-Version': package_info.version,
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
  Object? _handleResponse(http.Response response) {
    try {
      // Let the decode throw on invalid json.
      final json = jsonDecode(response.body) as Map<String, Object?>;

      if (response.statusCode == 200) return json['data'];

      throw ApiException._(response.statusCode, json['message']! as String);
    } catch (e) {
      var message =
          'Globe API Error.\nThere was an issue calling the Globe API, please try again.\n';
      logger.err(
        '$message Use verbose mode using the --verbose flag for more details.',
      );
      message =
          'If this issue persists please contact support and provide these logs.\n'
          '---\n'
          '"Status Code": ${response.statusCode}\n\n'
          '"Headers":${response.headers.entries.fold('', (acc, v) => '$acc\n${v.key}: ${v.value}')}\n\n'
          '"Body":\n${response.body}';
      logger.detail(message);
      if (e is FormatException) {
        throw ApiException._(response.statusCode, 'Invalid JSON response');
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
    requireAuth();
    final path = '/orgs/$orgId/projects/$projectId/settings';
    final uri = _buildUri(path);
    logger.detail('API Request: PUT $path');

    final request = http.Request('PUT', uri);
    request.headers.addAll(headers);

    request.body = jsonEncode(settings.toJson());

    _handleResponse(
      await request.send().then(http.Response.fromStream),
    )! as Map<String, Object?>;
  }

  /// Gets all of the organizations that the current user is a member of.
  Future<List<Organization>> getOrganizations() async {
    requireAuth();
    logger.detail('API Request: GET /user/orgs');
    final response = _handleResponse(
      await http.get(_buildUri('/user/orgs'), headers: headers),
    )! as List<Object?>;

    return response
        .cast<Map<String, Object?>>()
        .map(Organization.fromJson)
        .toList();
  }

  /// Gets all of the projects that the current user is a member of.
  Future<List<Project>> getProjects({
    required String org,
  }) async {
    requireAuth();
    logger.detail('API Request: GET /orgs/$org/projects');
    final response = _handleResponse(
      await http.get(_buildUri('/orgs/$org/projects'), headers: headers),
    )! as List<Object?>;
    return response.cast<Map<String, Object?>>().map(Project.fromJson).toList();
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

    final response = _handleResponse(
      await request.send().then(http.Response.fromStream),
    )! as Map<Object?, Object?>;

    return Project.fromJson(response);
  }

  Future<FrameworkPresetOptions?> discoverPreset(String pubspecContent) async {
    const path = '/preset-discovery';
    logger.detail('API Request: POST $path');
    final request = http.Request('POST', _buildUri(path));

    request.headers.addAll(headers);
    request.headers['Content-Type'] = 'text/plain';
    request.body = pubspecContent;

    final response = _handleResponse(
      await request.send().then(http.Response.fromStream),
    ) as Map<Object?, Object?>?;

    if (response == null) return null;

    return FrameworkPresetOptions.fromJson(response);
  }

  Future<Deployment> getDeployment({
    required String orgId,
    required String projectId,
    required String deploymentId,
  }) async {
    requireAuth();
    logger.detail(
      'API Request: GET /orgs/$orgId/projects/$projectId/deployments/$deploymentId',
    );
    final response = _handleResponse(
      await http.get(
        _buildUri('/orgs/$orgId/projects/$projectId/deployments/$deploymentId'),
        headers: headers,
      ),
    )! as Map<Object?, Object?>;

    return Deployment.fromJson(response);
  }

  /// Deploy the current project to the given project.
  Future<Deployment> deploy({
    required String orgId,
    required String projectId,
    required DeploymentEnvironment environment,
    required List<int> archive,
  }) async {
    requireAuth();
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

    final response = _handleResponse(
      await request.send().then(http.Response.fromStream),
    )! as Map<Object?, Object?>;

    return Deployment.fromJson(response);
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
        throw const FormatException('Settings');
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
        throw const FormatException('SettingsConnection');
    }
  }

  final String owner;
  final String repository;
  final String branch;
}

class Organization {
  Organization._({
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
        Organization._(
          id: id,
          name: name,
          slug: slug,
          type: OrganizationType.fromString(type),
          // role: Role.fromString(role),
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        ),
      _ => throw const FormatException('Organization'),
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
  Project._({
    required this.id,
    required this.orgId,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project.fromJson(Map<dynamic, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'organizationId': final String organizationId,
        'slug': final String slug,
        'createdAt': final String createdAt,
        'updatedAt': final String updatedAt,
      } =>
        Project._(
          id: id,
          orgId: organizationId,
          slug: slug,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        ),
      _ => throw const FormatException('Project'),
    };
  }

  final String id;
  final String orgId;
  final String slug;
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
    required this.message,
    required this.url,
    required this.hash,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
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
          message: message ?? '',
          url: url,
          hash: hash,
          active: active,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt),
        ),
      _ => throw const FormatException('Deployment'),
    };
  }

  final String id;
  final String projectId;
  final DeploymentEnvironment environment;
  final String status;
  final DeploymentState state;
  final String message;
  final String url;
  final String hash;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
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
  });

  factory FrameworkPresetOptions.fromJson(Map<dynamic, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'name': final String name,
        'buildCommand': final String buildCommand,
        'entrypoint': final String entrypoint,
      } =>
        FrameworkPresetOptions(
          id: id,
          name: name,
          buildCommand: buildCommand,
          entrypoint: entrypoint,
        ),
      _ => throw const FormatException('FrameworkPresetOptions'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'buildCommand': buildCommand,
      'entrypoint': entrypoint,
    };
  }

  final String id;
  final String name;
  final String buildCommand;
  final String entrypoint;
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
