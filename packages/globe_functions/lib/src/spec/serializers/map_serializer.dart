import 'dart:convert';

import 'package:globe_functions/src/spec/serializer.dart';

final class MapSerializer extends Serializer<Map> {
  const MapSerializer();

  @override
  Object? serialize(Map value) {
    return value.map(
      (key, val) => MapEntry(
        key,
        val == null
            ? null
            : val is Map || val is List
            ? serialize(val)
            : val,
      ),
    );
  }

  @override
  Map deserialize(Object? value) {
    if (value == null) return {};
    final map = assertWireType<Map>(value);
    return map.map(
      (key, val) => MapEntry(
        key,
        val == null
            ? null
            : val is Map || val is List
            ? deserialize(val)
            : val,
      ),
    );
  }
}
