import 'dart:async';
import 'dart:io';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shelf/shelf.dart';

import 'firebase.dart';

final class APIError {
  static final String unauthorized = 'You are not authorized';
}

typedef RequiresUser = FutureOr<Response> Function(Request req, Object user);

/// Middleware that checks for Bearer Token in incoming request header.
Future<Response> checkAuth(Request request, RequiresUser action) async {
  final tokenFromHeader =
      request.headers[HttpHeaders.authorizationHeader]?.split(' ').lastOrNull;

  // ensure token is present
  if (tokenFromHeader == null) {
    return Response.unauthorized(APIError.unauthorized);
  }

  final tokenValue = JwtDecoder.tryDecode(tokenFromHeader);
  if (tokenValue == null) {
    return Response.unauthorized(APIError.unauthorized);
  }

  final user = await Firebase.auth.getUser(tokenValue['uid']);

  return action.call(request, user);
}
