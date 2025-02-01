import 'package:shelf/shelf.dart' as shelf show Request;
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:shelf_rpc/src/build/sourced_imports.dart';
import 'package:shelf_rpc/src/serializers.dart';

/// A sealed class representing a [DartType] that can be used in the RPC.
sealed class SupportedType {
  /// The type checker for the [shelf.Request] type.
  static const _shelfRequestType = TypeChecker.fromRuntime(shelf.Request);

  /// Creates a new [SupportedType] instance from a [DartType].
  factory SupportedType.fromDartType({
    required DartType type,
    required SourcedImports imports,
    required LibraryElement library,
  }) {
    // Narrow down the type to an [InterfaceType] and throw errors for unsupported types.
    final interface = switch (type) {
      InterfaceType type => type,
      DynamicType _ => throw InvalidGenerationSourceError(
          'Cannot return dynamic types.',
          element: type.element,
        ),
      NeverType _ => throw InvalidGenerationSourceError(
          'Cannot return never types.',
          element: type.element,
        ),
      TypeParameterType _ => throw InvalidGenerationSourceError(
          'Cannot return generic type parameters directly. Use a concrete type instead.',
          element: type.element,
        ),
      _ => throw InvalidGenerationSourceError(
          'Unhandled type: $type ${type.runtimeType}',
          element: type.element,
        ),
    };

    // Narrow down the type to a supported type.
    final supported = switch (interface) {
      InterfaceType type when type.isDartAsyncFuture => FutureType._(
          type,
          imports: imports,
          library: library,
        ),
      InterfaceType type when type.isDartAsyncFutureOr => FutureOrType._(
          type,
          imports: imports,
          library: library,
        ),
      InterfaceType type when type.isDartAsyncStream => StreamType._(
          type,
          imports: imports,
          library: library,
        ),
      InterfaceType type when type.isDartCoreNull => NullType._(
          type,
          imports: imports,
          library: library,
        ),
      InterfaceType type when type.isDartCoreList => ListType._(
          type,
          imports: imports,
          library: library,
        ),
      InterfaceType type when type.isDartCoreSet => SetType._(
          type,
          imports: imports,
          library: library,
        ),
      InterfaceType type when type.isDartCoreMap => MapType._(
          type,
          imports: imports,
          library: library,
        ),
      InterfaceType type when type.isDartCoreIterable => IterableType._(
          type,
          imports: imports,
          library: library,
        ),
      // Handle the core types.
      InterfaceType type
          when type.isDartCoreBool ||
              type.isDartCoreDouble ||
              type.isDartCoreInt ||
              type.isDartCoreString ||
              type.isDartCoreNum =>
        CoreType(type, imports: imports, library: library),
      // Throw on any unsupported types.
      InterfaceType type
          when type.isDartCoreEnum ||
              type.isDartCoreSymbol ||
              type.isDartCoreObject ||
              type.isDartCoreRecord ||
              type.isDartCoreType ||
              type.isDartCoreFunction =>
        throw InvalidGenerationSourceError(
          'RPC does not support type $type',
          element: interface.element,
        ),
      InterfaceType _ => null,
    };

    // If the type is not supported, apply further checks.
    if (supported == null) {
      // If the type is a RequestContext, return the RequestContextType.
      if (_shelfRequestType.isExactlyType(interface)) {
        return ShelfRequestType(
          interface,
          imports: imports,
          library: library,
        );
      }

      // If the type has a serializer, we can use the CoreType, e.g. DateTime.
      if (Serializers.instance.getFromType(interface) != null) {
        return CoreType(interface, imports: imports, library: library);
      }

      // Otherwise, its unknown (a user defined type or something else).
      return UnknownType(interface, imports: imports, library: library);
    }

    return supported;
  }

  /// The [InterfaceType] that was used to create the [SupportedType].
  final InterfaceType type;

  /// The [SourcedImports] instance.
  final SourcedImports imports;

  /// The [LibraryElement] that was used to create the [SupportedType].
  final LibraryElement library;

  /// Creates a new [SupportedType] instance.
  SupportedType(this.type, {required this.imports, required this.library});

  /// The name of the type.
  String get name => type.getDisplayString(withNullability: false);

  /// Whether the type is nullable.
  bool get isNullable => type.nullabilitySuffix == NullabilitySuffix.question;

  /// The type definition of the type.
  /// This also should include any prefixed imports.
  String get typeDefinition;

  /// An interface to allow subclasses to assert the type is valid.
  void assertValid() => {};
}

/// A [SupportedType] that is unknown (a user defined type or something else).
final class UnknownType extends MultipleTypeArguments {
  /// Creates a new [UnknownType] instance.
  UnknownType(super.type, {required super.imports, required super.library})
      : importId = imports.register(type.element.source.uri);

  /// The import ID of the type.
  final int importId;

