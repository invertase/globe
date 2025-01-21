import 'package:analyzer/dart/element/type.dart';
import 'package:globe_functions/src/build/serializer.dart';

class SourcedFunction {
  SourcedFunction({
    required this.functionName,
    required this.uri,
    required this.returnType,
    required this.parameters,
  });

  /// The name of the top-level function.
  final String functionName;

  /// The URI of the file containing the function.
  final Uri uri;

  /// The return type details.
  final SourcedType returnType;

  /// The parameters of the function.
  final List<SourcedFunctionParameter> parameters;

  int get id => '$uri:$functionName'.hashCode;

  String get pathname {
    // Path comes through as <package>/lib/api/.../<name>.dart
    // We want to remove the <package>/lib/api/
    final filePath = uri.pathSegments
        .sublist(uri.pathSegments.indexOf('api') + 1)
        .join('/');

    // Remove the .dart extension
    final pathname = filePath.replaceAll('.dart', '');

    return '$pathname/$functionName';
  }

  factory SourcedFunction.fromJson(Map<String, dynamic> json) {
    return SourcedFunction(
      functionName: json['functionName'] as String,
      uri: Uri.parse(json['uri'] as String),
      returnType: SourcedType.fromJson(json['returnType']),
      parameters:
          (json['parameters'] as List<dynamic>)
              .map((p) => SourcedFunctionParameter.fromJson(p))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'functionName': functionName,
      'uri': uri.toString(),
      'returnType': returnType.toJson(),
      'parameters': parameters.map((p) => p.toJson()).toList(),
    };
  }
}

class SourcedFunctionParameter {
  SourcedFunctionParameter({
    required this.name,
    required this.type,
    required this.defaultValue,
    required this.isNamed,
    required this.isPositional,
    required this.isOptional,
    required this.isRequired,
    required this.isRequestContext,
  });

  /// The name of the parameter.
  final String name;

  /// The type of the parameter.
  final SourcedType type;

  /// The default value of the parameter.
  final String? defaultValue;

  /// Whether the parameter is named.
  final bool isNamed;

  /// Whether the parameter is positional.
  final bool isPositional;

  /// Whether the parameter is optional.
  final bool isOptional;

  /// Whether the parameter is required.
  final bool isRequired;

  /// Whether the parameter is the request context.
  final bool isRequestContext;

  factory SourcedFunctionParameter.fromJson(Map<String, dynamic> json) {
    return SourcedFunctionParameter(
      name: json['name'] as String,
      type: SourcedType.fromJson(json['type'] as Map<String, dynamic>),
      defaultValue: json['defaultValue'] as String?,
      isNamed: json['isNamed'] as bool,
      isPositional: json['isPositional'] as bool,
      isOptional: json['isOptional'] as bool,
      isRequired: json['isRequired'] as bool,
      isRequestContext: json['isRequestContext'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.toJson(),
      'defaultValue': defaultValue,
      'isNamed': isNamed,
      'isPositional': isPositional,
      'isOptional': isOptional,
      'isRequired': isRequired,
      'isRequestContext': isRequestContext,
    };
  }
}

class SourcedType {
  final String type;
  final SerializerType serializerType;
  final Uri? uri;
  final bool isFuture;

  SourcedType.fromDartType({
    required DartType type,
    required this.serializerType,
    required this.isFuture,
  }) : type = type.toString(),
       uri =
           serializerType == SerializerType.clazz
               ? type.element?.library?.source.uri
               : null;

  SourcedType({
    required this.type,
    required this.serializerType,
    required this.uri,
    required this.isFuture,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'serializerType': serializerType.name,
    'uri': uri?.toString(),
    'isFuture': isFuture,
  };

  factory SourcedType.fromJson(Map<String, dynamic> json) {
    return SourcedType(
      type: json['type'] as String,
      serializerType: SerializerType.values.byName(
        json['serializerType'] as String,
      ),
      uri: json['uri'] != null ? Uri.parse(json['uri'] as String) : null,
      isFuture: json['isFuture'] as bool,
    );
  }
}
