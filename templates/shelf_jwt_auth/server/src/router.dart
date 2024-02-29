import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_firebase_admin/auth.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'firebase.dart';
import 'utils.dart';

Router get router => Router()
  ..get('/me', (req) => checkAuth(req, _echoHandler))
  ..post('/signin', _loginHandler)
  ..post('/signup', _signupHandler);

Response _echoHandler(Request request, Object user) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> _loginHandler(Request request) async {
  final {
    'email': email as String,
    'password': password as String,
  } = jsonDecode(await request.readAsString());

  return Response.ok('Hello, World!');
}

Future<Response> _signupHandler(Request request) async {
  final {
    'email': email as String,
    'password': password as String,
    'name': name as String,
  } = jsonDecode(await request.readAsString());

  final user = await Firebase.auth.createUser(CreateRequest(
    email: email,
    password: password,
    displayName: name,
  ));

  final now = DateTime.now().toUtc().toIso8601String();
  final userData = {
    "name": name,
    "email": email,
    'createdAt': now,
    'updatedAt': now
  };

  await Firebase.firestore.collection('users').doc(user.uid).create(userData);

  return Response.ok(
    jsonEncode({
      "user": {...userData, "id": user.uid},
    }),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
}
