// ignore_for_file: invalid_use_of_protected_member

import 'package:luthor/luthor.dart';

bool _isNotModifierValidation(Validation validation) {
  return validation is AnyValidation ||
      validation is BoolValidation ||
      validation is DoubleValidation ||
      validation is IntValidation ||
      validation is ListValidation ||
      validation is MapValidation ||
      validation is NullValidation ||
      validation is NumberValidation ||
      validation is SchemaValidation ||
      validation is StringValidation;
}

dynamic _validationsToJson(
  List<Validation> validations,
  String? fieldName,
  List<String> _,
) {
  if (validations.isEmpty) return null;
  final [first, ...rest] = validations;
  if (!_isNotModifierValidation(first)) {
    throw StateError('First validation must be a type validation');
  }

  final isRequired = rest.any((v) => v is RequiredValidation);

  Map<String, dynamic> wrapWithRequired(Map<String, dynamic> schema) {
    if (isRequired) {
      return {
        ...schema,
        "required": true,
      };
    }
    return schema;
  }

  if (first is AnyValidation) {
    return wrapWithRequired({"type": "any"});
  }

  if (first is BoolValidation) {
    return wrapWithRequired({"type": "boolean"});
  }

  if (first is DoubleValidation || first is NumberValidation) {
    return wrapWithRequired({"type": "number"});
  }

  if (first is IntValidation) {
    return wrapWithRequired({"type": "integer"});
  }

  if (first is StringValidation) {
    return {"type": "string"};
  }

  if (first is NullValidation) {
    return wrapWithRequired({"type": "null"});
  }

  if (first is MapValidation) {
    return wrapWithRequired({
      "type": "object",
      "additionalProperties": true,
    });
  }

  if (first is ListValidation) {
    final innerValidator = (first.validators?.isNotEmpty ?? false)
        ? first.validators!.first
        : null;

    return {
      "type": "array",
      if (innerValidator != null)
        "items": _validationsToJson(innerValidator.validations, null, [])
    };
  }

  if (first is SchemaValidation) {
    final properties = <String, dynamic>{};

    /// Make all fields required by default
    final requiredProps = first.validatorSchema.entries
        .where((e) => e.value.validations.isNotEmpty)
        .map((e) => e.key);

    first.validatorSchema.forEach((key, validator) {
      final fieldJson = _validationsToJson(validator.validations, key, []);
      if (fieldJson != null) properties[key] = fieldJson;
    });

    return {
      "type": "object",
      "properties": properties,
      if (requiredProps.isNotEmpty) "required": requiredProps.toList(),
      "additionalProperties": false,
    };
  }

  throw StateError('Unknown validation type: $first');
}

extension LuthorValidationToJson on Validator {
  Map<String, dynamic> toJson() {
    if (validations.isEmpty) {
      throw StateError('Validator has no validations');
    }
    final requiredKeys = <String>[];
    return _validationsToJson(validations, null, requiredKeys)
        as Map<String, dynamic>;
  }
}
