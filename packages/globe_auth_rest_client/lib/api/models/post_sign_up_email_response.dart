// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_sign_up_email_response.g.dart';

@JsonSerializable()
class PostSignUpEmailResponse {
  const PostSignUpEmailResponse({
    required this.id,
    required this.email,
    required this.name,
    required this.image,
    required this.emailVerified,
  });
  
  factory PostSignUpEmailResponse.fromJson(Map<String, Object?> json) => _$PostSignUpEmailResponseFromJson(json);
  
  /// The id of the user
  final String id;

  /// The email of the user
  final String email;

  /// The name of the user
  final String name;

  /// The image of the user
  final String image;

  /// If the email is verified
  final bool emailVerified;

  Map<String, Object?> toJson() => _$PostSignUpEmailResponseToJson(this);
}
