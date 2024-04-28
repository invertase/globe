import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../users.dart';

/// these two objects will serve as our faux database
final repos = [
  {"id": 0, "name": 'express', "url": 'github.com/expressjs/express'},
  {"id": 1, "name": 'stylus', "url": 'github.com/learnboost/stylus'},
  {"id": 2, "name": 'cluster', "url": 'github.com/learnboost/cluster'}
];

final userRepos = {
  "tobi": [repos[0], repos[1]],
  "loki": [repos[1]],
  "jane": [repos[2]]
};

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getRepos(context.request),
    HttpMethod.post => await _createRepo(context.request),
    _ => Response(statusCode: HttpStatus.forbidden),
  };
}

Response _getRepos(Request request) {
  final username = request.uri.queryParameters['username'];
  if (username != null) {
    return Response.json(body: userRepos[username] ?? const []);
  }

  return Response.json(body: repos);
}

Future<Response> _createRepo(Request request) async {
  final username = request.uri.queryParameters['username'];
  if (username == null) {
    return Response(statusCode: HttpStatus.badRequest);
  } else if (!userExists(username)) {
    return Response(statusCode: HttpStatus.unauthorized);
  }

  final {
    "name": String name,
    "url": String url,
  } = Map<String, dynamic>.from(await request.json());

  final newRepoEntry = {"id": repos.length, "name": name, "url": url};
  repos.add(newRepoEntry);

  final existingRepos = userRepos[username] ?? [];
  userRepos[username] = existingRepos..add(newRepoEntry);

  return Response.json(body: existingRepos);
}
