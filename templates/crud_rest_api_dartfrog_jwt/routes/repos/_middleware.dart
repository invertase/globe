import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../login.dart';

final class AuthData {
  final String username;
  const AuthData(this.username);
}

Handler middleware(Handler handler) {
  return (context) async {
    final path = context.request.uri.pathSegments;
    final method = context.request.method;

    /// Ignore 'GET: /repos'
    if (path.length == 1 && path.last == 'repos' && method == HttpMethod.get) {
      return handler(context);
    }

    final bearerToken = context.request.headers[HttpHeaders.authorizationHeader]
        ?.split(' ')
        .lastOrNull;
    if (bearerToken == null) {
      return Response(statusCode: HttpStatus.unauthorized);
    }

    final jwt = JWT.tryVerify(bearerToken, secretKey);
    if (jwt == null) {
      return Response(statusCode: HttpStatus.unauthorized);
    }

    final username = jwt.payload['username'] as String;

    return await handler(
      context.provide<AuthData>(() => AuthData(username)),
    );
  };
}
