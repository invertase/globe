// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.username,
    required this.displayUsername,
    required this.isAnonymous,
  });
  
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
  
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String username;
  final String displayUsername;
  final bool isAnonymous;

  Map<String, Object?> toJson() => _$UserToJson(this);
}
