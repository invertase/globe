import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:globe_functions/src/annotations.dart';
import 'package:globe_functions/src/spec/serializer.dart';
import 'package:globe_functions/src/spec/sourced_function.dart';
import 'package:globe_functions/src/spec/sourced_function_parameter.dart';
import 'package:globe_functions/src/spec/sourced_imports.dart';
import 'package:globe_functions/src/spec/sourced_type.dart';
import 'package:globe_functions/src/server/request_context.dart';
import 'package:source_gen/source_gen.dart';

const _requestContextType = TypeChecker.fromRuntime(RequestContext);
const _rpcFunctionType = TypeChecker.fromRuntime(RpcFunction);
const _httpFunctionType = TypeChecker.fromRuntime(HttpFunction);

class SourceFunctionsBuilder extends Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
    r'$package$': [
      '.dart_tool/functions_spec.dart',
      '.dart_tool/functions_spec.json',
    ],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final functions = <SourcedFunction>[];
    final imports = SourcedImports();

    // Find all annotated functions
    await for (final asset in buildStep.findAssets(Glob('lib/api/**'))) {
      final library = await buildStep.resolver.libraryFor(asset);
      final reader = LibraryReader(library);

      // Find all annotated functions.
      for (final discovered in reader.annotatedWith(
        TypeChecker.fromRuntime(GlobeFunction),
      )) {
        // Check that the discovered element is a function.
        if (discovered.element is! FunctionElement) {
          throw InvalidGenerationSourceError(
            'The @GlobeFunction annotation can only be applied to top-level functions.',
            element: discovered.element,
          );
        }

        // Check if the annotation is an RpcFunction or HttpFunction
        final functionType = switch (discovered.element) {
          Element e when _rpcFunctionType.hasAnnotationOf(e) =>
            GlobeFunctionType.rpc,
          Element e when _httpFunctionType.hasAnnotationOf(e) =>
            GlobeFunctionType.http,
          _ =>
            throw InvalidGenerationSourceError(
              'Invalid annotation',
              element: discovered.element,
            ),
        };

        // Get the function element.
        final element = discovered.element as FunctionElement;

        // Check if the function returns a Future.
        final isFutureReturnType = element.returnType.isDartAsyncFuture;

        // Get the return type.
        // Future<T> -> T
        // T -> T
        DartType? returnType;
        if (isFutureReturnType) {
          final futureType = element.returnType as InterfaceType;
          if (futureType.typeArguments.isNotEmpty) {
            returnType = futureType.typeArguments.first;
          }
        } else {
          returnType = element.returnType;
        }

        if (returnType == null) {
          throw InvalidGenerationSourceError(
            'Unsupported return type: ${element.returnType.toString()}',
            element: element,
          );
        }

        final serializer = Serializers.instance.getFromType(returnType);

        if (serializer == null && returnType is! InterfaceType) {
          throw InvalidGenerationSourceError(
            'Unsupported type is not serializable: ${returnType.toString()}',
            element: element,
          );
        }

        if (serializer == null &&
            !Serializers.isSerializableInterface(
              returnType as InterfaceType,
              library,
            )) {
          throw InvalidGenerationSourceError(
            'Unsupported type is not serializable: ${returnType.toString()}',
            element: element,
          );
        }

        final parameters =
            element.parameters.map((parameter) {
              final serializer = Serializers.instance.getFromType(
                parameter.type,
              );

              // If we have a serializer, the type is valid regardless of its nature
              if (serializer != null) {
                // Type is serializable, continue with the rest of the code
              }
              // If no serializer, check if it's a serializable interface
              else if (parameter.type is InterfaceType) {
                if (!Serializers.isSerializableInterface(
                  parameter.type as InterfaceType,
                  library,
                )) {
                  throw InvalidGenerationSourceError(
                    'Type is not serializable: ${parameter.type}',
                    element: parameter,
                  );
                }
              }
              // If it's not an interface type and has no serializer, it's invalid
              else {
                throw InvalidGenerationSourceError(
                  'Unsupported type is not serializable: ${parameter.type}',
                  element: parameter,
                );
              }

              return SourcedFunctionParameter(
                name: parameter.name,
                type: SourcedType.fromDartType(
                  type: parameter.type,
                  importId:
                      serializer == null
                          ? imports.register(
                            parameter.type.element!.source!.uri,
                          )
                          : null,
                ),
                defaultValue: parameter.defaultValueCode,
                isNamed: parameter.isNamed,
                isPositional: parameter.isPositional,
                isOptional:
                    parameter.isOptionalNamed || parameter.isOptionalPositional,
                isRequired:
                    parameter.isRequiredNamed || parameter.isRequiredPositional,
                isRequestContext: _requestContextType.isExactlyType(
                  parameter.type,
                ),
              );
            }).toList();

        functions.add(
          SourcedFunction(
            functionName: element.name,
            functionType: functionType,
            importId: imports.register(element.source.uri),
            uri: element.source.uri,
            type: SourcedType.fromDartType(
              type: returnType,
              importId:
                  serializer == null
                      ? imports.register(returnType.element!.source!.uri)
                      : null,
            ),
            parameters: parameters,
          ),
        );
      }
    }

    final spec = jsonEncode({'imports': imports, 'functions': functions});

    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, '.dart_tool/functions_spec.dart'),
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
const spec = $spec;
''',
    );

    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, '.dart_tool/functions_spec.json'),
      spec,
    );

    // // Generate the output file with all collected functions
    // final content = StringBuffer();
    // content.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');

    // for (final fn in _functions) {
    //   content.writeln("import '${fn.uri}' as fn_${fn.id};");
    // }

    // content.writeln('final specs = ${jsonEncode(_functions)};');

    // content.writeln('');
    // content.writeln('final handlers = {');
    // for (final function in _functions) {
    //   content.writeln(
    //     '  ${function.id}: fn_${function.id}.${function.functionName},',
    //   );
    // }
    // content.writeln('};');

    // // Write the output file
    // final dartSpec = AssetId(
    //   buildStep.inputId.package,
    //   '.dart_tool/functions_spec.dart',
    // );

    // await buildStep.writeAsString(dartSpec, content.toString());

    // // Write the output file
    // final jsonSpec = AssetId(
    //   buildStep.inputId.package,
    //   '.dart_tool/functions_spec.json',
    // );

    // await buildStep.writeAsString(jsonSpec, jsonEncode(_functions));
  }
}
