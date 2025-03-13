// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'post_change_password_response.g.dart';

@JsonSerializable()
class PostChangePasswordResponse {
  const PostChangePasswordResponse({
    required this.user,
  });
  
  factory PostChangePasswordResponse.fromJson(Map<String, Object?> json) => _$PostChangePasswordResponseFromJson(json);
  
  /// The user object
  final User user;

  Map<String, Object?> toJson() => _$PostChangePasswordResponseToJson(this);
}
