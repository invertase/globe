import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../routes/index.dart' as route;
import '../routes/api/[id].dart' as api_route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('DartFrog API', () {
    test('should response OK for PATH: /', () async {
      final context = _MockRequestContext();
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));

      expect(
        response.body(),
        completion(
          contains('Welcome to DartFrog REST API!'),
        ),
      );
    });

    test('should response OK for PATH: /api/101', () async {
      final context = _MockRequestContext();
      final request = Request.get(Uri.parse('http://localhost/'));
      when(() => context.request).thenReturn(request);

      final response = api_route.onRequest(context, '101');
      expect(response.statusCode, equals(HttpStatus.ok));

      expect(
        response.body(),
        completion(equals('GET request to /101')),
      );
    });
  });
}
