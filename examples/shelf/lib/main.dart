import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);

  final server = await shelf_io.serve(
    handler,
    InternetAddress.anyIPv4,
    int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080,
  );

  // Enable content compression
  server.autoCompress = true;

  stdout.writeln('Serving at http://${server.address.host}:${server.port}');
}

Response _echoRequest(Request request) =>
    Response.ok('Got a request for "${request.url}"...!');
