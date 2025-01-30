// import 'package:analyzer/dart/element/nullability_suffix.dart';
// import 'package:analyzer/dart/element/type.dart';
// import 'package:globe_functions/src/build/source_rpc_builder.dart';
// import 'package:globe_functions/src/spec/serializer.dart';
// import 'package:globe_functions/src/spec/sourced_type.dart';

// class SourcedSerializers {
//   final _types = <String, SourcedType>{};

//   SourcedSerializers();

//   void register(SourcedType info) {
//     // Get the full typedef of the type, e.g. `Map<String, i0.User>`
//     final typedef = info.typeDefinition;

//     // Don't register the same type twice.
//     if (_types.containsKey(typedef)) {
//       return;
//     }

//     // Register the type.
//     _types[typedef] = info;
//   }

//   String generateRegistrationCode() {
//     final b = StringBuffer();
//     b.writeln('void registerSerializers() {');

//     for (final info in _types.values) {
//       final typedef = info.typeDefinition;
//       b.writeln('Serializers.instance.register<$typedef, String>(');
//       b.writeln('  Serializer.create<$typedef}>(');

//       if (info.kind == SourcedTypeKind.list) {
//         final innerType = info.typeArguments.first;
//         final typedef = innerType.typeDefinition;

//         // Serialize the list.
//         b.writeln('serialize: ($typedef value) => jsonEncode(');
//         b.writeln('  value.map((i) => i.toJson()).toList(),');
//         b.writeln('),');

//         b.writeln('    deserialize: (value) {');
//         if (info.isNullable) {
//           b.writeln('      if (value == null) {');
//           b.writeln(
//             '        throw Exception("Cannot deserialize null value");',
//           );
//           b.writeln('      }');
//         }
//         b.writeln(
//           '      final json = value is String ? jsonDecode(value) : value;',
//         );
//         b.writeln('      return (json as List)');
//         b.writeln('          .map((item) => $innerTypeName.fromJson(item))');
//         b.writeln('          .toList();');
//         b.writeln('    }');
//       } else if (info.kind == SourcedTypeKind.set) {
//         b.writeln('    serialize: (value) => jsonEncode(value.toJson()),');
//       } else {
//         b.writeln('    serialize: (value) => jsonEncode(value.toJson()),');
//       }

//       b.writeln('    serialize: (value) => jsonEncode(value.toJson()),');
//       b.writeln('    deserialize: (value) {');
//       b.writeln('      if (value == null) {');
//       b.writeln('        throw Exception("Cannot deserialize null value");');
//       b.writeln('      }');
//       b.writeln(
//         '      final json = value is String ? jsonDecode(value) : value;',
//       );
//       b.writeln('      return $typedef.fromJson(json);');
//       b.writeln('    }');

//       b.writeln('  )');
//       b.writeln(');');
//     }

//     b.writeln('}');
//     return b.toString();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'serializers': {
//         for (final entry in _types.entries) entry.key: entry.value.toJson(),
//       },
//     };
//   }

//   factory SourcedSerializers.fromJson(Map<String, dynamic> json) {
//     final serializers = SourcedSerializers();
//     final map = json['serializers'] as Map<String, dynamic>;

//     for (final entry in map.entries) {
//       final info = SourcedType.fromJson(entry.value as Map<String, dynamic>);
//       serializers._types[entry.key] = info;
//     }

//     return serializers;
//   }
// }
