import 'dart:convert';

import 'package:globe_functions/src/spec/serializer.dart';

final class SetSerializer extends Serializer<Set> {
  const SetSerializer();

  @override
  Object? serialize(Set value) {
    return value
        .map(
          (item) =>
              item == null
                  ? null
                  : item is List || item is Map
                  ? serialize(item)
                  : item,
        )
        .toList();
  }

  @override
  Set deserialize(Object? value) {
    if (value == null) return {};
    final list = assertWireType<List>(value);
    return list
        .map(
          (item) =>
              item == null
                  ? null
                  : item is List || item is Map
                  ? deserialize(item)
                  : item,
        )
        .toSet();
  }
}
