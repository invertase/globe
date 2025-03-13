// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'verification.g.dart';

@JsonSerializable()
class Verification {
  const Verification({
    required this.id,
    required this.identifier,
    required this.value,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory Verification.fromJson(Map<String, Object?> json) => _$VerificationFromJson(json);
  
  final String id;
  final String identifier;
  final String value;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, Object?> toJson() => _$VerificationToJson(this);
}
