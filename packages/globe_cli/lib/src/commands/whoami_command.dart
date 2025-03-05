import 'dart:async';

import 'package:mason_logger/mason_logger.dart';

import '../command.dart';

class WhoamiCommand extends BaseGlobeCommand {
  @override
  String get description => 'Show the current user.';

  @override
  String get name => 'whoami';

  @override
  FutureOr<int>? run() async {
    logger.info('You are already logged in.');
    return ExitCode.success.code;
  }
}
