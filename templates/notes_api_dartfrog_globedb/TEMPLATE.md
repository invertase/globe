---
name: Dart Database
description: Notes CRUD API using DartFrog and Globe's serverless SQLite database.
tags: ["Full stack", "Dart Frog", "Database", "Globe DB", "Drift"]
username: Invertase
---

# Notes CRUD API with Dart Frog and Globe Database

## Overview

Build a complete CRUD API for managing notes using Dart Frog and Globe's serverless SQLite database with Drift. This template provides a ready-to-deploy backend with full CRUD operations for a notes system.

### Features

- **Full CRUD Operations**: Create, Read, Update, and Delete notes
- **Globe Database Integration**: Uses Globe's serverless SQLite database
- **Drift ORM**: Type-safe database operations with code generation
- **Dart Frog Framework**: Modern, fast Dart backend framework
- **RESTful API**: Clean HTTP endpoints following REST conventions

### Getting Started

#### Bootstrap

Initialize your project using the `notes_api_dartfrog_globedb` template:

```shell
$ globe create -t notes_api_dartfrog_globedb
```

#### Setup Globe Database

1. Navigate to the [Globe dashboard](https://globe.dev/login)
2. Go to the **Databases** tab and click **Create Database**
3. Select a location, click **Create**, and a name will be automatically assigned
4. Copy the **auto-generated database name** (e.g., `gold-butterfly-1234`)

#### Configure Database Connection

1. Open `lib/database.dart`
2. Replace `your-db-name` with the database name you copied from the Globe dashboard:

```dart
static QueryExecutor _openConnection() {
  // Replace 'your-db-name' with your actual Globe database name
  return NativeDatabase.opened(sqlite3.open('your-actual-db-name.db'));
}
```

#### Generate Drift Code

Run the build runner to generate the necessary database code:

```shell
$ dart run build_runner build --delete-conflicting-outputs
```

#### Start Development Server

```shell
$ dart_frog dev --port 8080
```

### API Endpoints

#### List All Notes

```bash
curl http://localhost:8080/notes
```

#### Create a Note

```bash
curl -X POST -H "Content-Type: application/json" \
  -d '{"title": "My First Note", "content": "Hello Globe DB!"}' \
  http://localhost:8080/notes
```

#### Get a Specific Note

```bash
curl http://localhost:8080/notes/1
```

#### Update a Note

```bash
curl -X PATCH -H "Content-Type: application/json" \
  -d '{"content": "Updated content"}' \
  http://localhost:8080/notes/1
```

#### Delete a Note

```bash
curl -X DELETE http://localhost:8080/notes/1
```

### Database Schema

The template includes a simple notes table with the following structure:

- `id`: Auto-incrementing primary key
- `title`: Note title (text)
- `content`: Note content (text)

### Deployment

#### Deploy to Globe

1. Make sure you're logged in to Globe CLI:

```shell
$ globe login
```

2. Deploy your API:

```shell
$ globe deploy
```

The Globe CLI will guide you through linking the project and will automatically connect your database. Once complete, you will receive a unique URL for your live API.

#### Test Live API

After deployment, test your live API endpoints:

```bash
# Create a note on your live API
curl -X POST https://<YOUR_LIVE_URL>/notes \
  -H "Content-Type: application/json" \
  -d '{"title": "Live Note", "content": "This is on Globe!"}'

# Get the list of live notes
curl https://<YOUR_LIVE_URL>/notes
```

### Project Structure

```
notes_api_dartfrog_globedb/
├── lib/
│   └── database.dart          # Drift database schema and connection
├── routes/
│   └── notes/
│       ├── _middleware.dart   # Database provider middleware
│       ├── index.dart         # GET /notes, POST /notes
│       └── [id].dart          # GET /notes/:id, PATCH /notes/:id, DELETE /notes/:id
├── pubspec.yaml               # Dependencies
├── analysis_options.yaml      # Linting rules
└── TEMPLATE.md               # This file
```

### Dependencies

- **dart_frog**: Modern Dart backend framework
- **drift**: Type-safe SQLite ORM
- **sqlite3**: SQLite database driver
- **build_runner**: Code generation for Drift
- **drift_dev**: Development tools for Drift

### Next Steps

- **Add Authentication**: Integrate with Globe's auth system
- **Add Validation**: Implement request validation
- **Add Error Handling**: Enhance error responses
- **Add Tests**: Write unit and integration tests
- **Add Documentation**: Generate API documentation
