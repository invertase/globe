import 'dart:convert';
import 'dart:typed_data';
import 'package:globe_functions/src/spec/serializer.dart';

final class Uint8ListSerializer extends Serializer<Uint8List> {
  /// Creates a [Serializer] for [Uint8List] objects.
  const Uint8ListSerializer();

  @override
  String toWire(Uint8List value) {
    return base64.encode(value);
  }

  @override
  Uint8List fromWire(Object? value) {
    final str = assertType<String>(value);
    if (str.isEmpty) return Uint8List(0);
    return base64.decode(str);
  }
}
