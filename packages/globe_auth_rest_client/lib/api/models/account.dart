// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  const Account({
    required this.id,
    required this.accountId,
    required this.providerId,
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
    required this.idToken,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
    required this.scope,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory Account.fromJson(Map<String, Object?> json) => _$AccountFromJson(json);
  
  final String id;
  final String accountId;
  final String providerId;
  final String userId;
  final String accessToken;
  final String refreshToken;
  final String idToken;
  final DateTime accessTokenExpiresAt;
  final DateTime refreshTokenExpiresAt;
  final String scope;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, Object?> toJson() => _$AccountToJson(this);
}
