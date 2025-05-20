class Repository {
  final int id;
  final String name;
  final String url;

  const Repository({required this.id, required this.name, required this.url});

  factory Repository.fromMap(Map<String, dynamic> map) =>
      Repository(id: map['id'], name: map['name'], url: map['url']);
}
