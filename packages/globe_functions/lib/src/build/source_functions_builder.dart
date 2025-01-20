import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:globe_functions/src/annotations.dart';
import 'package:globe_functions/src/build/sourced_function.dart';
import 'package:globe_functions/src/server/request_context.dart';
import 'package:source_gen/source_gen.dart';

final _requestContextType = TypeChecker.fromRuntime(RequestContext);

class SourceFunctionsBuilder extends Builder {
  static final _functions = <SourcedFunction>[];

  @override
  Map<String, List<String>> get buildExtensions => {
    r'$package$': [
      '.dart_tool/functions_spec.dart',
      '.dart_tool/functions_spec.json',
    ],
  };

  /// Check if the type is a primitive type or a serializable type.
  bool _isSerializableType(DartType type) {
    return type.isDartCoreString ||
        type.isDartCoreNum ||
        type.isDartCoreBool ||
        type.isDartCoreMap ||
        type.isDartCoreNull;
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    // Clear previous functions at start of build
    _functions.clear();

    // Find all annotated functions
    await for (final asset in buildStep.findAssets(Glob('lib/api/**'))) {
      final library = await buildStep.resolver.libraryFor(asset);
      final reader = LibraryReader(library);

      for (final discovered in reader.annotatedWith(
        TypeChecker.fromRuntime(GlobeFunction),
      )) {
        if (discovered.element is! FunctionElement) {
          throw InvalidGenerationSourceError(
            'The @GlobeFunction annotation can only be applied to top-level functions.',
            element: discovered.element,
          );
        }

        final element = discovered.element as FunctionElement;
        final isFutureReturnType = element.returnType.isDartAsyncFuture;

        // If it is a Future, get the type argument otherwise just use the return type.
        final returnType =
            isFutureReturnType
                ? (element.returnType as InterfaceType).typeArguments.first
                : element.returnType;

        // Check if the return type is a serializable type.
        final isSerializableType = _isSerializableType(returnType);

        // If it's not a serializable type, check if it has a toJson/fromJson method.
        if (!isSerializableType) {
          final clazz = returnType as InterfaceType;
          final toJson = clazz.getMethod('toJson');
          final fromJson = clazz.lookUpConstructor('fromJson', library);

          if (toJson == null || fromJson == null) {
            throw InvalidGenerationSourceError(
              'Function return type must be a serializable type.',
              element: element,
            );
          }

          // TODO: Add further checks (no required parameters, etc.)
        }

        final parameters = <SourcedFunctionParameter>[];

        for (final parameter in element.parameters) {
          parameters.add(
            SourcedFunctionParameter(
              name: parameter.name,
              type: parameter.type.toString(),
              isNamed: parameter.isNamed,
              isPositional: parameter.isPositional,
              isOptional:
                  parameter.isOptionalNamed || parameter.isOptionalPositional,
              isRequired:
                  parameter.isRequiredNamed || parameter.isRequiredPositional,
              isRequestContext: _requestContextType.isExactlyType(
                parameter.type,
              ),
            ),
          );
        }

        _functions.add(
          SourcedFunction(
            functionName: element.name,
            uri: element.source.uri,
            returnType: returnType.toString(),
            isFutureReturnType: isFutureReturnType,
            parameters: parameters,
          ),
        );
      }
    }

    // Generate the output file with all collected functions
    final content = StringBuffer();
    content.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');

    for (final fn in _functions) {
      content.writeln("import '${fn.uri}' as fn_${fn.id};");
    }

    content.writeln('final specs = ${jsonEncode(_functions)};');

    content.writeln('');
    content.writeln('final handlers = {');
    for (final function in _functions) {
      content.writeln(
        '  "${function.pathname}": fn_${function.id}.${function.functionName},',
      );
    }
    content.writeln('};');

    // Write the output file
    final dartSpec = AssetId(
      buildStep.inputId.package,
      '.dart_tool/functions_spec.dart',
    );

    await buildStep.writeAsString(dartSpec, content.toString());

    // Write the output file
    final jsonSpec = AssetId(
      buildStep.inputId.package,
      '.dart_tool/functions_spec.json',
    );

    await buildStep.writeAsString(jsonSpec, jsonEncode(_functions));
  }
}

// import 'dart:convert';

// import 'package:analyzer/dart/element/element.dart';
// import 'package:build/src/builder/build_step.dart';
// import 'package:globe_functions/src/annotations.dart';
// import 'package:source_gen/source_gen.dart';

// const httpFunction = TypeChecker.fromRuntime(HttpFunction);

// enum FunctionType { http }

// // class SourceFunctions extends GeneratorForAnnotation<GlobeFunction> {
// //   SourceFunctions();

// //   static String get header => '''
// // final List<Map<String, dynamic>> specs = [];
// // ''';

// //   @override
// //   generateForAnnotatedElement(
// //     Element element,
// //     ConstantReader annotation,
// //     BuildStep buildStep,
// //   ) {
// //     print('ELLIOT');
// //     print(element);
// //     // TODO: Validate this works for only-top-level functions
// //     if (element is! FunctionElement) {
// //       throw InvalidGenerationSourceError(
// //         'The @GlobeFunction annotation can only be applied to top-level functions.',
// //         element: element,
// //       );
// //     }

// //     // TODO: Get relative name to `api/` directory
// //     final relativeFileName = buildStep.inputId.pathSegments.first;

// //     final functionName = element.name;

// //     final returnType = element.returnType;

// //     FunctionType? type;

// //     // if (httpFunction.isExactlyType(element.metadata.first.type)) {
// //     //   type = FunctionType.http;
// //     // }

// //     // if (type == null) {
// //     //   throw InvalidGenerationSourceError(
// //     //     'Invalid function type',
// //     //     element: element,
// //     //   );
// //     // }

// //     final json = {};

// //     json['functionName'] = functionName;
// //     json['relativeFileName'] = relativeFileName;
// //     json['returnType'] = returnType.toString();
// //     json['type'] = type.toString();

// //     final writer =
// //         StringBuffer()..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');

// //     writer.writeln('// $functionName');

// //     // writer.writeln(jsonEncode(json));

// //     return writer.toString();
// //   }
// // }
