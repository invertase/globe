import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import '../register.dart' show fauxUserDB;
import '_middleware.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }

  final username = context.read<AuthData>().username;
  final userData = fauxUserDB[username]!;

  return Response.json(body: {
    'id': userData.id,
    'username': username,
    'createdAt': userData.createdAt.toIso8601String()
  });
}
