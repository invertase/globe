import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  // handle GET, POST, PUT, DELETE, etc.
  if (context.method == 'GET') {
    return Response(
      body: 'GET request to {{primary_endpoint}}',
    );
  } else if (context.method == 'POST') {
    return Response(
      body: 'POST request to {{primary_endpoint}}',
    );
  } else if (context.method == 'PUT') {
    return Response(
      body: 'PUT request to {{primary_endpoint}}',
    );
  } else if (context.method == 'DELETE') {
    return Response(
      body: 'DELETE request to {{primary_endpoint}}',
    );
  } else {
    return Response(
      statusCode: 405,
      body: 'Method not allowed',
    );
  }
}
