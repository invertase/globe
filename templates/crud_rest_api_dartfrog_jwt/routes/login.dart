import 'dart:io';

import 'package:crud_rest_api_dartfrog_jwt/env.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

final secretKey = SecretKey(Env.secretKey);

Future<Response> onRequest(RequestContext context) async {
  final {
    "username": String username,
    "password": String password,
  } = Map<String, dynamic>.from(await context.request.json());

  if (!userExists(username) || password != 'admin101') {
    return Response(statusCode: HttpStatus.unauthorized);
  }

  final newToken = JWT({'username': username}).sign(
    secretKey,
    expiresIn: const Duration(days: 1),
  );

  return Response.json(body: {'token': newToken});
}

final users = [
  {"name": 'tobi'},
  {"name": 'loki'},
  {"name": 'jane'}
];

bool userExists(String username) {
  return users.any((user) => user['name'] == username);
}
