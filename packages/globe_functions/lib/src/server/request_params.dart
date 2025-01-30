import 'dart:convert';

import 'package:shelf/shelf.dart' show Request;

final class RequestParams {
  static Future<RequestParams> fromRequest(Request request) async {
    switch (request.method) {
      case 'GET':
        final Map<String, dynamic> params = {};
        final queryParams = request.url.queryParameters;
        params['id'] = queryParams['id'];
        params['named'] = {};
        params['positional'] = [];
        return RequestParams._(params);
      case 'POST':
        final body = await request.readAsString();
        final json = jsonDecode(body) as Map<String, dynamic>;
        return RequestParams._(json);
      default:
        throw Exception('Unsupported method: ${request.method}');
    }
  }

  final Map<String, dynamic> parms;
  RequestParams._(this.parms);

  String get id => parms['id'] as String;
  Map<String, dynamic> get named => parms['named'] ?? {};
  List<dynamic> get positional => parms['positional'] ?? [];
}
