import 'package:globe_functions/src/build/writers/base_writer.dart';
import 'package:change_case/change_case.dart';
import 'package:globe_functions/src/spec/rpc_procedure.dart';
import 'package:globe_functions/src/spec/sourced_entry.dart';
import 'package:globe_functions/src/spec/types.dart';

class ClientWriter extends BaseWriter {
  ClientWriter({required super.imports, required super.entrypoints});

  @override
  String write() {
    b.writeln("import 'dart:convert';");
    b.writeln("import 'package:http/http.dart' as http;");
    b.writeln("import 'package:globe_functions/src/spec/serializer.dart';");
    b.writeln(
      "import 'package:globe_functions/src/client/rpc_http_client.dart';",
    );

    // Add imports with unique import indexes
    b.write(writeImports());
    b.writeln();

    // Write the RpcClient class with named constructors for each entrypoint
    b.writeln("class RpcClient extends RpcHttpClient {");
    b.writeln();

    // Private constructor
    b.writeln("  RpcClient._({required super.uri, super.client});");

    // Static factory methods for each entrypoint
    for (final entrypoint in entrypoints) {
      final entrypointClassName = _generateClientClassName(
        entrypoint,
        '',
        isEntrypoint: true,
      );
      b.writeln();
      b.writeln('''
  static $entrypointClassName ${entrypoint.name}({
    required Uri uri,
    http.Client? client,
  }) => $entrypointClassName(RpcClient._(uri: uri, client: client));
''');
    }

    b.writeln("}");
    b.writeln();

    // First write the base class for all generated clients
    b.writeln('''
abstract base class _RpcGeneratedClient {
  final RpcClient client;
  const _RpcGeneratedClient(this.client);
}
''');

    for (final entrypoint in entrypoints) {
      final routes = _groupProceduresByPath(entrypoint.procedures);
      final allPaths = _getAllPaths(routes.keys);

      // Generate internal client classes for all paths
      for (final path in allPaths.where((k) => k.isNotEmpty)) {
        b.writeln();
        _writeNestedClientClass(entrypoint, path, routes[path] ?? [], allPaths);
      }

      // Generate the public entrypoint class
      final entrypointClassName = _generateClientClassName(
        entrypoint,
        '',
        isEntrypoint: true,
      );
      b.writeln(
        "final class $entrypointClassName extends _RpcGeneratedClient {",
      );
      b.writeln();
      b.writeln("  const $entrypointClassName(super.client);");

      // Generate getters for nested routes
      _writeNestedRouteGetters(entrypoint, routes);
      b.writeln();

      // Write root level methods
      if (routes[''] != null) {
        for (final procedure in routes['']!) {
          _writeProcedureMethod(procedure);
          b.writeln();
        }
      }

      b.writeln("}");
    }

    return formatter.format(b.toString());
  }

  Map<String, List<RpcProcedure>> _groupProceduresByPath(
    List<RpcProcedure> procedures,
  ) {
    final routes = <String, List<RpcProcedure>>{};
    for (final procedure in procedures) {
      final segments = procedure.id.split('.');
      final path =
          segments.length == 1
              ? ''
              : segments.take(segments.length - 1).join('.');
      routes[path] ??= [];
      routes[path]!.add(procedure);
    }
    return routes;
  }

  Set<String> _getAllPaths(Iterable<String> routes) {
    final allPaths = <String>{};

    for (final route in routes) {
      if (route.isEmpty) continue;

      final segments = route.split('.');
      var currentPath = '';

      // Add all intermediate paths
      for (var i = 0; i < segments.length; i++) {
        currentPath = i == 0 ? segments[0] : '$currentPath.${segments[i]}';
        allPaths.add(currentPath);
      }
    }

    return allPaths;
  }

  String _generateClientClassName(
    SourcedEntry entrypoint,
    String path, {
    bool isEntrypoint = false,
  }) {
    final parts = [
      'Rpc',
      entrypoint.className,
      ...path.split('.').map((s) => s.toPascalCase()),
      if (isEntrypoint) 'ClientEntrypoint' else 'Client',
    ];

    return parts.join();
  }

  void _writeNestedClientClass(
    SourcedEntry entrypoint,
    String path,
    List<RpcProcedure> procedures,
    Set<String> allPaths,
  ) {
    final className = _generateClientClassName(entrypoint, path);
    b.writeln('final class $className extends _RpcGeneratedClient {');
    b.writeln('  const $className(super.client);');

    // Write methods for this path level
    for (final procedure in procedures) {
      _writeProcedureMethod(procedure);
    }

    // Add getters for next level paths
    final currentSegments = path.split('.');
    final nextLevelPaths =
        allPaths
            .where((p) => p.startsWith('$path.'))
            .where((p) => p.split('.').length == currentSegments.length + 1)
            .map((p) => p.split('.').last)
            .toSet();

    for (final nextPath in nextLevelPaths) {
      final nextClassName = _generateClientClassName(
        entrypoint,
        '$path.$nextPath',
      );
      b.writeln(
        '  $nextClassName get ${nextPath.toCamelCase()} => $nextClassName(client);',
      );
    }

    b.writeln('}');
  }

