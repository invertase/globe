import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import '../src/router.dart';
import '../src/firebase.dart';

void main(List<String> args) async {
  Firebase.init();

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');

  ProcessSignal.sigint.watch().listen((signal) async {
    await Firebase.close();
    await server.close();
    exit(0); // Exit the program
  });
}
