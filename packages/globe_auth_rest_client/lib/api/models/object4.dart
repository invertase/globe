// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object4.g.dart';

@JsonSerializable()
class Object4 {
  const Object4({
    required this.newPassword,
    required this.token,
  });
  
  factory Object4.fromJson(Map<String, Object?> json) => _$Object4FromJson(json);
  
  /// The new password to set
  final String newPassword;

  /// The token to reset the password
  final String token;

  Map<String, Object?> toJson() => _$Object4ToJson(this);
}
