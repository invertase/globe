// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_revoke_sessions_response.g.dart';

@JsonSerializable()
class PostRevokeSessionsResponse {
  const PostRevokeSessionsResponse({
    required this.status,
  });
  
  factory PostRevokeSessionsResponse.fromJson(Map<String, Object?> json) => _$PostRevokeSessionsResponseFromJson(json);
  
  final bool status;

  Map<String, Object?> toJson() => _$PostRevokeSessionsResponseToJson(this);
}
