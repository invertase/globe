import 'dart:convert';
import 'dart:typed_data';

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

/// An interface for serializing and deserializing objects.
abstract class Serializer<T extends Object?> {
  const Serializer();

  /// Creates a new serializer with the given serialize and deserialize functions
  static Serializer<T> create<T extends Object?, W extends Object?>({
    required Object? Function(T value) serialize,
    required T Function(W value) deserialize,
  }) =>
      _FunctionSerializer<T, W>(
        serializeFn: serialize,
        deserializeFn: deserialize,
      );

  /// Serializes [value] to a JSON-compatible type
  /// If T is nullable, value may be null
  Object? serialize(T value);

  /// Deserializes [value] from a JSON-compatible type
  /// If value is null and T is nullable, returns null
  /// If value is null and T is non-nullable, throws an error
  T deserialize(Object? value);

  /// Helper to verify wire type and throw clear errors
  W assertWireType<W>(Object? value) {
    if (value == null) {
      if (null is T) {
        throw Exception('Cannot convert null to wire type $W for $runtimeType');
      }
      throw Exception(
        'Cannot deserialize null to non-nullable type $T for $runtimeType',
      );
    }
    if (value is! W) {
      throw Exception(
        'Expected wire type $W but got ${value.runtimeType} for $runtimeType',
      );
    }
    return value as W;
  }
}

class _FunctionSerializer<T extends Object?, W extends Object?>
    extends Serializer<T> {
  const _FunctionSerializer({
    required this.serializeFn,
    required this.deserializeFn,
  });

  final Object? Function(T value) serializeFn;
  final T Function(W value) deserializeFn;

  @override
  Object? serialize(T value) => value == null ? null : serializeFn(value);

  @override
  T deserialize(Object? value) {
    if (value == null) {
      if (null is T) {
        return null as T;
      }
      throw Exception(
        'Cannot deserialize null to non-nullable type ${T} for $runtimeType',
      );
    }
    return deserializeFn(assertWireType<W>(value));
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
  final _typeTokenSerializers = <String, Serializer>{};

  Serializers._() {
    // Register built-in serializers
    register(
      Serializer.create<String, String>(
        serialize: (v) => v,
        deserialize: (v) => v,
      ),
    );
    register(
      Serializer.create<int, num>(
        serialize: (v) => v,
        deserialize: (v) => v.toInt(),
      ),
    );
    register(
      Serializer.create<double, num>(
        serialize: (v) => v,
        deserialize: (v) => v.toDouble(),
      ),
    );
    register(
      Serializer.create<bool, bool>(serialize: (v) => v, deserialize: (v) => v),
    );
    register(
      Serializer.create<BigInt, String>(
        serialize: (v) => v.toString(),
        deserialize: (v) => BigInt.parse(v),
      ),
    );
    register(
      Serializer.create<DateTime, String>(
        serialize: (v) => v.toIso8601String(),
        deserialize: (v) => DateTime.parse(v),
      ),
    );
    register(
      Serializer.create<Duration, String>(
        serialize: (v) => v.inMicroseconds.toString(),
        deserialize: (v) => Duration(microseconds: int.parse(v)),
      ),
    );
    register(
      Serializer.create<RegExp, String>(
        serialize: (v) => v.pattern,
        deserialize: (v) => RegExp(v),
      ),
    );
    register(
      Serializer.create<Uri, String>(
        serialize: (v) => v.toString(),
        deserialize: (v) => Uri.parse(v),
      ),
    );
    register(
      Serializer.create<UriData, String>(
        serialize: (v) => v.toString(),
        deserialize: (v) => UriData.parse(v),
      ),
    );
    register(
      Serializer.create<Uint8List, String>(
        serialize: (v) => base64.encode(v),
        deserialize: (v) => v.isEmpty ? Uint8List(0) : base64.decode(v),
      ),
    );
  }

  /// Registers a serializer for the given type.
  void register<T>(Serializer<T> serializer) {
    _serializers[T] = serializer;
    // Also register with type token for generic types
    _typeTokenSerializers['$T'] = serializer;
  }

  /// Gets a serializer for the [DartType].
  Serializer<T>? getFromType<T>(DartType type) {
    final serializer = switch (type) {
      DartType _ when type.isDartCoreString => get<String>(),
      DartType _ when type.isDartCoreInt => get<int>(),
      DartType _ when type.isDartCoreDouble => get<double>(),
      DartType _ when type.isDartCoreBool => get<bool>(),
      DartType _ when type.isDartCoreMap => get<Map>(),
      DartType _ when type.isDartCoreList => get<List>(),
      DartType _ when type.isDartCoreSet => get<Set>(),
      DartType _ when type.isDartAsyncFuture => null,
      DartType _ when type.isDartAsyncStream => null,
      DartType _ when type.isDartCoreIterable => null,
      _ => _typeTokenSerializers[type.getDisplayString(withNullability: true)],
    };
    return serializer as Serializer<T>?;
  }

  Serializer<T> get<T>() {
    final serializer = _serializers[T] ?? _typeTokenSerializers['$T'];
    if (serializer == null) {
      throw Exception('No serializer registered for type $T');
    }
    return serializer as Serializer<T>;
  }

  T deserialize<T>(Object? value) => get<T>().deserialize(value);
  Object? serialize<T>(T value) => get<T>().serialize(value);
}
