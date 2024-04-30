import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'note.dart';

class ApiService {
  final Uri baseUrl;

  String? _authToken;

  ApiService(this.baseUrl);

  void setToken(String? token) {
    _authToken = token;
  }

  Map<String, String> get _headers => {
        HttpHeaders.contentTypeHeader: 'application/json',
        if (_authToken != null) HttpHeaders.authorizationHeader: _authToken!
      };

  Uri _getUri(String path) => baseUrl.replace(path: path);

  Future<List<Note>> getNotes() async {
    final result = await _runCatching(() => http.get(
          _getUri('/notes'),
          headers: _headers,
        ));

    return (jsonDecode(result.body) as Iterable)
        .map((e) => Note.fromJson(e))
        .toList();
  }

  Future<Note> createNote(String title, String description) async {
    final newNoteData = {'title': title, 'description': description};

    final result = await _runCatching(() => http.post(
          _getUri('/notes'),
          headers: _headers,
          body: jsonEncode(newNoteData),
        ));

    return Note.fromJson(jsonDecode(result.body));
  }

  Future<Note> updateNote(
    String noteId,
    String title,
    String description,
  ) async {
    final newNoteData = {'title': title, 'description': description};

    final result = await _runCatching(() => http.put(
          _getUri('/notes/$noteId'),
          headers: _headers,
          body: jsonEncode(newNoteData),
        ));

    return Note.fromJson(jsonDecode(result.body));
  }

  Future<Note> deleteNote(String noteId) async {
    final result = await _runCatching(() => http.delete(
          _getUri('/notes/$noteId'),
          headers: _headers,
        ));

    return Note.fromJson(jsonDecode(result.body));
  }

  Future<http.Response> _runCatching(
    Future<http.Response> Function() apiCall,
  ) async {
    try {
      final response = await apiCall.call();
      if (response.statusCode == HttpStatus.ok) return response;
      throw HttpException(response.body);
    } on HttpException {
      rethrow;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
