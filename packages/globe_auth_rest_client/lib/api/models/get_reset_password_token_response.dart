// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'get_reset_password_token_response.g.dart';

@JsonSerializable()
class GetResetPasswordTokenResponse {
  const GetResetPasswordTokenResponse({
    required this.token,
  });
  
  factory GetResetPasswordTokenResponse.fromJson(Map<String, Object?> json) => _$GetResetPasswordTokenResponseFromJson(json);
  
  final String token;

  Map<String, Object?> toJson() => _$GetResetPasswordTokenResponseToJson(this);
}
