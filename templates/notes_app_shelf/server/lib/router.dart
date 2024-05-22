import 'dart:async';
import 'dart:convert';

import 'package:dart_firebase_admin/firestore.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

final router = Router()
  ..get('/notes', getNotes)
  ..post('/notes', createNote)
  ..get('/notes/<noteId>', getNote)
  ..put('/notes/<noteId>', updateNote)
  ..delete('/notes/<noteId>', deleteNote);

extension on Request {
  CollectionReference get userNotes {
    return context['notes'] as CollectionReference;
  }
}

Future<Response> getNotes(Request request) async {
  final userNotes =
      await request.userNotes.orderBy('updatedAt', descending: true).get();

  final body = jsonEncode(
    userNotes.docs.map((e) => {"id": e.id, ...e.data()}).toList(),
  );

  return Response.ok(body);
}

Future<Response> getNote(Request request, String noteId) async {
  final note = await request.userNotes.doc(noteId).get();
  final noteData = note.data();

  if (!note.exists) {
    return Response.notFound(null);
  }

  return Response.ok(jsonEncode({'id': note.id, ...noteData}));
}

Future<Response> createNote(Request request) async {
  final body = await request.readAsString();

  try {
    final decoded = jsonDecode(body);

    final (title, description) = switch (decoded) {
      {'title': final String t, 'description': final String d} => (t, d),
      _ => throw FormatException(),
    };

    final now = DateTime.now().toUtc().toIso8601String();
    final newNoteData = {
      "title": title,
      "description": description,
      "createdAt": now,
      "updatedAt": now,
    };

    final noteReference = request.userNotes.doc();
    await noteReference.create(newNoteData);

    return Response.ok(jsonEncode({'id': noteReference.id, ...newNoteData}));
  } catch (_) {
    return Response.badRequest();
  }
}

Future<Response> deleteNote(Request request, String noteId) async {
  final noteReference = request.userNotes.doc(noteId);
  final note = await noteReference.get();

  if (!note.exists) {
    return Response.notFound(null);
  }

  await noteReference.delete();
  return Response.ok(jsonEncode({'id': note.id}));
}

Future<Response> updateNote(Request request, String noteId) async {
  final body = await request.readAsString();

  try {
    final decoded = jsonDecode(body);

    final (title, description) = switch (decoded) {
      {'title': final String? t, 'description': final String? d} => (t, d),
      _ => throw FormatException(),
    };

    final noteReference = request.userNotes.doc(noteId);
    final note = await noteReference.get();

    if (!note.exists) {
      return Response.notFound(null);
    }

    final data = note.data();

    final now = DateTime.now().toUtc().toIso8601String();
    final updatedNoteData = {
      "title": title ?? data['title'],
      "description": description ?? data['description'],
      "updatedAt": now,
    };

    await noteReference.update(updatedNoteData);

    return Response.ok(jsonEncode({...note.data(), ...updatedNoteData}));
  } catch (_) {
    return Response.badRequest();
  }
}
