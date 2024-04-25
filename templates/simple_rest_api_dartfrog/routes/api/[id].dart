import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context, String id) {
  final request = context.request;

  if (request.method == HttpMethod.get) {
    return Response(
      body: 'GET request to /$id',
    );
  } else if (request.method == HttpMethod.post) {
    return Response(
      body: 'POST request to /$id',
    );
  } else if (request.method == HttpMethod.put) {
    return Response(
      body: 'PUT request to /$id',
    );
  } else if (request.method == HttpMethod.delete) {
    return Response(
      body: 'DELETE request to /$id',
    );
  }

  return Response(statusCode: 405, body: 'Method not allowed');
}
