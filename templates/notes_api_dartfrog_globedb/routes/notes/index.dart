import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:notes_api_dartfrog_globedb/database.dart';

Future<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.get => _getNotes(context),
    HttpMethod.post => _createNote(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getNotes(RequestContext context) async {
  final db = context.read<AppDatabase>();
  final allNotes = await db.select(db.notes).get();
  return Response.json(
    body: allNotes.map((note) => note.toJson()).toList(),
  );
}

Future<Response> _createNote(RequestContext context) async {
  final db = context.read<AppDatabase>();
  final body = await context.request.json() as Map<String, dynamic>;
  final newNote = await db.into(db.notes).insertReturning(
        NotesCompanion.insert(
          title: body['title'] as String,
          content: body['content'] as String,
        ),
      );

  return Response.json(
    statusCode: HttpStatus.created,
    body: newNote.toJson(),
  );
}
