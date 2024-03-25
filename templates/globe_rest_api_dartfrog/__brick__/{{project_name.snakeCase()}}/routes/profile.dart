import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:{{project_name.snakeCase()}}/models/models.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _onGet(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _onGet(RequestContext context) async {
  final apiSession = context.read<ApiSession>();
  return Response.json(body: apiSession.user.toJson());
}
