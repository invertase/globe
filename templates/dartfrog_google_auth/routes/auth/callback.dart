import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;

Future<Response> onRequest(RequestContext context) async {
  final code = context.request.uri.queryParameters['code'];
  if (code == null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Missing authorization code. Please try again.',
    );
  }

  final env = context.read<DotEnv>();
  final clientId = env['GOOGLE_CLIENT_ID'];
  final clientSecret = env['GOOGLE_CLIENT_SECRET'];

  if (clientId == null || clientSecret == null) {
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: 'Google credentials not configured. Please check your .env file.',
    );
  }

  try {
    // Exchange the code for an access token.
    final tokenResponse = await http.post(
      Uri.parse('https://oauth2.googleapis.com/token'),
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': code,
        'grant_type': 'authorization_code',
        'redirect_uri': 'http://localhost:8080/auth/callback',
      },
    );

    if (tokenResponse.statusCode != 200) {
      return Response(
        statusCode: HttpStatus.badRequest,
        body: 'Failed to exchange authorization code for access token.',
      );
    }

    final tokenJson = jsonDecode(tokenResponse.body) as Map<String, dynamic>;

    if (tokenJson.containsKey('error')) {
      return Response(
        statusCode: HttpStatus.badRequest,
        body: 'Google OAuth error: '
            '${tokenJson['error_description'] ?? tokenJson['error']}',
      );
    }

    final accessToken = tokenJson['access_token'] as String?;
    if (accessToken == null) {
      return Response(
        statusCode: HttpStatus.badRequest,
        body: 'No access token received from Google.',
      );
    }

    // Use the access token to get the user's profile.
    final userResponse = await http.get(
      Uri.parse('https://www.googleapis.com/oauth2/v1/userinfo?alt=json'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (userResponse.statusCode != 200) {
      return Response(
        statusCode: HttpStatus.badRequest,
        body: 'Failed to fetch user profile from Google.',
      );
    }

    final userJson = jsonDecode(userResponse.body) as Map<String, dynamic>;
    final name = userJson['name'] as String?;
    final email = userJson['email'] as String?;
    final picture = userJson['picture'] as String?;
    final verifiedEmail = userJson['verified_email'] as bool?;

    return Response(
      body: '''
<html>
<head>
  <title>Google Authentication Success</title>
  <style>
    body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; }
    .success { color: #28a745; }
    .user-info { background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0; }
    .avatar { width: 64px; height: 64px; border-radius: 50%; margin-right: 15px; }
    .user-details { display: flex; align-items: center; }
    .verified { color: #28a745; font-size: 14px; }
  </style>
</head>
<body>
  <h1 class="success">🎉 Authentication Successful!</h1>
  <p>You have successfully signed in with Google.</p>
  
  <div class="user-info">
    <div class="user-details">
      ${picture != null ? '<img src="$picture" alt="Profile Picture" class="avatar">' : ''}
      <div>
        <h2>Welcome, ${name ?? 'User'}!</h2>
        ${email != null ? '<p><strong>Email:</strong> $email</p>' : ''}
        ${(verifiedEmail ?? false) ? '<p class="verified">✓ Email Verified</p>' : ''}
      </div>
    </div>
  </div>
  
  <p><em>This is a demo response. In a real application, you would typically:</em></p>
  <ul>
    <li>Create a user session or JWT token</li>
    <li>Store user information in your database</li>
    <li>Redirect to your application's main page</li>
  </ul>
</body>
</html>
      ''',
      headers: {'Content-Type': 'text/html'},
    );
  } catch (e) {
    return Response(
      statusCode: HttpStatus.internalServerError,
      body: 'An error occurred during authentication: $e',
    );
  }
}
