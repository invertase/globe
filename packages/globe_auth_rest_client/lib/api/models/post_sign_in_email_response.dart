// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_sign_in_email_response.g.dart';

@JsonSerializable()
class PostSignInEmailResponse {
  const PostSignInEmailResponse({
    required this.user,
    required this.url,
    required this.redirect,
  });
  
  factory PostSignInEmailResponse.fromJson(Map<String, Object?> json) => _$PostSignInEmailResponseFromJson(json);
  
  final dynamic user;
  final String url;
  final bool redirect;

  Map<String, Object?> toJson() => _$PostSignInEmailResponseToJson(this);
}
