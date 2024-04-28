import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_frog/dart_frog.dart';

import '_middleware.dart';
import 'index.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final username = context.read<AuthData>().username;

  final repoId = int.tryParse(id);
  if (repoId == null) {
    return Response(statusCode: HttpStatus.badRequest);
  }

  return switch (context.request.method) {
    HttpMethod.put => await _updateRepo(context, username, repoId),
    HttpMethod.delete => await _deleteRepo(context, username, repoId),
    _ => Response(statusCode: HttpStatus.forbidden),
  };
}

Future<Response> _updateRepo(
  RequestContext context,
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
  } = Map<String, dynamic>.from(await context.request.json());

  repo.addAll({"name": name, "url": url});

  return Response.json(body: repo);
}

Future<Response> _deleteRepo(
  RequestContext context,
  String username,
  int repoId,
) async {
  final username = context.read<AuthData>().username;
  userRepos[username]?.removeWhere((repo) => repo['id'] == repoId);

  return Response.json(body: userRepos[username]);
}
