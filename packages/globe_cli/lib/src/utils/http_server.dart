import 'dart:async';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';

import 'templates.dart';

enum GlobeHttpServerRedirectStrategy {
  /// The server will respond with a HTML template that will redirect the user
  /// to the provided callback URL.
  redirect,
}

/// A utility class for creating a simple HTTP server.
class GlobeHttpServer {
  /// Starts a local HTTP server which listens for an incoming request
  /// to the `/callback` endpoint with a `session` query parameter.
  ///
  /// Once the request is received, the server will respond with a 200
  /// and close the connection.
  Future<String?> getSessionToken({
    void Function(int port)? onConnected,
    required Logger logger,
  }) async {
    const host = 'localhost';
    // Using port 0 will find a random open port.
    // We then use "onConnected" to let the client know which port is used.
    final server = await HttpServer.bind(host, 0);

    try {
      onConnected?.call(server.port);

      await for (final request in server) {
        try {
          switch ((method: request.method, path: request.uri.path)) {
            case (method: 'OPTIONS', path: _):
              request.response.statusCode = 200;
              request.response.headers
                ..add('Access-Control-Allow-Origin', '*')
                ..add('Access-Control-Allow-Methods', '*')
                ..add('Access-Control-Allow-Headers', '*');
            case (method: 'GET', path: '/callback'):
              request.response.statusCode = 200;
              request.response.headers
                ..add('Access-Control-Allow-Origin', '*')
                ..add('Access-Control-Allow-Methods', '*')
                ..add('Access-Control-Allow-Headers', '*');

              final session = request.uri.queryParameters['session'];
              final strategy = request.uri.queryParameters['strategy'];

              if (strategy == GlobeHttpServerRedirectStrategy.redirect.name) {
                final message = session == null
                    ? 'Failed to login. No session token was provided.'
                    : 'Successfully logged in. You may now close this tab.';

                // Return a HTML template.
                request.response.headers.contentType = ContentType.html;
                request.response.write(cliCallbackTemplate(message));
              }

              // Stop the server from getting new requests
              return session;
            default:
            // On unknown requests, do nothing
          }
        } catch (error, stackTrace) {
          // A failing request shouldn't impact the server, but we still log
          // the error for debugging purposes.

          logger.err('''
An error occured while handling the request $request:
$error
$stackTrace
''');
        } finally {
          await request.response.close();
        }
      }

      throw StateError(
        'The server stopped before we were able to obtain the session token.',
      );
    } finally {
      await server.close();
    }
  }
}
