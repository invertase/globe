---
name: Google OAuth Authentication
description: Google OAuth 2.0 authentication implementation using Dart Frog
tags: ["dart-frog", "oauth", "google", "authentication"]
username: Invertase
---

# Google OAuth Authentication with Dart Frog

## Overview

This template provides an implementation of Google OAuth 2.0 authentication using Dart Frog. Users can securely sign in with their Google accounts, and the application fetches their profile information including name, email, and profile picture.

### Getting Started

#### Prerequisites

- A **Google account** with access to Google Cloud Console
- **Dart Frog CLI** installed (`dart pub global activate dart_frog_cli`)

#### Bootstrap

Initialize your project using the command below:

```shell
$ globe create -t dartfrog_google_auth
```

#### Configure Google Cloud OAuth 2.0 Client

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

#### Environment Setup

1. Copy the environment template:

   ```shell
   cp .env.example .env
   ```

2. Update `.env` with your Google credentials:
   ```env
   GOOGLE_CLIENT_ID=your_actual_client_id_here
   GOOGLE_CLIENT_SECRET=your_actual_client_secret_here
   ```

#### Start Server

```shell
$ dart_frog dev
```

### Testing the Authentication Flow

1. Open your browser and navigate to: `http://localhost:8080/auth/google`
2. You will be redirected to Google to log in and authorize the application
3. After authorizing, you will be redirected back to `http://localhost:8080/auth/callback`
4. You should see a success page with your Google profile information

### API Endpoints

- **GET** `/auth/google` - Initiates the Google OAuth flow
- **GET** `/auth/callback` - Handles the OAuth callback from Google

### Features

- **OAuth 2.0 Flow**: Handles the full Google OAuth authorization flow
- **Secure Configuration**: Uses environment variables for sensitive credentials
- **User Profile Access**: Fetches and displays Google user information (name, email, picture)
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Production Ready**: Structured for easy deployment to Globe

### Project Structure

```
├── routes/
│   ├── _middleware.dart          # Environment variable middleware
│   ├── index.dart               # Welcome page with instructions
│   └── auth/
│       ├── google.dart          # OAuth initiation endpoint
│       └── callback.dart        # OAuth callback handler
├── .env.example                 # Environment variables template
├── .gitignore                   # Git ignore rules
└── pubspec.yaml                 # Dependencies (http, dotenv)
```

### Security Considerations

- **Never commit `.env` files** to version control
- **Keep Google Client Secret secure** and rotate regularly
- **Use HTTPS in production** for all OAuth redirects
- **Consider CSRF protection** for production deployments

### Next Steps

- **Implement JWT Authentication**: Generate JWT tokens for session management
- **Add User Database**: Store user information in your database
- **Create Protected Routes**: Add authentication middleware for protected endpoints
- **Add Logout Functionality**: Implement proper session termination
- **Refresh Token Handling**: Implement token refresh for long-lived sessions

### Deployment

Deploy your Google OAuth application to Globe:

```shell
$ globe deploy
```

**Important**: Update your Google Cloud Console OAuth client settings with your production callback URL:

- **Authorized redirect URIs**: `https://your-app.globeapp.dev/auth/callback`
