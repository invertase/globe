import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import '../src/router.dart';
import '../src/firebase.dart';

void main(List<String> args) async {
  final dotenv = DotEnv()..load();

  Firebase.init(
    projectId: dotenv['PROJECT_ID']!,
    clientId: dotenv['FIREBASE_CLIENT_ID']!,
    privateKey: dotenv['FIREBASE_PRIVATE_KEY']!.replaceAll(r'\n', '\n'),
    clientEmail: dotenv['FIREBASE_CLIENT_EMAIL']!,
  );

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');

  ProcessSignal.sigint.watch().listen((_) async {
    await Firebase.close();
    await server.close();
    exit(0); // Exit the program
  });
}
