import 'package:cli_table/cli_table.dart';
import 'package:mason_logger/mason_logger.dart';

import '../command.dart';
import '../utils/prompts.dart';

/// `globe logout`
///
/// Links the local project to a Globe project.
class LinkCommand extends BaseGlobeCommand {
  LinkCommand() {
    argParser.addFlag(
      'show-all',
      help: 'Show all linked projects',
      negatable: false,
    );
  }

  @override
  String get description => 'Link this local project to a Globe project.';

  @override
  String get name => 'link';

  @override
  Future<int> run() async {
    final showLinked = argResults!['show-all'] as bool;
    if (showLinked) {
      final linkedProjects = scope.workspace;
      if (linkedProjects.isEmpty) return ExitCode.success.code;

      final table = Table(
        header: [
          cyan.wrap('Project'),
          cyan.wrap('Project ID'),
          cyan.wrap('Organization ID'),
        ],
        columnWidths: [30, 30, 30],
      );
      for (final project in linkedProjects) {
        table.add([
          project.projectSlug,
          project.projectId,
          project.orgId,
        ]);
      }

      logger.info(table.toString());
      return ExitCode.success.code;
    }

    requireAuth();

    await linkProject(logger: logger, api: api);
    return ExitCode.success.code;
  }
}
