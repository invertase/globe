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
        help: 'Specify name to identity token.',
      )
      ..addOption(
        'expiry',
        abbr: 'e',
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

    final organization = await selectOrganization(logger: logger, api: api);
    final name = argResults?['name']?.toString() ??
        logger.prompt('❓ Provide name for token:');
    final dateString = argResults?['expiry']?.toString() ??
        logger.prompt('❓ Set Expiry (yyyy-mm-dd):',
            defaultValue: _getDefaultDate());

    final expiry = _parseTokenExpiryStr(dateString);
    if (expiry == null) {
      logger.err(
        'Invalid date.\nDate format should be ${cyan.wrap('2012-02-27')} or ${cyan.wrap('2012-02-27 13:27:00')}',
      );
      exitOverride(1);
    }

    final projects = await selectProjects(
      'Select projects to associate token with:',
      organization,
      logger: logger,
      api: api,
      scope: scope,
      ids: argResults?['project'] as List<String>?,
    );
    final projectNames = projects.map((e) => cyan.wrap(e.slug)).join(', ');

    final createTokenProgress =
        logger.progress('Creating Token for $projectNames');

    try {
      final token = await api.createToken(
        orgId: organization.id,
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

DateTime? _parseTokenExpiryStr(String dateStr) {
  final parsedDate = DateTime.tryParse(dateStr);
  if (parsedDate == null) return null;

  final parts = dateStr.split('-');
  if (parsedDate.year != int.parse(parts[0]) ||
      parsedDate.month != int.parse(parts[1]) ||
      parsedDate.day != int.parse(parts[2])) {
    return null;
  }

  if (parsedDate.isBefore(DateTime.now().add(const Duration(hours: 2)))) {
    return null;
  }

  return parsedDate;
}

String _getDefaultDate() {
  final yearFromNow = DateTime.now().add(const Duration(days: 365));

  final year = yearFromNow.year;
  final month = yearFromNow.month.toString().padLeft(2, '0');
  final day = yearFromNow.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}
