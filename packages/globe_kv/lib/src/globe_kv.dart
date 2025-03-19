import 'package:globe_kv/src/asserts.dart';
import 'package:globe_kv/src/stores/http_store.dart';
import 'package:globe_kv/src/stores/memory_store.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
import 'package:globe_env/globe_env.dart';

part 'globe_kv_store.dart';

final class GlobeKV {
  late final GlobeKvStore _store;

  /// Creates a new GlobeKV instance with the specified namespace.
  ///
  /// If running in a Globe environment (GLOBE=1), it will use GlobeHttpStore
  /// with the URL from GLOBE_DS_API environment variable.
  /// Otherwise, it uses the provided [store] or defaults to GlobeMemoryStore.
  ///
  /// Throws StateError if GLOBE is set but GLOBE_DS_API is not defined.
  GlobeKV(String namespace, {GlobeKvStore? store, bool debug = false}) {
    if (GlobeEnv.isGlobeRuntime) {
      _store = GlobeHttpStore(
        namespace,
        GlobeEnv.datasource ?? (throw StateError('GLOBE_DS_API is not set')),
        http.Client(),
        enableLogging: debug,
      );
    } else {
      _store = store ?? GlobeMemoryStore();
    }
  }

  /// Retrieves a value with metadata from the store.
  ///
  /// [key] The key to look up.
  /// [ttl] Optional time-to-live in seconds to consider the cached value valid.
  ///
  /// Returns a Future that resolves to a `KvValue<T>` object or null if the
  /// key doesn't exist or has expired.
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

  /// Retrieves a string value from the store.
  ///
  /// [key] The key to look up.
  /// [ttl] Optional time-to-live in seconds to consider the cached value valid.
  ///
  /// Returns a Future that resolves to a String or null if the key doesn't exist,
  /// or has expired.
  Future<String?> getString(String key, {int? ttl}) {
    return _getTyped<String>(key, ttl: ttl);
  }

  /// Retrieves a numeric value from the store.
  ///
  /// [key] The key to look up.
  /// [ttl] Optional time-to-live in seconds to consider the cached value valid.
  ///
  /// Returns a Future that resolves to a num or null if the key doesn't exist or
  /// has expired.
  Future<num?> getNumber(String key, {int? ttl}) {
    return _getTyped<num>(key, ttl: ttl);
  }

  /// Retrieves a boolean value from the store.
  ///
  /// [key] The key to look up.
  /// [ttl] Optional time-to-live in seconds to consider the cached value valid.
  ///
  /// Returns a Future that resolves to a bool or null if the key doesn't exist or
  /// has expired.
  Future<bool?> getBool(String key, {int? ttl}) async {
    return _getTyped<bool>(key, ttl: ttl);
  }

  /// Retrieves binary data from the store.
  ///
  /// [key] The key to look up.
  /// [ttl] Optional time-to-live in seconds to consider the cached value valid.
  ///
  /// Returns a Future that resolves to a `List<int>` or null if the key doesn't
  /// exist or has expired.
  Future<List<int>?> getBinary(String key, {int? ttl}) {
    return _getTyped<List<int>>(key, ttl: ttl);
  }

  /// Stores a value in the key-value store.
  ///
  /// [key] The key to store the value under.
  /// [value] The value to store.
  /// [expires] Optional absolute expiration time for this value.
  /// [ttl] Optional relative time-to-live in seconds for this value.
  Future<void> set<T extends Object>(
    String key,
    T value, {
    DateTime? expires,
    int? ttl,
  }) async {
    assertKey(key);
    await _store.set(key, KvValue.from(value), expires: expires, ttl: ttl);
  }

  /// Removes a key and its associated value from the store.
  ///
  /// [key] The key to delete.
  Future<void> delete(String key) async {
    assertKey(key);
    await _store.delete(key);
  }

  /// Lists keys in the store, with optional filtering.
  ///
  /// [prefix] Optional. Only return keys that start with this prefix.
  /// [cursor] Optional. Continue listing from this pagination cursor.
  /// [limit] Optional. Maximum number of keys to return.
  ///
  /// Returns a Future that resolves to a KVListResult containing keys
  /// and pagination information.
  Future<KVListResult> list({
    String? prefix,
    String? cursor,
    int? limit,
  }) async {
    return _store.list(prefix: prefix, cursor: cursor, limit: limit);
  }
}
