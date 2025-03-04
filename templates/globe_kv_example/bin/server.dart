import 'dart:convert';
import 'dart:io';

import 'package:globe_kv/globe_kv.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

final globeKv = GlobeKV('1dd01f766be2bf5f');

// Configure routes.
final _router = Router()
  ..get('/get/<key>', _handleReadKey)
  ..post('/set/<key>', _handleSetKey);

Future<Response> _handleReadKey(Request request) async {
  final key = request.params['key']!;
  final result = await globeKv.get(key);
  if (result == null) {
    return Response.notFound('Key not found: $key');
  }

  return Response.ok(
    jsonEncode({
      'key': key,
      'type': result.type.name,
      'value': result.value,
    }),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
}

Future<Response> _handleSetKey(Request request) async {
  final key = request.params['key']!;
  final body = await request.readAsString();

  await globeKv.set(key, body);

  return Response.ok('Key set: $key');
}

void main(List<String> args) async {
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, InternetAddress.anyIPv4, port);

  stdout.writeln('Server listening on port ${server.port}');
}
