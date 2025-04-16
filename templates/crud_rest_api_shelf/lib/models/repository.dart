class Repository {
  final int id;
  final String name;
  final String url;

  Repository({
    required this.id,
    required this.name,
    required this.url,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }

  Repository copyWith({
    int? id,
    String? name,
    String? url,
  }) {
    return Repository(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
