import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

import '../exit.dart';
import 'api.dart';
import 'metadata.dart';
import 'prompts.dart';

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

  late final List<ScopeMetadata> workspace;

  ScopeMetadata? get current => _current;
  static ScopeMetadata? _current;
  static ScopeMetadata? get value => _current;

  late final _projectDirectory = Directory(
    p.join('.dart_tool', 'dart_globe'),
  );
  final Logger logger;
  final GlobeApi api;
  final GlobeMetadata metadata;

  ScopeMetadata? _findScope(String projectIdOrSlug, {String? orgId}) {
    return workspace.firstWhereOrNull(
      (e) {
        final hasIdOrSlug =
            e.projectId == projectIdOrSlug || e.projectSlug == projectIdOrSlug;
        if (orgId == null) return hasIdOrSlug;

        return hasIdOrSlug && e.orgId == orgId;
      },
    );
  }

  void _writeWorkspaceToFile() {
    _projectFile
      ..createSync(recursive: true)
      ..writeAsStringSync(const JsonEncoder.withIndent(' ').convert(workspace));
  }

  /// Sets the current project scope.
  ScopeMetadata setScope(ScopeMetadata scope) {
    workspace
      ..removeWhere((e) {
        return e.projectId == scope.projectId && e.orgId == scope.orgId;
      })
      ..add(scope);

    _writeWorkspaceToFile();

    return _current = scope;
  }

  void unlinkScope(ScopeMetadata scope) {
    if (workspace.isEmpty) return;
    workspace.removeWhere(
      (e) => e.orgId == scope.orgId && e.projectId == scope.projectId,
    );

    _writeWorkspaceToFile();
  }

  bool hasScope() {
    return current != null;
  }

  Future<ScopeMetadata> selectOrLinkNewScope({
    bool canLinkNew = true,
  }) async {
    if (hasScope()) return current!;

    final selectedOrg = await selectOrganization(logger: logger, api: api);

    if (workspace.isNotEmpty) {
      const linkNewProjectSymbol = '__LINK_NEW_PROJECT';

      final scopes = workspace.where((p) => p.orgId == selectedOrg.id);
      var selectedProject = linkNewProjectSymbol;

      if (scopes.length > 1) {
        selectedProject = logger.chooseOne(
          '🔺 Select project:',
          choices: [
            ...scopes.map((o) => o.projectId),
            if (canLinkNew) linkNewProjectSymbol,
          ],
          display: (choice) {
            if (choice == linkNewProjectSymbol) {
              return lightYellow.wrap('link new project +')!;
            }
            return scopes.firstWhere((o) => o.projectId == choice).projectSlug;
          },
        );
      } else if (scopes.length == 1) {
        return setScope(scopes.first);
      }

      if (selectedProject != linkNewProjectSymbol) {
        return setScope(
          scopes.firstWhere((scope) => scope.projectId == selectedProject),
        );
      }
    }

    return linkProject(logger: logger, api: api, org: selectedOrg);
  }

  Future<Organization> _findOrg() async {
    final orgId = current?.orgId;
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

  Future<Project> _findProject(Organization org) async {
    final projectId = current?.projectId;
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
      final organization = await _findOrg();
      final project = await _findProject(organization);

      // if name not matching, update the name locally
      if (current!.projectSlug != project.slug) {
        setScope(
          ScopeMetadata(
            orgId: organization.id,
            projectId: project.id,
            projectSlug: project.slug,
          ),
        );
      }

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
  void unlink() {
    if (_current == null) return;
    unlinkScope(_current!);
    _current = null;
  }

  /// Sets the current scope metadata.
  void loadScope({String? projectIdOrSlug}) {
    if (!_projectFile.existsSync()) {
      workspace = [];
      return;
    }

    final contents = _projectFile.readAsStringSync();
    if (contents.trim().isEmpty) {
      workspace = [];
      return;
    }

    final jsonContent = json.decode(contents);
    workspace = switch (jsonContent) {
      Map<String, dynamic>() => [
          ScopeMetadata.fromJson({...jsonContent, 'projectSlug': ''}),
        ],
      List<dynamic>() => jsonContent
          .map((e) => ScopeMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      _ => throw StateError('Invalid workspace schema'),
    };

    if (projectIdOrSlug != null) {
      _current = _findScope(projectIdOrSlug);
    } else if (workspace.length == 1) {
      _current = workspace[0];
    }

    // migrate old schema to new schema
    if (jsonContent is Map<String, dynamic>) {
      _writeWorkspaceToFile();
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
    required this.projectSlug,
  });

  /// Creates a new [ScopeMetadata] instance from the given [json].
  factory ScopeMetadata.fromJson(Map<String, dynamic> json) {
    return ScopeMetadata(
      orgId: json['orgId'] as String,
      projectId: json['projectId'] as String,
      projectSlug: json['projectSlug'] as String,
    );
  }

  /// The organization ID this project belongs to.
  final String orgId;

  /// The project ID, which belongs to the org.
  final String projectId;

  /// The project Slug,
  final String projectSlug;

  /// Converts this [ScopeMetadata] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        'orgId': orgId,
        'projectId': projectId,
        'projectSlug': projectSlug,
      };
}
