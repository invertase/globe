import 'package:globe_functions/src/spec/serializer.dart';

final class CoreSerializer<T> extends Serializer<T> {
  /// Creates a [Serializer] for core Dart types like [String], [int], [double], [bool], etc.
  /// 
  /// This serializer performs an as-is serialization, meaning the value is passed through
  /// without any transformation. The value must already be of a JSON-compatible type.
  const CoreSerializer();

  @override
  Object? toWire(T value) {
    return value;
  }

  @override
  T fromWire(Object? value) {
    return assertType<T>(value);
  }
}
