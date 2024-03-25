import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:user_repository/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _onPost(RequestContext context) async {
  final body = (await context.request.json()) as Map<String, dynamic>;

  final name = body['name'] as String?;
  final username = body['username'] as String?;
  final password = body['password'] as String?;

  if (name == null || username == null || password == null) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  final userRepository = context.read<UserRepository>();

  try {
    await userRepository.createUser(
      username: username,
      name: name,
      password: password,
    );
  } on UserAlreadyExistsException {
    return Response(statusCode: HttpStatus.conflict);
  }

  return Response(statusCode: HttpStatus.noContent);
}
