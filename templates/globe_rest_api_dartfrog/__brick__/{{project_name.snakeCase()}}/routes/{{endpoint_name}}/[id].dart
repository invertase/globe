import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _onGetRequest(context, id);
    case HttpMethod.put:
      return _onPutRequest(context, id);
    case HttpMethod.delete:
      return _onDeleteRequest(context, id);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _onGetRequest(RequestContext context, String id) async {
  return Response.json(
    body: {
      'message:': 'GET',
      'project_name': '{{project_name}}',
    },
  );
}

Future<Response> _onPutRequest(RequestContext context, String id) async {
  return Response.json(
    body: {
      'message:': 'PUT',
      'project_name': '{{project_name}}',
    },
  );
}

Future<Response> _onDeleteRequest(RequestContext context, String id) async {
  return Response.json(
    body: {
      'message:': 'DELETE',
      'project_name': '{{project_name}}',
    },
  );
}
