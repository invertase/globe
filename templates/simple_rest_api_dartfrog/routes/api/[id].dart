import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context, String id) {
  final request = context.request;

  if (request.method == HttpMethod.get) {
    return Response(body: 'GET request to /$id');
  }

  return Response(statusCode: 405, body: 'Method not allowed');
}
