import 'dart:async';
import 'dart:io';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shelf/shelf.dart';

import 'router.dart';

class User {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User(
    this.id, {
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(String id, Map<String, dynamic> json) => User(
        id,
        name: json['name'],
        email: json['email'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}

final class APIError {
  static final String unauthorized = 'You are not authorized';
}

typedef RequiresUser = FutureOr<Response> Function(Request req, User user);

/// Middleware that checks for Bearer Token in incoming request header.
Future<Response> checkAuth(Request request, RequiresUser action) async {
  final userToken =
      request.headers[HttpHeaders.authorizationHeader]?.split(' ').lastOrNull;

  // ensure token is present
  if (userToken == null) {
    return Response.unauthorized(APIError.unauthorized);
  }

  final tokenValue = JwtDecoder.tryDecode(userToken) ?? {};

  final userId = tokenValue['user_id'];
  if (userId == null) {
    return Response.unauthorized(APIError.unauthorized);
  }

  // retrieve user record from firestore
  final userData = (await userCollection.doc(userId).get()).data();

  return action.call(request, User.fromJson(userId, userData));
}
