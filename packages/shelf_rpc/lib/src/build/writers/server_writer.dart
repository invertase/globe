import 'package:shelf_rpc/src/build/writers/base_writer.dart';
import 'package:shelf_rpc/src/build/sourced_rpc_procedure.dart';
import 'package:shelf_rpc/src/build/supported_type.dart';

/// The writer for the server RPC code.
class ServerWriter extends BaseWriter {
  /// Creates a new [ServerWriter] instance.
  ServerWriter({required super.imports, required super.entrypoints});

  @override
  String write() {
    b.writeln("import 'dart:convert';");
    b.writeln("import 'package:shelf/shelf.dart';");
    b.writeln("import 'package:shelf_rpc/shelf_rpc.dart';");
    b.writeln("import 'package:shelf_rpc/src/serializers.dart';");
    b.writeln(
      "import 'package:globe_functions/src/server/request_params.dart';",
    );
    b.writeln(
      "import 'package:globe_functions/src/server/request_context.dart';",
    );
    b.writeln("import 'package:globe_functions/src/server/sse_response.dart';");

    // Add imports with unique import indexes
    b.write(writeImports());

    for (final entrypoint in entrypoints) {
      b.writeln('final ${entrypoint.name} = Pipeline()');
      b.writeln('  .addHandler((Request request) async {');
      b.writeln('    final params = await RequestParams.fromRequest(request);');
      b.writeln('    final positional = params.positional;');
      b.writeln('    final named = params.named;');

      // Import the entrypoint from the users library.
      b.writeln(
        '    final _${entrypoint.name} = i${entrypoint.importId}.${entrypoint.name};',
      );

      // Create a pipeline and add middleware for the entrypoint.
      b.writeln('    Pipeline pipeline = Pipeline();');
      b.writeln();
      b.writeln('    for (final m in _${entrypoint.name}.middleware) {');
      b.writeln('      pipeline = pipeline.addMiddleware(m);');
      b.writeln('    }');

      // Add switch statement for procedures.
      b.writeln();
      b.writeln('    switch (params.id) {');

      for (final procedure in entrypoint.procedures) {
        b.writeln('      case "${procedure.id}":');

        final parts = procedure.id.split('.');

        // Get the procedure from the entrypoint - if its nested, get the nested procedure.
        if (parts.length == 1) {
          b.writeln(
            'final procedure = _${entrypoint.name}.routes[#${parts[0]}] as ExecutedProcedure;',
          );
          b.writeln('final middleware = procedure.middleware;');
        } else {
          var i = 0;
          for (final part in parts) {
            final isLast = i == parts.length - 1;
            if (isLast) {
              final prevVar =
                  i == 0
                      ? '_${entrypoint.name}'
                      : '_${parts.take(i).join('_')}';
              b.writeln(
                'final procedure = $prevVar.routes[#$part] as ExecutedProcedure;',
              );
              b.writeln('final middleware = procedure.middleware;');
            } else {
              final prevVar =
                  i == 0
                      ? '_${entrypoint.name}'
                      : '_${parts.take(i).join('_')}';
              final nextVar = '_${parts.take(i + 1).join('_')}';
              b.writeln('final $nextVar = $prevVar.routes[#$part] as Router;');
            }
            i++;
          }
        }

        // Apply middleware to the pipeline.
        b.writeln();
        b.writeln('for (final m in middleware) {');
        b.writeln('  pipeline = pipeline.addMiddleware(m);');
        b.writeln('}');

        // Add handler to the pipeline.
        b.writeln();
        b.writeln('return pipeline.addHandler((request) async {');
        b.writeln(_buildFunctionHandler(procedure));
        b.writeln('})(request);');
      }

      // Missing procedure case.
      b.writeln('      default:');
      b.writeln('        return Response.notFound("Unknown procedure");');
      b.writeln('    }');

      b.writeln('  });');
    }

    return formatter.format(b.toString());
  }

