import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class AuthUser {
  final String id;
  final String name;
  final String email;

  final DateTime createdAt, updatedAt;

  const AuthUser(
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
  );

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}
