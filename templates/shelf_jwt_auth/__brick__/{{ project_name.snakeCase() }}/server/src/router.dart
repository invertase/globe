import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'firebase.dart';
import 'utils.dart';

Router get router => Router()
  ..post('/api/auth/register', _signupHandler)
  ..get('/api/users/me', (req) => checkAuth(req, _getUser));

CollectionReference get userCollection =>
    Firebase.firestore.collection('users');

Future<Response> _getUser(Request request, User user) async {
  return Response.ok(
    jsonEncode(user.toJson()),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    },
  );
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
    jsonEncode({...userData, "id": user.uid}),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
}
