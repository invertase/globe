import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    // Validate repo id
    final repoId = int.tryParse(context.mountedParams['id']!);
    if (repoId == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }

    // Forward the request to the respective handler & return response.
    return await handler(context);
  };
}
