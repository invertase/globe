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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        json['id'] as String,
        json['title'] as String,
        json['description'] as String,
        DateTime.parse(json['createdAt'] as String),
        DateTime.parse(json['updatedAt'] as String),
      );
}
