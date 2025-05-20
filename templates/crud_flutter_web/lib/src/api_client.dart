import 'dart:convert';
import 'dart:io';
import 'package:crud_flutter_web/src/repository.dart';
import 'package:http/http.dart' as http;

extension DecodeBody on http.Response {
  Future<dynamic> json() async {
    return jsonDecode(body);
  }
}

class APIClient {
  APIClient(this._baseUrl);

  final String _baseUrl;
  late final Uri _uri = Uri.parse(_baseUrl);

  Future<List<Repository>> getRepositories() async {
    final uri = _uri.resolve('/repos');

    final res = await http.get(uri);

    if (res.statusCode != HttpStatus.ok) {
      throw Exception('Failed to get repositories');
    }

    return (await res.json() as List<dynamic>)
        .map((e) => Repository.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<Repository> getRepository(int id) async {
    final url = _uri.resolve('/repos/$id');
    final res = await http.get(url);

    if (res.statusCode != HttpStatus.ok) {
      throw Exception('Failed to get repository');
    }

    return Repository.fromMap(await res.json() as Map<String, dynamic>);
  }

  Future<Repository> createRepository({
    required String name,
    required String url,
  }) async {
    final uri = _uri.resolve('/repos');

    final res = await http.post(
      uri,
      body: jsonEncode({'name': name, 'url': url}),
    );

    if (res.statusCode != HttpStatus.ok) {
      throw Exception('Failed to create repository');
    }

    return Repository.fromMap(await res.json() as Map<String, dynamic>);
  }

  Future<Repository> updateRepository(
    int id, {
    String? name,
    String? url,
  }) async {
    final uri = _uri.resolve('/repos/$id');
    final res = await http.put(
      uri,
      body: jsonEncode({
        if (name != null) 'name': name,
        if (url != null) 'url': url,
      }),
    );

    if (res.statusCode != HttpStatus.ok) {
      throw Exception('Failed to update repository');
    }

    return Repository.fromMap(await res.json() as Map<String, dynamic>);
  }

  Future<void> deleteRepository(int id) async {
    final url = _uri.resolve('/repos/$id');
    final res = await http.delete(url);

    if (res.statusCode != HttpStatus.ok) {
      throw Exception('Failed to delete repository');
    }
  }
}
