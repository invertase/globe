import 'package:http/http.dart' as http;

class GlobeHttpClient extends http.BaseClient {
  final http.Client _inner;
  final String projectId;
  final String publicKey;
  final Future<String?> Function() getAccessToken;
  final Future<void> Function(String token) setAccessToken;

  GlobeHttpClient(
    this._inner, {
    required this.projectId,
    required this.publicKey,
    required this.getAccessToken,
    required this.setAccessToken,
  });

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      // Attach required headers.
      request.headers['Content-Type'] = 'application/json';
      request.headers['X-Globe-Auth-Project-Id'] = projectId;
      request.headers['X-Globe-Auth-Public-Key'] = publicKey;

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
