import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

class SourcedType {
  final String type;
  final bool isNullable;
  final int? importId;

  const SourcedType._({
    required this.type,
    required this.isNullable,
    required this.importId,
  });

  SourcedType.fromDartType({required DartType type, required this.importId})
    : type = type.getDisplayString(withNullability: false),
      isNullable = type.nullabilitySuffix == NullabilitySuffix.question;

  Map<String, dynamic> toJson() {
    return {'type': type, 'importId': importId, 'isNullable': isNullable};
  }

  factory SourcedType.fromJson(Map<String, dynamic> json) {
    return SourcedType._(
      type: json['type'] as String,
      importId: json['importId'] as int?,
      isNullable: json['isNullable'] as bool,
    );
  }
}
