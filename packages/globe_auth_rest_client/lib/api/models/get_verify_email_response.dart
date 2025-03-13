// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'get_verify_email_response.g.dart';

@JsonSerializable()
class GetVerifyEmailResponse {
  const GetVerifyEmailResponse({
    required this.user,
    required this.status,
  });
  
  factory GetVerifyEmailResponse.fromJson(Map<String, Object?> json) => _$GetVerifyEmailResponseFromJson(json);
  
  final dynamic user;
  final bool status;

  Map<String, Object?> toJson() => _$GetVerifyEmailResponseToJson(this);
}
