import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:globe_functions/globe_functions.dart';
import 'package:globe_functions/src/spec/serializer.dart';
import 'package:globe_functions/src/spec/sourced_imports.dart';
import 'package:source_gen/source_gen.dart';

const _requestContextType = TypeChecker.fromRuntime(RequestContext);

final class UnsupportedType implements Exception {
  UnsupportedType(this.type);
  final InterfaceType type;

  @override
  String toString() {
    return 'UnsupportedType: $type';
  }
}

sealed class SupportedType {
  factory SupportedType.fromDartType({
    required DartType type,
    required SourcedImports imports,
    required LibraryElement library,
  }) {
    final interface = switch (type) {
      InterfaceType type => type,
      DynamicType _ =>
        throw InvalidGenerationSourceError(
          'Cannot return dynamic types.',
          element: type.element,
        ),
      NeverType _ =>
        throw InvalidGenerationSourceError(
          'Cannot return never types.',
          element: type.element,
        ),
      TypeParameterType _ =>
        throw InvalidGenerationSourceError(
          'Cannot return generic type parameters directly. Use a concrete type instead.',
          element: type.element,
        ),
      _ =>
        throw InvalidGenerationSourceError(
          'Unhandled type: ${type} ${type.runtimeType}',
          element: type.element,
        ),
    };

    final supported = switch (interface) {
      InterfaceType type when type.isDartAsyncFuture => FutureType(
        type,
        imports: imports,
        library: library,
      ),
      InterfaceType type when type.isDartAsyncFutureOr => FutureOrType(
        type,
        imports: imports,
        library: library,
      ),
      InterfaceType type when type.isDartAsyncStream => StreamType(
        type,
        imports: imports,
        library: library,
      ),
      InterfaceType type when type.isDartCoreNull => NullType(
        type,
        imports: imports,
        library: library,
      ),
      InterfaceType type when type.isDartCoreList => ListType(
        type,
        imports: imports,
        library: library,
      ),
      InterfaceType type when type.isDartCoreSet => SetType(
        type,
        imports: imports,
        library: library,
      ),
      InterfaceType type when type.isDartCoreMap => MapType(
        type,
        imports: imports,
        library: library,
      ),
      InterfaceType type when type.isDartCoreIterable => IterableType(
        type,
        imports: imports,
        library: library,
      ),
      InterfaceType type
          when type.isDartCoreBool ||
              type.isDartCoreDouble ||
              type.isDartCoreInt ||
              type.isDartCoreString ||
              type.isDartCoreNum ||
              type.element is DateTime =>
        CoreType(type, imports: imports, library: library),
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

    if (supported == null) {
      if (_requestContextType.isExactlyType(interface)) {
        return RequestContextType(
          interface,
          imports: imports,
          library: library,
        );
      }

      // If the type has a serializer, we can use the CoreType, e.g. DateTime.
      if (Serializers.instance.getFromType(interface) != null) {
        return CoreType(interface, imports: imports, library: library);
      }

      // Otherwise, its unknown (a user defined type).
      return UnknownType(interface, imports: imports, library: library);
    }

    return supported;
  }

  final InterfaceType type;
  final SourcedImports imports;
  final LibraryElement library;

  SupportedType(this.type, {required this.imports, required this.library});

  String get name => type.getDisplayString(withNullability: false);
  bool get isNullable => type.nullabilitySuffix == NullabilitySuffix.question;

  String get typeDefinition;

  void assertValid() => {};
}

final class UnknownType extends MultipleTypeArguments {
  UnknownType(super.type, {required super.imports, required super.library})
    : importId = imports.register(type.element.source.uri);

  final int importId;

  @override
  void assertValid() {
    if (typeArguments.isNotEmpty) {
      throw InvalidGenerationSourceError(
        'Unknown type cannot have type arguments',
        element: type.element,
      );
    }

    assertSerializable();
  }

  void assertSerializable() {
    final toJson = type.lookUpMethod2('toJson', library);
    final fromJson = type.lookUpConstructor('fromJson', library);

    if (toJson == null || fromJson == null) {
      throw InvalidGenerationSourceError(
        'Type is not serializable (missing toJson or fromJson method)',
        element: type.element,
      );
    }
  }

  @override
  String get typeDefinition {
    return 'i$importId.$name${isNullable ? '?' : ''}';
  }
}

final class AsyncType extends SingleTypeArgument {
  AsyncType(super.type, {required super.imports, required super.library});
}

final class SingleTypeArgument extends SupportedType {
  SingleTypeArgument(
    super.type, {
    required super.imports,
    required super.library,
  });
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

final class MultipleTypeArguments extends SupportedType {
  MultipleTypeArguments(
    super.type, {
    required super.imports,
    required super.library,
  });
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

final class FutureType extends AsyncType {
  FutureType(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'Future${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

final class FutureOrType extends AsyncType {
  FutureOrType(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'FutureOr${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

final class StreamType extends AsyncType {
  StreamType(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'Stream${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

final class MapType extends MultipleTypeArguments {
  MapType(super.type, {required super.imports, required super.library});

  @override
  void assertValid() {
    final first = typeArguments.first;
    final last = typeArguments.last;

    if (first is! CoreType && !first.type.isDartCoreString) {
      throw InvalidGenerationSourceError(
        'Map type must have a string key and a serializable value.',
        element: type.element,
      );
    }

    return switch (last) {
      AsyncType() =>
        throw InvalidGenerationSourceError(
          'Map type cannot have an async type argument',
          element: type.element,
        ),
      RequestContextType() => null,
      SupportedType type => type.assertValid(),
    };
  }

  @override
  String get typeDefinition =>
      'Map${isNullable ? '?' : ''}<${typeArguments.first.typeDefinition}, ${typeArguments.last.typeDefinition}>';
}

final class NullType extends SupportedType {
  NullType(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition => 'Null';
}

final class ListType extends SingleTypeArgument {
  ListType(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'List${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

final class SetType extends SingleTypeArgument {
  SetType(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'Set${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

final class IterableType extends SingleTypeArgument {
  IterableType(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition =>
      'Iterable${isNullable ? '?' : ''}<${typeArgument.typeDefinition}>';
}

final class CoreType extends SupportedType {
  CoreType(super.type, {required super.imports, required super.library});

  @override
  String get typeDefinition => '$name${isNullable ? '?' : ''}';
}

final class RequestContextType extends CoreType {
  RequestContextType(
    super.type, {
    required super.imports,
    required super.library,
  });

  @override
  String get typeDefinition => 'RequestContext';
}
