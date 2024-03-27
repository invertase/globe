import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _onGet(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _onGet(RequestContext context) async {
  final apiSession = context.read<ApiSession>();
  final authenticationRepository = context.read<AuthenticationRepository>();

  final token = authenticationRepository.sign(apiSession.session.toJson());
  return Response.json(body: {'token': token});
}
