import 'dart:async';

import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:mason_logger/mason_logger.dart';

import '../command.dart';
import '../graphql/client.dart';
import '../graphql/operations/me.graphql.dart';

class WhoamiCommand extends BaseGlobeCommand {
  @override
  String get description => 'Show the current user.';

  @override
  String get name => 'whoami';

  GlobeGraphQLClient get graphqlClient => GetIt.I();

  @override
  FutureOr<int>? run() async {
    requireAuth();

    final progress = logger.progress('Fetching user information');
    try {
      final result = await graphqlClient.client.query(
        Options$Query$Me(),
      );

      if (result.hasException) {
        if (result.exception?.graphqlErrors.any(
              (error) => error.extensions?['code'] == 'UNAUTHORIZED',
            ) ??
            false) {
          progress.fail('Not logged in');
        } else {
          progress.fail('Failed to fetch user information');
          logger.err(result.exception.toString());
        }
        return ExitCode.software.code;
      }

      final data = Query$Me.fromJson(result.data!);
      final user = data.me;
      if (user == null) {
        progress.fail('Not logged in');
        return ExitCode.software.code;
      }

      progress.complete('User information fetched');

      logger
        ..info('')
        ..info('User Information:')
        ..info('  ${lightCyan.wrap('ID:')}        ${user.id}')
        ..info('  ${lightCyan.wrap('Name:')}      ${user.name}')
        ..info('  ${lightCyan.wrap('Email:')}     ${user.email}')
        ..info('  ${lightCyan.wrap('Created:')}   ${user.createdAt.toLocal()}')
        ..info('');

      // Display linked projects information
      final linkedProjects = scope.workspace;
      if (linkedProjects.isNotEmpty) {
        logger
          ..info('Linked Projects:')
          ..info('');

        for (final project in linkedProjects) {
          final orgName = user.organizations
              ?.firstWhereOrNull((org) => org.id == project.orgId)
              ?.name;

          logger
              .info('  ${lightCyan.wrap('Project:')}   ${project.projectSlug}');
          logger.info(
            '  ${lightCyan.wrap('Org:')}       ${orgName ?? project.orgId}',
          );
          logger.info('');
        }
      } else {
        logger
          ..info('No linked projects.')
          ..info('  Run ${cyan.wrap('globe link')} to link a project.')
          ..info('');
      }

      return ExitCode.success.code;
    } catch (e) {
      progress.fail('Failed to fetch user information');
      logger.err(e.toString());
      return ExitCode.software.code;
    }
  }
}
