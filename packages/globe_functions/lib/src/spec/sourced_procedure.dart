// import 'package:globe_functions/src/spec/sourced_parameter.dart';
// import 'package:globe_functions/src/spec/sourced_type.dart';

// class SourcedProcedure {
//   SourcedProcedure({
//     required this.id,
//     required this.type,
//     required this.parameters,
//   });

//   /// The RPC ID of the procedure.
//   final String id;

//   /// The type of the procedure.
//   final SourcedType type;

//   /// The parameters of the procedure.
//   final List<SourcedParameter> parameters;

//   String get typeDefinition {
//     final b = StringBuffer();

//     // Write the return type def (e.g. String, Future<String>, etc.)
//     b.write(type.typeDefinition);

//     b.write(' Function(');
//     final positional = parameters.where((p) => p.isPositional && !p.isOptional);
//     final optional = parameters.where((p) => p.isPositional && p.isOptional);
//     final named = parameters.where((p) => p.isNamed);

//     b.write(positional.map((p) => p.type.typeDefinition).join(', '));

//     if (optional.isNotEmpty) {
//       if (positional.isNotEmpty) b.write(', ');
//       b.write('[${optional.map((p) => p.type.typeDefinition).join(', ')}]');
//     }

//     if (named.isNotEmpty) {
//       if (positional.isNotEmpty || optional.isNotEmpty) b.write(', ');
//       b.write(
//         '{${named.map((p) => '${p.isRequired ? "required " : ""}${p.type.typeDefinition} ${p.name}').join(', ')}}',
//       );
//     }
//     b.write(')');

//     return b.toString();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'type': type.toJson(),
//       'parameters': parameters.map((p) => p.toJson()).toList(),
//     };
//   }

//   static SourcedProcedure fromJson(Map<String, dynamic> json) {
//     return SourcedProcedure(
//       id: json['id'] as String,
//       type: SourcedType.fromJson(json['type'] as Map<String, dynamic>),
//       parameters:
//           (json['parameters'] as List)
//               .map((p) => SourcedParameter.fromJson(p as Map<String, dynamic>))
//               .toList(),
//     );
//   }
// }
