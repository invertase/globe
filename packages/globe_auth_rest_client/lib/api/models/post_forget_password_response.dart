// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_forget_password_response.g.dart';

@JsonSerializable()
class PostForgetPasswordResponse {
  const PostForgetPasswordResponse({
    required this.status,
  });
  
  factory PostForgetPasswordResponse.fromJson(Map<String, Object?> json) => _$PostForgetPasswordResponseFromJson(json);
  
  final bool status;

  Map<String, Object?> toJson() => _$PostForgetPasswordResponseToJson(this);
}
