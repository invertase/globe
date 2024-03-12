import 'package:json_annotation/json_annotation.dart';

part "user.g.dart";

@JsonSerializable()
class AuthUser {
  final int id;
  final String name;
  final String email;

  const AuthUser(this.id, this.name, this.email);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
