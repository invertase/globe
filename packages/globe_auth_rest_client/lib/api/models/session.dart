// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  const Session({
    required this.token,
    required this.userId,
    required this.expiresAt,
  });
  
  factory Session.fromJson(Map<String, Object?> json) => _$SessionFromJson(json);
  
  final String token;
  final String userId;
  final String expiresAt;

  Map<String, Object?> toJson() => _$SessionToJson(this);
}
