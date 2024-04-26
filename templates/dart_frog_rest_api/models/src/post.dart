import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

/// {@template post}
/// Post model.
/// {@endtemplate}
@JsonSerializable()
class Post extends Equatable {
  /// {@macro post}
  const Post({
    required this.id,
    required this.message,
    required this.userId,
  });

  /// {@macro post}
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// Post id.
  final String id;

  /// Post message.
  final String message;

  /// Post user id.
  final String userId;

  /// Returns a JSON representation of the session.
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [id, message, userId];
}
