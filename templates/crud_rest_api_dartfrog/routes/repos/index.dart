import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// This object [repos] will serve as our faux database
final repos = [
  {"id": 0, "name": 'serverpod', "url": 'github.com/serverpod/serverpod'},
  {"id": 1, "name": 'melos', "url": 'github.com/invertase/melos'},
  {"id": 2, "name": 'freezed', "url": 'github.com/rrousselGit/freezed'}
];

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getRepos(context.request),
    HttpMethod.post => await _createRepo(context.request),
    _ => Response(statusCode: HttpStatus.forbidden),
  };
}

Future<Response> _createRepo(Request request) async {
  final {
    "name": String name,
    "url": String url,
  } = Map<String, dynamic>.from(await request.json());

  final newRepoEntry = {"id": repos.length, "name": name, "url": url};
  repos.add(newRepoEntry);

  return Response.json(body: newRepoEntry);
}

Response _getRepos(Request request) => Response.json(body: repos);
