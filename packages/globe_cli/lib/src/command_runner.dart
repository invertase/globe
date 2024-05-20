import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cli_completion/cli_completion.dart';
import 'package:get_it/get_it.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

import 'commands/build_logs_command.dart';
import 'commands/commands.dart';
import 'commands/project_command.dart';
import 'commands/update.dart';
import 'package_info.dart' as package_info;
import 'utils/api.dart';
import 'utils/auth.dart';
import 'utils/http_server.dart';
import 'utils/metadata.dart';
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
      ..addFlag(
        'local',
        help: 'Switches the CLI to use a locally running API.',
        hide: true,
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
      if (topLevelResults['local'] == true) {
        _logger.warn(
          'You are using a local API. Remove the --local flag to use the production API.',
        );
        metadata = GlobeMetadata.local;
      } else {
        metadata = GlobeMetadata.remote;
      }

      if (topLevelResults.command?.name != 'update') {
        await _checkForUpdates();
      }

      final auth = GlobeAuth(metadata);
      final api = GlobeApi(
        metadata: metadata,
        auth: auth,
        logger: _logger,
      );
      final scope = GlobeScope(
        api: api,
        metadata: metadata,
        logger: _logger,
      );
      GetIt.instance.registerSingleton<GlobeAuth>(auth);
      GetIt.instance.registerSingleton<GlobeApi>(api);
      GetIt.instance.registerSingleton<GlobeMetadata>(metadata);
      GetIt.instance.registerSingleton<GlobeScope>(scope);

      // Load the current project scope.
      scope.loadScope();
      auth.loadSession();

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
