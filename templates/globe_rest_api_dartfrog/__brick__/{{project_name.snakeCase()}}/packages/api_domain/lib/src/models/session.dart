import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

/// {@template session}
///
/// Represents a user session.
///
/// {@endtemplate}
@JsonSerializable()
class Session extends Equatable {
  /// {@macro session}
  const Session({
    required this.id,
    required this.token,
    required this.userId,
    required this.expiryDate,
    required this.createdAt,
  });

  /// {@macro session}
  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  /// The session id.
  final String id;

  /// The session token.
  final String token;

  /// The user id.
  final String userId;

  /// The session expiration date.
  final DateTime expiryDate;

  /// The session creation date.
  final DateTime createdAt;

  /// Returns a JSON representation of the session.
  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  List<Object?> get props => [id, token, userId, expiryDate, createdAt];
}
