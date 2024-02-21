import 'dart:async';

import 'package:mason_logger/mason_logger.dart';

import '../../command.dart';
import '../../utils/api.dart';

class TokenListCommand extends BaseGlobeCommand {
  @override
  String get description => 'List globe auth tokens for current project';

  @override
  String get name => 'list';

  @override
  FutureOr<int>? run() async {
    requireAuth();

    final validated = await scope.validate();
    final projectName = cyan.wrap(validated.project.slug);

    final listTokenProgress =
        logger.progress('Listing Tokens for $projectName');

    try {
      final tokens = await api.listTokens(
        orgId: validated.organization.id,
        projectUuids: [validated.project.id],
      );
      if (tokens.isEmpty) {
        listTokenProgress.fail('No Tokens found for $projectName');
        return ExitCode.success.code;
      }

      String tokenLog(Token token) => '''
----------------------------------
  ID:       ${cyan.wrap(token.uuid)}
  Name:     ${token.name}
  Expiry:   ${token.expiresAt.toLocal()}''';

      listTokenProgress.complete(
        'Tokens for $projectName\n${tokens.map(tokenLog).join('\n')}',
      );

      return ExitCode.success.code;
    } on ApiException catch (e) {
      listTokenProgress.fail('✗ Failed to create token: ${e.message}');
      return ExitCode.software.code;
    } catch (e, s) {
      listTokenProgress.fail('✗ Failed to create token: $e');
      logger.detail(s.toString());
      return ExitCode.software.code;
    }
  }
}
