---
name: Dart-Frog GitHub Auth
description: GitHub OAuth 2.0 authentication implementation using Dart Frog
tags: ['dart-frog', 'oauth', 'github', 'authentication']
username: Invertase
---

# GitHub OAuth Authentication with Dart Frog

## Overview

This template provides a implementation of GitHub OAuth 2.0 authentication using Dart Frog. Users can securely sign in with their GitHub accounts, and the application fetches their profile information.

### Getting Started

#### Prerequisites

- A **GitHub account** with access to Developer Settings
- **Dart Frog CLI** installed (`dart pub global activate dart_frog_cli`)

#### Bootstrap

Initialize your project using the command below:

```shell
$ globe create -t dartfrog_github_auth
```

#### Configure GitHub OAuth App

1. Navigate to [GitHub Developer Settings](https://github.com/settings/developers)
2. Click **OAuth Apps** → **New OAuth App**
3. Fill out the form:
   - **Application name**: `My Dart Frog App`
   - **Homepage URL**: `http://localhost:8080`
   - **Authorization callback URL**: `http://localhost:8080/auth/callback`
4. Click **Register application**
5. Copy your **Client ID** and generate a **Client Secret**

#### Environment Setup

1. Copy the environment template:

   ```shell
   cp .env.example .env
   ```

2. Update `.env` with your GitHub credentials:
   ```env
   GITHUB_CLIENT_ID=your_actual_client_id_here
   GITHUB_CLIENT_SECRET=your_actual_client_secret_here
   ```

#### Start Server

```shell
$ dart_frog dev
```

### Testing the Authentication Flow

1. Open your browser and navigate to: `http://localhost:8080/auth/github`
2. You will be redirected to GitHub to log in and authorize the application
3. After authorizing, you will be redirected back to `http://localhost:8080/auth/callback`
4. You should see a success page with your GitHub profile information

### API Endpoints

- **GET** `/auth/github` - Initiates the GitHub OAuth flow
- **GET** `/auth/callback` - Handles the OAuth callback from GitHub

### Features

- **Complete OAuth 2.0 Flow**: Handles the full GitHub OAuth authorization flow
- **Secure Configuration**: Uses environment variables for sensitive credentials
- **User Profile Access**: Fetches and displays GitHub user information
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Production Ready**: Structured for easy deployment to Globe

### Project Structure

```
├── routes/
│   ├── _middleware.dart          # Environment variable middleware
│   └── auth/
│       ├── github.dart          # OAuth initiation endpoint
│       └── callback.dart        # OAuth callback handler
├── .env.example                 # Environment variables template
├── .gitignore                   # Git ignore rules
└── pubspec.yaml                 # Dependencies (http, dotenv)
```

### Security Considerations

- **Never commit `.env` files** to version control
- **Keep GitHub Client Secret secure** and rotate regularly
- **Use HTTPS in production** for all OAuth redirects
- **Consider CSRF protection** for production deployments

### Next Steps

- **Implement JWT Authentication**: Generate JWT tokens for session management
- **Add User Database**: Store user information in your database
- **Create Protected Routes**: Add authentication middleware for protected endpoints
- **Add Logout Functionality**: Implement proper session termination
- **Refresh Token Handling**: Implement token refresh for long-lived sessions

### Deployment

Deploy your GitHub OAuth application to Globe:

```shell
$ globe deploy
```

**Important**: Update your GitHub OAuth App settings with your production callback URL:

- **Authorization callback URL**: `https://your-app.globeapp.dev/auth/callback`
