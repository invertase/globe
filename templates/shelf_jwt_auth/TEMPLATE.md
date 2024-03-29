---
name: Firebase + JWT Auth + Shelf
description: Build an authentication flow using Firebase + JWT with your Backend from a Flutter application.
tags: ["firebase", "shelf", "authentication", "jwt"]
username: Invertase
---

# Firebase + JWT Auth + Shelf

## Overview

The example shows how to use Firebase + JWT Authentication on Flutter app & Dart Backend.

### Features

- [Shelf](https://pub.dev/packages/shelf)
- [Flutter](https://flutter.dev)
- [Firebase](https://firebase.google.com/)
- [JWT Authentication](https://jwt.io/introduction)

### Getting Started

#### Bootstrap

Initialize your project using the `shelf_jwt_auth` brick

```shell
$ mason make shelf_jwt_auth
```

#### Create Firebase Account

You must create a Firebase account and generate Firebase Admin Service Account and download.

Copy the `project_id`, `private_key`, `client_id`, `client_email` and fill in the `.env` file in the `server` directory.

```
FIREBASE_PROJECT_ID=
FIREBASE_CLIENT_ID=
FIREBASE_PRIVATE_KEY=
FIREBASE_CLIENT_EMAIL=
```

> We'll only need the `.env` for local development.

### Running Project

#### Server

In the server directory, run the command below to start the Dart Shelf server.

```shell
$ dart run bin/server.dart
```

#### Frontend

In the frontend directory, run the command below to start the Flutter Web App.

> The current template is setup for Web. You can add additional support for Android, IOS and other flutter supported platforms.

```shell
$ flutter run -d chrome
```

### Deployment

#### Setup Globe CLI

You can deploy with a single command on [Globe](https://docs.globe.dev/). To install the Globe CLI, run the following command:

```shell
$ dart pub global activate globe_cli
```

To login with your Globe account, run the following command:

```shell
$ globe login
```

#### Deploy Server

To deploy the Shelf Dart server, in the `server` directory, run the following command:

```shell
$ globe deploy
```

Once this is complete, copy your Deployment URL. Checkout [Deployments](https://docs.globe.dev/deployments) for more details.

#### Deploy Frontend
