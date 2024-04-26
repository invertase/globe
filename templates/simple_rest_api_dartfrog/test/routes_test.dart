import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../routes/repos.dart' as repos;
import '../routes/users.dart' as users;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('DartFrog API', () {
    test('should response OK for PATH: /repos', () async {
      final context = _MockRequestContext();
      final response = repos.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));

      expect(
        response.json(),
        completion(equals([
          {'name': 'express', 'url': 'https://github.com/expressjs/express'},
          {'name': 'stylus', 'url': 'https://github.com/learnboost/stylus'},
          {'name': 'cluster', 'url': 'https://github.com/learnboost/cluster'}
        ])),
      );
    });

    test('should response OK for PATH: /users', () async {
      final context = _MockRequestContext();
      final request = Request.get(Uri.parse('http://localhost/'));
      when(() => context.request).thenReturn(request);

      final response = users.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));

      expect(
        response.json(),
        completion(equals([
          {'name': 'tobi'},
          {'name': 'loki'},
          {'name': 'jane'}
        ])),
      );
    });
  });
}
