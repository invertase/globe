import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_frog/dart_frog.dart';

import '../index.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final request = context.request;
  final repoId = int.parse(id);

  return switch (context.request.method) {
    HttpMethod.put => await _updateRepo(request, repoId),
    HttpMethod.delete => await _deleteRepo(request, repoId),
    _ => Response(statusCode: HttpStatus.forbidden),
  };
}

Future<Response> _updateRepo(Request request, int repoId) async {
  final existinRepo = repos.firstWhereOrNull((repo) => repo['id'] == repoId);
  if (existinRepo == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  final {
    "name": String name,
    "url": String url,
  } = Map<String, dynamic>.from(await request.json());

  existinRepo.addAll({"name": name, "url": url});

  return Response.json(body: existinRepo);
}

Future<Response> _deleteRepo(Request request, int repoId) async {
  repos.removeWhere((repo) => repo['id'] == repoId);
  return Response.json(body: {'message': 'Repo $repoId successfully deleted.'});
}
