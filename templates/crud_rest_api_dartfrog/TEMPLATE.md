---
name: Simple DartFrog Server
description: Building a simple CRUD REST API backend with DartFrog
tags: ["dart", "dart-frog"]
username: Invertase
---

# Simple DartFrog Server

## Overview

Creating a simple CRUD REST API server. This template helps you to save time to scaffold your Dart backend with DartFrog as quickly as possible.

### Getting Started

#### Bootstrap

Initialize your project using the command below

```shell
$ globe create -t crud_rest_api_dartfrog
```

#### Start Server

```shell
$ dart_frog dev --port=3000
```

### REST Endpoints

- List Repositories

  ```shell
  curl --request GET --url http://localhost:3000/repos
  ```

  ```json
  [
    { "id": 0, "name": "serverpod", "url": "github.com/serverpod/serverpod" },
    { "id": 1, "name": "melos", "url": "github.com/invertase/melos" },
    { "id": 2, "name": "freezed", "url": "github.com/rrousselGit/freezed" }
  ]
  ```

- Create New Repository

  ```shell
  curl -X POST -H "Content-Type: application/json" -d '{"name": "java", "url": "java.com/env"}' http://localhost:3000/repos
  ```

  ```json
  { "id": 3, "name": "java", "url": "java.com/env" }
  ```

- Update Repository

  ```shell
  curl -X PUT -H "Content-Type: application/json" -d '{"name": "dart", "url": "dart.dev"}' http://localhost:3000/repos/3
  ```

  ```json
  { "id": 3, "name": "dart", "url": "dart.dev" }
  ```

- Delete Repository for user

  ```shell
  curl --request DELETE http://localhost:3000/repos/2
  ```

  ```json
  { "message": "Repo 2 successfully deleted." }
  ```
