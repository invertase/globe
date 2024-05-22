import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../login.dart';

final bearerTokenRegExp = RegExp(r'Bearer (?<token>.+)');

final class AuthData {
  final String username;
  const AuthData(this.username);
}

Handler middleware(Handler handler) {
  return (context) async {
    final authHeader =
        context.request.headers[HttpHeaders.authorizationHeader] ?? '';
    final match = bearerTokenRegExp.firstMatch(authHeader);
    final token = match?.namedGroup('token');
    if (token == null) {
      return Response(statusCode: HttpStatus.unauthorized);
    }

    final jwt = JWT.tryVerify(token, jwtSecretKey);
    if (jwt == null) {
      return Response(statusCode: HttpStatus.unauthorized);
    }

    final username = jwt.payload['username'] as String;
    return await handler(
      context.provide<AuthData>(() => AuthData(username)),
    );
  };
}
