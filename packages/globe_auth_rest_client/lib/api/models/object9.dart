// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object9.g.dart';

@JsonSerializable()
class Object9 {
  const Object9({
    required this.callbackUrl,
    required this.password,
    required this.token,
  });
  
  factory Object9.fromJson(Map<String, Object?> json) => _$Object9FromJson(json);
  
  @JsonKey(name: 'callbackURL')
  final String callbackUrl;
  final String password;
  final String token;

  Map<String, Object?> toJson() => _$Object9ToJson(this);
}
