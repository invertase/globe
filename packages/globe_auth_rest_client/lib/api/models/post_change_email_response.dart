// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_change_email_response.g.dart';

@JsonSerializable()
class PostChangeEmailResponse {
  const PostChangeEmailResponse({
    required this.user,
    required this.status,
  });
  
  factory PostChangeEmailResponse.fromJson(Map<String, Object?> json) => _$PostChangeEmailResponseFromJson(json);
  
  final dynamic user;
  final bool status;

  Map<String, Object?> toJson() => _$PostChangeEmailResponseToJson(this);
}
