import 'package:analyzer/dart/element/element.dart';
import 'package:shelf_rpc/src/build/supported_type.dart';

/// A class representing a sourced RPC procedure parameter from the user's code.
class SourcedRpcProcedureParameter {
  /// The interface of the parameter.
  final SupportedType interface;

  /// The parameter element (from Analyzer).
  final ParameterElement parameter;
        
  /// Creates a new [SourcedRpcProcedureParameter] instance.
  SourcedRpcProcedureParameter(this.interface, this.parameter);

  /// The name of the parameter.
  String get name => parameter.name;

  /// The default value of the parameter (if any).
  String? get defaultValue => parameter.defaultValueCode;

  /// Whether the parameter is named.
  bool get isNamed => parameter.isNamed;

  /// Whether the parameter is positional.
  bool get isPositional => parameter.isPositional;

  /// Whether the parameter is optional.
  bool get isOptional =>
      parameter.isOptionalNamed || parameter.isOptionalPositional;

  /// Whether the parameter is required.
  bool get isRequired =>
      parameter.isRequiredNamed || parameter.isRequiredPositional;

  /// The reconstructed typedef of the parameter.
  String get typedef {
    return '${interface.typeDefinition}${isOptional ? '?' : ''} $name';
  }
}
