// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object1.g.dart';

@JsonSerializable()
class Object1 {
  const Object1({
    required this.name,
    required this.email,
    required this.password,
    required this.callbackUrl,
  });
  
  factory Object1.fromJson(Map<String, Object?> json) => _$Object1FromJson(json);
  
  /// The name of the user
  final String name;

  /// The email of the user
  final String email;

  /// The password of the user
  final String password;

  /// The URL to use for email verification callback
  @JsonKey(name: 'callbackURL')
  final String callbackUrl;

  Map<String, Object?> toJson() => _$Object1ToJson(this);
}
