import 'package:globe_kv/globe_kv.dart';

void assertKey(String key) {
  assert(key.isNotEmpty, 'Key cannot be empty');
  assert(key != '.' && key != '..', 'Key cannot be . or ..');
}

KvValue<T> ensureValidType<T>(Object value) {
  final type = T != dynamic ? T : value.runtimeType;
  final result = switch (type) {
    const (String) => KvString(value as String),
    const (num) || const (int) || const (double) => KvNumber(value as num),
    const (bool) => KvBoolean(value as bool),
    const (List<int>) => KvBinary(value as List<int>),
    _ => throw ArgumentError(
        'Value must be a String, number, boolean or binary data',
      )
  };

  if (result is! KvValue<T>) {
    throw ArgumentError(
      'Type mismatch: Expected ${T.toString()} but got ${value.runtimeType}',
    );
  }

  return result;
}
