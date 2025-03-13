// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_reset_password_response.g.dart';

@JsonSerializable()
class PostResetPasswordResponse {
  const PostResetPasswordResponse({
    required this.status,
  });
  
  factory PostResetPasswordResponse.fromJson(Map<String, Object?> json) => _$PostResetPasswordResponseFromJson(json);
  
  final bool status;

  Map<String, Object?> toJson() => _$PostResetPasswordResponseToJson(this);
}
