import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:get_it/get_it.dart';
import 'package:mason_logger/mason_logger.dart';

import 'exit.dart';
import 'utils/api.dart';
import 'utils/auth.dart';
import 'utils/metadata.dart';
import 'utils/scope.dart';

typedef StartProcess = Future<Process> Function(
  String executable,
  List<String> arguments, {
  bool runInShell,
});

typedef RunProcess = Future<ProcessResult> Function(
  String executable,
  List<String> arguments, {
  bool runInShell,
});

typedef ScopeValidator = Future<ScopeValidation> Function();

abstract class BaseGlobeCommand extends Command<int> {
  GlobeAuth get auth => GetIt.I();
  GlobeApi get api => GetIt.I();
  GlobeScope get scope => GetIt.I();
  Logger get logger => GetIt.I();
  GlobeMetadata get metadata => GetIt.I();

  /// Checks for a valid auth session.
  void requireAuth() {
    final session = auth.currentSession;
    if (session == null) {
      logger
        ..err('Please login to deploy a project.')
        ..err('Run `globe login` to login.');

      exitOverride(1);
    }

    // TODO(ehesp): Check for JWT expiry and refresh if needed?
  }

  ScopeValidator declareScopeArguments() {
    argParser.addOption(
      'org',
      abbr: 'o',
      help: 'The organization ID used by this command. '
          'Defaults to what was previously linked using `globe link`.',
    );

    return () => scope.validate(argResults);
  }
}
