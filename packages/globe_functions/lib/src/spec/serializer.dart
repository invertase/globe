import 'dart:typed_data';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:globe_functions/src/spec/serializers/big_int_serializer.dart';
import 'package:globe_functions/src/spec/serializers/core_serializer.dart';
import 'package:globe_functions/src/spec/serializers/date_time_serializer.dart';
import 'package:globe_functions/src/spec/serializers/duration_serializer.dart';
import 'package:globe_functions/src/spec/serializers/regexp_serializer.dart';
import 'package:globe_functions/src/spec/serializers/uint8list_serialzier.dart';
import 'package:globe_functions/src/spec/serializers/uri_data_serializer.dart';
import 'package:globe_functions/src/spec/serializers/uri_serializer.dart';
import 'package:source_gen/source_gen.dart';

abstract class Serializer<T> {
  const Serializer();

  /// Serializes [value] to a JSON-compatible type
  Object? toWire(T value);

  /// Deserializes [value] from a JSON-compatible type
  T fromWire(Object? value);

  /// Helper to verify wire type and throw clear errors
  W assertType<W>(Object? value) {
    if (value is! W) {
      throw Exception('Expected $W but got ${value.runtimeType}');
    }
    return value;
  }
}

class Serializers {
  static final _instance = Serializers._();
  static Serializers get instance => _instance;

  static const bigInt = TypeChecker.fromRuntime(BigInt);
  static const dateTime = TypeChecker.fromRuntime(DateTime);
  static const duration = TypeChecker.fromRuntime(Duration);
  static const regExp = TypeChecker.fromRuntime(RegExp);
  static const uri = TypeChecker.fromRuntime(Uri);
  static const uriData = TypeChecker.fromRuntime(UriData);
  static const uint8List = TypeChecker.fromRuntime(Uint8List);
  static const list = TypeChecker.fromRuntime(List);
  static const map = TypeChecker.fromRuntime(Map);

  final _serializers = <Type, Serializer>{};

  static bool isSerializableInterface(
    InterfaceType type,
    LibraryElement library,
  ) {
    final toJson = type.lookUpMethod2('toJson', library);
    final fromJson = type.lookUpConstructor('fromJson', library);
    return toJson != null && fromJson != null;
  }

  Serializer<T>? getFromType<T>(DartType type) {
    return switch (type) {
          DartType _ when type.isDartCoreString => get<String>(),
          DartType _ when type.isDartCoreInt => get<int>(),
          DartType _ when type.isDartCoreDouble => get<double>(),
          DartType _ when type.isDartCoreBool => get<bool>(),
          DartType _ when type.isDartCoreMap => get<Map>(),
          DartType _ when dateTime.isExactlyType(type) => get<DateTime>(),
          DartType _ when uri.isExactlyType(type) => get<Uri>(),
          DartType _ when uriData.isExactlyType(type) => get<UriData>(),
          DartType _ when list.isExactlyType(type) => get<List>(),
          DartType _ when duration.isExactlyType(type) => get<Duration>(),
          DartType _ when bigInt.isExactlyType(type) => get<BigInt>(),
          DartType _ when regExp.isExactlyType(type) => get<RegExp>(),
          DartType _ when uint8List.isExactlyType(type) => get<Uint8List>(),
          _ => null,
        }
        as Serializer<T>?;
  }

  Serializers._() {
    // Register built-in serializers
    register(const CoreSerializer<String>());
    register(const CoreSerializer<int>());
    register(const CoreSerializer<double>());
    register(const CoreSerializer<bool>());
    register(const CoreSerializer<List>());
    register(const CoreSerializer<Map>());
    register(const BigIntSerializer());
    register(const DateTimeSerializer());
    register(const DurationSerializer());
    register(const RegExpSerializer());
    register(const Uint8ListSerializer());
    register(const UriDataSerializer());
    register(const UriSerializer());
  }

  void register<T>(Serializer<T> serializer) {
    _serializers[T] = serializer;
  }

  Serializer<T> get<T>() {
    final serializer = _serializers[T];
    if (serializer == null) {
      throw Exception('No serializer registered for type $T');
    }
    return serializer as Serializer<T>;
  }

  T deserialize<T>(Object? value) => get<T>().fromWire(value);
  Object? serialize<T>(T value) => get<T>().toWire(value);
}

// Example built-in serializer:

// Usage:
// final serializers = Serializers.instance;
// serializers.register(const DateTimeSerializer());
// final date = serializers.deserialize<DateTime>("2024-03-14");
// final wire = serializers.serialize(date);
