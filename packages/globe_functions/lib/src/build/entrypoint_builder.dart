import 'package:build/build.dart';
import 'package:glob/glob.dart';

class EntrypointBuilder implements Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    final package = buildStep.inputId.package;

    final specs =
        await buildStep.findAssets(Glob('**/functions_spec.dart')).toList();

    final spec = specs.first;

    print('found spec ${spec}');

    final content = StringBuffer();

    // Import shelf server
    content.writeln("import 'package:shelf/shelf_io.dart' as shelf_io;");

    // Import sourced functions
    content.writeln(
      'import "package:globe_functions/src/build/sourced_function.dart";',
    );

    // Import server
    content.writeln(
      'import "package:globe_functions/src/server/globe_functions.dart";',
    );

    // Import functions spec
    content.writeln("import 'functions_spec.dart';");

    // Main function
    content.writeln('void main() async {');

    // Create sourced functions from spec
    content.writeln(
      '  final sourced = specs.map((e) => SourcedFunction.fromJson(e)).toList();',
    );

    // Create server
    content.writeln(
      '  final handler = GlobeFunctions(sourced: sourced, handlers: handlers).getShelfHandler();',
    );

    // Start server
    content.writeln(
      "  var server = await shelf_io.serve(handler, 'localhost', 8080);",
    );

    // Print server address
    content.writeln(
      "  print('Serving at http://\${server.address.host}:\${server.port}');",
    );

    content.writeln('}');

    await buildStep.writeAsString(
      AssetId(package, '.dart_tool/entrypoint.dart'),
      content.toString(),
    );

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
