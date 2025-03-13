// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

import 'session.dart';
import 'user.dart';

part 'get_get_session_response.g.dart';

@JsonSerializable()
class GetGetSessionResponse {
  const GetGetSessionResponse({
    required this.session,
    required this.user,
  });
  
  factory GetGetSessionResponse.fromJson(Map<String, Object?> json) => _$GetGetSessionResponseFromJson(json);
  
  final Session session;
  final User user;

  Map<String, Object?> toJson() => _$GetGetSessionResponseToJson(this);
}
