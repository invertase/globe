// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object2.g.dart';

@JsonSerializable()
class Object2 {
  const Object2({
    required this.email,
    required this.password,
    required this.callbackUrl,
    required this.rememberMe,
  });
  
  factory Object2.fromJson(Map<String, Object?> json) => _$Object2FromJson(json);
  
  /// Email of the user
  final String email;

  /// Password of the user
  final String password;

  /// Callback URL to use as a redirect for email verification
  @JsonKey(name: 'callbackURL')
  final String callbackUrl;

  /// If this is false, the session will not be remembered. Default is `true`.
  final String rememberMe;

  Map<String, Object?> toJson() => _$Object2ToJson(this);
}
