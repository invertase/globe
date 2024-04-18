---
name: Flutter + Firebase Auth + Shelf Backend
description: Build a Notes App using Flutter Web, Firebase Auth and a custom backend using Shelf.
tags: ["firebase", "shelf", "flutter", "firestore"]
username: Invertase
---

# Firebase + JWT Auth + Shelf

## Overview

Build a Simple Notes App using Flutter Web, Firebase Auth and Dart for our backend.

### Features

- [Shelf](https://pub.dev/packages/shelf)
- [Flutter](https://flutter.dev)
- [Firebase](https://firebase.google.com/)

### Getting Started

#### Bootstrap

Initialize your project using the `shelf_firebase_jwt` brick

```shell
$ mason make shelf_firebase_jwt
```

#### Setup Firebase Project

You must create a Firebase account and generate Firebase Admin Service Account and download.

To generate a private key for your service account:

- In the Firebase console, open **Settings** > **[Service Accounts](https://console.firebase.google.com/project/_/settings/serviceaccounts/adminsdk)**
- Click **Generate New Private Key**, then confirm by clicking **Generate Key**
- Securely store the JSON file containing the key.

Copy the `project_id`, `private_key`, `client_id`, `client_email` and fill in the `.env` file in the `server` directory.

> We'll only need the `.env` for local development.

```
FIREBASE_PROJECT_ID=
FIREBASE_CLIENT_ID=
FIREBASE_PRIVATE_KEY=
FIREBASE_CLIENT_EMAIL=
```

> After providing values in the `.env` file, Run the `build_runner build` command to generate some typed Env class.

```shell
dart run build_runner build --delete-conflicting-outputs
```

#### Link Frontend with Firebase

Follow the guide at https://firebase.flutter.dev/docs/cli to link the `frontend` project with existing/newly created Firebase project.

> You should have a `firebase_options.dart` generated after completing this step.

### Running Project

#### Server

In the server directory, run the command below to start the Dart Shelf server.

```shell
$ dart run bin/server.dart
```

#### Frontend

In the frontend directory, run the command below to start the Flutter Web App.

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

In the `server` directory, run the following command:

```shell
$ globe deploy
```

Once this is complete, copy your Deployment URL. Checkout [Deployments](https://docs.globe.dev/deployments) for more details.

> Remember to set Environment Variables for your server app on Globe Dashboard and re-deploy your project.

#### Deploy Frontend

In the `frontend` directory, run the following command:

```shell
$ globe deploy
```

> You'll need to add an `API_URL` Environment variable to your project on Globe Dashboard. Then re-deploy your project.
