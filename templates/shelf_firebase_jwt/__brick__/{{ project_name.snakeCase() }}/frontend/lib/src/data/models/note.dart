import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  final String id;
  final String title;
  final String description;

  final DateTime createdAt, updatedAt;

  const Note(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  );

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
