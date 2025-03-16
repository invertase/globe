import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/session.dart';
import 'models/user.dart';

typedef GetAccessToken = Future<String?> Function();
typedef SetAccessToken = Future<void> Function(String token);

class GlobeAuthRestClient {
  GlobeAuthRestClient({required this.baseUrl, required this.client});

  final GlobeHttpClient client;
  final String baseUrl;

  Future<Map<String, dynamic>> _request(
    Future<http.Response> Function() request,
  ) async {
    final response = await request();
    final json = jsonDecode(response.body);
    return Map<String, dynamic>.from(json);
  }

  Future<void> getOk() async {
    await _request(() => http.get(Uri.parse('$baseUrl/ok')));
  }

  Future<({Session session, User user})> getGetSession() async {
    final json = await _request(
      () => http.get(Uri.parse('$baseUrl/get-session')),
    );

    return (
      session: Session.fromJson(json['session']),
      user: User.fromJson(json['user']),
    );
  }

  Future<void> postSignOut() async {
    await _request(() => http.post(Uri.parse('$baseUrl/sign-out')));
  }
}

class GlobeHttpClient extends http.BaseClient {
  final http.Client _inner;
  final Future<String?> Function() getAccessToken;
  final Future<void> Function(String token) setAccessToken;

  GlobeHttpClient(
    this._inner, {
    required this.getAccessToken,
    required this.setAccessToken,
  });

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      final accessToken = await getAccessToken();
      if (accessToken != null) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      final response = await _inner.send(request);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('TODO make me a sealed error');
      }

      if (response.headers['set-access-token'] != null) {
        await setAccessToken(response.headers['set-access-token']!);
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
