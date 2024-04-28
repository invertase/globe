import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import '_middleware.dart';

/// These two objects [_repos] & [userRepos] will serve as our faux database
final _repos = [
  {"id": 0, "name": 'express', "url": 'github.com/expressjs/express'},
  {"id": 1, "name": 'stylus', "url": 'github.com/learnboost/stylus'},
  {"id": 2, "name": 'cluster', "url": 'github.com/learnboost/cluster'}
];
final userRepos = {
  "tobi": [_repos[0], _repos[1]],
  "loki": [_repos[1]],
  "jane": [_repos[2]]
};

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getRepos(context.request),
    HttpMethod.post => await _createRepo(context),
    _ => Response(statusCode: HttpStatus.forbidden),
  };
}

Response _getRepos(Request request) {
  final username = request.uri.queryParameters['username'];
  if (username != null) {
    return Response.json(body: userRepos[username] ?? const []);
  }

  return Response.json(body: _repos);
}

Future<Response> _createRepo(RequestContext context) async {
  final username = context.read<AuthData>().username;

  final {
    "name": String name,
    "url": String url,
  } = Map<String, dynamic>.from(await context.request.json());

  final newRepoEntry = {"id": _repos.length, "name": name, "url": url};
  _repos.add(newRepoEntry);

  final existingRepos = userRepos[username] ?? [];
  userRepos[username] = existingRepos..add(newRepoEntry);

  return Response.json(body: existingRepos);
}
