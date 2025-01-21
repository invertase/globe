import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

enum SerializerType {
  string,
  int,
  num,
  double,
  bool,
  map,
  dateTime,
  uri,
  list,
  set,
  duration,
  bigInt,
  regExp,
  runes,
  symbol,
  clazz,
}

const checkers = (
  dateTime: TypeChecker.fromRuntime(DateTime),
  uri: TypeChecker.fromRuntime(Uri),
  duration: TypeChecker.fromRuntime(Duration),
  bigInt: TypeChecker.fromRuntime(BigInt),
  regExp: TypeChecker.fromRuntime(RegExp),
  runes: TypeChecker.fromRuntime(Runes),
  symbol: TypeChecker.fromRuntime(Symbol),
  list: TypeChecker.fromRuntime(List),
  set: TypeChecker.fromRuntime(Set),
  map: TypeChecker.fromRuntime(Map),
);

SerializerType? serializerTypeFromDartType(DartType type) {
  return switch (type) {
    DartType _ when type.isDartCoreString => SerializerType.string,
    DartType _ when type.isDartCoreInt => SerializerType.int,
    DartType _ when type.isDartCoreDouble => SerializerType.double,
    DartType _ when type.isDartCoreBool => SerializerType.bool,
    DartType _ when type.isDartCoreMap => SerializerType.map,
    DartType _ when checkers.dateTime.isExactlyType(type) => SerializerType.dateTime,
    DartType _ when checkers.uri.isExactlyType(type) => SerializerType.uri,
    DartType _ when checkers.list.isExactlyType(type) => SerializerType.list,
    DartType _ when checkers.set.isExactlyType(type) => SerializerType.set,
    DartType _ when checkers.duration.isExactlyType(type) => SerializerType.duration,
    DartType _ when checkers.bigInt.isExactlyType(type) => SerializerType.bigInt,
    DartType _ when checkers.regExp.isExactlyType(type) => SerializerType.regExp,
    DartType _ when checkers.runes.isExactlyType(type) => SerializerType.runes,
    DartType _ when checkers.symbol.isExactlyType(type) => SerializerType.symbol,
    DartType _ when type is InterfaceType => SerializerType.clazz,
    _ => null,
  };
}

assertIsSerializableClass(InterfaceType type, LibraryElement library) {
  final toJson = type.getMethod('toJson');
  final fromJson = type.lookUpConstructor('fromJson', library);

  if (toJson == null || fromJson == null) {
    print('here');
    print(type.getDisplayString());
    throw SerializerException(
      'Class ${type.getDisplayString()} does not have a toJson method or a fromJson constructor.',
    );
  }

  // TODO: Add further checks (no required parameters, etc.)
}

Object? serialize(SerializerType type, Object? value) {
  if (value == null) {
    return null;
  }

  switch (type) {
    case SerializerType.string:
    case SerializerType.int:
    case SerializerType.num:
    case SerializerType.double:
    case SerializerType.bool:
      return value;
    case SerializerType.map:
    case SerializerType.list:
      return jsonEncode(value);
    case SerializerType.dateTime:
      return (value as DateTime).toIso8601String();
    case SerializerType.uri:
      return (value as Uri).toString();
    case SerializerType.set:
      return jsonEncode((value as Set).toList());
    case SerializerType.duration:
      return (value as Duration).inMicroseconds;
    case SerializerType.bigInt:
      return (value as BigInt).toString();
    case SerializerType.regExp:
      return (value as RegExp).pattern;
    case SerializerType.runes:
      return (value as Runes).string;
    case SerializerType.symbol:
      return (value as Symbol).toString();
    case SerializerType.clazz:
      return (value as SerializedClass).toJson();
  }
}

Object? deserialize(SerializerType type, Object? value) {
  if (value == null) {
    return null;
  }

  switch (type) {
    case SerializerType.string:
    case SerializerType.int:
    case SerializerType.num:
    case SerializerType.double:
    case SerializerType.bool:
      return value;
    case SerializerType.map:
      return jsonDecode(value as String) as Map<String, dynamic>;
    case SerializerType.list:
      return jsonDecode(value as String) as List<dynamic>;
    case SerializerType.dateTime:
      return DateTime.parse(value as String);
    case SerializerType.uri:
      return Uri.parse(value as String);
    case SerializerType.set:
      return Set.from(jsonDecode(value as String) as List);
    case SerializerType.duration:
      return Duration(microseconds: value as int);
    case SerializerType.bigInt:
      return BigInt.parse(value as String);
    case SerializerType.regExp:
      return RegExp(value as String);
    case SerializerType.runes:
      return (value as String).runes;
    case SerializerType.symbol:
      return Symbol(value as String);
    case SerializerType.clazz:
      throw UnimplementedError(
        'Class deserialization must be handled by the class itself',
      );
  }
}

