import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../lib/routes/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group(
    'GET /{{primary_endpoint}}',
    () {
      test(
        'responds with a 200 and "Welcome to {{project_name}}".',
        () async {
          final context = _MockRequestContext();
          final response = route.onRequest(context);
          final result = await response;
          expect(result.statusCode, equals(HttpStatus.ok));
          expect(
            result.body(),
            completion(
              equals(
                'GET request to {{primary_endpoint}}',
              ),
            ),
          );
        },
      );
    },
  );
}
