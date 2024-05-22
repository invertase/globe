import 'dart:io';

import 'package:bcrypt/bcrypt.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';

import 'register.dart' show fauxUserDB;

final env = DotEnv(includePlatformEnvironment: true)..load();
final _secretKeyString = env['JWT_SECRET_KEY'] ??
    (throw StateError('JWT_SECRET_KEY environment variable not provided'));
final jwtSecretKey = SecretKey(_secretKeyString);

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  ({String username, String password}) reqBody;

  try {
    final body = Map<String, dynamic>.from(await context.request.json());
    reqBody = switch (body) {
      {'username': String username, 'password': String password} => (
          username: username,
          password: password,
        ),
      _ => throw FormatException('Username & Password required for register'),
    };
  } on FormatException catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: e.message);
  }

  final userFromDB = fauxUserDB[reqBody.username];
  final passwordMatches = userFromDB == null
      ? false
      : BCrypt.checkpw(reqBody.password, userFromDB.passwordHash);

  if (!passwordMatches) {
    return Response(
      statusCode: HttpStatus.unauthorized,
      body: 'Invalid user credentials',
    );
  }

  // Issue a token valid for a day
  final jwtToken = JWT({'username': reqBody.username}).sign(
    jwtSecretKey,
    expiresIn: const Duration(days: 1),
  );

  return Response.json(body: {'token': jwtToken});
}
