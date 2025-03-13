// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object7.g.dart';

@JsonSerializable()
class Object7 {
  const Object7({
    required this.newPassword,
    required this.currentPassword,
    required this.revokeOtherSessions,
  });
  
  factory Object7.fromJson(Map<String, Object?> json) => _$Object7FromJson(json);
  
  /// The new password to set
  final String newPassword;

  /// The current password
  final String currentPassword;

  /// Revoke all other sessions
  final String revokeOtherSessions;

  Map<String, Object?> toJson() => _$Object7ToJson(this);
}