abstract class SerializedClass {
  Object toJson();
}

// class Serializer {
//   final String type;
//   final Function? serializer;
//   final Function? deserializer;

//   Serializer._(
//     this.type, {
//     required this.serializer,
//     required this.deserializer,
//   });

//   static void validateIsSerializable(
//     InterfaceType type,
//     LibraryElement library,
//   ) {
//     final toJson = type.getMethod('toJson');
//     final fromJson = type.lookUpConstructor('fromJson', library);

//     if (toJson == null || fromJson == null) {
//       throw SerializerException(
//         'Class ${type.getDisplayString()} does not have a toJson method or a fromJson constructor.',
//       );
//     }

//     // TODO: Add further checks (no required parameters, etc.)
//   }

//   factory Serializer.fromType(DartType type, LibraryElement library) {
//     switch (type) {
//       case DartType _ when type.isDartCoreString:
//         return Serializer._(
//           'String',
//           serializer: (value) => value.toString(),
//           deserializer: (value) => value as String,
//         );
//       case DartType _ when type.isDartCoreInt:
//         return Serializer._(
//           'int',
//           serializer: (value) => value as int,
//           deserializer: (value) => value as int,
//         );
//       case DartType _ when type.isDartCoreDouble:
//         return Serializer._(
//           'double',
//           serializer: (value) => value as double,
//           deserializer: (value) => value as double,
//         );
//       case DartType _ when type.isDartCoreBool:
//         return Serializer._(
//           'bool',
//           serializer: (value) => value as bool,
//           deserializer: (value) => value as bool,
//         );
//       case DartType _ when type.isDartCoreMap:
//         return Serializer._(
//           'Map',
//           serializer: (value) => jsonEncode(value),
//           deserializer: (value) => jsonDecode(value as String),
//         );
//       case DartType _ when type is DateTime:
//         return Serializer._(
//           'DateTime',
//           serializer: (value) => (value as DateTime).toIso8601String(),
//           deserializer: (value) => DateTime.parse(value as String),
//         );
//       case DartType _ when type is Uri:
//         return Serializer._(
//           'Uri',
//           serializer: (value) => (value as Uri).toString(),
//           deserializer: (value) => Uri.parse(value as String),
//         );
//       case DartType _ when type.isDartCoreList:
//         return Serializer._(
//           'List',
//           serializer: (value) => jsonEncode(value),
//           deserializer: (value) => jsonDecode(value as String),
//         );
//       case DartType _ when type.isDartCoreSet:
//         return Serializer._(
//           'Set',
//           serializer: (value) => jsonEncode(value.toList()),
//           deserializer: (value) => Set.from(jsonDecode(value as String)),
//         );
//       case DartType _ when type.isDartCoreNum:
//         return Serializer._(
//           'num',
//           serializer: (value) => value as num,
//           deserializer: (value) => value as num,
//         );
//       case DartType _ when type is Duration:
//         return Serializer._(
//           'Duration',
//           serializer: (value) => (value as Duration).inMicroseconds,
//           deserializer: (value) => Duration(microseconds: value as int),
//         );
//       case DartType _ when type is BigInt:
//         return Serializer._(
//           'BigInt',
//           serializer: (value) => (value as BigInt).toString(),
//           deserializer: (value) => BigInt.parse(value as String),
//         );
//       case DartType _ when type is RegExp:
//         return Serializer._(
//           'RegExp',
//           serializer: (value) => (value as RegExp).pattern,
//           deserializer: (value) => RegExp(value as String),
//         );
//       case DartType _ when type is Runes:
//         return Serializer._(
//           'Runes',
//           serializer: (value) => (value as Runes).string,
//           deserializer: (value) => Runes(value as String),
//         );
//       case DartType _ when type is Symbol:
//         return Serializer._(
//           'Symbol',
//           serializer: (value) => (value as Symbol).toString(),
//           deserializer:
//               (value) => Symbol(
//                 value.toString().substring(8, value.toString().length - 1),
//               ),
//         );
//       case DartType _ when type is InterfaceType:
//         final toJson = type.getMethod('toJson');
//         final fromJson = type.lookUpConstructor('fromJson', library);

//         if (toJson == null || fromJson == null) {
//           throw SerializerException(
//             'Class ${type.getDisplayString()} does not have a toJson method or a fromJson constructor.',
//           );
//         }

//         return Serializer._('Class', serializer: null, deserializer: null);
//       default:
//         throw SerializerException('Unsupported type: ${type.toString()}');
//     }
//   }

//   /// Serializes a value using the serializer function.
//   Map<String, dynamic> toJson(dynamic value) {
//     if (serializer == null) {
//       return {'type': type, 'value': null};
//     }

//     return {'type': type, 'value': serializer!(value)};
//   }
// }

final class SerializerException implements Exception {
  final String message;
  SerializerException(this.message);
}
