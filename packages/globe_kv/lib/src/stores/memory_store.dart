import 'dart:convert';

import 'package:globe_kv/globe_kv.dart';

class GlobeMemoryStore implements GlobeKvStore {
  final Map<String, MemoryValue> _store = {};

  GlobeMemoryStore();

  GlobeMemoryStore.fromJson(Map<String, dynamic> json) {
    _store.clear();
    _store.addAll(json.map((key, value) {
      return MapEntry(
        key,
        MemoryValue.fromJson(value),
      );
    }));
  }

  Map<String, dynamic> toJson() {
    return _store.map((key, value) => MapEntry(key, value.toJson()));
  }

  void _removeExpired() {
    _store.removeWhere((_, value) => value.isExpired);
  }

  @override
  Future<void> set(
    String key,
    KvValue value, {
    DateTime? expires,
    int? ttl,
  }) async {
    // Calculate expiry time.
    final expiryTime = expires ??
        (ttl != null ? DateTime.now().add(Duration(seconds: ttl)) : null);

    _store[key] = MemoryValue(
      value: value,
      expiresAt: expiryTime,
    );
  }

  @override
  Future<void> delete(String key) async {
    _store.remove(key);
  }

  @override
  Future<KvValue<T>?> get<T extends Object>(String key, {int? ttl}) async {
    _removeExpired();

    if (!_store.containsKey(key)) {
      return null;
    }

    return _store[key]!.value as KvValue<T>;
  }

  int _compareUtf8Bytes(String a, String b) {
    var aBytes = utf8.encode(a);
    var bBytes = utf8.encode(b);

    for (var i = 0; i < aBytes.length && i < bBytes.length; i++) {
      if (aBytes[i] != bBytes[i]) {
        return aBytes[i].compareTo(bBytes[i]);
      }
    }
    return aBytes.length.compareTo(bBytes.length);
  }

  @override
  Future<KVListResult> list(
      {String? prefix, String? cursor, int? limit}) async {
    _removeExpired();

    // Get all matching keys and sort them lexicographically by UTF-8 bytes
    var matches = prefix != null
        ? _store.keys.where((key) => key.startsWith(prefix)).toList()
        : _store.keys.toList();

    matches.sort((a, b) => _compareUtf8Bytes(a, b));

    // Find starting position if cursor is provided
    var startIndex = 0;
    if (cursor != null) {
      startIndex = matches.indexWhere((key) => key.compareTo(cursor) > 0);
      if (startIndex == -1) startIndex = matches.length;
    }

    // Apply pagination
    var endIndex = limit != null ? startIndex + limit : matches.length;
    var hasMore = endIndex < matches.length;

    // Get the subset of matches for this page
    var pageMatches =
        matches.sublist(startIndex, endIndex.clamp(0, matches.length));

    final results = pageMatches.map((key) {
      final kvValue = _store[key]!;
      return KvListResultItem(key, kvValue.value.type, kvValue.expiresAt);
    }).toList();

    // Return next cursor only if there are more results
    String? nextCursor = hasMore ? pageMatches.last : null;

    return KVListResult(
      results: results,
      complete: !hasMore,
      cursor: nextCursor,
    );
  }
}

class MemoryValue {
  KvValue value;
  DateTime? expiresAt;

  MemoryValue({required this.value, this.expiresAt});

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  factory MemoryValue.fromJson(Map<String, dynamic> json) {
    return MemoryValue(
      value: KvValue.fromJson(json),
      expiresAt:
          json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'type': value.type.name,
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }
}
