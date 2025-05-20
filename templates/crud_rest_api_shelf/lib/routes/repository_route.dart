import 'dart:convert';
import '../models/repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../data/repositories.dart';

class RepositoryRoute {
  Router get router {
    final router = Router();

    // Get all repositories
    router.get('/repos', (Request request) async {
      final repos = repositories.map((repo) => repo.toJson()).toList();

      return Response.ok(
        json.encode(repos),
        headers: {'content-type': 'application/json'},
      );
    });

    // Create a new repository
    router.post('/repos', (Request request) async {
      final body = await _parseJson(request);
      if (body == null || body['name'] is! String || body['url'] is! String) {
        return Response.badRequest(
          body: {'error': 'Invalid input'},
          headers: {'content-type': 'application/json'},
        );
      }

      final newRepo = Repository(
        id: repositories.length,
        name: body['name'] as String,
        url: body['url'] as String,
      );

      repositories.add(newRepo);

      return Response.ok(
        json.encode(newRepo.toJson()),
        headers: {'content-type': 'application/json'},
      );
    });

    // Get a repository
    router.get('/repos/<id>', (Request request, String id) async {
      final repoId = int.tryParse(id);
      if (repoId == null) {
        return Response.badRequest(
          body: jsonEncode({'error': 'Invalid repository ID'}),
          headers: {'content-type': 'application/json'},
        );
      }

      final index = repositories.indexWhere((repo) => repo.id == repoId);
      if (index == -1) {
        return Response.notFound(
          jsonEncode({'error': 'Repository not found'}),
          headers: {'content-type': 'application/json'},
        );
      }

      return Response.ok(
        jsonEncode(repositories[index].toJson()),
        headers: {'content-type': 'application/json'},
      );
    });

    // Update a repository
    router.put('/repos/<id>', (Request request, String id) async {
      final repoId = int.tryParse(id);
      if (repoId == null) {
        return Response.badRequest(
          body: jsonEncode({'error': 'Invalid repository ID'}),
          headers: {'content-type': 'application/json'},
        );
      }

      final body = await _parseJson(request);
      if (body == null) {
        return Response.badRequest(
          body: {'error': 'Invalid input'},
          headers: {'content-type': 'application/json'},
        );
      }

      final index = repositories.indexWhere((repo) => repo.id == repoId);
      if (index == -1) {
        return Response.notFound(
          jsonEncode({'error': 'Repository not found'}),
          headers: {'content-type': 'application/json'},
        );
      }

      final repository = repositories[index].copyWith(
        name: body['name'] as String?,
        url: body['url'] as String?,
      );

      repositories[index] = repository;

      return Response.ok(
        jsonEncode(repository.toJson()),
        headers: {'content-type': 'application/json'},
      );
    });

    // Delete a repository
    router.delete('/repos/<id>', (Request request, String id) {
      final repoId = int.tryParse(id);
      if (repoId == null) {
        return Response.badRequest(
          body: jsonEncode({'error': 'Invalid repository ID'}),
          headers: {'content-type': 'application/json'},
        );
      }

      final index = repositories.indexWhere((repo) => repo.id == repoId);
      if (index == -1) {
        return Response.notFound(
          jsonEncode({'error': 'Repository not found'}),
          headers: {'content-type': 'application/json'},
        );
      }

      repositories.removeAt(index);

      return Response.ok(
        jsonEncode({'message': 'Repo $repoId successfully deleted.'}),
        headers: {'content-type': 'application/json'},
      );
    });

    return router;
  }

  Future<Map<String, dynamic>?> _parseJson(Request request) async {
    try {
      final payload = await request.readAsString();
      return jsonDecode(payload) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
