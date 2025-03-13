import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:globe_auth/src/models/session.dart';
import 'package:globe_auth/src/models/user.dart';

final class GlobeAuthHttpClient {
  final Uri baseUrl;
  final http.Client client;

  GlobeAuthHttpClient({required this.baseUrl, required this.client});

  Future<({Session session, User user})> getSession() async {
    final response = await client.get(Uri.parse('$baseUrl/get-session'));

    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(json['message']);
    }

    return (
      session: Session.fromJson(json['session'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Future<({String token, User user})> signUpWithEmail({
    required String email,
    required String password,
    String? name,
    String? username,
    Uri? image,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/signup/email'),
      body: {
        'email': email,
        'password': password,
        'name': name ?? email.split('@')[0],
        if (username != null) 'username': username,
        if (image != null) 'image': image.toString(),
      },
    );

    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(json['message']);
    }

    return (
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Future<({bool redirect, String token, User user})> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/sign-in/email'),
      body: {'email': email, 'password': password},
    );

    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(json['message']);
    }

    return (
      redirect: json['redirect'] as bool,
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Future<({String token, User user})> signInWithUsername({
    required String username,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/sign-in/username'),
      body: {'username': username, 'password': password},
    );

    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(json['message']);
    }

    return (
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
