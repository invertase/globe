---
name: Dart Backend with Authentication (Dart Frog)
description: JWT authentication for Dart backends with protected routes.
tags: ["API", "Authentication", "Dart Frog", "JWT"]
username: Invertase
---

# Dart Backend with Authentication (Dart Frog)

## Overview

Get started with Dart-Frog JWT Authentication for your backend. Register user with Username/Password & issue JWT tokens for accessing protected routes.

### Getting Started

#### Bootstrap

Initialize your project using the command below

```shell
$ globe create -t dartfrog_jwt_auth
```

> For local development, create a `.env` file in the root of your project and provide `JWT_SECRET_KEY` environment variable.

#### Start Server

```shell
$ dart_frog dev --port=8080
```

### REST Endpoints

- Register User

  ```shell
  curl -X POST -H "Content-Type: application/json" -d '{"username": "john", "password": "password123"}' http://localhost:8080/register
  ```

  ```
  User registered
  ```

- Login User

  ```shell
  curl -X POST -H "Content-Type: application/json" -d '{"username": "john", "password": "password123"}' http://localhost:8080/login
  ```

  ```json
  {
    "token": "<your-jwt-token>"
  }
  ```

- Get Current User

  ```shell
  curl -H "Authorization: Bearer <your-jwt-token>" http://localhost:8080/me
  ```

  ```json
  {
    "id": "user_id",
    "username": "john",
    "createdAt": "2024-05-07T12:30:45Z"
  }
  ```
