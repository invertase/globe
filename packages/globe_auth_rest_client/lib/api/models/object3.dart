// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object3.g.dart';

@JsonSerializable()
class Object3 {
  const Object3({
    required this.email,
    required this.redirectTo,
  });
  
  factory Object3.fromJson(Map<String, Object?> json) => _$Object3FromJson(json);
  
  /// The email address of the user to send a password reset email to
  final String email;

  /// The URL to redirect the user to reset their password. If the token isn't valid or expired, it'll be redirected with a query parameter `?error=INVALID_TOKEN`. If the token is valid, it'll be redirected with a query parameter `?token=VALID_TOKEN
  final String redirectTo;

  Map<String, Object?> toJson() => _$Object3ToJson(this);
}
