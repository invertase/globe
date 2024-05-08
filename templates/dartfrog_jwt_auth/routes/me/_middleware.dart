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
    // Retrieve token from header eg: `Bearer xxxxxx` -> `xxxxxx`
    final bearerToken = context.request.headers[HttpHeaders.authorizationHeader]
        ?.split(' ')
        .lastOrNull;
    if (bearerToken == null) {
      return Response(statusCode: HttpStatus.unauthorized);
    }

    final jwt = JWT.tryVerify(bearerToken, jwtSecretKey);
    if (jwt == null) {
      return Response(statusCode: HttpStatus.unauthorized);
    }

    final username = jwt.payload['username'] as String;
    return await handler(
      context.provide<AuthData>(() => AuthData(username)),
    );
  };
}
