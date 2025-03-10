part of 'globe_kv.dart';

abstract class GlobeKvStore {
  Future<void> set(
    String key,
    KvValue value, {
    DateTime? expires,
    int? ttl,
  });

  Future<void> delete(String key);

  Future<KvValue<T>?> get<T extends Object>(String key, {int? ttl});

  Future<KVListResult> list({
    String? prefix,
    String? cursor,
    int? limit,
  });
}

enum KvValueType {
  string(),
  number(),
  boolean(),
  binary();

  const KvValueType();

  static KvValueType typeOf(Object value) {
    return switch (value.runtimeType) {
      const (String) => KvValueType.string,
      const (bool) => KvValueType.boolean,
      const (List<int>) => KvValueType.binary,
      const (num) || const (double) || const (int) => KvValueType.number,
      _ => throw ArgumentError('Invalid type: $value'),
    };
  }

  bool isValid(Object value) => switch (this) {
        KvValueType.string => value is String,
        KvValueType.number => value is num,
        KvValueType.boolean => value is bool,
        KvValueType.binary => value is List<int>,
      };

  KvValue value(Object value) {
    final result = switch (this) {
      KvValueType.string => KvString(value as String),
      KvValueType.number => KvNumber(value as num),
      KvValueType.boolean => KvBoolean(value as bool),
      KvValueType.binary => KvBinary(value as List<int>),
    };
    return result as KvValue;
  }
}

sealed class KvValue<T> {
  final T value;
  const KvValue._(this.value);

  @internal
  static KvValue from(Object object) {
    return KvValueType.typeOf(object).value(object);
  }

  @internal
  static KvValue<T> fromJson<T extends Object>(Map<String, dynamic> json) {
    final value = json['value'];
    final type =
        KvValueType.values.firstWhereOrNull((t) => t.name == json['type']);
    if (type == null) {
      throw ArgumentError('KV value type not found: Type:${json['type']}');
    }

    return type.value(value) as KvValue<T>;
  }

  KvValueType get type {
    return switch (T) {
      const (String) => KvValueType.string,
      const (num) || const (int) || const (double) => KvValueType.number,
      const (bool) => KvValueType.boolean,
      const (List<int>) => KvValueType.binary,
      _ => throw ArgumentError('Invalid type: $T'),
    };
  }

  @override
  String toString() => value.toString();
}

class KvString extends KvValue<String> {
  const KvString(super.value) : super._();
}

class KvNumber extends KvValue<num> {
  const KvNumber(super.value) : super._();
}

class KvBoolean extends KvValue<bool> {
  const KvBoolean(super.value) : super._();
}

class KvBinary extends KvValue<List<int>> {
  const KvBinary(super.value) : super._();
}

final class KVListResult {
  final List<KvListResultItem> results;
  final bool complete;
  final String? cursor;
  KVListResult({
    required this.results,
    required this.complete,
    required this.cursor,
  });
}

final class KvListResultItem {
  final String key;
  final KvValueType type;
  final DateTime? expires;
  KvListResultItem(this.key, this.type, this.expires);
}
