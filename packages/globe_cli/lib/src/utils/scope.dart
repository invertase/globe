import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import '../exit.dart';
import 'api.dart';
import 'prompts.dart';
import 'metadata.dart';

/// A utility class for managing the user's local project.
class GlobeScope {
  GlobeScope({
    required this.logger,
    required this.api,
    required this.metadata,
  });

  File get _projectFile {
    return File(
      p.join(
        _projectDirectory.path,
        metadata.projectFileName,
      ),
    );
  }

  /// The current project metadata, or `null` if the project has not been setup.
  ///
  /// Use [validate] instead if you're looking to read the current project metadata.
  @protected
  ScopeMetadata? get current => _current;
  ScopeMetadata? _current;

  late final _projectDirectory = Directory(
    p.join('.dart_tool', 'dart_globe'),
  );
  final Logger logger;
  final GlobeApi api;
  final GlobeMetadata metadata;

  /// Sets the current project scope.
  ScopeMetadata setScope({required String orgId, required String projectId}) {
    final result = _current = ScopeMetadata(orgId: orgId, projectId: projectId);
    _projectFile.createSync(recursive: true);
    _projectFile.writeAsStringSync(json.encode(_current!.toJson()));

    return result;
  }

  bool hasScope() {
    return current != null;
  }

  Future<Organization> _findOrg(ArgResults? argResults) async {
    final orgId = argResults?['org'] ?? current?.orgId;

    if (orgId is! String) return selectOrganization(logger: logger, api: api);

    final organizations = await api.getOrganizations();
    return organizations.firstWhere(
      (org) => org.id == orgId,
      orElse: () => throw Exception(
        'Organization #$orgId not found. '
        'Either that organization does not exists or you do not have permission to access to it.',
      ),
    );
  }

  Future<Project> _findProject(
    ArgResults? argResults,
    Organization org,
  ) async {
    final projectId = argResults?['project'] ?? current?.projectId;

    if (projectId is! String) {
      return selectProject(org, logger: logger, api: api);
    }

    final projects = await api.getProjects(org: org.id);
    return projects.firstWhere(
      (project) => project.id == projectId,
      orElse: () => throw Exception(
        'Project #$projectId not found. '
        'Either that project does not exists or you do not have permission to access to it.',
      ),
    );
  }

  Future<ScopeValidation> validate(ArgResults? argResults) async {
    try {
      final organization = await _findOrg(argResults);
      final project = await _findProject(argResults, organization);

      logger.detail('Validated scope: ${organization.slug}/${project.slug}');

      return ScopeValidation(
        organization: organization,
        project: project,
      );
    } on ApiException catch (e) {
      logger.err(e.message);
      exitOverride(1);
    } catch (e) {
      logger.err(e.toString());
      exitOverride(1);
    }
  }

  /// Clears the current project metadata.
  void clear() {
    _current = null;
    if (_projectFile.existsSync()) {
      _projectFile.deleteSync(recursive: true);
    }
  }

  /// Sets the current scope metadata.
  void loadScope() {
    if (_projectFile.existsSync()) {
      try {
        final contents = _projectFile.readAsStringSync();
        _current = ScopeMetadata.fromJson(
          json.decode(contents) as Map<String, dynamic>,
        );
      } catch (_) {
        // TODO(rrousselGit) why are we catching and ignoring errors?
      }
    }
  }
}

class ScopeValidation {
  ScopeValidation({
    required this.organization,
    required this.project,
  });

  final Organization organization;
  final Project project;
}

/// A data class containing the current project metadata.
class ScopeMetadata {
  /// Creates a new [ScopeMetadata] instance.
  const ScopeMetadata({
    required this.orgId,
    required this.projectId,
  });

  /// Creates a new [ScopeMetadata] instance from the given [json].
  factory ScopeMetadata.fromJson(Map<String, dynamic> json) {
    return ScopeMetadata(
      orgId: json['orgId'] as String,
      projectId: json['projectId'] as String,
    );
  }

  /// The organization ID this project belongs to.
  final String orgId;

  /// The project ID, which belongs to the org.
  final String projectId;

  /// Converts this [ScopeMetadata] instance to a JSON map.
  Map<String, dynamic> toJson() => {'orgId': orgId, 'projectId': projectId};
}
