import 'package:mason_logger/mason_logger.dart';

import '../command.dart';
import '../utils/logs.dart';

class BuildLogsCommand extends BaseGlobeCommand {
  BuildLogsCommand() {
    argParser.addOption(
      'deployment',
      abbr: 'd',
      help: 'Deployment ID.',
    );
    _validator = declareScopeArguments();
  }

  late final ScopeValidator _validator;

  @override
  String get description => 'View build logs for a given deployment ID.';

  @override
  String get name => 'build-logs';

  @override
  Future<int> run() async {
    requireAuth();

    final validated = await _validator();
    final deploymentId = argResults!['deployment'] as String?;

    if (deploymentId == null) {
      logger.err('No deployment ID provided.');
      printUsage();

      return ExitCode.software.code;
    }

    final deployment = await api.getDeployment(
      orgId: validated.organization.id,
      projectId: validated.project.id,
      deploymentId: deploymentId,
    );

    if (deployment.buildId == null) {
      logger.info('Build for $deploymentId has not started yet.');
      return ExitCode.software.code;
    }

    final logs = await streamBuildLogs(
      api: api,
      orgId: validated.organization.id,
      projectId: validated.project.id,
      deploymentId: deploymentId,
      buildId: deployment.buildId!,
    );

    await printLogs(logger, logs);

    return ExitCode.success.code;
  }
}
