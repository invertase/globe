import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../routes/{{endpoint_name}}/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group(
    'GET /{{endpoint_name}}',
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
                {
                  'message:': 'GET',
                  'project_name': '{{project_name}}',
                },
              ),
            ),
          );
        },
      );
    },
  );
}
