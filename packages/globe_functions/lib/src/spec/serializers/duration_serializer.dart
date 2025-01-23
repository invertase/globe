import 'package:globe_functions/src/spec/serializer.dart';

final class DurationSerializer extends Serializer<Duration> {
  /// Creates a [Serializer] for [Duration] objects.
  const DurationSerializer();

  @override
  String toWire(Duration value) {
    return value.inMicroseconds.toString();
  }

  @override
  Duration fromWire(Object? value) {
    return Duration(microseconds: int.parse(assertType<String>(value)));
  }
}
