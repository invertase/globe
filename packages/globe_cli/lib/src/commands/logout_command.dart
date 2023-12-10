import 'package:mason_logger/mason_logger.dart';

import '../command.dart';

/// `globe logout`
///
/// Logout of the current user.
class LogoutCommand extends BaseGlobeCommand {
  @override
  String get description => 'Logout of the current user';

  @override
  String get name => 'logout';

  @override
  Future<int> run() async {
    final session = auth.currentSession;
    if (session == null) {
      logger.info('You are already logged out.');
      return ExitCode.success.code;
    }

    auth.logout();
    logger.success('✓ Logging out.');

    return ExitCode.success.code;
  }
}
