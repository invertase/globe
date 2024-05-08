import 'dart:io';

import 'package:bcrypt/bcrypt.dart';
import 'package:dart_frog/dart_frog.dart';

typedef UserData = ({
  String id,
  String passwordHash,
  DateTime createdAt,
});

// A map of username and userdata eg: { 'john-doe': (id, _, __) }
final fauxUserDB = <String, UserData>{};

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

  if (fauxUserDB.containsKey(reqBody.username)) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Username already taken.',
    );
  }

  final String hashedPassword =
      BCrypt.hashpw(reqBody.password, BCrypt.gensalt());
  final now = DateTime.now().toUtc();
  fauxUserDB[reqBody.username] = (
    passwordHash: hashedPassword,
    createdAt: now,
    id: '${now.toIso8601String()}_${fauxUserDB.length}',
  );

  return Response(statusCode: HttpStatus.created, body: 'User registered');
}
