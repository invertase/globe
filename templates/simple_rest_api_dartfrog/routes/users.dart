import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

final users = [
  {"name": 'tobi'},
  {"name": 'loki'},
  {"name": 'jane'}
];

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => Response.json(body: users),
    _ => Response(statusCode: HttpStatus.notAcceptable),
  };
}
