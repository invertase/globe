import 'dart:io';

import 'package:globe_kv/src/asserts.dart';
import 'package:globe_kv/src/stores/file_store.dart';
import 'package:globe_kv/src/stores/http_store.dart';
import 'package:globe_kv/src/stores/memory_store.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

part 'globe_kv_store.dart';

String _globeLocalPath(String namespace) =>
    p.join('.dart_tool', 'globe_ds', 'kv', '$namespace.json');

final class GlobeKV {
  late final GlobeKvStore _store;

  GlobeKV.inmemory() : _store = GlobeMemoryStore();

  GlobeKV.file(String namespace)
      : _store = GlobeFileStore(_globeLocalPath(namespace));

  GlobeKV.init(String namespace, {GlobeKvStore? store}) {
    if (Platform.environment['GLOBE'] == '1') {
      final baseUrl = Platform.environment['GLOBE_KV_API'] ??
          (throw StateError('GLOBE_KV_API is not set'));

      _store = store ?? GlobeHttpStore(namespace, baseUrl, http.Client());
    } else {
      _store = store ?? GlobeMemoryStore();
    }
  }

  Future<KvValue<T>?> get<T extends Object>(String key, {int? ttl}) async {
    assertKey(key);
    return _store.get<T>(key, ttl: ttl);
  }

  Future<T?> _getTyped<T extends Object>(String key, {int? ttl}) async {
    assertKey(key);
    final result = await _store.get<T>(key, ttl: ttl);
    if (result == null) return null;
    return result.value;
  }

  Future<String?> getString(String key, {int? ttl}) {
    return _getTyped<String>(key, ttl: ttl);
  }

  Future<num?> getNumber(String key, {int? ttl}) {
    return _getTyped<num>(key, ttl: ttl);
  }

  Future<bool?> getBool(String key, {int? ttl}) async {
    return _getTyped<bool>(key, ttl: ttl);
  }

  Future<List<int>?> getBinary(String key, {int? ttl}) {
    return _getTyped<List<int>>(key, ttl: ttl);
  }

  Future<void> set<T extends Object>(
    String key,
    T value, {
    DateTime? expires,
    int? ttl,
  }) async {
    assertKey(key);
    await _store.set(key, KvValue.from(value), expires: expires, ttl: ttl);
  }

  Future<void> delete(String key) async {
    assertKey(key);
    await _store.delete(key);
  }

  Future<KVListResult> list({
    String? prefix,
    String? cursor,
    int? limit,
  }) async {
    return _store.list(prefix: prefix, cursor: cursor, limit: limit);
  }
}
