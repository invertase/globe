import 'dart:async';

import 'package:cli_table/cli_table.dart';
import 'package:mason_logger/mason_logger.dart';

import '../../command.dart';
import '../../utils/api.dart';

class TokenListCommand extends BaseGlobeCommand {
  @override
  String get description => 'List globe auth tokens for project(s)';

  @override
  String get name => 'list';

  @override
  FutureOr<int>? run() async {
    requireAuth();
    await scope.selectOrLinkNewScope();

    final projectName = scope.current!.projectSlug;
    final listTokenProgress =
        logger.progress('Listing tokens for $projectName');

    try {
      final tokens = await api.listTokens(
        orgId: scope.current!.orgId,
        projectUuids: [scope.current!.projectId],
      );
      if (tokens.isEmpty) {
        listTokenProgress.fail('No Tokens found for $projectName');
        return ExitCode.success.code;
      }

      final table = Table(
        header: [
          cyan.wrap('ID'),
          cyan.wrap('Name'),
          cyan.wrap('Expiry'),
        ],
        columnWidths: [
          tokens.first.uuid.length + 2,
          tokens.first.name.length + 2,
          25,
        ],
      );

      for (final token in tokens) {
        table.add([
          token.uuid,
          token.name,
          token.expiresAt.toLocal().toIso8601String(),
        ]);
      }

      listTokenProgress.complete(
        'Found ${tokens.length} ${tokens.length > 1 ? 'tokens' : 'token'}',
      );

      logger.info(table.toString());

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
