import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:session_repository/session_repository.dart';
import 'package:user_repository/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _onPost(RequestContext context) async {
  final body = (await context.request.json()) as Map<String, dynamic>;

  final username = body['username'] as String?;
  final password = body['password'] as String?;

  if (username == null || password == null) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  final sessionRepository = context.read<SessionRepository>();
  final userRepository = context.read<UserRepository>();

  final user = await userRepository.findByUsernameAndPassword(
    username: username,
    password: password,
  );

  if (user != null) {
    final session = await sessionRepository.createSession(user.id);

    final authenticationRepository = context.read<AuthenticationRepository>();
    final signedSession = authenticationRepository.sign(session.toJson());
    return Response.json(
      body: {
        'token': signedSession,
      },
    );
  } else {
    return Response(statusCode: HttpStatus.unauthorized);
  }
}
