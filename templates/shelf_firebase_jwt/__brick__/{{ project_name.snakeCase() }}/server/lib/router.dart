import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_firebase_admin/firestore.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'src/firebase.dart';

extension on Request {
  String get userId => context['userId'].toString();
  Request withUserId(String id) => change(context: {...context, 'userId': id});
}

Middleware authMiddleware = (innerHandler) {
  return (request) async {
    final userToken =
        request.headers[HttpHeaders.authorizationHeader]?.split(' ').lastOrNull;

    if (userToken == null) {
      return Response.unauthorized(null);
    }

    final result = await Firebase.auth.verifyIdToken(userToken);

    return innerHandler(request.withUserId(result.uid));
  };
};

Router get router => Router()
  ..get('/notes', getNotes)
  ..post('/notes', addNewNote)
  ..get('/notes/<noteId>', getNote)
  ..put('/notes/<noteId>', updateNote)
  ..delete('/notes/<noteId>', deleteNote);

Future<Response> getNotes(Request request) async {
  final userNotes = await notesCollection
      .where('userId', WhereFilter.equal, request.userId)
      .orderBy('updatedAt', descending: true)
      .get();

  return Response.ok(jsonEncode(
      userNotes.docs.map((e) => {"id": e.id, ...e.data()}).toList()));
}

Future<Response> getNote(Request request, String noteId) async {
  final note = await notesCollection.doc(noteId).get();
  final noteData = note.data();

  if (!note.exists || noteData['userId'] != request.userId) {
    return Response.notFound(null);
  }

  return Response.ok(jsonEncode({'id': note.id, ...noteData}));
}

Future<Response> addNewNote(Request request) async {
  final {
    'title': title as String,
    'description': description as String,
  } = jsonDecode(await request.readAsString());

  final now = DateTime.now().toUtc().toIso8601String();
  final newNoteData = {
    "title": title,
    "description": description,
    "userId": request.userId,
    "createdAt": now,
    "updatedAt": now,
  };

  final noteReference = notesCollection.doc();
  await noteReference.create(newNoteData);

  return Response.ok(jsonEncode({'id': noteReference.id, ...newNoteData}));
}

Future<Response> deleteNote(Request request, String noteId) async {
  final noteReference = notesCollection.doc(noteId);
  final note = await noteReference.get();

  if (!note.exists || note.data()['userId'] != request.userId) {
    return Response.notFound(null);
  }

  await noteReference.delete();

  return Response.ok('Note deleted successfully.');
}

Future<Response> updateNote(Request request, String noteId) async {
  final {
    'title': title as String,
    'description': description as String,
  } = jsonDecode(await request.readAsString());

  final noteReference = notesCollection.doc(noteId);
  final note = await noteReference.get();
  final noteData = note.data();

  if (!note.exists || noteData['userId'] != request.userId) {
    return Response.notFound(null);
  }

  final newNoteData = {
    "title": title,
    "description": description,
    "updatedAt": DateTime.now().toUtc().toIso8601String(),
  };

  await noteReference.update(newNoteData);

  return Response.ok(jsonEncode({...noteData, ...newNoteData}));
}
