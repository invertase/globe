import 'dart:convert';
import 'package:globe_kv/src/globe_kv.dart';
import 'package:http/http.dart' as http;

class GlobeHttpStore implements GlobeKvStore {
  final String namespace;
  final String baseUrl;
  final http.Client client;

  GlobeHttpStore(this.namespace, this.baseUrl, this.client);

  Map<String, dynamic> _parseResponse(http.Response response) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw Exception(data['message']);
    }

    return data;
  }

  @override
  Future<void> set(
    String key,
    KvValue value, {
    DateTime? expires,
    int? ttl,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/set'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'namespace': namespace,
        'key': key,
        'value': value.value,
        'type': value.type.name,
        if (expires != null) 'expires': expires.millisecondsSinceEpoch ~/ 1000,
        if (ttl != null) 'ttl': ttl,
      }),
    );

    _parseResponse(response);
  }

  @override
  Future<void> delete(String key) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'namespace': namespace,
        'key': key,
      }),
    );

    _parseResponse(response);
  }

  @override
  Future<KvValue<T>?> get<T extends Object>(String key, {int? ttl}) async {
    final response = await client.post(
      Uri.parse('$baseUrl/get'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'namespace': namespace,
        'key': key,
        if (ttl != null) 'ttl': ttl,
      }),
    );

    final json = _parseResponse(response);
    if (json['value'] == null) return null;

    return KvValue.fromJson(json);
  }

  @override
  Future<KVListResult> list({
    String? prefix,
    String? cursor,
    int? limit,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/list'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'namespace': namespace,
        if (prefix != null) 'prefix': prefix,
        if (cursor != null) 'cursor': cursor,
        if (limit != null) 'limit': limit,
      }),
    );

    final json = _parseResponse(response);

    final results = (json['results'] as List).map((item) {
      final itemMap = item as Map<String, dynamic>;
      return KvListResultItem(
        itemMap['key'],
        KvValueType.values.firstWhere((t) => t.toString() == itemMap['type']),
        itemMap['expiration'] != null
            ? DateTime.fromMillisecondsSinceEpoch(itemMap['expiration'] * 1000)
            : null,
      );
    }).toList();

    return KVListResult(
      results: results,
      complete: json['complete'] as bool,
      cursor: json['cursor'] as String?,
    );
  }
}
