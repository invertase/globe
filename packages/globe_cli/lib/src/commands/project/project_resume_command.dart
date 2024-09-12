import 'dart:async';

import 'package:mason_logger/mason_logger.dart';

import '../../command.dart';
import '../../utils/api.dart';

class ProjectResumeCommand extends BaseGlobeCommand {
  ProjectResumeCommand() {
    _validator = declareScopeArguments();
  }

  @override
  String get description => 'Resume the current globe project';

  @override
  String get name => 'resume';

  late final ScopeValidator _validator;

  @override
  FutureOr<int> run() async {
    requireAuth();

    final validated = await _validator();
    final projectSlug = validated.project.slug;
    final pauseProjectProgress =
        logger.progress('Resuming project: ${cyan.wrap(projectSlug)}');

    try {
      await api.resumeProject(
        orgSlug: validated.organization.slug,
        projectSlug: validated.project.slug,
      );

      pauseProjectProgress
          .complete('Your project: ${cyan.wrap(projectSlug)} is now resumed');
      return ExitCode.success.code;
    } on ApiException catch (e) {
      pauseProjectProgress.fail('✗ Failed to pause project: ${e.message}');
      return ExitCode.software.code;
    } catch (e, s) {
      pauseProjectProgress.fail('✗ Failed to resume project: $e');
      logger.detail(s.toString());
      return ExitCode.software.code;
    }
  }
}
