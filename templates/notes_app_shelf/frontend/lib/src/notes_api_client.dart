import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';

extension DecodeBody on http.Response {
  Future<dynamic> json() async {
    return jsonDecode(body);
  }
}

class NotesAPIClient {
  final String _url;
  late final Uri _uri = Uri.parse(_url);

  NotesAPIClient(this._url);

  Future<String?> get token => FirebaseAuth.instance.currentUser!.getIdToken();
  Future<Map<String, String>> get headers async {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${await token}',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  Future<List<Note>> getNotes() async {
    final url = _uri.resolve('/notes');
    final res = await http.get(url, headers: await headers);

    if (res.statusCode != HttpStatus.ok) {
      throw Exception('Failed to get notes');
    }

    return (await res.json() as List<dynamic>)
        .map((e) => Note.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Note> getNote(String id) async {
    final url = _uri.resolve('/notes/$id');
    final res = await http.get(url, headers: await headers);

    if (res.statusCode != HttpStatus.ok) {
      throw Exception('Failed to get note');
    }

    return Note.fromJson(await res.json() as Map<String, dynamic>);
  }

  Future<Note> createNote({
    required String title,
    required String description,
  }) async {
    final url = _uri.resolve('/notes');

    final res = await http.post(
      url,
      headers: await headers,
      body: jsonEncode({
        'title': title,
        'description': description,
      }),
    );

    if (res.statusCode != HttpStatus.created) {
      throw Exception('Failed to create note');
    }

    return Note.fromJson(await res.json() as Map<String, dynamic>);
  }

  Future<void> deleteNote(String id) async {
    final url = _uri.resolve('/notes/$id');
    final res = await http.delete(url, headers: await headers);

    if (res.statusCode != HttpStatus.ok) {
      throw Exception('Failed to delete note');
    }
  }

  Future<Note> updateNote(
    String noteId, {
    String? title,
    String? description,
  }) async {
    final url = _uri.resolve('/notes/$noteId');
    final res = await http.put(
      url,
      headers: await headers,
      body: jsonEncode({
        if (title != null) 'title': title,
        if (description != null) 'description': description,
      }),
    );

    if (res.statusCode != HttpStatus.ok) {
      throw Exception('Failed to update note');
    }

    return Note.fromJson(await res.json() as Map<String, dynamic>);
  }
}

class Note {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
