import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// User model.
/// {@endtemplate}
@JsonSerializable()
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    required this.username,
    required this.name,
  });

  /// {@macro from_json}
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// User id.
  final String id;

  /// User username.
  final String username;

  /// User name.
  final String name;

  /// Returns this object as a JSON map.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, username, name];
}
