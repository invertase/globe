// Configure routes.
import 'dart:convert';
import 'dart:io';

import 'package:bcrypt/bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'app.dart';

final router = Router()
  ..post('/register', _register)
  ..post('/login', _login)
  ..get('/me', _getCurrentUser);

Middleware authMiddleware = (innerHandler) {
  return (request) {
    final reqPath = request.url.path;

    // Bypass auth header check for these routes
    if (const ['login', 'register'].contains(reqPath)) {
      return innerHandler(request);
    }

    // Retrieve token from header eg: `Bearer xxxxxx` -> `xxxxxx`
    final authToken =
        request.headers[HttpHeaders.authorizationHeader]?.split(' ').lastOrNull;
    if (authToken == null) {
      return Response.unauthorized(null);
    }

    // Verify JWT token using secret key
    final decodedToken = JWT.tryVerify(authToken, jwtSecretKey);
    if (decodedToken == null) {
      return Response.unauthorized(null);
    }

    return innerHandler(request.change(
      context: {'user': decodedToken.payload},
    ));
  };
};

Response _getCurrentUser(Request request) {
  final {
    'username': String username,
  } = Map<String, dynamic>.from(request.context['user']! as dynamic);
  final userData = fauxUserDB[username]!;

  return Response.ok(
    jsonEncode({
      'id': userData.id,
      'username': username,
      'createdAt': userData.createdAt.toIso8601String()
    }),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
}

Future<Response> _register(Request request) async {
  ({String username, String password}) reqBody;

  try {
    final body =
        await json.decode(await request.readAsString()) as Map<String, dynamic>;
    reqBody = switch (body) {
      {'username': String username, 'password': String password} => (
          username: username,
          password: password,
        ),
      _ => throw FormatException('Username & Password required for register'),
    };
  } on FormatException catch (e) {
    return Response.badRequest(body: e.message);
  }

  if (fauxUserDB.containsKey(reqBody.username)) {
    return Response.badRequest(body: 'Username already taken.');
  }

  final String hashedPassword =
      BCrypt.hashpw(reqBody.password, BCrypt.gensalt());
  final now = DateTime.now().toUtc();
  fauxUserDB[reqBody.username] = (
    passwordHash: hashedPassword,
    createdAt: now,
    id: '${now.toIso8601String()}_${fauxUserDB.length}',
  );

  return Response.ok('User registered');
}

Future<Response> _login(Request request) async {
  ({String username, String password}) reqBody;

  try {
    final body =
        await json.decode(await request.readAsString()) as Map<String, dynamic>;
    reqBody = switch (body) {
      {'username': String username, 'password': String password} => (
          username: username,
          password: password,
        ),
      _ => throw FormatException('Username & Password required for register'),
    };
  } on FormatException catch (e) {
    return Response.badRequest(body: e.message);
  }

  final userFromDB = fauxUserDB[reqBody.username];
  if (userFromDB == null ||
      !BCrypt.checkpw(reqBody.password, userFromDB.passwordHash)) {
    return Response.unauthorized('Invalid user credentials');
  }

  // Issue a token valid for a day
  final jwtToken = JWT({'username': reqBody.username}).sign(
    jwtSecretKey,
    expiresIn: const Duration(days: 1),
  );

  return Response.ok(
    jsonEncode({'token': jwtToken}),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
}
