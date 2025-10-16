import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:notes_api_dartfrog_globedb/notes_repository.dart';

Future<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.get => _getNotes(context),
    HttpMethod.post => _createNote(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getNotes(RequestContext context) async {
  final repository = context.read<NotesRepository>();
  final allNotes = await repository.getAllNotes();
  return Response.json(
    body: allNotes.map((note) => note.toJson()).toList(),
  );
}

Future<Response> _createNote(RequestContext context) async {
  final repository = context.read<NotesRepository>();
  final body = await context.request.json() as Map<String, dynamic>;
  final newNote = await repository.createNote(
    body['title'] as String,
    body['content'] as String,
  );

  return Response.json(
    statusCode: HttpStatus.created,
    body: newNote.toJson(),
  );
}
