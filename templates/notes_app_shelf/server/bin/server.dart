import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import 'package:server/firebase_admin.dart' as firebase_admin;
import 'package:server/auth_middleware.dart';
import 'package:server/router.dart';

void main(List<String> args) async {
  final env = DotEnv(includePlatformEnvironment: true)..load();
  final port = int.tryParse(env['PORT'] ?? '3000') ?? 3000;

  firebase_admin.init();

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addMiddleware(authMiddleware)
      .addHandler(router);

  final server = await serve(handler, InternetAddress.anyIPv4, port);
  stdout.writeln('Server listening on port ${server.port}');
}
