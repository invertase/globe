import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../routes/repos.dart' as repos;
import '../routes/users.dart' as users;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('DartFrog API', () {
    group('PATH: /repos', () {
      test('should respond OK', () async {
        final context = _MockRequestContext();
        final path = Uri.parse('http://localhost/repos');

        var request = Request.get(path);
        when(() => context.request).thenReturn(request);
        var response = await repos.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.ok));
        expect(
          response.json(),
          completion(equals([
            {'name': 'express', 'url': 'https://github.com/expressjs/express'},
            {'name': 'stylus', 'url': 'https://github.com/learnboost/stylus'},
            {'name': 'cluster', 'url': 'https://github.com/learnboost/cluster'}
          ])),
        );

        request = Request.get(path.replace(query: 'username=jane'));
        when(() => context.request).thenReturn(request);
        response = await repos.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.ok));
        expect(
          response.json(),
          completion(equals([
            {'name': 'cluster', 'url': 'https://github.com/learnboost/cluster'}
          ])),
        );
      });
    });

    group('PATH: /users', () {
      test('should respond OK', () async {
        final context = _MockRequestContext();
        final request = Request.get(Uri.parse('http://localhost/'));
        when(() => context.request).thenReturn(request);

        final response = await users.onRequest(context);
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
  });
}
