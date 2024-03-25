
{{#include_cors}}
import 'package:cors_headers/cors_headers.dart';

Middleware corsMiddleware() {
  return cors();
}
{{/include_cors}}

{{#include_auth}}
import 'package:jwt/jwt.dart';

Middleware authMiddleware() {
  return (handler) {
    return (context) async {
      // Your authentication logic here
      return handler(context);
    };
  };
}
{{/include_auth}}