  void _writeNestedRouteGetters(
    SourcedEntry entrypoint,
    Map<String, List<RpcProcedure>> routes,
  ) {
    final topLevelPaths =
        routes.keys
            .where((k) => k.isNotEmpty)
            .map((k) => k.split('.')[0])
            .toSet();

    for (final path in topLevelPaths) {
      final className = _generateClientClassName(entrypoint, path);
      b.writeln(
        '\n  $className get ${path.toCamelCase()} => $className(client);',
      );
    }
  }

  void _writeProcedureMethod(RpcProcedure procedure) {
    final returnType = switch (procedure.interface) {
      AsyncType() => procedure.interface.typeDefinition,
      _ => 'Future<${procedure.interface.typeDefinition}>',
    };

    final methodName = procedure.id.split('.').last.toCamelCase();

    // Write method signature with properly structured parameters
    b.write('  $returnType $methodName(');

    // Write positional parameters first
    final positional = procedure.parameters.where((p) => !p.isNamed);
    b.write(positional.map((p) => p.typedef).join(', '));

    // If we have named parameters, add them in curly braces
    final named = procedure.parameters.where((p) => p.isNamed);
    if (named.isNotEmpty) {
      if (positional.isNotEmpty) b.write(', ');
      b.write('{');
      b.write(
        named
            .map((p) => '${p.isOptional ? '' : 'required '}${p.typedef}')
            .join(', '),
      );
      b.write('}');
    }

    b.writeln(') async {');

    // Build the request body
    b.writeln('final positional = [];');
    b.writeln('final named = <String, dynamic>{};');

    // Handle positional arguments
    for (final param in procedure.parameters.where((p) => !p.isNamed)) {
      b.write('positional.add(');
      b.write(_serializeType(param.interface, param.name));
      b.writeln(');');
    }

    // Handle named arguments
    for (final param in procedure.parameters.where((p) => p.isNamed)) {
      b.write('named["${param.name}"] = ');
      if (param.isOptional) {
        b.write('${param.name} == null ? null : ');
      }
      b.write(_serializeType(param.interface, param.name));
      b.writeln(';');
    }

    // Construct the request body
    b.writeln();
    b.writeln('final body = jsonEncode({');
    b.writeln('  "id": "${procedure.id}",');
    b.writeln('  "params": {');
    b.writeln('    "positional": positional,');
    b.writeln('    "named": named,');
    b.writeln('  },');
    b.writeln('});');
    b.writeln();

    if (procedure.interface is StreamType) {
      // TODO: handle streaming
      throw UnimplementedError('Streaming is not supported yet');
    } else {
      // POST request
      b.write('final result = await client.postRequest("${procedure.id}",');
      // b.write('final result = await client.getRequest("${procedure.id}",');
      b.writeln('  namedParams: named,');
      b.writeln('  positionalParams: positional,');
      b.writeln(');');
      b.writeln();

      // Return the deserialized result
      b.writeln('return ${_deserializeType(procedure.interface, 'result')};');
    }

    b.writeln('  }');
  }

  String _serializeType(
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
        '$value.map((item) => ${_serializeType(innerType, "item", isRoot: false)})',
      );
      return isRoot ? '$mapCode.toList()' : mapCode;
    } else if (type is MapType) {
      final valueType = type.typeArguments.last;
      return generateNullCheck(
        value,
        '$value.map((key, value) => MapEntry(key, ${_serializeType(valueType, "value", isRoot: false)}))',
      );
    } else {
      return generateNullCheck(
        value,
        'Serializers.instance.get<${type.name}>().serialize($value)',
      );
    }
  }

  String _deserializeType(
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
      return generateNullCheck(
        value,
        'i${type.importId}.${type.name}.fromJson($value)',
      );
    } else if (type is ListType || type is SetType || type is IterableType) {
      final innerType = (type as SingleTypeArgument).typeArgument;
      final mapCode = generateNullCheck(
        value,
        '($value as List).map((item) => ${_deserializeType(innerType, "item", isRoot: false)})',
      );
      return isRoot ? '$mapCode.toList()' : mapCode;
    } else if (type is MapType) {
      final valueType = type.typeArguments.last;
      return generateNullCheck(
        value,
        '($value as Map).map((key, value) => MapEntry(key, ${_deserializeType(valueType, "value", isRoot: false)}))',
      );
    } else {
      return generateNullCheck(
        value,
        'Serializers.instance.get<${type.name}>().deserialize($value)',
      );
    }
  }
}

extension on SourcedEntry {
  String get className => name.toPascalCase();
}
