import 'package:globe_functions/src/spec/serializer.dart';

final class BigIntSerializer extends Serializer<BigInt> {
  /// Creates a [Serializer] for [BigInt] objects.
  const BigIntSerializer();

  @override
  String toWire(BigInt value) {
    return value.toString();
  }

  @override
  BigInt fromWire(Object? value) {
    return BigInt.parse(assertType<String>(value));
  }
}
