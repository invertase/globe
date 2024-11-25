import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cli_completion/cli_completion.dart';
import 'package:get_it/get_it.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

import 'commands/build_logs_command.dart';
import 'commands/commands.dart';
import 'commands/create_project_command.dart';
import 'commands/project_command.dart';
import 'commands/update.dart';
import 'get_it.dart';
import 'package_info.dart' as package_info;
import 'utils/api.dart';
import 'utils/auth.dart';
import 'utils/http_server.dart';
import 'utils/metadata.dart';
import 'utils/prompts.dart';
import 'utils/scope.dart';

class GlobeCliCommandRunner extends CompletionCommandRunner<int> {
  GlobeCliCommandRunner({
    Logger? logger,
    PubUpdater? pubUpdater,
    GlobeHttpServer? httpServer,
  })  : _logger = logger ?? Logger(),
        _pubUpdater = pubUpdater ?? PubUpdater(),
        super(package_info.name, package_info.description) {
    argParser
      ..addFlag(
        'version',
        abbr: 'v',
        negatable: false,
        help: 'Print the current version of the CLI.',
      )
      ..addFlag(
        'verbose',
        help: 'Enables verbose logging.',
      )
      ..addOption(
        'api',
        help: 'Switches the CLI to use a different running API.',
        hide: true,
      )
      ..addOption(
        'token',
        abbr: 't',
        help: 'Set the API token for cli.',
      )
      ..addOption(
        'project',
        abbr: 'p',
        help: 'Set the Project ID used by this command. '
            'Defaults to what was previously linked using `globe link`.',
      )
      ..addOption(
        'org',
        abbr: 'o',
        help: 'Set the Organization ID used by this command. '
            'Defaults to what was previously linked using `globe link`.',
      );

    // Register singleton utils.
    GetIt.instance.registerSingleton<Logger>(_logger);

    addCommand(LoginCommand(httpServer: httpServer));
    addCommand(UpdateCommand(_pubUpdater));
    addCommand(LogoutCommand());
    addCommand(DeployCommand());
    addCommand(LinkCommand());
    addCommand(UnlinkCommand());
    addCommand(BuildLogsCommand());
    addCommand(TokenCommand());
    addCommand(ProjectCommand());
    addCommand(CreateProjectFromTemplate());
  }

  final Logger _logger;
  final PubUpdater _pubUpdater;

  @override
  void printUsage() => _logger.info(usage);

  @override
  Future<int> run(Iterable<String> args) async {
    final GlobeMetadata metadata;

    try {
      final topLevelResults = parse(args);
      if (topLevelResults['verbose'] == true) {
        _logger.level = Level.verbose;
        _logger.detail('Verbose logging enabled.');
      }
      if (topLevelResults['api'] != null) {
        final apiUrl = topLevelResults['api'].toString();

        _logger.warn(
          'You are using a different API. Remove the --api flag to use the production API.',
        );

        metadata = apiUrl == 'local'
            ? GlobeMetadata.local
            : GlobeMetadata(
                endpoint: apiUrl,
                isLocal: apiUrl.contains('localhost'),
              );
      } else {
        metadata = GlobeMetadata.remote;
      }

      if (topLevelResults.command?.name != 'update') {
        await _checkForUpdates();
      }

      final auth = GetIt.instance.singletonPutIfAbsent<GlobeAuth>(
        () => GlobeAuth(metadata),
      );
      final api = GetIt.instance.singletonPutIfAbsent<GlobeApi>(() {
        return GlobeApi(metadata: metadata, auth: auth, logger: _logger);
      });
      final scope = GlobeScope(
        api: api,
        metadata: metadata,
        logger: _logger,
      );

      GetIt.instance.registerSingleton<GlobeMetadata>(metadata);
      GetIt.instance.registerSingleton<GlobeScope>(scope);

      final maybeProjectIdOrSlug = topLevelResults['project'] as String?;
      final maybeToken = topLevelResults['token'] as String?;

      // Load the current project scope.
      auth.loadSession();
      scope.loadScope(projectIdOrSlug: maybeProjectIdOrSlug);

      Organization? org;

      if (maybeToken != null) {
        api.auth.loginWithApiToken(jwt: maybeToken);
        org = await selectOrganization(
          logger: _logger,
          api: api,
          onNoOrganizationsError: () => _logger.err(
            'API Token provided is invalid or is not associated with any organizations.',
          ),
        );
      }

      if (maybeProjectIdOrSlug != null && !scope.hasScope()) {
        org ??= await selectOrganization(logger: _logger, api: api);
        final projects = await api.getProjects(org: org.id);

        final selectedProject = projects.firstWhere(
          (project) =>
              project.id == maybeProjectIdOrSlug ||
              project.slug == maybeProjectIdOrSlug,
          orElse: () =>
              throw Exception('Project #$maybeProjectIdOrSlug not found.'),
        );
        scope.setScope(
          ScopeMetadata(
            orgId: org.id,
            projectId: selectedProject.id,
            projectSlug: selectedProject.slug,
          ),
        );
      }

      return await runCommand(topLevelResults) ?? ExitCode.success.code;
      // TODO(rrousselGit) why are we checking FormatExceptions here?
    } on FormatException catch (e, stackTrace) {
      // On format errors, show the commands error message, root usage and
      // exit with an error code
      _logger
        ..err(e.message)
        ..err('$stackTrace')
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      // On usage errors, show the commands usage message and
      // exit with an error code
      _logger
        ..err(e.message)
        ..info('')
        ..info(e.usage);
      return ExitCode.usage.code;
    } on Exception catch (e) {
      _logger.err(e.toString());
      return ExitCode.software.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] == true) {
      _logger.info('Globe CLI v${package_info.version}');
      return ExitCode.success.code;
    }

    return super.runCommand(topLevelResults);
  }

  // Checks if the current version (set by the build runner on the
  // version.dart file) is the most recent one. If not, show a prompt to the
  // user.
  Future<void> _checkForUpdates() async {
    try {
      // Handles the case where the local version is more recent than
      // the current version
      final isUpToDate = _pubUpdater.isUpToDate(
        packageName: package_info.name,
        currentVersion: package_info.version,
      );

      if (!await isUpToDate) {
        final latestVersion = _pubUpdater.getLatestVersion(package_info.name);
        _logger.info(
          '''

${lightYellow.wrap('Update available!')} ${lightCyan.wrap(package_info.version)} \u2192 ${lightCyan.wrap(await latestVersion)}
Run ${lightCyan.wrap('${package_info.executable} update')} to update
''',
        );
      }
    } catch (_) {}
  }
}
