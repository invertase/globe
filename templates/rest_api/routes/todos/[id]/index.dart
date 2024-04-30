import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:rest_api/data/todos.dart';

const _notFound = <String, Object>{};

Future<dynamic> onRequest(RequestContext context, String id) async {
  final intId = int.parse(id);
  final req = context.request;

  return switch (req.method) {
    HttpMethod.get => getById(intId),
    HttpMethod.put => await updateById(intId, req),
    HttpMethod.delete => await deleteById(intId),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}

Response getById(int id) {
  final todo = todos.firstWhere(
    (todo) => todo['id'] == id,
    orElse: () => _notFound,
  );

  return switch (todo) {
    _notFound => Response(statusCode: HttpStatus.notFound),
    _ => Response.json(body: todo),
  };
}

Future<Response> updateById(int id, Request req) async {
  try {
    final body = (await req.json()) as Map<String, Object>;

    if (body case {'title': final title}) {
      final index = todos.indexWhere((todo) => todo['id'] == id);
      if (index == -1) {
        return Response(statusCode: HttpStatus.notFound);
      }

      todos[index] = {
        'id': id,
        'title': title,
      };

      return Response.json(body: todos[index]);
    } else {
      throw const FormatException();
    }
  } catch (_) {
    return Response(statusCode: HttpStatus.badRequest);
  }
}

Future<Response> deleteById(int id) async {
  final index = todos.indexWhere((todo) => todo['id'] == id);
  if (index == -1) {
    return Response(statusCode: HttpStatus.notFound);
  }

  final todo = todos.removeAt(index);
  return Response.json(body: todo);
}
