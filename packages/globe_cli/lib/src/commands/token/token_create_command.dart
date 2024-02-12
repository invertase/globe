import 'dart:async';

import 'package:mason_logger/mason_logger.dart';

import '../../command.dart';
import '../../utils/api.dart';
import '../../utils/prompts.dart';

class TokenCreateCommand extends BaseGlobeCommand {
  TokenCreateCommand() {
    argParser
      ..addOption(
        'name',
        // abbr: 'n',
        help: 'Specify name to identity token.',
      )
      ..addOption(
        'expiry',
        // abbr: 'x',
        help: 'Specify lifespan of token.',
      )
      ..addOption(
        'project',
        // abbr: 'p',
        help: 'Specify projects(s) to associate token with.',
      );
  }

  @override
  String get description => 'Create auth tokens for your projects.';

  @override
  String get name => 'create';

  @override
  FutureOr<int> run() async {
    requireAuth();

    final validated = await scope.validate();

    final projects = await selectProjects(
      validated.organization,
      logger: logger,
      api: api,
      scope: scope,
    );
    if (projects.isEmpty) {
      return ExitCode.software.code;
    }

    final projectNames = projects.map((e) => cyan.wrap(e.slug)).join(', ');
    final createTokenProgress =
        logger.progress('Creating Token for $projectNames');

    try {
      final token = await api.createToken(
        orgId: validated.organization.slug,
        name: 'New Token',
        projectUuids: projects.map((e) => e.id).toList(),
        expiresAt: DateTime(2024, 12),
      );
      createTokenProgress.complete("Here's your token: ${cyan.wrap(token)}");
      return ExitCode.success.code;
    } on ApiException catch (e) {
      createTokenProgress.fail('✗ Failed to create token: ${e.message}');
      return ExitCode.software.code;
    } catch (e, s) {
      createTokenProgress.fail('✗ Failed to create token: $e');
      logger.detail(s.toString());
      return ExitCode.software.code;
    }
  }
}
