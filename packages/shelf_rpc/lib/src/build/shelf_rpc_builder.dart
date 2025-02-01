import 'package:shelf_rpc/shelf_rpc.dart';
import 'package:shelf_rpc/src/build/sourced_entrypoint.dart';
import 'package:shelf_rpc/src/build/sourced_imports.dart';
import 'package:shelf_rpc/src/build/sourced_rpc_procedure.dart';
import 'package:shelf_rpc/src/build/sourced_rpc_procedure_parameter.dart';
import 'package:shelf_rpc/src/build/supported_type.dart';
import 'package:shelf_rpc/src/build/writers/client_writer.dart';
import 'package:shelf_rpc/src/build/writers/server_writer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Type checker for the [RpcRouter] type.
const _rpcRouter = TypeChecker.fromRuntime(RpcRouter);

/// Type checker for the [ExecutedRpcProcedure] type.
const _executedRpcProcedure = TypeChecker.fromRuntime(ExecutedRpcProcedure);

/// Any reserved names which are exposed in the client to prevent conflicts.
const _reservedNames = ['postRequest', 'getRequest', 'sseRequest'];

/// Builder for the [ShelfRpc] library.
final class ShelfRpcBuilder extends Builder {
  /// The options for the builder, if any.
  final BuilderOptions? options;

  /// Creates a new [ShelfRpcBuilder] instance.
  ShelfRpcBuilder(this.options);

