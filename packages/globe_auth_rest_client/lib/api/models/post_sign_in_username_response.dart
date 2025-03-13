// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'user.dart';
import 'session.dart';

part 'post_sign_in_username_response.g.dart';

@JsonSerializable()
class PostSignInUsernameResponse {
  const PostSignInUsernameResponse({
    required this.user,
    required this.session,
  });
  
  factory PostSignInUsernameResponse.fromJson(Map<String, Object?> json) => _$PostSignInUsernameResponseFromJson(json);
  
  final User user;
  final Session session;

  Map<String, Object?> toJson() => _$PostSignInUsernameResponseToJson(this);
}
