final class Session {
  final String id;
  final DateTime expiresAt;
  final String token;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String ipAddress;
  final String userAgent;
  final String userId;

  const Session({
    required this.id,
    required this.expiresAt,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    required this.ipAddress,
    required this.userAgent,
    required this.userId,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      token: json['token'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      ipAddress: json['ipAddress'] as String,
      userAgent: json['userAgent'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'expiresAt': expiresAt.toIso8601String(),
    'token': token,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'ipAddress': ipAddress,
    'userAgent': userAgent,
    'userId': userId,
  };
}
