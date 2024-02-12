import 'dart:async';

import 'package:mason_logger/mason_logger.dart';

import '../../command.dart';
import '../../exit.dart';
import '../../utils/api.dart';
import '../../utils/prompts.dart';

class TokenCreateCommand extends BaseGlobeCommand {
  TokenCreateCommand() {
    argParser
      ..addOption(
        'name',
        abbr: 'n',
        mandatory: true,
        help: 'Specify name to identity token.',
      )
      ..addOption(
        'expiry',
        abbr: 'e',
        mandatory: true,
        help: 'Specify lifespan of token.',
      )
      ..addMultiOption(
        'project',
        help: 'Specify projects(s) to associate token with.',
      );
  }

  @override
  String get description => 'Create globe auth token.';

  @override
  String get name => 'create';

  @override
  FutureOr<int> run() async {
    requireAuth();

    final name = argResults?['name'] as String;
    final projectIds = argResults?['project'] as List<String>?;
    final dateString = argResults?['expiry'] as String;
    final expiry = DateTime.tryParse(dateString)?.toUtc();
    if (expiry == null) {
      logger.err(
        'Invalid date format.\nDate format should be ${cyan.wrap('2012-02-27')} or ${cyan.wrap('2012-02-27 13:27:00"')}',
      );
      exitOverride(1);
    }

    final validated = await scope.validate();

    final projects = await selectProjects(
      validated.organization,
      logger: logger,
      api: api,
      scope: scope,
      ids: projectIds,
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
        name: name,
        projectUuids: projects.map((e) => e.id).toList(),
        expiresAt: expiry,
      );
      createTokenProgress.complete(
        "Here's your token:\nID: ${cyan.wrap(token.id)}\nToken: ${cyan.wrap(token.value)}",
      );
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
