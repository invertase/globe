import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'firebase.dart';
import 'utils.dart';

CollectionReference get userCollection =>
    Firebase.firestore.collection('users');

Router get router => Router()
  ..get('/user', (req) => checkAuth(req, _getUser))
  ..post('/api/auth/register', _signupHandler);

Future<Response> _getUser(Request request, User) async {
  final {
    'email': email as String,
    'password': password as String,
  } = jsonDecode(await request.readAsString());

  return Response.ok('Hello, World!');
}

Future<Response> _signupHandler(Request request) async {
  final {
    'name': name as String,
    'email': email as String,
    'password': password as String,
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

  await userCollection.doc(user.uid).create(userData);

  return Response.ok(
    jsonEncode({
      "user": {...userData, "id": user.uid},
    }),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
}
