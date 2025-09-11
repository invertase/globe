import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    body: '''
<html>
<head>
  <title>Google OAuth with Dart Frog</title>
  <style>
    body { font-family: Arial, sans-serif; max-width: 800px; margin: 50px auto; padding: 20px; }
    .header { color: #333; border-bottom: 2px solid #4285f4; padding-bottom: 10px; }
    .endpoint { background: #f6f8fa; padding: 15px; margin: 10px 0; border-radius: 6px; border-left: 4px solid #4285f4; }
    .method { background: #4285f4; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; }
    .url { font-family: monospace; color: #4285f4; }
    .description { margin-top: 8px; color: #666; }
    .cta { text-align: center; margin: 30px 0; }
    .btn { background: #4285f4; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; display: inline-block; }
    .btn:hover { background: #3367d6; }
  </style>
</head>
<body>
  <h1 class="header">🔐 Google OAuth with Dart Frog</h1>
  
  <p>Welcome to the Google OAuth authentication demo! This application demonstrates how to implement OAuth 2.0 authentication with Google using Dart Frog.</p>
  
  <h2>Available Endpoints</h2>
  
  <div class="endpoint">
    <span class="method">GET</span> <span class="url">/auth/google</span>
    <div class="description">Initiates the Google OAuth flow. Redirects users to Google for authentication.</div>
  </div>
  
  <div class="endpoint">
    <span class="method">GET</span> <span class="url">/auth/callback</span>
    <div class="description">Handles the OAuth callback from Google. Processes the authorization code and fetches user information.</div>
  </div>
  
  <div class="cta">
    <a href="/auth/google" class="btn">🚀 Start Google Authentication</a>
  </div>
  
  <h2>Setup Instructions</h2>
  <ol>
    <li>Create a Google Cloud project in the <a href="https://console.cloud.google.com/" target="_blank">Google Cloud Console</a></li>
    <li>Set up OAuth 2.0 credentials with callback URL: <code>http://localhost:8080/auth/callback</code></li>
    <li>Copy <code>.env.example</code> to <code>.env</code> and add your Google credentials</li>
    <li>Click the button above to test the authentication flow!</li>
  </ol>
  
  <p><em>For detailed setup instructions, see the README.md file.</em></p>
</body>
</html>
    ''',
    headers: {'Content-Type': 'text/html'},
  );
}
