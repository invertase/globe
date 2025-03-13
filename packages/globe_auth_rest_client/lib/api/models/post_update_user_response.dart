// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_update_user_response.g.dart';

@JsonSerializable()
class PostUpdateUserResponse {
  const PostUpdateUserResponse({
    required this.user,
  });
  
  factory PostUpdateUserResponse.fromJson(Map<String, Object?> json) => _$PostUpdateUserResponseFromJson(json);
  
  final dynamic user;

  Map<String, Object?> toJson() => _$PostUpdateUserResponseToJson(this);
}
