import 'package:globe_functions/src/spec/serializer.dart';

final class UriDataSerializer extends Serializer<UriData> {
  /// Creates a [Serializer] for [UriData] objects.
  const UriDataSerializer();

  @override
  String toWire(UriData value) {
    return value.toString();
  }

  @override
  UriData fromWire(Object? value) {
    return UriData.parse(assertType<String>(value));
  }
}
