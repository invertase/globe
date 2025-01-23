import 'package:globe_functions/src/spec/serializer.dart';

final class RegExpSerializer extends Serializer<RegExp> {
  /// Creates a [Serializer] for [RegExp] objects.
  const RegExpSerializer();

  @override
  String toWire(RegExp value) {
    return value.pattern;
  }

  @override
  RegExp fromWire(Object? value) {
    return RegExp(assertType<String>(value));
  }
}
