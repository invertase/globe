import 'package:analyzer/dart/element/element.dart';

class SourcedFunction {
  // factory SourcedFunction.fromFunctionElement(FunctionElement element) {
  //   return SourcedFunction(functionName: element.name, uri: element.source.uri);
  // }

  SourcedFunction({
    required this.functionName,
    required this.uri,
    required this.returnType,
    required this.isFutureReturnType,
    required this.parameters,
  });

  /// The name of the top-level function.
  final String functionName;

  /// The URI of the file containing the function.
  final Uri uri;

  /// The return type of the function (as a string).
  final String returnType;

  /// Whether the function returns a Future.
  final bool isFutureReturnType;

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
      returnType: json['returnType'] as String,
      isFutureReturnType: json['isFutureReturnType'] as bool,
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
      'returnType': returnType,
      'isFutureReturnType': isFutureReturnType,
      'parameters': parameters.map((p) => p.toJson()).toList(),
    };
  }
}

class SourcedFunctionParameter {
  SourcedFunctionParameter({
    required this.name,
    required this.type,
    required this.isNamed,
    required this.isPositional,
    required this.isOptional,
    required this.isRequired,
    required this.isRequestContext,
  });

  /// The name of the parameter.
  final String name;

  /// The type of the parameter (as a string).
  final String type;

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
      type: json['type'] as String,
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
      'type': type,
      'isNamed': isNamed,
      'isPositional': isPositional,
      'isOptional': isOptional,
      'isRequired': isRequired,
      'isRequestContext': isRequestContext,
    };
  }
}
