import 'dart:async';
import 'dart:io';

import 'package:crud_rest_api_dartfrog/users.dart';
import 'package:dart_frog/dart_frog.dart';

/// These two objects [_repos] & [userRepos] will serve as our faux database
final _repos = [
  {"id": 0, "name": 'serverpod', "url": 'github.com/serverpod/serverpod'},
  {"id": 1, "name": 'melos', "url": 'github.com/invertase/melos'},
  {"id": 2, "name": 'freezed', "url": 'github.com/rrousselGit/freezed'}
];

final userRepos = {
  "tobi": [_repos[0], _repos[1]],
  "loki": [_repos[1]],
  "jane": [_repos[2]]
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

  return Response.json(body: _repos);
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

  final newRepoEntry = {"id": _repos.length, "name": name, "url": url};
  _repos.add(newRepoEntry);

  final existingRepos = userRepos[username] ?? [];
  userRepos[username] = existingRepos..add(newRepoEntry);

  return Response.json(body: existingRepos);
}
