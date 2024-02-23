import 'dart:async';

import 'package:mason_logger/mason_logger.dart';

import '../../command.dart';
import '../../utils/api.dart';
import '../../utils/prompts.dart';

class TokenListCommand extends BaseGlobeCommand {
  TokenListCommand() {
    argParser.addOption(
      'project',
      help: 'Specify project to list token for.',
    );
  }
  @override
  String get description => 'List globe auth tokens for current project';

  @override
  String get name => 'list';

  @override
  FutureOr<int>? run() async {
    requireAuth();

    final organization = await selectOrganization(logger: logger, api: api);
    final projectUuidsFromArgs = argResults?['project'] as String?;

    final projects = await selectProjects(
      'Select projects to list tokens for:',
      organization,
      logger: logger,
      api: api,
      scope: scope,
      ids: projectUuidsFromArgs == null ? null : [projectUuidsFromArgs],
    );

    final projectNames = projects.map((e) => cyan.wrap(e.slug)).join(', ');
    final listTokenProgress = logger.progress(
      'Listing Tokens for $projectNames',
    );

    try {
      final tokens = await api.listTokens(
        orgId: organization.id,
        projectUuids: projects.map((e) => e.id).toList(),
      );
      if (tokens.isEmpty) {
        listTokenProgress.fail('No Tokens found for $projectNames');
        return ExitCode.success.code;
      }

      String tokenLog(Token token) => '''
----------------------------------
  ID:       ${cyan.wrap(token.uuid)}
  Name:     ${token.name}
  Expiry:   ${token.expiresAt.toLocal()}''';

      listTokenProgress.complete(
        'Tokens for $projectNames\n${tokens.map(tokenLog).join('\n')}',
      );

      return ExitCode.success.code;
    } on ApiException catch (e) {
      listTokenProgress.fail('✗ Failed to list tokens: ${e.message}');
      return ExitCode.software.code;
    } catch (e, s) {
      listTokenProgress.fail('✗ Failed to list tokens: $e');
      logger.detail(s.toString());
      return ExitCode.software.code;
    }
  }
}
