import 'dart:convert';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:globe_functions/src/spec/sourced_function.dart';
import 'package:globe_functions/src/spec/sourced_imports.dart';

class EntrypointBuilder implements Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    final package = buildStep.inputId.package;

    final spec =
        (await buildStep.findAssets(Glob('**/functions_spec.json')).toList())
            .first;

    final json = jsonDecode(await buildStep.readAsString(spec));

    final imports = SourcedImports.fromJson(json['imports'] as List<dynamic>);

    final functions =
        (json['functions'] as List<dynamic>)
            .map((e) => SourcedFunction.fromJson(e as Map<String, dynamic>))
            .toList();

    print('found spec ${spec}');

    final content = StringBuffer();

    // // Import shelf server
    content.writeln("import 'dart:convert';");
    content.writeln(
      "import 'package:globe_functions/src/spec/serializer.dart';",
    );
    content.writeln("import 'package:shelf/shelf.dart';");
    content.writeln("import 'package:shelf/shelf_io.dart' as shelf_io;");

    // Write imports for all sourced imports
    for (final import in imports()) {
      content.writeln("import '$import' as i${imports.register(import)};");
    }

    // Write the main function
    content.writeln();
    content.writeln("void main() async {");
    content.writeln(
      "  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(_onRequest);",
    );
    content.writeln(
      "  final server = await shelf_io.serve(handler, 'localhost', 8080);",
    );
    content.writeln(
      "  print('Serving at http://\${server.address.host}:\${server.port}');",
    );
    content.writeln('}');

    // Write the _onRequest function
    content.writeln();
    content.writeln("Future<Response> _onRequest(Request request) async {");
    content.writeln(
      "  if (request.method == 'POST' && request.url.path == '_rpc') {",
    );
    content.writeln("    return _onRpcRequest(request);");
    content.writeln("  }");
    content.writeln();
    content.writeln("  return Response.ok('Not found...');");
    content.writeln("}");

    // Write the _onRpcRequest function
    content.writeln();
    content.writeln("Future<Response> _onRpcRequest(Request request) async {");
    content.writeln("  final body = jsonDecode(await request.readAsString());");
    content.writeln("  final id = body['id'] as String;");
    content.writeln("  final named = body['named'] as Map<String, dynamic>;");
    content.writeln(
      "  final positional = body['positional'] as List<dynamic>;",
    );
    content.writeln();

    for (final function in functions) {
      content.writeln("  if (id == '${function.id}') {");

      // Convert positional parameters first
      var paramIndex = 0;
      for (final param in function.parameters.where((p) => p.isPositional)) {
        content.write("    final param$paramIndex = ");
        if (param.isOptional || param.type.isNullable) {
          if (param.type.importId != null) {
            content.writeln(
              "positional[${function.parameters.indexOf(param)}] == null ? null : "
              "i${param.type.importId}.${param.type.type}.fromJson(positional[${function.parameters.indexOf(param)}] as Map<String, dynamic>);",
            );
          } else {
            content.writeln(
              "positional[${function.parameters.indexOf(param)}] == null ? null : "
              "Serializers.instance.deserialize<${param.type.type}>(positional[${function.parameters.indexOf(param)}]);",
            );
          }
        } else {
          if (param.type.importId != null) {
            content.writeln(
              "i${param.type.importId}.${param.type.type}.fromJson(positional[${function.parameters.indexOf(param)}] as Map<String, dynamic>);",
            );
          } else {
            content.writeln(
              "Serializers.instance.deserialize<${param.type.type}>(positional[${function.parameters.indexOf(param)}]);",
            );
          }
        }
        paramIndex++;
      }

      // Convert named parameters
      for (final param in function.parameters.where((p) => p.isNamed)) {
        content.write("    final ${param.name}Param = ");
        if (param.isOptional || param.type.isNullable) {
          if (param.type.importId != null) {
            content.writeln(
              "named['${param.name}'] == null ? null : "
              "i${param.type.importId}.${param.type.type}.fromJson(named['${param.name}'] as Map<String, dynamic>);",
            );
          } else {
            content.writeln(
              "named['${param.name}'] == null ? null : "
              "Serializers.instance.deserialize<${param.type.type}>(named['${param.name}']);",
            );
          }
        } else {
          if (param.type.importId != null) {
            content.writeln(
              "i${param.type.importId}.${param.type.type}.fromJson(named['${param.name}'] as Map<String, dynamic>);",
            );
          } else {
            content.writeln(
              "Serializers.instance.deserialize<${param.type.type}>(named['${param.name}']);",
            );
          }
        }
      }

      // Make the function call
      content.writeln(
        "    final result = await i${function.importId}.${function.functionName}(",
      );

      // Add positional parameters
      var isFirst = true;
      for (
        var i = 0;
        i < function.parameters.where((p) => p.isPositional).length;
        i++
      ) {
        if (!isFirst) content.writeln(",");
        content.write("      param$i");
        isFirst = false;
      }

      // Add named parameters
      for (final param in function.parameters.where((p) => p.isNamed)) {
        if (!isFirst) content.writeln(",");
        content.write("      ${param.name}: ${param.name}Param");
        isFirst = false;
      }

      content.writeln("\n    );");

      // Handle return value serialization
      content.write("    final serializedResult = ");
      if (function.type.importId != null) {
        if (function.type.isNullable) {
          content.write("result?.toJson()");
        } else {
          content.write("result.toJson()");
        }
      } else {
        if (function.type.isNullable) {
          content.write(
            "result == null ? null : Serializers.instance.serialize<${function.type.type}>(result)",
          );
        } else {
          content.write(
            "Serializers.instance.serialize<${function.type.type}>(result)",
          );
        }
      }
      content.writeln(";");

      content.writeln("    return Response.ok(");
      content.writeln(
        "      jsonEncode({'result': serializedResult, 'error': null}),",
      );
      content.writeln("      headers: {'content-type': 'application/json'},");
      content.writeln("    );");
      content.writeln("  }");
      content.writeln();
    }

    // Add not found handler at the end
    content.writeln();
    content.writeln("  // No matching function found");
    content.writeln("  return Response.notFound(");
    content.writeln("    jsonEncode({");
    content.writeln("      'result': null,");
    content.writeln("      'error': 'Function not found: \$id'");
    content.writeln("    }),");
    content.writeln("    headers: {'content-type': 'application/json'},");
    content.writeln("  );");

    content.writeln("}");

    await buildStep.writeAsString(
      AssetId(package, '.dart_tool/entrypoint.dart'),
      content.toString(),
    );

    // // Import sourced functions
    // content.writeln(
    //   'import "package:globe_functions/src/build/sourced_function.dart";',
    // );

    // // Import server
    // content.writeln(
    //   'import "package:globe_functions/src/server/globe_functions.dart";',
    // );

    // // Import functions spec
    // content.writeln("import 'functions_spec.dart';");

    // // Main function
    // content.writeln('void main() async {');

    // // Create sourced functions from spec
    // content.writeln(
    //   '  final sourced = specs.map((e) => SourcedFunction.fromJson(e)).toList();',
    // );

    // // Create server
    // content.writeln(
    //   '  final handler = GlobeFunctions(sourced: sourced, handlers: handlers).getShelfHandler();',
    // );

    // // Start server
    // content.writeln(
    //   "  var server = await shelf_io.serve(handler, 'localhost', 8080);",
    // );

    // // Print server address
    // content.writeln(
    //   "  print('Serving at http://\${server.address.host}:\${server.port}');",
    // );

    // content.writeln('}');

    // await buildStep.writeAsString(
    //   AssetId(package, '.dart_tool/entrypoint.dart'),
    //   content.toString(),
    // );

    // final functionsSpec = await buildStep.readAsString(functions.first);

    // print(functionsSpec);

    // final dev =
    //     TargetEntryWriter(production: false, applicationPackage: package);
    // await buildStep.writeAsString(
    //     AssetId(package, '.dart_tool/.target_artifacts/main.dev.dart'),
    //     dev.write());

    // final prod =
    //     TargetEntryWriter(production: true, applicationPackage: package);
    // await buildStep.writeAsString(
    //     AssetId(package, '.dart_tool/.target_artifacts/main.prod.dart'),
    //     prod.write());
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    r'$package$': [".dart_tool/entrypoint.dart"],
  };
}
