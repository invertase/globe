import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// these two objects will serve as our faux database
var repos = [
  {"name": 'express', "url": 'https://github.com/expressjs/express'},
  {"name": 'stylus', "url": 'https://github.com/learnboost/stylus'},
  {"name": 'cluster', "url": 'https://github.com/learnboost/cluster'}
];

final userRepos = {
  "tobi": [repos[0], repos[1]],
  "loki": [repos[1]],
  "jane": [repos[2]]
};

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getRepos(context.request),
    _ => Response(statusCode: HttpStatus.notAcceptable),
  };
}

Response _getRepos(Request request) {
  final username = request.uri.queryParameters['username'];
  if (username != null) {
    return Response.json(body: userRepos[username] ?? const []);
  }

  return Response.json(body: repos);
}
