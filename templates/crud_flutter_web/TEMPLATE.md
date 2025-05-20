---
name: Simple Flutter App
description: Building a simple CRUD Flutter Web application that connects to a Shelf Server
tags: ["flutter", "web", "shelf", "api"]
username: Invertase
---

# Flutter Web + Shelf Server

## Overview

This template provides a Flutter Web frontend client that connects to the Simple Shelf Server REST API. It offers a clean, responsive interface for managing repositories with complete CRUD operations.

### Getting Started

#### Setup Shelf Server

This Flutter Web client connects to the Simple Shelf Server. These are two separate projects that should be in different folders.

1. Initialize the Shelf server:

```shell
$ globe create -t crud_rest_api_shelf
```

2. Start the Shelf server:

```shell
$ dart bin/server.dart
```

Your Shelf server should now be running at http://localhost:3000 with the repository API endpoints available.

#### Run the Flutter App

1. In a separate folder, initialize the Flutter Web client:

```shell
$ globe create -t crud_flutter_web
```

2. Run the Flutter web application with:

```shell
flutter run -d chrome
```

### Features

- **Repository List**: View all repositories
- **Repository Details**: View and edit specific repository information
- **Add Repository**: Create new repositories
- **Delete Repository**: Remove repositories

### Deployment

#### Deploy Both Applications

For a complete production setup, you'll need to deploy both the Shelf server and Flutter Web client from their separate directories:

1. Deploy the Shelf Server:

```shell
$ globe deploy
```

Note the deployment URL (e.g., `https://your-shelf-api.globeapp.dev`).

2. Update the API endpoint in your Flutter Web client's `main.dart`:

```dart
  const apiUrl =
      !kReleaseMode
          ? 'http://localhost:3000'
          : 'https://your-shelf-api.globeapp.dev'; // Your deployed API URL
```

3. Build and deploy the Flutter Web client:

```shell
$ flutter build web
$ globe deploy
```

Your full-stack application is now deployed with the Flutter frontend connecting to your deployed Shelf backend.
