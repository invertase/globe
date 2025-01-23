import 'package:globe_functions/src/spec/serializer.dart';

final class UriSerializer extends Serializer<Uri> {
  /// Creates a [Serializer] for [Uri] objects.
  const UriSerializer();

  @override
  String toWire(Uri value) {
    return value.toString();
  }

  @override
  Uri fromWire(Object? value) {
    return Uri.parse(assertType<String>(value));
  }
}
