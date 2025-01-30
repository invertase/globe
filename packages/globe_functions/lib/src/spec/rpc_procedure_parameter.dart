import 'package:analyzer/dart/element/element.dart';
import 'package:globe_functions/globe_functions.dart';
import 'package:globe_functions/src/spec/types.dart';
import 'package:source_gen/source_gen.dart';

class RpcProcedureParameter {
  final SupportedType interface;
  final ParameterElement parameter;

  RpcProcedureParameter(this.interface, this.parameter);

  String get name => parameter.name;

  String? get defaultValue => parameter.defaultValueCode;

  bool get isNamed => parameter.isNamed;

  bool get isPositional => parameter.isPositional;

  bool get isOptional =>
      parameter.isOptionalNamed || parameter.isOptionalPositional;

  bool get isRequired =>
      parameter.isRequiredNamed || parameter.isRequiredPositional;

  String get typedef {
    return '${interface.typeDefinition}${isOptional ? '?' : ''} $name';
  }
}
