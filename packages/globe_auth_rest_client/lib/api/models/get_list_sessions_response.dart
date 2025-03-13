// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'get_list_sessions_response.g.dart';

@JsonSerializable()
class GetListSessionsResponse {
  const GetListSessionsResponse({
    required this.token,
    required this.userId,
    required this.expiresAt,
  });
  
  factory GetListSessionsResponse.fromJson(Map<String, Object?> json) => _$GetListSessionsResponseFromJson(json);
  
  final String token;
  final String userId;
  final String expiresAt;

  Map<String, Object?> toJson() => _$GetListSessionsResponseToJson(this);
}
