import 'dart:convert';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:globe_functions/src/build/sourced_function.dart';

class RpcClientBuilder implements Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    final package = buildStep.inputId.package;

    final specs =
        await buildStep.findAssets(Glob('**/functions_spec.json')).toList();

    final json = await buildStep.readAsString(specs.first);

    final functions =
        (jsonDecode(json) as List<dynamic>)
            .map((e) => SourcedFunction.fromJson(e as Map<String, dynamic>))
            .toList();

    print(functions);

    final content = StringBuffer();

    // Add imports
    content.writeln("import 'package:http/http.dart' as http;");
    content.writeln();

    // Write the base class
    content.writeln('''
abstract class RpcBaseClient {
  final String baseUrl;
  final http.Client _client;
  final String path;

  RpcBaseClient(this.baseUrl, this._client, this.path);

  String get fullPath => '\$baseUrl/\$path';
}
''');

    // Group functions by their directory path
    final pathGroups = <String, List<SourcedFunction>>{};
    for (final func in functions) {
      final pathParts = func.uri.pathSegments.sublist(
        func.uri.pathSegments.indexOf('api') + 1,
      );
      pathParts[pathParts.length - 1] = pathParts.last.replaceAll('.dart', '');
      final path = pathParts.join('/');
      pathGroups[path] = [...(pathGroups[path] ?? []), func];
    }

    // Helper to check if a path has subpaths
    bool hasSubpath(String currentPath, String segment) {
      return pathGroups.keys.any((p) {
        if (!p.startsWith('$currentPath/')) return false;

        final remaining = p.substring(currentPath.length + 1);
        if (remaining.isEmpty) return false;

        return remaining.split('/')[0] == segment;
      });
    }

    // Generate segment classes from root to leaf
    final processedPaths = <String>{};
    for (final path in pathGroups.keys) {
      var currentPath = '';
      final segments = path.split('/');

      for (var i = 0; i < segments.length; i++) {
        currentPath = i == 0 ? segments[i] : '$currentPath/${segments[i]}';

        if (processedPaths.contains(currentPath)) continue;
        processedPaths.add(currentPath);

        final className = _generateClassName(segments.sublist(0, i + 1));

        // Check if this segment should be callable
        final parentPath = segments.sublist(0, i).join('/');
        final isCallable =
            pathGroups[parentPath]?.any(
              (func) => func.functionName == segments[i],
            ) ??
            false;

        content.writeln('''
class $className extends RpcBaseClient {
  $className(String baseUrl, http.Client client) 
      : super(baseUrl, client, '$currentPath');
''');

        // Add call() method if this segment is callable
        if (isCallable) {
          content.writeln('''
  Future<String> call() async {
    final response = await _client.get(Uri.parse(fullPath));
    return response.body as String;
  }
''');
        }

        // Add methods for this path level
        if (pathGroups.containsKey(currentPath)) {
          for (final func in pathGroups[currentPath]!) {
            final returnType =
                func.isFutureReturnType
                    ? func.returnType
                    : 'Future<${func.returnType}>';

            // Only generate the method if it doesn't have a corresponding subpath
            if (!hasSubpath(currentPath, func.functionName)) {
              content.writeln('''
  $returnType ${func.functionName}() async {
    final response = await _client.get(Uri.parse('\$fullPath/${func.functionName}'));
    return response.body as ${func.returnType};
  }
''');
            }
          }
        }

        // Add getters for next level
        if (i < segments.length - 1) {
          final nextSegment = segments[i + 1];
          final nextClassName = _generateClassName(segments.sublist(0, i + 2));
          content.writeln('''
  $nextClassName get $nextSegment => $nextClassName(baseUrl, _client);
''');
        }

        content.writeln('}');
        content.writeln();
      }
    }

    // Generate the main RpcClient class
    content.writeln('''
class RpcClient {
  final String baseUrl;
  final http.Client _client;

  RpcClient(this.baseUrl, [http.Client? client]) 
      : _client = client ?? http.Client();
''');

    // Add top-level getters
    final topLevelSegments =
        pathGroups.keys.map((p) => p.split('/').first).toSet();

    for (final segment in topLevelSegments) {
      final className = _generateClassName([segment]);
      content.writeln('''
  $className get $segment => $className(baseUrl, _client);''');
    }

    content.writeln('}');

    // Write the generated file
    await buildStep.writeAsString(
      AssetId(package, 'lib/rpc_client.g.dart'),
      content.toString(),
    );
  }

  String _generateClassName(List<String> segments) {
    return '${segments.map((s) => s[0].toUpperCase() + s.substring(1)).join()}Segment';
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    r'$lib$': ['rpc_client.g.dart'],
  };
}