  @override
  void assertValid() {
    // We can't support unknown types with type arguments,
    // otherwise things just start getting complex.
    if (typeArguments.isNotEmpty) {
      throw InvalidGenerationSourceError(
        'Unknown type cannot have type arguments',
        element: type.element,
      );
    }

    assertSerializable();
  }

  /// Asserts that the type is serializable.
  void assertSerializable() {
    // TOOD: Improve this - should have no args.
    final toJson = type.lookUpMethod2('toJson', library);
    // TOOD: Improve this - should have 1 Map<String, dynamic> arg.
    final fromJson = type.lookUpConstructor('fromJson', library);

    if (toJson == null || fromJson == null) {
      throw InvalidGenerationSourceError(
        'Type is not serializable (missing or invalid toJson or fromJson method)',
        element: type.element,
      );
    }
  }

  @override
  String get typeDefinition {
    return 'i$importId.$name${isNullable ? '?' : ''}';
  }
}

/// Represents an async type with a single type argument.
/// For example: [Future<String>], [Stream<String>], etc.
final class AsyncType extends SingleTypeArgument {
  AsyncType(super.type, {required super.imports, required super.library});
}

/// Represents a type with a single type argument.
/// For example: [List<String>], [Set<String>], etc.
final class SingleTypeArgument extends SupportedType {
  /// Creates a new [SingleTypeArgument] instance.
  SingleTypeArgument(super.type,
      {required super.imports, required super.library});

  /// The [SupportedType] argument of the type.
  SupportedType get typeArgument => SupportedType.fromDartType(
        type: type.typeArguments.first,
        imports: imports,
        library: library,
      );

  @override
  void assertValid() {
    typeArgument.assertValid();
  }

  @override
  String get typeDefinition => '$name${isNullable ? '?' : ''}';
}

/// Represents a type with multiple type arguments.
/// For example: [Map<String, int>], etc.
final class MultipleTypeArguments extends SupportedType {
  /// Creates a new [MultipleTypeArguments] instance.
  MultipleTypeArguments(super.type,
      {required super.imports, required super.library});

  /// The [SupportedType] arguments of the type.
  Iterable<SupportedType> get typeArguments => type.typeArguments.map(
        (type) => SupportedType.fromDartType(
          type: type,
          imports: imports,
          library: library,
        ),
      );

  @override
  String get typeDefinition =>
      typeArguments.map((t) => t.typeDefinition).join(', ');
}

/// Represents a [Future] type with a single type argument.
/// For example: [Future<String>], etc.
final class FutureType extends AsyncType {
  FutureType._(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'Future${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

/// Represents a [FutureOr] type with a single type argument.
/// For example: [FutureOr<String>], etc.
final class FutureOrType extends AsyncType {
  FutureOrType._(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'FutureOr${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

/// Represents a [Stream] type with a single type argument.
/// For example: [Stream<String>], etc.
final class StreamType extends AsyncType {
  StreamType._(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'Stream${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

/// Represents a [Map] type with a string key and a serializable value.
/// For example: [Map<String, int>], etc.
final class MapType extends MultipleTypeArguments {
  MapType._(super.type, {required super.imports, required super.library});

  @override
  void assertValid() {
    final first = typeArguments.first;
    final last = typeArguments.last;

    // For a [Map] to be serializable, the key must be a string.
    if (first is! CoreType && !first.type.isDartCoreString) {
      throw InvalidGenerationSourceError(
        'Map type must have a string key and a serializable value.',
        element: type.element,
      );
    }

    // For a [Map] to be serializable, the value must be serializable.
    return switch (last) {
      AsyncType() => throw InvalidGenerationSourceError(
          'Map type cannot have an async type argument',
          element: type.element,
        ),
      ShelfRequestType() => null,
      SupportedType type => type.assertValid(),
    };
  }

  @override
  String get typeDefinition =>
      'Map${isNullable ? '?' : ''}<${typeArguments.first.typeDefinition}, ${typeArguments.last.typeDefinition}>';
}

/// Represents a [Null] type.
/// For example: [Null], etc.
final class NullType extends SupportedType {
  NullType._(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition => 'Null';
}

/// Represents a [List] type with a single type argument.
/// For example: [List<String>], etc.
final class ListType extends SingleTypeArgument {
  ListType._(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'List${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

/// Represents a [Set] type with a single type argument.
/// For example: [Set<String>], etc.
final class SetType extends SingleTypeArgument {
  SetType._(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'Set${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

/// Represents an [Iterable] type with a single type argument.
/// For example: [Iterable<String>], etc.
final class IterableType extends SingleTypeArgument {
  IterableType._(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'Iterable${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

/// Represents a core type.
/// For example: [String], [int], [bool], etc.
final class CoreType extends SupportedType {
  CoreType(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition => '$name${isNullable ? '?' : ''}';
}

/// Represents a [ShelfRequestType] type.
final class ShelfRequestType extends CoreType {
  ShelfRequestType(super.type,
      {required super.imports, required super.library});

  @override
  String get typeDefinition => 'Request';
}
