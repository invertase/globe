import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final id = int.tryParse(context.mountedParams['id']!);
    if (id == null) return Response(statusCode: HttpStatus.badRequest);

    final response = await handler(context);
    return response;
  };
}
