// ignore_for_file: avoid_dynamic_calls

import 'dart:io';
import 'package:args/args.dart';
import 'package:graphql/client.dart';
import 'package:path/path.dart' as path;

/// Downloads a GraphQL schema from a URL and saves it to a file.
///
/// Usage:
/// ```
/// dart run lib/src/graphql/download_schema.dart --url=https://your-graphql-endpoint.com/graphql --output=schema.graphql
/// ```
Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(
      'url',
      abbr: 'u',
      help: 'The GraphQL endpoint URL',
      defaultsTo: 'http://localhost:8788/graphql',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'The output file path',
      defaultsTo: 'lib/src/graphql/schema.graphql',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show this help message',
      negatable: false,
    );

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool) {
      _printUsage(parser);
      return;
    }

    final url = results['url'] as String;
    final outputPath = results['output'] as String;

    stdout.writeln('Downloading GraphQL schema from $url...');

    final link = HttpLink(url);
    final client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );

    final result = await client.query(
      QueryOptions(
        document: gql(_introspectionQuery),
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    // Convert the introspection result to a schema
    final schemaString = _processIntrospectionResult(result.data!);

    // Ensure the directory exists
    final directory = Directory(path.dirname(outputPath));
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    // Write the schema to the file
    await File(outputPath).writeAsString(schemaString);

    stdout.writeln('Schema successfully saved to $outputPath');
  } catch (e) {
    stderr.writeln('Error: $e');
    _printUsage(parser);
    exitCode = 1;
  }
}

void _printUsage(ArgParser parser) {
  stdout.writeln(
    'Usage: dart run lib/src/graphql/download_schema.dart [options]',
  );
  stdout.writeln(parser.usage);
}

/// Converts the introspection result to a GraphQL schema string.
///
/// This is a simplified version that extracts the types and their fields.
/// For a complete implementation, you might want to use a dedicated library.
String _processIntrospectionResult(Map<String, dynamic> data) {
  final schema = StringBuffer();
  final schemaData = data['__schema'] as Map<String, dynamic>;

  // Add schema definition
  final queryType = schemaData['queryType']?['name'];
  final mutationType = schemaData['mutationType']?['name'];
  final subscriptionType = schemaData['subscriptionType']?['name'];

  schema.writeln('schema {');
  if (queryType != null) schema.writeln('  query: $queryType');
  if (mutationType != null) schema.writeln('  mutation: $mutationType');
  if (subscriptionType != null) {
    schema.writeln('  subscription: $subscriptionType');
  }
  schema.writeln('}');
  schema.writeln();

  // Process types
  final types = schemaData['types'] as List<dynamic>;
  for (final type in types) {
    final typeName = type['name'] as String;

    // Skip internal types
    if (typeName.startsWith('__')) continue;

    final kind = type['kind'] as String;
    final description = type['description'] as String?;

    if (description != null && description.isNotEmpty) {
      schema.writeln('"""');
      schema.writeln(description);
      schema.writeln('"""');
    }

    switch (kind) {
      case 'OBJECT':
        schema.write('type $typeName');

        // Add interfaces
        final interfaces = type['interfaces'] as List<dynamic>;
        if (interfaces.isNotEmpty) {
          schema.write(' implements ');
          schema.write(interfaces.map((i) => i['name'] as String).join(' & '));
        }

        schema.writeln(' {');

        // Add fields
        final fields = type['fields'] as List<dynamic>;
        for (final field in fields) {
          final fieldName = field['name'] as String;
          final fieldDescription = field['description'] as String?;

          if (fieldDescription != null && fieldDescription.isNotEmpty) {
            schema.writeln('  """');
            schema.writeln('  $fieldDescription');
            schema.writeln('  """');
          }

          schema.write('  $fieldName');

          // Add arguments
          final args = field['args'] as List<dynamic>;
          if (args.isNotEmpty) {
            schema.write('(');
            schema.write(
              args.map((arg) {
                final argName = arg['name'] as String;
                final argType =
                    _processTypeRef(arg['type'] as Map<String, dynamic>);
                final defaultValue = arg['defaultValue'] as String?;

                return '$argName: $argType${defaultValue != null ? ' = $defaultValue' : ''}';
              }).join(', '),
            );
            schema.write(')');
          }

          // Add return type
          final fieldType =
              _processTypeRef(field['type'] as Map<String, dynamic>);
          schema.writeln(': $fieldType');
        }

        schema.writeln('}');

      case 'INTERFACE':
        schema.writeln('interface $typeName {');

        // Add fields
        final fields = type['fields'] as List<dynamic>;
        for (final field in fields) {
          final fieldName = field['name'] as String;
          final fieldType =
              _processTypeRef(field['type'] as Map<String, dynamic>);
          schema.writeln('  $fieldName: $fieldType');
        }

        schema.writeln('}');

      case 'ENUM':
        schema.writeln('enum $typeName {');

        // Add enum values
        final enumValues = type['enumValues'] as List<dynamic>;
        for (final value in enumValues) {
          final valueName = value['name'] as String;
          schema.writeln('  $valueName');
        }

        schema.writeln('}');

      case 'INPUT_OBJECT':
        schema.writeln('input $typeName {');

        // Add input fields
        final inputFields = type['inputFields'] as List<dynamic>;
        for (final field in inputFields) {
          final fieldName = field['name'] as String;
          final fieldType =
              _processTypeRef(field['type'] as Map<String, dynamic>);
          schema.writeln('  $fieldName: $fieldType');
        }

        schema.writeln('}');

      case 'SCALAR':
        schema.writeln('scalar $typeName');
      case 'UNION':
        schema.write('union $typeName = ');

        // Add possible types
        final possibleTypes = type['possibleTypes'] as List<dynamic>;
        schema
            .writeln(possibleTypes.map((t) => t['name'] as String).join(' | '));
    }

    schema.writeln();
  }

  return schema.toString();
}

/// Processes a type reference to get the full type string.
String _processTypeRef(Map<String, dynamic> typeRef) {
  final kind = typeRef['kind'] as String;
  final name = typeRef['name'] as String?;
  final ofType = typeRef['ofType'] as Map<String, dynamic>?;

  switch (kind) {
    case 'NON_NULL':
      return '${_processTypeRef(ofType!)}!';
    case 'LIST':
      return '[${_processTypeRef(ofType!)}]';
    default:
      return name!;
  }
}

/// The introspection query to get the schema.
const _introspectionQuery = '''
  query IntrospectionQuery {
    __schema {
      queryType { name }
      mutationType { name }
      subscriptionType { name }
      types {
        ...FullType
      }
      directives {
        name
        description
        locations
        args {
          ...InputValue
        }
      }
    }
  }
  
  fragment FullType on __Type {
    kind
    name
    description
    fields(includeDeprecated: true) {
      name
      description
      args {
        ...InputValue
      }
      type {
        ...TypeRef
      }
      isDeprecated
      deprecationReason
    }
    inputFields {
      ...InputValue
    }
    interfaces {
      ...TypeRef
    }
    enumValues(includeDeprecated: true) {
      name
      description
      isDeprecated
      deprecationReason
    }
    possibleTypes {
      ...TypeRef
    }
  }
  
  fragment InputValue on __InputValue {
    name
    description
    type {
      ...TypeRef
    }
    defaultValue
  }
  
  fragment TypeRef on __Type {
    kind
    name
    ofType {
      kind
      name
      ofType {
        kind
        name
        ofType {
          kind
          name
          ofType {
            kind
            name
            ofType {
              kind
              name
              ofType {
                kind
                name
                ofType {
                  kind
                  name
                }
              }
            }
          }
        }
      }
    }
  }
''';
