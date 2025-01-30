// import 'package:analyzer/dart/element/element.dart';
// import 'package:analyzer/dart/element/nullability_suffix.dart';
// import 'package:analyzer/dart/element/type.dart';
// import 'package:globe_functions/src/build/source_rpc_builder.dart';
// import 'package:globe_functions/src/spec/serializer.dart';
// import 'package:globe_functions/src/spec/sourced_imports.dart';
// import 'package:source_gen/source_gen.dart';

// enum SourcedTypeKind {
//   /// Whether the type is a [Future]
//   future(name: 'Future', supported: true, streamable: false),

//   /// Whether the type is a [FutureOr]
//   futureOr(name: 'FutureOr', supported: true, streamable: false),

//   /// Whether the type is a [Stream]
//   stream(name: 'Stream', supported: true, streamable: true),

//   /// Whether the type is an [Iterable]
//   iterable(name: 'Iterable', supported: true, streamable: true),

//   /// Whether the type is a [List]
//   list(name: 'List', supported: true, streamable: false),

//   /// Whether the type is a [Set]
//   set(name: 'Set', supported: true, streamable: false),

//   /// Whether the type is a [Map]
//   map(name: 'Map', supported: true, streamable: false),

//   /// Whether the type is a [Null]
//   null_(name: 'Null', supported: true, streamable: false),

//   /// Whether the type is a [Record]
//   record(name: 'Record', supported: false, streamable: false),

//   /// Whether the type is a core type, like [int], [String], [bool], etc.
//   core(name: null, supported: true, streamable: false),

//   /// Whether the type is a custom class/interface type.
//   unknown(name: null, supported: true, streamable: false),

//   /// Whether the type is void
//   void_(name: 'void', supported: true, streamable: false),

//   /// Whether the type is dynamic
//   dynamic_(name: 'dynamic', supported: false, streamable: false),

//   /// Whether the type is Never
//   never(name: 'Never', supported: false, streamable: false),

//   /// Whether the type is a Function
//   function(name: 'Function', supported: false, streamable: false),

//   /// Whether the type is an Object
//   object(name: 'Object', supported: false, streamable: false),

//   /// Whether the type is an Enum
//   enum_(name: 'Enum', supported: false, streamable: false);

//   final String? name;
//   final bool supported;
//   final bool streamable;

//   const SourcedTypeKind({
//     required this.name,
//     required this.supported,
//     this.streamable = false,
//   });
// }

// class SourcedType {
//   final String type;
//   final SourcedTypeKind? kind;
//   final bool isNullable;
//   final int? importId;
//   final List<SourcedType> typeArguments;

//   SourcedType({
//     required this.type,
//     required this.isNullable,
//     this.kind,
//     this.importId,
//     this.typeArguments = const [],
//   });

//   factory SourcedType.fromDartType({
//     required SourcedImports imports,
//     // required SourcedSerializers serializers,
//     required LibraryElement library,
//     required DartType type,
//     int depth = 0,
//   }) {
//     final kind = switch (type) {
//       // Future, FutureOr
//       InterfaceType type
//           when type.isDartAsyncFuture || type.isDartAsyncFutureOr =>
//         SourcedTypeKind.future,
//       // Stream
//       InterfaceType type when type.isDartAsyncStream => SourcedTypeKind.stream,
//       // Iterable
//       InterfaceType type when type.isDartCoreIterable =>
//         SourcedTypeKind.iterable,
//       // List
//       InterfaceType type when type.isDartCoreList => SourcedTypeKind.list,
//       // Set
//       InterfaceType type when type.isDartCoreSet => SourcedTypeKind.set,
//       // Map
//       InterfaceType type when type.isDartCoreMap => SourcedTypeKind.map,
//       // Enum
//       InterfaceType type when type.isDartCoreEnum => SourcedTypeKind.enum_,
//       // Record
//       InterfaceType type when type.isDartCoreRecord => SourcedTypeKind.record,
//       // Null
//       InterfaceType type when type.isDartCoreNull => SourcedTypeKind.null_,
//       // Enum
//       InterfaceType type when type.isDartCoreEnum => SourcedTypeKind.enum_,
//       // Object
//       InterfaceType type when type.isDartCoreObject => SourcedTypeKind.object,
//       // Function
//       InterfaceType type when type.isDartCoreFunction =>
//         SourcedTypeKind.function,
//       // Void
//       VoidType _ => SourcedTypeKind.void_,
//       // Dynamic
//       DynamicType _ => SourcedTypeKind.dynamic_,
//       // Never
//       NeverType _ => SourcedTypeKind.never,
//       // Core types
//       InterfaceType type
//           when type.isDartCoreBool ||
//               type.isDartCoreDouble ||
//               type.isDartCoreInt ||
//               type.isDartCoreString ||
//               type.isDartCoreNum =>
//         SourcedTypeKind.core,
//       // Custom types
//       InterfaceType _ => SourcedTypeKind.unknown,
//       // Unknown type, throw an error.
//       _ =>
//         throw InvalidGenerationSourceError(
//           'Unable to determine type kind (${type.runtimeType})',
//           element: type.element,
//         ),
//     };

