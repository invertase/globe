// import 'dart:convert';

// import 'package:build/build.dart';
// import 'package:dart_style/dart_style.dart';
// import 'package:globe_functions/src/spec/sourced_entry.dart';
// import 'package:globe_functions/src/spec/sourced_parameter.dart';
// import 'package:globe_functions/src/spec/sourced_procedure.dart';
// import 'package:globe_functions/src/spec/sourced_type.dart';

// class RpcPipelineBuilder implements Builder {
//   final formatter = DartFormatter(
//     languageVersion: DartFormatter.latestLanguageVersion,
//   );

//   @override
//   Future<void> build(BuildStep buildStep) async {
//     final content = await buildStep.readAsString(buildStep.inputId);
//     final spec = json.decode(content) as Map<String, dynamic>;

//     final b = StringBuffer();

//     // Add imports
//     b.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
//     b.writeln(
//       '// ignore_for_file: non_constant_identifier_names, unused_local_variable, implementation_imports',
//     );
//     b.writeln();
//     b.writeln("import 'dart:convert';");
//     b.writeln("import 'package:shelf/shelf.dart';");
//     b.writeln("import 'package:globe_functions/src/shelf_rpc.dart';");
//     b.writeln(
//       "import 'package:globe_functions/src/server/request_context.dart';",
//     );
//     b.writeln("import 'package:globe_functions/src/spec/serializer.dart';");

//     // Add imports from spec
//     final imports = (spec['imports'] as List).asMap();
//     for (final entry in imports.entries) {
//       b.writeln("import '${entry.value}' as i${entry.key};");
//     }

//     b.writeln();

//     // Get entrypoints
//     final entrypoints = (spec['entrypoints'] as List<dynamic>).map(
//       (e) => SourcedEntry.fromJson(e as Map<String, dynamic>),
//     );

//     // Create handlers for each exported variable
//     for (final entrypoint in entrypoints) {
//       b.writeln('final ${entrypoint.name} = Pipeline()');
//       b.writeln('  .addHandler((Request request) async {');
//       b.writeln('    if (request.method != "POST") {');
//       b.writeln('      return Response(405, body: "Method not allowed");');
//       b.writeln('    }');
//       b.writeln('    final payload = await request.readAsString();');
//       b.writeln(
//         '    final json = jsonDecode(payload) as Map<String, dynamic>;',
//       );
//       b.writeln('    final id = json["id"] as String;');
//       b.writeln('    final params = json["params"] as Map<String, dynamic>;');

//       // Import the entrypoint from the users library.
//       b.writeln(
//         '    final _${entrypoint.name} = i${entrypoint.importId}.${entrypoint.name};',
//       );

//       // Create a pipeline and add middleware for the entrypoint.
//       b.writeln('    Pipeline pipeline = Pipeline();');
//       b.writeln();
//       b.writeln('    for (final m in _${entrypoint.name}.middleware) {');
//       b.writeln('      pipeline = pipeline.addMiddleware(m);');
//       b.writeln('    }');

//       // Add switch statement for procedures.
//       b.writeln();
//       b.writeln('    switch (id) {');

//       for (final procedure in entrypoint.procedures) {
//         b.writeln('      case "${procedure.id}":');
//         b.writeln(_buildHandlerCall(entrypoint, procedure));
//       }

//       b.writeln('      default:');
//       b.writeln('        return Response.notFound("Unknown procedure");');
//       b.writeln('    }');
//       b.writeln('  });');
//       b.writeln();
//     }

//     // Write the output file
//     final originalPath = buildStep.inputId.path.replaceAll(
//       '.shelf_rpc_spec.json',
//       '.dart',
//     );
//     final outputId = AssetId(
//       buildStep.inputId.package,
//       originalPath,
//     ).changeExtension('.server.dart');

//     await buildStep.writeAsString(outputId, formatter.format(b.toString()));
//   }

//   String _buildHandlerCall(
//     SourcedEntry entrypoint,
//     SourcedProcedure procedure,
//   ) {
//     final parts = procedure.id.split('.');

//     final b = StringBuffer();

//     if (parts.length == 1) {
//       b.writeln(
//         'final procedure = _${entrypoint.name}.routes[#${parts[0]}] as ExecutedProcedure;',
//       );
//       b.writeln('final middleware = procedure.middleware;');
//     } else {
//       var i = 0;
//       for (final part in parts) {
//         final isLast = i == parts.length - 1;
//         if (isLast) {
//           final prevVar =
//               i == 0 ? '_${entrypoint.name}' : '_${parts.take(i).join('_')}';
//           b.writeln(
//             'final procedure = $prevVar.routes[#$part] as ExecutedProcedure;',
//           );
//           b.writeln('final middleware = procedure.middleware;');
//         } else {
//           final prevVar =
//               i == 0 ? '_${entrypoint.name}' : '_${parts.take(i).join('_')}';
//           final nextVar = '_${parts.take(i + 1).join('_')}';
//           b.writeln('final $nextVar = $prevVar.routes[#$part] as Router;');
//         }
//         i++;
//       }
//     }

