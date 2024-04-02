import 'dart:convert';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

import '../exit.dart';
import 'api.dart';
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

  Future<ScopeValidation> validate() async {
    final metadata = current;

    if (metadata == null) {
      logger.err('Unable to validate project, no project metadata found.');
      exitOverride(1);
    }

    final Organization organization;
    final Project project;

    try {
      final organizations = await api.getOrganizations();
      organization = organizations.firstWhere(
        (org) => org.id == metadata.orgId,
        orElse: () => throw Exception(
          'Organization #${metadata.orgId} not found. '
          'Either that organization does not exists or you do not have permission to access to it.',
        ),
      );

      final projects = await api.getProjects(org: organization.id);
      project = projects.firstWhere(
        (project) => project.id == metadata.projectId,
        orElse: () => throw Exception(
          'Project #${metadata.projectId} not found. '
          'Either that project does not exists or you do not have permission to access to it.',
        ),
      );

      if (project.paused) {
        throw Exception(
          'Project #${metadata.projectId} is paused. '
          'So, new deployments cannot be created for this project.',
        );
      }
    } on ApiException catch (e) {
      logger.err(e.message);
      exitOverride(1);
      // TODO(rrousselGit) why do we catch Exceptions but not Errors?
    } on Exception catch (e) {
      logger.err(e.toString());
      exitOverride(1);
    }

    logger.detail('Validated scope: ${organization.slug}/${project.slug}');

    return ScopeValidation(
      organization: organization,
      project: project,
    );
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
