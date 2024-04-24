import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final request = context.request;

  if (request.method == HttpMethod.get) {
    return Response(
      body: 'GET request to ',
    );
  } else if (request.method == HttpMethod.post) {
    return Response(
      body: 'POST request to ',
    );
  } else if (request.method == HttpMethod.put) {
    return Response(
      body: 'PUT request to ',
    );
  } else if (request.method == HttpMethod.delete) {
    return Response(
      body: 'DELETE request to ',
    );
  }

  return Response(
    statusCode: 405,
    body: 'Method not allowed',
  );
}
