import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    body: '''
<html>
<head>
  <title>GitHub OAuth with Dart Frog</title>
  <style>
    body { font-family: Arial, sans-serif; max-width: 800px; margin: 50px auto; padding: 20px; }
    .header { color: #333; border-bottom: 2px solid #0366d6; padding-bottom: 10px; }
    .endpoint { background: #f6f8fa; padding: 15px; margin: 10px 0; border-radius: 6px; border-left: 4px solid #0366d6; }
    .method { background: #0366d6; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; }
    .url { font-family: monospace; color: #0366d6; }
    .description { margin-top: 8px; color: #666; }
    .cta { text-align: center; margin: 30px 0; }
    .btn { background: #0366d6; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; display: inline-block; }
    .btn:hover { background: #0256cc; }
  </style>
</head>
<body>
  <h1 class="header">🔐 GitHub OAuth with Dart Frog</h1>
  
  <p>Welcome to the GitHub OAuth authentication demo! This application demonstrates how to implement OAuth 2.0 authentication with GitHub using Dart Frog.</p>
  
  <h2>Available Endpoints</h2>
  
  <div class="endpoint">
    <span class="method">GET</span> <span class="url">/auth/github</span>
    <div class="description">Initiates the GitHub OAuth flow. Redirects users to GitHub for authentication.</div>
  </div>
  
  <div class="endpoint">
    <span class="method">GET</span> <span class="url">/auth/callback</span>
    <div class="description">Handles the OAuth callback from GitHub. Processes the authorization code and fetches user information.</div>
  </div>
  
  <div class="cta">
    <a href="/auth/github" class="btn">🚀 Start GitHub Authentication</a>
  </div>
  
  <h2>Setup Instructions</h2>
  <ol>
    <li>Create a GitHub OAuth App in your <a href="https://github.com/settings/developers" target="_blank">Developer Settings</a></li>
    <li>Set the callback URL to: <code>http://localhost:8080/auth/callback</code></li>
    <li>Copy <code>.env.example</code> to <code>.env</code> and add your GitHub credentials</li>
    <li>Click the button above to test the authentication flow!</li>
  </ol>
  
  <p><em>For detailed setup instructions, see the README.md file.</em></p>
</body>
</html>
    ''',
    headers: {'Content-Type': 'text/html'},
  );
}
