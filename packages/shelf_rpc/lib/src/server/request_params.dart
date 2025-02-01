import 'dart:convert';

import 'package:shelf/shelf.dart' show Request;

/// A class which is used to parse the request parameters for an RPC request.
final class RequestParams {
  /// Creates a new [RequestParams] instance from a [Request].
  static Future<RequestParams> fromRequest(Request request) async {
    switch (request.method) {
      case 'GET':
        final Map<String, dynamic> params = {};
        final queryParams = request.url.queryParameters;
        params['id'] = queryParams['id'];
        params['named'] =
            jsonDecode(utf8.decode(base64Decode(queryParams['named'] ?? ''))) ??
                {};
        params['positional'] = jsonDecode(
                utf8.decode(base64Decode(queryParams['positional'] ?? ''))) ??
            [];
        return RequestParams._(params);
      case 'POST':
        final body = await request.readAsString();
        final json = jsonDecode(body) as Map<String, dynamic>;
        return RequestParams._(json);
      default:
        throw Exception('Unsupported method: ${request.method}');
    }
  }

  /// The parsed parameters.
  final Map<String, dynamic> _params;

  /// Creates a new [RequestParams] instance from a map of parameters.
  RequestParams._(this._params);

  /// The incoming RPC identifier.
  String get id => _params['id'] as String;

  /// The named parameters of the procedure.
  Map<String, dynamic> get named => _params['named'] ?? {};

  /// The positional parameters of the procedure.
  List<dynamic> get positional => _params['positional'] ?? [];
}
