// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object6.g.dart';

@JsonSerializable()
class Object6 {
  const Object6({
    required this.newEmail,
    required this.callbackUrl,
  });
  
  factory Object6.fromJson(Map<String, Object?> json) => _$Object6FromJson(json);
  
  /// The new email to set
  final String newEmail;

  /// The URL to redirect to after email verification
  @JsonKey(name: 'callbackURL')
  final String callbackUrl;

  Map<String, Object?> toJson() => _$Object6ToJson(this);
}
