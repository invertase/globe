// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_send_verification_email_response.g.dart';

@JsonSerializable()
class PostSendVerificationEmailResponse {
  const PostSendVerificationEmailResponse({
    required this.status,
  });
  
  factory PostSendVerificationEmailResponse.fromJson(Map<String, Object?> json) => _$PostSendVerificationEmailResponseFromJson(json);
  
  final bool status;

  Map<String, Object?> toJson() => _$PostSendVerificationEmailResponseToJson(this);
}
