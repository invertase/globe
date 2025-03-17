class User {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role;
  final bool banned;
  final String? banReason;
  final DateTime? banExpires;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.banned,
    required this.banReason,
    required this.banExpires,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
      image: json['image'] == null ? '' : json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      role: json['role'] as String,
      banned: json['banned'] == null ? false : json['banned'] as bool,
      banReason: json['banReason'] == null ? null : json['banReason'] as String,
      banExpires:
          json['banExpires'] == null
              ? null
              : DateTime.parse(json['banExpires'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailVerified': emailVerified,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'role': role,
      'banned': banned,
      'banReason': banReason,
      'banExpires': banExpires?.toIso8601String(),
    };
  }
}
