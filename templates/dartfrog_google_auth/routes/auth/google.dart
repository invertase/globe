import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';

Response onRequest(RequestContext context) {
  final env = context.read<DotEnv>();
  final clientId = env['GOOGLE_CLIENT_ID'];

  if (clientId == null) {
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: 'Google Client ID not configured. Please check your .env file.',
    );
  }

  final uri = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
    'client_id': clientId,
    'redirect_uri': 'http://localhost:8080/auth/callback',
    'response_type': 'code',
    'scope':
        'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email',
  });

  return Response(
    statusCode: HttpStatus.found,
    headers: {
      HttpHeaders.locationHeader: uri.toString(),
    },
  );
}
