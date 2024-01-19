import 'dart:async';

import 'package:mason_logger/mason_logger.dart';

import '../command.dart';
import '../utils/http_server.dart';
import '../utils/open_url.dart';

/// {@template login_command}
/// `globe login`
///
/// Login to the Dart Deploy service.
/// {@endtemplate}
class LoginCommand extends BaseGlobeCommand {
  /// {@macro login_command}
  LoginCommand({GlobeHttpServer? httpServer})
      : _httpServer = httpServer ?? GlobeHttpServer();

  final GlobeHttpServer _httpServer;

  @override
  String get name => 'login';

  @override
  String get description => 'Login to the Dart Deploy service.';

  @override
  FutureOr<int> run() async {
    final endpoint = metadata.endpoint;
    final session = auth.currentSession;

    if (session != null) {
      // TODO should "login" ping the server to reconnect if the token is expired?
      logger.info('You are already logged in.');
      return ExitCode.success.code;
    }

    final sessionToken = await _httpServer.getSessionToken(
      logger: logger,
      onConnected: (port) async {
        logger.info('Please authenticate via the opened browser window.');
        // TODO can we react to openUrl close, to have the command emit a "failed to login"?
        final url = '$endpoint/login/cli?callback=http://localhost:$port/callback?strategy=${GlobeHttpServerRedirectStrategy.redirect.name}';
        logger.info('\nOr go to this link: $url\n');
        await openUrl(
          url,
        );
      },
    );

    if (sessionToken == null) {
      logger.err('Failed to login.');
      return ExitCode.software.code;
    }

    auth.login(jwt: sessionToken);
    logger.success('Successfully logged in.');
    return ExitCode.success.code;
  }
}
