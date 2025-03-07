import 'dart:convert';
import 'dart:io';
import 'package:globe_kv/src/globe_kv.dart';
import 'package:http/http.dart' as http;

final _jsonEncoder = JsonEncoder.withIndent('');

class GlobeHttpStore implements GlobeKvStore {
  final String namespace;
  final Uri baseUrl;
  final http.Client client;
  final bool enableLogging;

  GlobeHttpStore(
    this.namespace,
    this.baseUrl,
    this.client, {
    this.enableLogging = false,
  });

  Map<String, dynamic> _parseResponse(http.Response response) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (enableLogging) {
      stdout.writeln(_jsonEncoder.convert(data));
    }

    if (response.statusCode != 200) {
      throw Exception(data['error']);
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
    final payload = {
      'namespace': namespace,
      'key': key,
      'value': value.value,
      'type': value.type.name,
      if (expires != null) 'expires': expires.millisecondsSinceEpoch ~/ 1000,
      if (ttl != null) 'ttl': ttl,
    };

    if (enableLogging) {
      stdout.writeln('SET: ${_jsonEncoder.convert(payload)}');
    }

    final response = await client.post(
      baseUrl.replace(path: '/kv/set'),
      body: jsonEncode(payload),
    );

    _parseResponse(response);
  }

  @override
  Future<void> delete(String key) async {
    final payload = {'namespace': namespace, 'key': key};

    if (enableLogging) {
      stdout.writeln('DELETE: ${_jsonEncoder.convert(payload)}');
    }

    final response = await client.delete(
      baseUrl.replace(path: '/kv/delete'),
      body: jsonEncode(payload),
    );

    _parseResponse(response);
  }

  @override
  Future<KvValue<T>?> get<T extends Object>(String key, {int? ttl}) async {
    final payload = {
      'namespace': namespace,
      'key': key,
      if (ttl != null) 'ttl': ttl,
    };

    if (enableLogging) {
      stdout.writeln('GET: ${_jsonEncoder.convert(payload)}');
    }

    final response = await client.post(
      baseUrl.replace(path: '/kv/get'),
      body: jsonEncode(payload),
    );

    final json = _parseResponse(response);
    if (json['value'] == null) return null;

    return KvValue.fromJson<T>(json);
  }

  @override
  Future<KVListResult> list({
    String? prefix,
    String? cursor,
    int? limit,
  }) async {
    final payload = {
      'namespace': namespace,
      if (prefix != null) 'prefix': prefix,
      if (cursor != null) 'cursor': cursor,
      if (limit != null) 'limit': limit,
    };

    if (enableLogging) {
      stdout.writeln('LIST: ${_jsonEncoder.convert(payload)}');
    }

    final response = await client.post(
      baseUrl.replace(path: '/kv/list'),
      body: jsonEncode(payload),
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
