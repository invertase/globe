// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object11.g.dart';

@JsonSerializable()
class Object11 {
  const Object11({
    required this.callbackUrl,
    required this.provider,
  });
  
  factory Object11.fromJson(Map<String, Object?> json) => _$Object11FromJson(json);
  
  /// The URL to redirect to after the user has signed in
  @JsonKey(name: 'callbackURL')
  final String callbackUrl;

  /// The OAuth2 provider to use
  final String provider;

  Map<String, Object?> toJson() => _$Object11ToJson(this);
}
