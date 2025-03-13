// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object13.g.dart';

@JsonSerializable()
class Object13 {
  const Object13({
    required this.username,
    required this.password,
    required this.rememberMe,
  });
  
  factory Object13.fromJson(Map<String, Object?> json) => _$Object13FromJson(json);
  
  /// The username of the user
  final String username;

  /// The password of the user
  final String password;

  /// Remember the user session
  final String rememberMe;

  Map<String, Object?> toJson() => _$Object13ToJson(this);
}
