import 'dart:convert';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:globe_functions/src/annotations.dart';
import 'package:globe_functions/src/build/writers/client_writer.dart';
import 'package:globe_functions/src/build/writers/server_writer.dart';
import 'package:globe_functions/src/shelf_rpc.dart';
import 'package:globe_functions/src/spec/rpc_procedure.dart';
import 'package:globe_functions/src/spec/rpc_procedure_parameter.dart';
import 'package:globe_functions/src/spec/serializer.dart';
import 'package:globe_functions/src/spec/sourced_entry.dart';
import 'package:globe_functions/src/spec/sourced_procedure.dart';
import 'package:globe_functions/src/spec/sourced_parameter.dart';
import 'package:globe_functions/src/spec/sourced_imports.dart';
// import 'package:globe_functions/src/spec/sourced_serializers.dart';
import 'package:globe_functions/src/server/request_context.dart';
import 'package:globe_functions/src/spec/sourced_type.dart';
import 'package:globe_functions/src/spec/types.dart';
import 'package:source_gen/source_gen.dart';

const _routerType = TypeChecker.fromRuntime(Router);
const _executedProcedureType = TypeChecker.fromRuntime(ExecutedProcedure);

// Any reserved names which are exposed in the client to prevent conflicts.
const _reservedNames = ['postRequest', 'getRequest', 'sseRequest'];

class SourceRpcBuilder extends Builder {
  final imports = SourcedImports();
  // final serializers = SourcedSerializers();

