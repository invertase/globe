import 'dart:async';
import 'dart:convert';
import 'dart:io';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:http/http.dart' as http;

import 'models/user.dart';

class ApiException extends HttpException {
  final Iterable<String> errors;
  ApiException(this.errors) : super(errors.join('\n'));
}

class ApiService {
  final Uri baseUrl;

  String? _authToken;

  ApiService(this.baseUrl);

  void setToken(String token) {
    _authToken = token;
  }

  Map<String, String> get _headers => {
        HttpHeaders.contentTypeHeader: 'application/json',
        if (_authToken != null) HttpHeaders.authorizationHeader: _authToken!
      };

  Uri _getUri(String path) => baseUrl.replace(path: '/api$path');

  Future<AuthUser> getUser() async {
    final result = await _runCatching(
        () => http.get(_getUri('/users/me'), headers: _headers));

    final data = jsonDecode(result.body)['user'];
    return AuthUser.fromJson(data);
  }

  Future<AuthUser> getUserById(int userId) async {
    final result = await _runCatching(
        () => http.get(_getUri('/users/$userId'), headers: _headers));

    final data = jsonDecode(result.body)['user'];
    return AuthUser.fromJson(data);
  }

  Future<bool> registerUser(
    String displayName,
    String email,
    String password,
  ) async {
    final requestBody = jsonEncode({
      'name': displayName,
      'email': email,
      'password': password,
    });
    await _runCatching(() => http.post(_getUri('/auth/register'),
        headers: _headers, body: requestBody));

    return true;
  }

  Future<http.Response> _runCatching(
    Future<http.Response> Function() apiCall,
  ) async {
    try {
      final response = await apiCall.call();
      if (response.statusCode == HttpStatus.ok) return response;
      final errors = jsonDecode(response.body)['errors'] as List<dynamic>;
      throw ApiException(errors.map((e) => e.toString()));
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException([e.toString()]);
    }
  }
}
