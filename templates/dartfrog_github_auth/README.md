# GitHub OAuth Authentication with Dart Frog

An implementation of GitHub OAuth 2.0 authentication using Dart Frog, allowing users to sign in securely with their GitHub accounts.

## Features

- **OAuth 2.0 Flow**: Complete GitHub OAuth implementation
- **Secure Configuration**: Environment-based secret management
- **User Profile Access**: Fetch and display GitHub user information
- **Error Handling**: Comprehensive error handling and user feedback
- **Production Ready**: Structured for easy deployment

## Quick Start

### 1. Create GitHub OAuth App

1. Go to [GitHub Developer Settings](https://github.com/settings/developers)
2. Click **OAuth Apps** → **New OAuth App**
3. Fill in the details:
   - **Application name**: `My Dart Frog App`
   - **Homepage URL**: `http://localhost:8080`
   - **Authorization callback URL**: `http://localhost:8080/auth/callback`
4. Click **Register application**
5. Copy your **Client ID** and generate a **Client Secret**

### 2. Configure Environment

1. Copy `.env.example` to `.env`:

   ```bash
   cp .env.example .env
   ```

2. Update `.env` with your GitHub credentials:
   ```env
   GITHUB_CLIENT_ID=your_actual_client_id
   GITHUB_CLIENT_SECRET=your_actual_client_secret
   ```

### 3. Run the Application

```bash
dart_frog dev
```

### 4. Test the Flow

1. Open your browser and navigate to: `http://localhost:8080/auth/github`
2. You'll be redirected to GitHub to authorize the application
3. After authorization, you'll be redirected back and see your GitHub profile

## API Endpoints

- **GET** `/auth/github` - Initiates GitHub OAuth flow
- **GET** `/auth/callback` - Handles OAuth callback from GitHub

## Project Structure

```
├── routes/
│   ├── _middleware.dart          # Environment variable middleware
│   └── auth/
│       ├── github.dart          # OAuth initiation endpoint
│       └── callback.dart        # OAuth callback handler
├── .env.example                 # Environment variables template
├── .gitignore                   # Git ignore rules
└── pubspec.yaml                 # Dependencies
```

## Dependencies

- `dart_frog` - Web framework
- `http` - HTTP client for API calls
- `dotenv` - Environment variable management

## Security Notes

- Never commit your `.env` file to version control
- Keep your GitHub Client Secret secure
- In production, use HTTPS for all OAuth redirects
- Consider implementing CSRF protection for production use

## Next Steps

- Implement JWT token generation for session management
- Add user database storage
- Create protected routes with authentication middleware
- Add logout functionality
- Implement refresh token handling
