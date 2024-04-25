import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../routes/index.dart' as route;
import '../routes/api/[id].dart' as apiRoute;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('DartFrog API', () {
    test('should response OK for PATH: /', () async {
      final context = _MockRequestContext();
      final response = route.onRequest(context);
      final result = await response;
      expect(result.statusCode, equals(HttpStatus.ok));

      expect(
        result.body(),
        completion(
          contains('Welcome to DartFrog REST API!'),
        ),
      );
    });

    test('should response OK for PATH: /api/101', () async {
      final context = _MockRequestContext();
      final request = Request.get(Uri.parse('http://localhost/'));
      when(() => context.request).thenReturn(request);

      final response = apiRoute.onRequest(context, '101');
      final result = await response;
      expect(result.statusCode, equals(HttpStatus.ok));

      expect(
        result.body(),
        completion(equals('GET request to /101')),
      );
    });
  });
}
