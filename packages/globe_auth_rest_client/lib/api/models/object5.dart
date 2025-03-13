// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object5.g.dart';

@JsonSerializable()
class Object5 {
  const Object5({
    required this.email,
    required this.callbackUrl,
  });
  
  factory Object5.fromJson(Map<String, Object?> json) => _$Object5FromJson(json);
  
  /// The email to send the verification email to
  final String email;

  /// The URL to use for email verification callback
  @JsonKey(name: 'callbackURL')
  final String callbackUrl;

  Map<String, Object?> toJson() => _$Object5ToJson(this);
}
