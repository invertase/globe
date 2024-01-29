import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';

import '../exit.dart';
import 'api.dart';
import 'auth.dart';
import 'env.dart';
import 'project_settings.dart';
import 'scope.dart';

/// Prompts the user to link the current local project to a Globe project.
///
/// This creates a `dart_globe/project.json` file in the `.dart_tool` directory
/// which is used to determine the current project scope.
Future<ScopeMetadata> linkProject({
  required Logger logger,
  required GlobeApi api,
}) async {
  // TODO inject as function parameter
  final scope = GetIt.I<GlobeScope>();

  if (scope.hasScope()) {
    if (!logger.confirm(
      '❓ Project already linked, would you like to link to a different project?',
    )) {
      exitOverride(0);
    }
  } else {
    if (!logger.confirm(
      '❓ Link this project to Globe ${cyan.wrap('"${Directory.current.path}"')}?',
      defaultValue: true,
    )) {
      exitOverride(0);
    }
  }

  try {
    final organization = await selectOrganization(
      logger: logger,
      api: api,
    );

    final project = await selectProject(
      organization,
      logger: logger,
      api: api,
      scope: scope,
    );

    final result = scope.setScope(
      orgId: organization.id,
      projectId: project.id,
    );
    logger.success('''
  Successfully linked project.
''');
    logger.write(
      '   To unlink this project in the future run: ${cyan.wrap('globe unlink')}\n',
    );

    return result;
  } on ApiException catch (e) {
    logger.err(e.message);
    exitOverride(1);
  } catch (e) {
    logger.err(e.toString());
    exitOverride(1);
  }
}

/// Prompts the user to select an organization they are a member of.
///
/// If the user is only a memeber of 1, it will automatically be selected.
Future<Organization> selectOrganization({
  required Logger logger,
  required GlobeApi api,
}) async {
  logger.detail('Fetching user organizations');
  final organizations = await api.getOrganizations();
  logger.detail('Found ${organizations.length} organizations');

  if (organizations.isEmpty) {
    logger.detail(
      'No organizations found, this is likely a new account which is still being setup. Please try again in a few seconds.',
    );
    logger.err('Your account is still being setup, please try again.');
    exitOverride(1);
  }

  /// If there's only one, automatically select it.
  if (organizations.length == 1) {
    final organization = organizations.first;
    logger.detail('Automatically selecting ${organization.name}.');
    return organization;
  }

  // Otherwise let the user select one.
  final selectedOrg = logger.chooseOne(
    'Please select an organization:',
    choices: organizations.map((o) => o.id).toList(),
    display: (choice) => organizations.firstWhere((o) => o.id == choice).name,
  );

  return organizations.firstWhere((o) => o.id == selectedOrg);
}

