// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_link_social_response.g.dart';

@JsonSerializable()
class PostLinkSocialResponse {
  const PostLinkSocialResponse({
    required this.url,
    required this.redirect,
  });
  
  factory PostLinkSocialResponse.fromJson(Map<String, Object?> json) => _$PostLinkSocialResponseFromJson(json);
  
  final String url;
  final bool redirect;

  Map<String, Object?> toJson() => _$PostLinkSocialResponseToJson(this);
}
