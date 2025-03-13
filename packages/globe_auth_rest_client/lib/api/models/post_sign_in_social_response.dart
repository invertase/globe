// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_sign_in_social_response.g.dart';

@JsonSerializable()
class PostSignInSocialResponse {
  const PostSignInSocialResponse({
    required this.session,
    required this.user,
    required this.url,
    required this.redirect,
  });
  
  factory PostSignInSocialResponse.fromJson(Map<String, Object?> json) => _$PostSignInSocialResponseFromJson(json);
  
  final String session;
  final dynamic user;
  final String url;
  final bool redirect;

  Map<String, Object?> toJson() => _$PostSignInSocialResponseToJson(this);
}