  String _buildFunctionHandler(SourcedRpcProcedure procedure) {
    final b = StringBuffer();
    final positional = procedure.parameters.where((p) => p.isPositional);
    final named = procedure.parameters.where((p) => p.isNamed);

    b.writeln('final fn = procedure.fn as ${procedure.typedef};');

    // Build each positional parameter in order.
    var p = 0;
    for (final param in positional) {
      b.write('final p$p = ');

      if (param.interface is ShelfRequestType) {
        // Do nothing.
      } else if (param.isOptional) {
        b.write('positional[$p] == null ? null : ');
      } else {
        b.write('positional[$p] = ');
      }

      if (param.interface is ShelfRequestType) {
        b.write('request;');
      } else if (param.interface is UnknownType) {
        b.write(
          '${param.interface.typeDefinition}.fromJson(positional[$p] as Map<String, dynamic>);',
        );
      } else {
        b.write(
          'Serializers.instance.get<${param.interface.name}>().deserialize(positional[$p]);',
        );
      }
      p++;
    }

    // Build each named parameter in order.
    var n = 0;
    for (final param in named) {
      b.write('final n$n = ');

      if (param.interface is ShelfRequestType) {
        // Do nothing.
      } else if (param.isOptional) {
        b.write('named["${param.name}"] == null ? null : ');
      } else {
        b.write('named["${param.name}"] = ');
      }

      if (param.interface is ShelfRequestType) {
        b.write('request;');
      } else if (param.interface is UnknownType) {
        b.write(
          '${param.interface.typeDefinition}.fromJson(named["${param.name}"]);',
        );
      } else {
        b.write(
          'Serializers.instance.get<${param.interface.name}>().deserialize(named["${param.name}"]);',
        );
      }
      n++;
    }

    b.writeln('');
    b.write('final result = ');

    switch (procedure.interface) {
      case FutureType():
      case FutureOrType():
        b.write('await fn(');
      default:
        b.write('fn(');
        break;
    }

    // Add positional parameters first.
    for (var i = 0; i < positional.length; i++) {
      final param = positional.elementAt(i);
      b.writeln('p$i');
      if (param.defaultValue != null) {
        b.write(' ?? ${param.defaultValue}');
      }
      b.writeln(',');
    }

    for (var i = 0; i < named.length; i++) {
      final param = named.elementAt(i);
      b.write('${param.name}: n$i');
      if (param.defaultValue != null) {
        b.write(' ?? ${param.defaultValue}');
      }
      b.writeln(',');
    }
    b.writeln(');');

    final returnType = switch (procedure.interface) {
      FutureType t => t.typeArgument,
      FutureOrType t => t.typeArgument,
      _ => procedure.interface,
    };

    // Helper function to generate serialization code for a type
    String serializeType(
      SupportedType type,
      String value, {
      bool isRoot = true,
    }) {
      String generateNullCheck(String value, String code) {
        return type.isNullable ? '$value == null ? null : $code' : code;
      }

      if (type is NullType) {
        return 'null';
      } else if (type is UnknownType) {
        return generateNullCheck(value, '$value.toJson()');
      } else if (type is ListType || type is SetType || type is IterableType) {
        final innerType = (type as SingleTypeArgument).typeArgument;
        final mapCode = generateNullCheck(
          value,
          '$value.map((item) => ${serializeType(innerType, "item", isRoot: false)})',
        );
        return isRoot ? '$mapCode.toList()' : mapCode;
      } else if (type is MapType) {
        final valueType = type.typeArguments.last;
        return generateNullCheck(
          value,
          '$value.map((key, value) => MapEntry(key, ${serializeType(valueType, "value", isRoot: false)}))',
        );
      } else {
        return generateNullCheck(
          value,
          'Serializers.instance.get<${type.name}>().serialize($value)',
        );
      }
    }

    if (returnType is StreamType) {
      final innerType = returnType.typeArgument;

      // If the return type is nullable, we still need to return a SSE
      // response, so instead we just create an empty stream.
      b.write('final stream = ');
      if (returnType.isNullable) {
        b.write('result ?? Stream<${innerType.typeDefinition}>.empty();');
      } else {
        b.write('result;');
      }

      b.writeAll([
        'final sse = SseResponse<${innerType.typeDefinition}>(',
        '  request: request,',
        '  stream: stream,',
        // Since the return type is still a Stream, we need the "inner" type.
        '  serializer: (data) => ${serializeType(innerType, 'data')},',
        ');',
        '',
        'return sse.response();',
      ], '\n');
      return b.toString();
    }

    // Serialize the result.
    b.write('final serialized = ');

    if (returnType.isNullable) {
      b.write('result == null ? null : ');
    }

    b.writeln('${serializeType(returnType, 'result')};');

    // Return the result as a JSON response.
    b.writeln('return Response.ok(jsonEncode({ "result": serialized }));');

    return b.toString();
  }
}