/// Prompts the user to select a project they have access to, in the provided
/// [organization].
Future<Project> selectProject(
  Organization organization, {
  required Logger logger,
  required GlobeApi api,
  required GlobeScope scope,
}) async {
  logger.detail('Fetching organization projects');
  final projects = await api.getProjects(org: organization.id);
  logger.detail('Found ${projects.length} projects');

  String selectRootDirectory() {
    final rootDirectory = logger.prompt(
      '❓ Specify which directory your project is in:',
      defaultValue: './',
    );

    if (rootDirectory.contains('..')) {
      logger.info(
        red.wrap(
          ' The root directory cannot be a parent directory, please try again.',
        ),
      );
      return selectRootDirectory();
    }

    final directory = Directory(
      p.join(Directory.current.path, rootDirectory),
    );

    if (!directory.existsSync()) {
      logger.info(
        red.wrap(
          '   The directory "$rootDirectory" does not exist, please try again.',
        ),
      );
      return selectRootDirectory();
    }

    return rootDirectory;
  }

  Future<Project> createProject() async {
    final rootDirectory = selectRootDirectory();
    final rootDirectoryDir = Directory(rootDirectory);

    final pubspecFile = File(
      p.join(rootDirectoryDir.absolute.path, 'pubspec.yaml'),
    );

    if (!pubspecFile.existsSync()) {
      logger.info(
        red.wrap(
          '   The directory "$rootDirectory" does not contain a pubspec.yaml file, please try again.',
        ),
      );
      return createProject();
    }

    final pubspecContent = pubspecFile.readAsStringSync();
    final parsed = Pubspec.parse(pubspecContent);

    final name = logger.prompt(
      '❓ Enter the name of the project:',
      defaultValue: parsed.name,
    );

    final discoveredPreset = await api.discoverPreset(pubspecContent);

    String? buildCommand;
    String? entrypoint;

    if (discoveredPreset != null) {
      final useDefaultSettings = logger.confirm(
        '❓ Detected "${discoveredPreset.name}" preset, would you like to use the default build settings?',
        defaultValue: true,
      );

      if (!useDefaultSettings) {
        buildCommand = logger.prompt(
          '❓ Enter a build command:',
          defaultValue: discoveredPreset.buildCommand,
        );

        entrypoint = logger.prompt(
          '❓ Enter a Dart entrypoint file:',
          defaultValue: discoveredPreset.entrypoint,
        );

        // If it's the same as the preset, don't send it.
        buildCommand =
            buildCommand == discoveredPreset.buildCommand ? null : buildCommand;
        entrypoint =
            entrypoint == discoveredPreset.entrypoint ? null : entrypoint;
      }
    } else {
      if (logger.confirm('❓ Would you like to run a custom build command?')) {
        buildCommand = logger.prompt(
          '❓ Enter a build command:',
        );
      }

      entrypoint = logger.prompt(
        '❓ Enter a Dart entrypoint file:',
        defaultValue: 'lib/main.dart',
      );
    }

    final envVarFile = File(
      p.join(
        rootDirectoryDir.absolute.path,
        '.env',
      ),
    );

    Map<String, String>? environmentVariables;

    if (envVarFile.existsSync()) {
      final uploadEnvVars = logger.chooseOne(
        '❓ An .env file was detected, would you like to:',
        choices: ['ignore', 'upload', 'modify'],
        display: (choice) {
          switch (choice) {
            case 'ignore':
              return 'Ignore local environment variables';
            case 'upload':
              return 'Upload local environment variables';
            case 'modify':
              return 'Upload environment variables with new values';
          }

          throw ArgumentError.value(choice, 'choice', 'Invalid choice');
        },
        defaultValue: 'ignore',
      );

      if (uploadEnvVars == 'upload') {
        environmentVariables = getEnvironmentVariables(envVarFile);
      }

      if (uploadEnvVars == 'modify') {
        getEnvironmentVariables(envVarFile).forEach((key, value) {
          final newValue = logger.prompt(
            '❓ Enter a value for "$key":',
            defaultValue: value,
          );

          environmentVariables ??= {};
          environmentVariables![key] = newValue;
        });
      }
    }

    final project = await api.createProject(
      orgId: organization.id,
      name: name,
    );

    await api.updateSettings(
      projectId: project.id,
      orgId: project.orgId,
      settings: ProjectSettings(
        rootDirectory: rootDirectory == './' ? null : rootDirectory,
        preset: discoveredPreset?.id,
        buildCommand: buildCommand,
        entrypoint: entrypoint,
        environmentVariables: environmentVariables,
      ),
    );

    return project;
  }

  if (projects.isEmpty) {
    logger.detail('No projects found, prompting to create a new project');
    return createProject();
  }

  const createSymbol = '__CREATE_PROJECT';

  // Select a project or create a new one.
  final selectedProject = logger.chooseOne(
    '❓ Please select a project you want to deploy to:',
    choices: [
      if (api.auth.currentSession?.authenticationMethod !=
          AuthenticationMethod.apiToken)
        createSymbol,
      ...projects.map((p) => p.id),
    ],
    display: (choice) {
      if (choice == createSymbol) {
        return 'Create a new project';
      }

      return projects.firstWhere((p) => p.id == choice).slug;
    },
  );

  // If the user selected to create a new project, prompt to create one.
  if (selectedProject == createSymbol) {
    return createProject();
  }

  return projects.firstWhere((p) => p.id == selectedProject);
}
