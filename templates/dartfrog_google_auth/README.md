# Google OAuth Authentication with Dart Frog

An implementation of Google OAuth 2.0 authentication using Dart Frog, allowing users to sign in securely with their Google accounts.

## Features

- **OAuth 2.0 Flow**: Google OAuth implementation
- **Secure Configuration**: Environment-based secret management
- **User Profile Access**: Fetch and display Google user information
- **Error Handling**: Comprehensive error handling and user feedback
- **Production Ready**: Structured for easy deployment

## Quick Start

### 1. Create Google Cloud OAuth 2.0 Client

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Navigate to **APIs & Services** > **Credentials**
4. Click **+ CREATE CREDENTIALS** and select **OAuth client ID**
5. If prompted, configure the OAuth consent screen:
   - Choose **External** and click **Create**
   - Fill in required fields: **App name**, **User support email**, **Developer contact information**
   - Click **SAVE AND CONTINUE** through all steps
6. Go back to **Credentials** and create **OAuth client ID** again
7. Select **Web application** as the Application type
8. Under **Authorized redirect URIs**, add: `http://localhost:8080/auth/callback`
9. Click **CREATE**
10. Copy your **Client ID** and **Client Secret**

### 2. Configure Environment

1. Copy `.env.example` to `.env`:

   ```bash
   cp .env.example .env
   ```

2. Update `.env` with your Google credentials:
   ```env
   GOOGLE_CLIENT_ID=your_actual_client_id
   GOOGLE_CLIENT_SECRET=your_actual_client_secret
   ```

### 3. Run the Application

```bash
dart_frog dev
```

### 4. Test the Flow

1. Open your browser and navigate to: `http://localhost:8080/auth/google`
2. You'll be redirected to Google to authorize the application
3. After authorization, you'll be redirected back and see your Google profile

## API Endpoints

- **GET** `/auth/google` - Initiates Google OAuth flow
- **GET** `/auth/callback` - Handles OAuth callback from Google

## Project Structure

```
├── routes/
│   ├── _middleware.dart          # Environment variable middleware
│   ├── index.dart               # Welcome page with instructions
│   └── auth/
│       ├── google.dart          # OAuth initiation endpoint
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
- Keep your Google Client Secret secure
- In production, use HTTPS for all OAuth redirects
- Consider implementing CSRF protection for production use

## Next Steps

- Implement JWT token generation for session management
- Add user database storage
- Create protected routes with authentication middleware
- Add logout functionality
- Implement refresh token handling
