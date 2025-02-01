import 'dart:convert';

import 'package:http/http.dart' as http;
import 'http_client.dart' if (dart.library.html) 'http_client.web.dart'
    show createHttpClient;

/// A class which is used to make RPC calls to the server.
abstract class RpcHttpClient {
  /// The HTTP client.
  final http.Client _httpClient;

  /// The URI of the server.
  final Uri _uri;

  /// Creates a new [RpcHttpClient] instance.
  RpcHttpClient({required Uri uri, http.Client? client})
      : _uri = uri,
        _httpClient = client ?? createHttpClient();

  /// Handles the response from the server.
  Future<Object?> _handleResponse(http.Response response) async {
    if (response.statusCode != 200) {
      throw Exception("Failed to make RPC call: ${response.statusCode}");
    }

    return jsonDecode(response.body)["result"];
  }

  /// Makes a POST request to the server.
  Future<Object?> postRequest(
    String id, {
    required Map<String, dynamic> namedParams,
    required List<dynamic> positionalParams,
  }) async {
    final body = jsonEncode({
      "id": id,
      "params": {"positional": positionalParams, "named": namedParams},
    });

    final response = await _httpClient.post(
      _uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    return _handleResponse(response);
  }

  /// Makes a GET request to the server.
  Future<Object?> getRequest(
    String id, {
    required Map<String, dynamic> namedParams,
    required List<dynamic> positionalParams,
  }) async {
    final uri = _uri.replace(
      queryParameters: {
        "id": id,
        "named": base64Encode(utf8.encode(jsonEncode(namedParams))),
        "positional": base64Encode(utf8.encode(jsonEncode(positionalParams))),
      },
    );
    return _handleResponse(await _httpClient.get(uri));
  }
}
