import 'package:http/http.dart' as http;

class GlobeHttpClient extends http.BaseClient {
  final http.Client _inner;
  final String projectId;
  final String publicKey;
  final Future<String?> Function()? getUserAgent;
  final Future<String?> Function() getAccessToken;
  final Future<void> Function(String token) setAccessToken;

  GlobeHttpClient(
    this._inner, {
    required this.projectId,
    required this.publicKey,
    required this.getAccessToken,
    required this.setAccessToken,
    this.getUserAgent,
  });

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      final result = await Future.wait([
        getAccessToken(),
        getUserAgent?.call() ?? Future.value(),
      ]);

      // Attach required headers.
      request.headers['Content-Type'] = 'application/json';
      request.headers['X-Globe-Auth-Project-Id'] = projectId;
      request.headers['X-Globe-Auth-Public-Key'] = publicKey;
      request.headers['User-Agent'] = result[1] ?? request.headers['User-Agent'];

      if (result[0] != null) {
        request.headers['Authorization'] = 'Bearer ${result[0]}';
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
