// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_revoke_other_sessions_response.g.dart';

@JsonSerializable()
class PostRevokeOtherSessionsResponse {
  const PostRevokeOtherSessionsResponse({
    required this.status,
  });
  
  factory PostRevokeOtherSessionsResponse.fromJson(Map<String, Object?> json) => _$PostRevokeOtherSessionsResponseFromJson(json);
  
  final bool status;

  Map<String, Object?> toJson() => _$PostRevokeOtherSessionsResponseToJson(this);
}
