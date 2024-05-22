import 'dart:io';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shelf/shelf.dart';

import 'firebase_admin.dart';

final bearerTokenRegExp = RegExp(r'Bearer (?<token>.+)');

Middleware authMiddleware = (innerHandler) {
  return (request) async {
    final authHeader = request.headers[HttpHeaders.authorizationHeader] ?? '';
    final match = bearerTokenRegExp.firstMatch(authHeader);
    final jwt = match?.namedGroup('token');

    if (jwt == null) {
      return Response.unauthorized(null);
    }

    if (JwtDecoder.tryDecode(jwt) case {'user_id': final String userId}) {
      final updated = request.change(context: {
        ...request.context,
        'notes': firestore.collection(userId),
      });

      return innerHandler(updated);
    } else {
      return Response.unauthorized(null);
    }
  };
};