  @override
  Future<void> build(BuildStep buildStep) async {
    final library = await buildStep.resolver.libraryFor(buildStep.inputId);
    final reader = LibraryReader(library);

    // Identify all registered entrypoints in the library.
    final registered = reader.annotatedWith(
      TypeChecker.fromRuntime(RpcEntrypoint),
    );

    // If no entrypoints are registered, return early.
    if (registered.isEmpty) {
      return;
    }

    // An instance to keep track of the imports.
    final imports = SourcedImports();

    // A list of all the entrypoints.
    final entrypoints = <SourcedEntrypoint>[];

    // Cycle through all the registered entrypoints.
    for (final annotated in registered) {
      // Check if the annotated element is a top-level variable.
      if (annotated.element is! TopLevelVariableElement) {
        throw InvalidGenerationSourceError(
          'The @RpcEntrypoint annotation can only be applied to top-level functions.',
          element: annotated.element,
        );
      }

      final element = annotated.element as TopLevelVariableElement;

      // Check if the annotated element is private (e.g. _foo).
      if (element.isPrivate) {
        throw InvalidGenerationSourceError(
          '@RpcEntrypoint annotation must be used on a public top-level variable.',
          element: element,
        );
      }

      // Check if the annotated element is a [RpcRouter] instance.
      if (!_rpcRouter.isExactlyType(element.type)) {
        throw InvalidGenerationSourceError(
          '@RpcEntrypoint must annotate a [RpcRouter] instance.',
          element: element,
        );
      }

      // Get the declaration of the annotated element, with resolution enabled.
      // TODO: Should we async await this for loop to speed up the build?
      final declaration = await buildStep.resolver.astNodeFor(
        element,
        resolve: true,
      );

      // Check if the declaration is a variable declaration.
      if (declaration == null || declaration is! VariableDeclaration) {
        throw InvalidGenerationSourceError(
          'Unable to find a Router instance (expected a variable declaration)',
          element: element,
        );
      }

      // Get the initializer of the declaration.
      final initializer = declaration.initializer;

      // Check if the initializer is a method invocation.
      if (initializer is! MethodInvocation) {
        throw InvalidGenerationSourceError(
          'Unable to find a Router instance (expected a method invocation)',
          element: element,
        );
      }

      // Routes can only be initialized with a Map as the single argument.
      final routes =
          initializer.argumentList.arguments.single as SetOrMapLiteral;

      // A list of all the procedures.
      final procedures = <SourcedRpcProcedure>[];

      // A generic function to process the routes.
      void processRoutes(
        List<CollectionElement> elements, [
        List<String>? prefix = const [],
      ]) {
        // Iterate over the routes in the router.
        for (final (element as MapLiteralEntry) in elements) {
          // Get the key of the route (the symbol name).
          final key = (element.key as SymbolLiteral).name;

          if (_reservedNames.contains(key)) {
            throw InvalidGenerationSourceError(
              'The reserved name "$key" cannot be used as an RPC route identifier.',
            );
          }

          // Skip private routes and duplicate routes.
          if (key.startsWith('_') ||
              !RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$').hasMatch(key)) {
            print('Skipping invalid RPC Route ${prefix == null ? key : [
                ...prefix,
                key
              ].join('.')}');
            continue;
          }

          // Get the value of the route (router or procedure).
          final value = element.value as MethodInvocation;

          // Get the chunks of the id, with any previous prefix.
          final idChunks = prefix == null ? [key] : [...prefix, key];

          // Join the chunks to form the id to make the RPC identifier.
          final id = idChunks.join('.');

          // Skip duplicate procedures.
          if (procedures.any((p) => p.id == id)) {
            continue;
          }

          // Switch on the static type of the value. These extend a sealed
          // [RpcRouterDefinition] type.
          switch (value.staticType!) {
            // If the Map value is a [RpcRouter], process the nested routes.
            case final type when _rpcRouter.isExactlyType(type):
              // Get the nested routes from the router.
              final nestedRoutes =
                  value.argumentList.arguments.single as SetOrMapLiteral;

              // Process the nested routes.
              return processRoutes(nestedRoutes.elements, idChunks);

            // If the Map value is an [ExecutedRpcProcedure].
            case final type when _executedRpcProcedure.isExactlyType(type):
              {
                // Get the function from the executed procedure.
                // TODO: This may need to be cleverer to support named args such as method override.
                final expression = value.argumentList.arguments.single;

                // The reference to the function.
                // Since there's a number of different types of expressions
                // that can be used to reference a function, we need to check
                // each one and extract the function type and parameters.
                DartType? function;

                // The parameters of the function.
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

                // Shouldn't technically get here, but we might have missed
                // a way to reference a function.
                if (function == null) {
                  throw InvalidGenerationSourceError(
                    'Unable to determine return procedure: ${expression.runtimeType}. Please create an issue.',
                  );
                }

                // Get the supported interface type from the function.
                final interface = SupportedType.fromDartType(
                  imports: imports,
                  type: function,
                  library: library,
                )..assertValid();

                // TODO validate the return type of the interface is not async

                // For each function parameter, get the supported interface type.
                final paramInterfaces = parameters.map((parameter) {
                  final interface = SupportedType.fromDartType(
                    imports: imports,
                    type: parameter.type,
                    library: library,
                  );

                  // We can't support async parameters.
                  if (interface is AsyncType) {
                    throw InvalidGenerationSourceError(
                      'Parameters cannot be async.',
                      element: parameter,
                    );
                  }

                  // Assert that the interface is valid.
                  interface.assertValid();

                  // Return the parameter with the interface type.
                  return SourcedRpcProcedureParameter(interface, parameter);
                }).toList();

                // Add the procedure to the list.
                procedures.add(
                  SourcedRpcProcedure(
                    id: id,
                    interface: interface,
                    parameters: paramInterfaces,
                  ),
                );
              }
            case _:
              // Shouldn't get here.
              throw Exception('Invalid procedure type.');
          }
        }
      }

      // Start the process of iterating over the base routes.
      processRoutes(routes.elements);

      // Add the entrypoint to the list.
      entrypoints.add(
        SourcedEntrypoint(
          importId: imports.register(element.source!.uri),
          name: element.name,
          procedures: procedures,
        ),
      );
    }

    // Create the server and client code.
    final server = ServerWriter(imports: imports, entrypoints: entrypoints);
    final client = ClientWriter(imports: imports, entrypoints: entrypoints);
    final asset = AssetId(buildStep.inputId.package, buildStep.inputId.path);

    // Write the server and client code to the build step.
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
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        r'.dart': ['.server.dart', '.client.dart'],
      };
}

extension on SymbolLiteral {
  /// Returns the name of the symbol without the leading `#` character.
  String get name {
    return toString().substring(1);
  }
}
