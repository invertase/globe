import 'dart:convert';
import 'dart:io';

import 'package:globe_kv/globe_kv.dart';

import 'memory_store.dart';

class GlobeFileStore implements GlobeKvStore {
  late final GlobeMemoryStore _memoryStore;
  final File _file;

  GlobeFileStore(String path) : _file = File(path) {
    final json = _loadFromFile();
    if (!_file.existsSync()) {
      _file.createSync(recursive: true);
    }
    try {
      _memoryStore = GlobeMemoryStore.fromJson(json);
    } catch (e) {
      // Re-throw if it wasn't a JSON format error
      if (e is! FormatException && e is! TypeError) {
        rethrow;
      }

      stderr.writeln('Error loading from persisted KV file: $e');
    }
  }

  Map<String, dynamic> _loadFromFile() {
    if (!_file.existsSync()) return {};
    final contents = _file.readAsStringSync();
    if (contents.isEmpty) return {};
    return jsonDecode(contents) as Map<String, dynamic>;
  }

  Future<void> _saveToFile() async {
    final json = _memoryStore.toJson();
    _file.writeAsStringSync(jsonEncode(json));
  }

  @override
  Future<void> delete(String key) async {
    await _memoryStore.delete(key);
    _saveToFile();
  }

  @override
  Future<KvValue<T>?> get<T extends Object>(String key, {int? ttl}) {
    return _memoryStore.get<T>(key, ttl: ttl);
  }

  @override
  Future<KVListResult> list({
    String? prefix,
    String? cursor,
    int? limit,
  }) {
    return _memoryStore.list(prefix: prefix, cursor: cursor, limit: limit);
  }

  @override
  Future<void> set(
    String key,
    KvValue value, {
    DateTime? expires,
    int? ttl,
  }) async {
    await _memoryStore.set(key, value, expires: expires, ttl: ttl);
    _saveToFile();
  }
}
