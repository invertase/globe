import 'dart:io';

import 'package:crud_rest_api_shelf/routes/repository_route.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  // Create handler
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(RepositoryRoute().router.call);

  // Start server
  final port = int.parse(Platform.environment['PORT'] ?? '3000');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('Server listening on port ${server.port}');
}
