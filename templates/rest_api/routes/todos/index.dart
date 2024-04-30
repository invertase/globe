import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:rest_api/data/todos.dart';

Future<Response> onRequest(RequestContext context) async {
  final req = context.request;

  return switch (req.method) {
    HttpMethod.get => Response.json(body: todos),
    HttpMethod.post => await createTodo(req),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}

Future<Response> createTodo(Request req) async {
  try {
    final body = (await req.json()) as Map<String, Object>;

    if (body case {'title': final title}) {
      todos.add({
        'id': todos.length,
        'title': title,
      });

      return Response.json(body: todos.last, statusCode: HttpStatus.created);
    } else {
      throw const FormatException();
    }
  } catch (_) {
    return Response(statusCode: HttpStatus.badRequest);
  }
}
