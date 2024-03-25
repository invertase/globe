import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _onGetRequest(context);
    case HttpMethod.post:
      return _onPostRequest(context);
    case _:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _onGetRequest(RequestContext context) async {
  return Response.json(
    body: {
      'message:': 'GET',
      'project_name': '{{project_name}}',
    },
  );
}

Future<Response> _onPostRequest(RequestContext context) async {
  return Response.json(
    body: {
      'message:': 'GET',
      'project_name': '{{project_name}}',
    },
  );
}