  @override
  Map<String, List<String>> get buildExtensions => {
    r'.dart': ['.server.dart', '.client.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final library = await buildStep.resolver.libraryFor(buildStep.inputId);
    final reader = LibraryReader(library);

    final registered = reader.annotatedWith(
      TypeChecker.fromRuntime(ShelfRpcRegistry),
    );

    if (registered.isEmpty) {
      return;
    }

    final imports = SourcedImports();
    final entrypoints = <SourcedEntry>[];

    for (final annotated in registered) {
      if (annotated.element is! TopLevelVariableElement) {
        throw InvalidGenerationSourceError(
          'The @ShelfRpcRegistry annotation can only be applied to top-level functions.',
          element: annotated.element,
        );
      }

      final element = annotated.element as TopLevelVariableElement;

      if (element.isPrivate) {
        throw InvalidGenerationSourceError(
          '@ShelfRpcRegistry annotation must be used on a public top-level variable.',
          element: element,
        );
      }

      if (_reservedNames.contains(element.name)) {
        throw InvalidGenerationSourceError(
          '@ShelfRpcRegistry cannot use the ${element.name} variable, it is reserved for internal use.',
          element: element,
        );
      }

      if (!_routerType.isExactlyType(element.type)) {
        throw InvalidGenerationSourceError(
          '@ShelfRpcRegistry annotation must be used on a Router instance',
          element: element,
        );
      }

      final declaration = await buildStep.resolver.astNodeFor(
        element,
        resolve: true,
      );

      if (declaration == null || declaration is! VariableDeclaration) {
        throw InvalidGenerationSourceError(
          'Unable to find a Router instance (expected a variable declaration)',
          element: element,
        );
      }

      final initializer = declaration.initializer;

      if (initializer is! MethodInvocation) {
        throw InvalidGenerationSourceError(
          'Unable to find a Router instance (expected a method invocation)',
          element: element,
        );
      }

      // Routes can only be initialized with a Map as the single argument.
      final routes =
          initializer.argumentList.arguments.single as SetOrMapLiteral;

      final procedures = <RpcProcedure>[];

      void processRoutes(
        List<CollectionElement> elements, [
        List<String>? prefix = const [],
      ]) {
        for (final (element as MapLiteralEntry) in elements) {
          final key = (element.key as SymbolLiteral).name;
          final value = element.value as MethodInvocation;

          // Skip private routes and duplicate routes.
          if (key.startsWith('_')) {
            continue;
          }

          final idChunks = prefix == null ? [key] : [...prefix, key];
          final id = idChunks.join('.');

          if (procedures.any((p) => p.id == id)) {
            continue;
          }

          switch (value.staticType!) {
            // If the procedure is a nested router, process the nested routes.
            case final type when _routerType.isExactlyType(type):
              final nestedRoutes =
                  value.argumentList.arguments.single as SetOrMapLiteral;
              return processRoutes(nestedRoutes.elements, idChunks);

            // If the procedure is executed, process the function.
            case final type when _executedProcedureType.isExactlyType(type):
              {
                final expression = value.argumentList.arguments.single;

                // Get function type and details
                DartType? function;
                List<ParameterElement> parameters = [];

                if (expression is SimpleIdentifier) {
                  final element = expression.staticElement;
                  if (element is FunctionElement) {
                    function = element.type.returnType;
                    parameters = element.parameters;
                  }
                } else if (expression is ConstructorReference) {
                  final element = expression.constructorName.staticElement;
                  if (element is ConstructorElement) {
                    function = element.returnType;
                    parameters = element.parameters;
                  }
                } else if (expression is PropertyAccess) {
                  final element = expression.propertyName.staticElement;
                  if (element is MethodElement) {
                    function = element.returnType;
                    parameters = element.parameters;
                  }
                } else if (expression is FunctionExpression) {
                  final type = expression.staticType;
                  if (type is FunctionType) {
                    function = type.returnType;
                    parameters = type.parameters;
                  }
                } else if (expression is PrefixedIdentifier) {
                  // Handle static method references like:
                  // #staticMethodTearOff: r.procedure().exec(Bar.foo),
                  final element = expression.staticElement;
                  if (element is MethodElement) {
                    function = element.returnType;
                    parameters = element.parameters;
                  }
                }

                // Shouldn't get to here...
                if (function == null) {
                  throw InvalidGenerationSourceError(
                    'Unable to determine return procedure: ${expression.runtimeType}',
                  );
                }

                final interface = SupportedType.fromDartType(
                  imports: imports,
                  type: function,
                  library: library,
                )..assertValid();

                final paramInterfaces =
                    parameters.map((parameter) {
                      final interface = SupportedType.fromDartType(
                        imports: imports,
                        type: parameter.type,
                        library: library,
                      );

                      if (interface is AsyncType) {
                        throw InvalidGenerationSourceError(
                          'Parameters cannot be async.',
                          element: parameter,
                        );
                      }

                      interface.assertValid();

                      return RpcProcedureParameter(interface, parameter);
                    }).toList();

                procedures.add(
                  RpcProcedure(
                    id: id,
                    interface: interface,
                    parameters: paramInterfaces,
                  ),
                );

                // // Get the sourced return type
                // final returnType = SourcedType.fromDartType(
                //   imports: imports,
                //   library: library,
                //   type: function,
                // );

                // // If the user has returned a Future, FutureOr, or Stream, we need
                // // to get the type of the value they are returning, e.g.
                // // Future<String> -> String.
                // final serializedType = switch (returnType.kind) {
                //   SourcedTypeKind.future => function,
                //   SourcedTypeKind.futureOr => returnType.typeArguments.first,
                //   SourcedTypeKind.stream => returnType.typeArguments.first,
                //   _ => returnType,
                // };

                // // Get the sourced parameters types
                // final parameterTypes = [
                //   for (final parameter in parameters)
                //     SourcedType.fromDartType(
                //       imports: imports,
                //       library: library,
                //       type: parameter.type,
                //     ),
                // ];

                // // Don't allow async parameters.
                // for (var i = 0; i < parameterTypes.length; i++) {
                //   switch (parameterTypes[i].kind) {
                //     case SourcedTypeKind.future:
                //     case SourcedTypeKind.futureOr:
                //     case SourcedTypeKind.stream:
                //       throw InvalidGenerationSourceError(
                //         'Parameters cannot be async.',
                //         element: parameters[i],
                //       );
                //     default:
                //       break;
                //   }
                // }

                // Get the sourced parameters
                // final sourcedParameters =
                //     parameters.map((parameter) {
                //       // Get the resolved parameter type.
                //       final parameterType = switch (parameter.type) {
                //         // If the parameter is an async type, throw an error.
                //         InterfaceType type
                //             when type.isDartAsyncFuture ||
                //                 type.isDartAsyncFutureOr ||
                //                 type.isDartAsyncStream =>
                //           throw InvalidGenerationSourceError(
                //             'Parameters cannot be async.',
                //             element: parameter,
                //           ),
                //         // If the parameter is a symbol, function, or record, throw an
                //         // error as we can't serialize these.
                //         InterfaceType type
                //             when type.isDartCoreSymbol ||
                //                 type.isDartCoreFunction ||
                //                 type.isDartCoreRecord =>
                //           throw InvalidGenerationSourceError(
                //             'Unsupported parameter type: ${parameter.type}',
                //             element: parameter,
                //           ),
                //         // If the parameter is a function or record, throw an
                //         // error as we can't serialize these.
                //         FunctionType _ || RecordType _ =>
                //           throw InvalidGenerationSourceError(
                //             'Unsupported parameter type: ${parameter.type}',
                //             element: parameter,
                //           ),
                //         _ => parameter.type,
                //       };

                //       // Check if the parameter is the RequestContext type.
                //       final isRequestContext = _requestContextType
                //           .isExactlyType(parameter.type);

                //       return SourcedParameter(
                //         name: parameter.name,
                //         type: SourcedType.fromDartType(
                //           imports: imports,
                //           // serializers: serializers,
                //           library: library,
                //           type: parameterType,
                //         ),
                //         defaultValue: parameter.defaultValueCode,
                //         isNamed: parameter.isNamed,
                //         isPositional: parameter.isPositional,
                //         isOptional:
                //             parameter.isOptionalNamed ||
                //             parameter.isOptionalPositional,
                //         isRequired:
                //             parameter.isRequiredNamed ||
                //             parameter.isRequiredPositional,
                //         isRequestContext: isRequestContext,
                //       );
                //     }).toList();

                // procedures.add(
                //   SourcedProcedure(
                //     id: id.join('.'),
                //     type: SourcedType.fromDartType(
                //       imports: imports,
                //       // serializers: serializers,
                //       library: library,
                //       type: returnType,
                //     ),
                //     parameters: sourcedParameters,
                //   ),
                // );
              }
            case _:
              throw Exception('Invalid procedure type.');
          }
        }
      }

      // Iterate over the root routes in the router.
      processRoutes(routes.elements);

      entrypoints.add(
        SourcedEntry(
          importId: imports.register(element.source!.uri),
          name: element.name,
          procedures: procedures,
        ),
      );
    }

    final server = ServerWriter(imports: imports, entrypoints: entrypoints);
    final client = ClientWriter(imports: imports, entrypoints: entrypoints);
    final asset = AssetId(buildStep.inputId.package, buildStep.inputId.path);

    await Future.wait([
      buildStep.writeAsString(
        asset.changeExtension('.server.dart'),
        server.write(),
      ),
      buildStep.writeAsString(
        asset.changeExtension('.client.dart'),
        client.write(),
      ),
    ]);

    // if (entrypoints.isEmpty) {
    //   return;
    // }

    // final spec = jsonEncode({
    //   'entrypoints': entrypoints.map((e) => e.toJson()).toList(),
    //   'imports': imports.toJson(),
    //   // 'serializers': serializers.toJson(),
    // });

    // await buildStep.writeAsString(
    //   buildStep.inputId.changeExtension('.shelf_rpc_spec.json'),
    //   spec,
    // );
  }
}

extension on SymbolLiteral {
  /// Returns the name of the symbol without the leading `#` character.
  String get name {
    return toString().substring(1);
  }
}

// class TypeInfo {
//   final DartType type;
//   final String typeName;
//   final List<TypeInfo> typeArguments;

//   TypeInfo({
//     required this.type,
//     required this.typeName,
//     this.typeArguments = const [],
//   });

//   factory TypeInfo.fromDartType(DartType type) {
//     return switch (type) {
//       InterfaceType interface
//           when interface.isDartCoreFunction ||
//               interface.isDartCoreSymbol ||
//               interface.isDartCoreRecord =>
//         throw InvalidGenerationSourceError(
//           'Unsupported type: ${interface.getDisplayString(withNullability: false)}',
//         ),
//       InterfaceType interface => TypeInfo(
//         type: type,
//         typeName: interface.element.name,
//         typeArguments:
//             interface.typeArguments
//                 .map((t) => TypeInfo.fromDartType(t))
//                 .toList(),
//       ),
//       RecordType _ =>
//         throw InvalidGenerationSourceError('Record types are not supported'),
//       FunctionType _ =>
//         throw InvalidGenerationSourceError('Function types are not supported'),
//       _ => TypeInfo(
//         type: type,
//         typeName: type.getDisplayString(withNullability: false),
//       ),
//     };
//   }
// }
