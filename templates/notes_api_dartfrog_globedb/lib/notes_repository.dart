import 'package:drift/drift.dart';
import 'package:notes_api_dartfrog_globedb/database.dart';

/// Repository interface for note operations.
/// This abstraction allows for easy testing by providing a mock implementation.
abstract class NotesRepository {
  /// Retrieves all notes from the database.
  Future<List<Note>> getAllNotes();

  /// Retrieves a note by its ID.
  /// Returns null if the note is not found.
  Future<Note?> getNoteById(int id);

  /// Creates a new note in the database.
  /// Returns the created note with its generated ID.
  Future<Note> createNote(String title, String content);

  /// Updates an existing note's content.
  /// Returns true if the note was updated, false if not found.
  Future<bool> updateNote(int id, String content);

  /// Deletes a note by its ID.
  /// Returns true if the note was deleted, false if not found.
  Future<bool> deleteNote(int id);
}

/// Concrete implementation of NotesRepository using Drift database.
class DriftNotesRepository implements NotesRepository {
  final AppDatabase _database;

  DriftNotesRepository(this._database);

  @override
  Future<List<Note>> getAllNotes() async {
    return await _database.select(_database.notes).get();
  }

  @override
  Future<Note?> getNoteById(int id) async {
    return await (_database.select(_database.notes)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Future<Note> createNote(String title, String content) async {
    return await _database.into(_database.notes).insertReturning(
          NotesCompanion.insert(
            title: title,
            content: content,
          ),
        );
  }

  @override
  Future<bool> updateNote(int id, String content) async {
    final affectedRows = await (_database.update(_database.notes)
          ..where((t) => t.id.equals(id)))
        .write(
      NotesCompanion(
        content: Value(content),
      ),
    );
    return affectedRows > 0;
  }

  @override
  Future<bool> deleteNote(int id) async {
    final affectedRows = await (_database.delete(_database.notes)
          ..where((t) => t.id.equals(id)))
        .go();
    return affectedRows > 0;
  }
}
