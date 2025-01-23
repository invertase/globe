import 'package:globe_functions/src/spec/serializer.dart';

class DateTimeSerializer extends Serializer<DateTime> {
  const DateTimeSerializer();

  @override
  String toWire(DateTime value) => value.toIso8601String();

  @override
  DateTime fromWire(Object? value) =>
      DateTime.parse(assertType<String>(value));
}