//     // If the type is not supported, throw an error.
//     if (!kind.supported) {
//       throw InvalidGenerationSourceError(
//         'Type is not supported (${type.runtimeType})',
//         element: type.element,
//       );
//     }

//     if (depth > 0) {
//       switch (kind) {
//         case SourcedTypeKind.future:
//         case SourcedTypeKind.futureOr:
//         case SourcedTypeKind.stream:
//           throw InvalidGenerationSourceError(
//             'Nested async types are not supported',
//             element: type.element,
//           );
//         case _:
//           break;
//       }
//     }

//     final interface = type as InterfaceType;

//     if (kind == SourcedTypeKind.map) {
//       // First type argument must be a string.
//       if (!interface.typeArguments.first.isDartCoreString) {
//         throw InvalidGenerationSourceError(
//           'Map key type must be a String',
//           element: type.element,
//         );
//       }
//     }

//     // Get the serializer for the type, e.g. String, DateTime etc.
//     // Get the serializer for the type, e.g. String, DateTime etc.
//     final serializer = Serializers.instance.getFromType(interface);

//     int? importId;

//     // If we have no serializer, we need to register an import and assert
//     // that the type is serializable.
//     if (serializer == null) {
//       // If the type is not serializable, throw an error.
//       interface.assertSerializable(library);

//       // Register the import.
//       importId = imports.register(interface.element.source.uri);
//     }

//     // Compose the type arguments if they exist, e.g.
//     // Map<String, User> -> [String, User]
//     final arguments = [
//       for (final type in interface.typeArguments)
//         SourcedType.fromDartType(
//           imports: imports,
//           // serializers: serializers,
//           library: library,
//           type: type,
//           depth: depth + 1,
//         ),
//     ];

//     final sourced = SourcedType(
//       type: type.getDisplayString(withNullability: false),
//       isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
//       kind: kind,
//       importId: importId,
//       typeArguments: arguments,
//     );

//     return sourced;
//   }

//   String get typeDefinition {
//     final b = StringBuffer();
//     if (importId != null) b.write('i$importId.');
//     b.write(type);

//     if (typeArguments.isNotEmpty) {
//       b.write('<');
//       b.write(typeArguments.map((type) => type.typeDefinition).join(', '));
//       b.write('>');
//     }

//     if (isNullable) b.write('?');
//     return b.toString();
//   }

//   factory SourcedType.fromJson(Map<String, dynamic> json) {
//     return SourcedType(
//       type: json['type'] as String,
//       kind:
//           json['kind'] == null
//               ? null
//               : SourcedTypeKind.values.firstWhere(
//                 (e) => e.name == json['kind'],
//               ),
//       isNullable: json['isNullable'] as bool,
//       importId: json['importId'] as int?,
//       typeArguments:
//           (json['typeArguments'] as List)
//               .map((arg) => SourcedType.fromJson(arg as Map<String, dynamic>))
//               .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'type': type,
//     'isNullable': isNullable,
//     'kind': kind?.name,
//     'importId': importId,
//     'typeArguments': typeArguments.map((arg) => arg.toJson()).toList(),
//   };
// }

// extension on InterfaceType {
//   /// Asserts that the type is serializable, by checking for a
//   /// `toJson` method and a `fromJson` constructor.
//   assertSerializable(LibraryElement library) {
//     final toJson = lookUpMethod2('toJson', library);
//     final fromJson = lookUpConstructor('fromJson', library);

//     if (toJson == null) {
//       throw InvalidGenerationSourceError(
//         'Type is not serializable (missing toJson method)',
//         element: element,
//       );
//     }

//     if (fromJson == null) {
//       throw InvalidGenerationSourceError(
//         'Type is not serializable (missing fromJson constructor)',
//         element: element,
//       );
//     }
//   }
// }

// // import 'package:analyzer/dart/element/nullability_suffix.dart';
// // import 'package:analyzer/dart/element/type.dart';

// // enum SourcedTypeKind { future, stream, iterable, list, set, map }

// // class SourcedType {
// //   final String type;
// //   final bool isNullable;
// //   final SourcedTypeKind? kind;
// //   final int? importId;

// //   SourcedType({
// //     required this.type,
// //     required this.isNullable,
// //     required this.kind,
// //     required this.importId,
// //   });

// //   factory SourcedType.fromDartType({
// //     required DartType type,
// //     SourcedTypeKind? kind,
// //     int? importId,
// //   }) {
// //     return SourcedType(
// //       type: type.getDisplayString(withNullability: false),
// //       isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
// //       kind: kind,
// //       importId: importId,
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'type': type,
// //       'isNullable': isNullable,
// //       'kind': kind?.name,
// //       'importId': importId,
// //     };
// //   }

// //   factory SourcedType.fromJson(Map<String, dynamic> json) {
// //     return SourcedType(
// //       type: json['type'] as String,
// //       isNullable: json['isNullable'] as bool,
// //       kind:
// //           json['kind'] != null
// //               ? SourcedTypeKind.values.firstWhere((e) => e.name == json['kind'])
// //               : null,
// //       importId: json['importId'] as int?,
// //     );
// //   }
// // }
