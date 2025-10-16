# Notes CRUD API with Dart Frog and Globe Database

A complete CRUD API for managing notes using Dart Frog and Globe's serverless SQLite database with Drift.

## Quick Start

1. **Create a new project:**
   ```bash
   globe create -t notes_api_dartfrog_globedb
   ```

2. **Set up your Globe Database:**
   - Go to [Globe dashboard](https://globe.dev/login)
   - Create a new database and copy the name
   - Update `lib/database.dart` with your database name

3. **Generate Drift code:**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Start development server:**
   ```bash
   dart_frog dev --port 8080
   ```

5. **Deploy to Globe:**
   ```bash
   globe deploy
   ```

## API Endpoints

- `GET /notes` - List all notes
- `POST /notes` - Create a new note
- `GET /notes/:id` - Get a specific note
- `PATCH /notes/:id` - Update a note
- `DELETE /notes/:id` - Delete a note

## Example Usage

```bash
# Create a note
curl -X POST -H "Content-Type: application/json" \
  -d '{"title": "My Note", "content": "Hello World!"}' \
  http://localhost:8080/notes

# List all notes
curl http://localhost:8080/notes
```

For detailed setup instructions, see [TEMPLATE.md](./TEMPLATE.md).