//     // Add middleware for the route.
//     b.writeln();
//     b.writeln('for (final m in middleware) {');
//     b.writeln('  pipeline = pipeline.addMiddleware(m);');
//     b.writeln('}');

//     // Add handler to the pipeline.
//     b.writeln();
//     b.writeln('return pipeline.addHandler((request) async {');
//     b.writeln(_buildFunctionHandler(procedure));
//     b.writeln('})(request);');

//     return b.toString();
//   }

//   String _buildFunctionHandler(SourcedProcedure procedure) {
//     final b = StringBuffer();

//     b.writeln('final fn = procedure.fn as ${procedure.typeDefinition};');

//     if (procedure.parameters.any((p) => p.isRequestContext)) {
//       b.writeln('final ctx = RequestContext();');
//     }

//     final positional = procedure.parameters.where((p) => p.isPositional);
//     final named = procedure.parameters.where((p) => p.isNamed);

//     if (positional.isNotEmpty) {
//       b.writeln('final positional = params["positional"] as List;');
//     }

//     if (named.isNotEmpty) {
//       b.writeln('final named = params["named"] as Map<String, dynamic>;');
//     }

//     // Build each positional parameter in order.
//     var p = 0;
//     for (final param in positional) {
//       b.write('final p$p = ');
//       if (param.isRequestContext) {
//         b.writeln('ctx;');
//       } else if (param.isOptional || param.type.isNullable) {
//         if (param.type.importId != null) {
//           b.writeln(
//             'positional[$p] == null ? null : i${param.type.importId}.${param.type.type}.fromJson(positional[$p] as Map<String, dynamic>);',
//           );
//         } else {
//           b.writeln(
//             'positional[$p] == null ? null : Serializers.instance.get<${param.type.type}>().deserialize(positional[$p]);',
//           );
//         }
//       } else if (param.type.importId != null) {
//         b.writeln(
//           'i${param.type.importId}.${param.type.type}.fromJson(positional[$p] as Map<String, dynamic>);',
//         );
//       } else {
//         b.writeln(
//           'Serializers.instance.get<${param.type.typeDefinition}>().deserialize(positional[$p]);',
//         );
//       }
//       p++;
//     }

//     var n = 0;
//     for (final param in named) {
//       b.write('final n$n = ');
//       if (param.isRequestContext) {
//         b.writeln('ctx;');
//       } else if (param.isOptional || param.type.isNullable) {
//         if (param.type.importId != null) {
//           b.writeln(
//             'named["${param.name}"] == null ? null : i${param.type.importId}.${param.type.type}.fromJson(named["${param.name}"]);',
//           );
//         } else {
//           b.writeln(
//             'named["${param.name}"] == null ? null : Serializers.instance.get<${param.type.typeDefinition}>().deserialize(named["${param.name}"]);',
//           );
//         }
//       } else if (param.type.importId != null) {
//         b.writeln(
//           'i${param.type.importId}.${param.type.type}.fromJson(named["${param.name}"]);',
//         );
//       } else {
//         b.writeln(
//           'Serializers.instance.get<${param.type.typeDefinition}>().deserialize(named["${param.name}"]);',
//         );
//       }
//       n++;
//     }

//     // Call the procedure handler.
//     b.writeln();
//     b.write('final result = ');

//     switch (procedure.type.kind) {
//       case SourcedTypeKind.future:
//         b.writeln('await fn(');
//         break;
//       case SourcedTypeKind.stream:
//         throw UnimplementedError(
//           'Iterable type is not supported for RPC pipelines',
//         );
//       case SourcedTypeKind.iterable:
//       case SourcedTypeKind.list:
//       case SourcedTypeKind.set:
//       case SourcedTypeKind.map:
//       default:
//         b.writeln('fn(');
//         break;
//     }

//     for (var i = 0; i < positional.length; i++) {
//       b.writeln('p$i,');
//     }
//     for (var i = 0; i < named.length; i++) {
//       final param = named.elementAt(i);
//       b.write('${param.name}: n$i');
//       if (param.defaultValue != null) {
//         b.write(' ?? ${param.defaultValue}');
//       }
//       b.writeln(',');
//     }
//     b.writeln(');');

//     b.writeln();
//     b.write('final serialized = ');
//     if (procedure.type.isNullable) {
//       b.writeln('result == null ? null : ');
//     }
//     if (procedure.type.importId != null) {
//       b.writeln('result.toJson();');
//     } else {
//       b.writeln(
//         'Serializers.instance.get<${procedure.type.typeDefinition}>().serialize(result);',
//       );
//     }

//     b.writeln('return Response.ok(jsonEncode({ "result": serialized }));');

//     return b.toString();
//   }

//   @override
//   Map<String, List<String>> get buildExtensions => {
//     ".shelf_rpc_spec.json": [".server.dart"],
//   };
// }
