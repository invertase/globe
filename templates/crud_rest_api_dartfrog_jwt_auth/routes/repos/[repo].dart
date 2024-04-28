import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_frog/dart_frog.dart';

import '../_users.dart';
import 'index.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final request = context.request;
  final repoId = int.tryParse(id);
  if (repoId == null) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  final username = request.uri.queryParameters['username'];
  if (username == null || !userExists(username)) {
    return Response(statusCode: HttpStatus.unauthorized);
  }

  return switch (context.request.method) {
    HttpMethod.put => await _updateRepo(request, username, repoId),
    HttpMethod.delete => await _deleteRepo(request, username, repoId),
    _ => Response(statusCode: HttpStatus.forbidden),
  };
}

Future<Response> _updateRepo(
  Request request,
  String username,
  int repoId,
) async {
  final repo =
      userRepos[username]?.firstWhereOrNull((repo) => repo['id'] == repoId);
  if (repo == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  final {
    "name": String name,
    "url": String url,
  } = Map<String, dynamic>.from(await request.json());

  repo.addAll({"name": name, "url": url});

  return Response.json(body: repo);
}

Future<Response> _deleteRepo(
  Request request,
  String username,
  int repoId,
) async {
  userRepos[username]?.removeWhere((repo) => repo['id'] == repoId);
  return Response.json(body: userRepos[username]);
}
