import 'package:globe_functions/src/annotations.dart';
import 'package:globe_functions/src/spec/sourced_function_parameter.dart';
import 'package:globe_functions/src/spec/sourced_type.dart';

class SourcedFunction {
  SourcedFunction({
    required this.functionName,
    required this.functionType,
    required this.importId,
    required this.uri,
    required this.type,
    required this.parameters,
  });

  /// The name of the top-level function.
  final String functionName;

  /// The type of the function.
  final GlobeFunctionType functionType;

  /// The import ID of the file containing the function.
  final int importId;

  /// The URI of the file containing the function.
  final Uri uri;

  /// The return type details.
  final SourcedType type;

  /// The parameters of the function.
  final List<SourcedFunctionParameter> parameters;

  String get id {
    // Path comes through as <package>/lib/api/.../<name>.dart
    // We want to remove the <package>/lib/api/
    final segments = uri.pathSegments
        .sublist(uri.pathSegments.indexOf('api') + 1);

    // Remove the .dart extension from last segment
    segments[segments.length - 1] = segments.last.replaceAll('.dart', '');

    // Join with dots to create ID like users.details.get
    return [...segments, functionName].join('.');
  }

  Map<String, dynamic> toJson() {
    return {
      'functionName': functionName,
      'functionType': functionType.name,
      'importId': importId,
      'uri': uri.toString(),
      'type': type.toJson(),
      'parameters': parameters.map((p) => p.toJson()).toList(),
    };
  }

  static SourcedFunction fromJson(Map<String, dynamic> json) {
    return SourcedFunction(
      functionName: json['functionName'] as String,
      functionType: GlobeFunctionType.values.firstWhere(
        (e) => e.name == json['functionType'],
      ),
      importId: json['importId'] as int,
      uri: Uri.parse(json['uri'] as String),
      type: SourcedType.fromJson(json['type'] as Map<String, dynamic>),
      parameters:
          (json['parameters'] as List)
              .map(
                (p) => SourcedFunctionParameter.fromJson(
                  p as Map<String, dynamic>,
                ),
              )
              .toList(),
    );
  }
}
