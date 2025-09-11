import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';

Response onRequest(RequestContext context) {
  final env = context.read<DotEnv>();
  final clientId = env['GITHUB_CLIENT_ID'];

  if (clientId == null) {
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: 'GitHub Client ID not configured. Please check your .env file.',
    );
  }

  final uri = Uri.https('github.com', '/login/oauth/authorize', {
    'client_id': clientId,
    'scope': 'read:user', // Request permission to read user profile data
  });

  // Construct the redirect response.
  return Response(
    statusCode: HttpStatus.found,
    headers: {
      HttpHeaders.locationHeader: uri.toString(),
    },
  );
}
