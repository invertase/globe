import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:drift/drift.dart';
import 'package:notes_api_dartfrog_globedb/database.dart';

Future<Response> onRequest(RequestContext context, String id) {
  return switch (context.request.method) {
    HttpMethod.get => _getNoteById(context, id),
    HttpMethod.patch => _updateNote(context, id),
    HttpMethod.delete => _deleteNote(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getNoteById(RequestContext context, String id) async {
  final db = context.read<AppDatabase>();
  final noteId = int.parse(id);
  final note = await (db.select(db.notes)..where((t) => t.id.equals(noteId)))
      .getSingleOrNull();
  return note == null
      ? Response(statusCode: HttpStatus.notFound)
      : Response.json(body: note.toJson());
}

Future<Response> _updateNote(RequestContext context, String id) async {
  final db = context.read<AppDatabase>();
  final noteId = int.parse(id);
  final body = await context.request.json() as Map<String, dynamic>;
  final success =
      await (db.update(db.notes)..where((t) => t.id.equals(noteId))).write(
    NotesCompanion(
      content: Value(body['content'] as String),
    ),
  );
  return success > 0
      ? Response(statusCode: HttpStatus.noContent)
      : Response(statusCode: HttpStatus.notFound);
}

Future<Response> _deleteNote(RequestContext context, String id) async {
  final db = context.read<AppDatabase>();
  final noteId = int.parse(id);
  final success =
      await (db.delete(db.notes)..where((t) => t.id.equals(noteId))).go();
  return success > 0
      ? Response(statusCode: HttpStatus.noContent)
      : Response(statusCode: HttpStatus.notFound);
}
