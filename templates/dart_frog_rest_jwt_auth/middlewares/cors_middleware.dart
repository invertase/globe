import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;

/// Returns a [Middleware] that adds CORS headers to the response.
Middleware corsHeaders() => fromShelfMiddleware(
      shelf.corsHeaders(
        headers: {
          shelf.ACCESS_CONTROL_ALLOW_ORIGIN: _hubUrl,
        },
      ),
    );

String get _hubUrl {
  final value = Platform.environment['PROJECT_URL'];
  if (value == null) {
    throw ArgumentError('PROJECT_URL is required to run the API');
  }
  return value;
}
