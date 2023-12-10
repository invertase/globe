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
  }

  @override
  String get description => 'View build logs for a given deployment ID.';

  @override
  String get name => 'build-logs';

  @override
  Future<int> run() async {
    requireAuth();

    if (!scope.hasScope()) {
      logger.err('Not a Globe project.');
    }

    final validated = await scope.validate();
    final deploymentId = argResults!['deployment'] as String?;

    if (deploymentId == null) {
      logger.err('No deployment ID provided.');
      printUsage();

      return ExitCode.software.code;
    }

    final logs = await streamBuildLogs(
      api: api,
      orgId: validated.organization.id,
      projectId: validated.project.id,
      deploymentId: deploymentId,
    );

    await printLogs(logger, logs);

    return ExitCode.success.code;
  }
}
