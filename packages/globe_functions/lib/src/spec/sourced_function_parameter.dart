import 'package:globe_functions/src/spec/sourced_type.dart';

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
}
