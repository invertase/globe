import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../routes/repos/index.dart' as repos;
import '../routes/repos/[id]/index.dart' as repo_by_id;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('DartFrog API', () {
    group('/repos', () {
      test('should return repos', () async {
        final context = _MockRequestContext();
        final path = Uri.parse('http://localhost/repos');

        /// Verify getting all repos
        var request = Request.get(path);
        when(() => context.request).thenReturn(request);
        var response = await repos.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.ok));
        expect(
          response.json(),
          completion(equals([
            {
              'id': 0,
              'name': 'serverpod',
              'url': 'github.com/serverpod/serverpod'
            },
            {'id': 1, 'name': 'melos', 'url': 'github.com/invertase/melos'},
            {
              'id': 2,
              'name': 'freezed',
              'url': 'github.com/rrousselGit/freezed'
            }
          ])),
        );
      });

      test('should create repo', () async {
        final context = _MockRequestContext();
        final path = Uri.parse('http://localhost/repos');

        final request = Request.post(
          path,
          body: jsonEncode({
            "name": "Dart Sdk",
            "url": "github.com/dart-lang/sdk",
          }),
        );

        when(() => context.request).thenReturn(request);
        final response = await repos.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.ok));
        expect(
          response.json(),
          completion(equals({
            'id': 3,
            'name': 'Dart Sdk',
            'url': 'github.com/dart-lang/sdk',
          })),
        );
      });

      test('should update repo', () async {
        final context = _MockRequestContext();
        const repoId = "1";

        final path = Uri.parse('http://localhost/repos/$repoId');

        final request = Request.put(
          path,
          body: jsonEncode({"name": "shelf", "url": "pub.dev/packages/shelf"}),
          headers: {'username': 'tobi'},
        );

        when(() => context.request).thenReturn(request);
        final response = await repo_by_id.onRequest(context, repoId);

        expect(response.statusCode, equals(HttpStatus.ok));
        expect(
          response.json(),
          completion(equals({
            'id': 1,
            'name': 'shelf',
            'url': 'pub.dev/packages/shelf',
          })),
        );
      });

      test('should delete repo', () async {
        final context = _MockRequestContext();
        final path = Uri.parse('http://localhost/repos/0');
        when(() => context.request).thenReturn(Request.delete(path));

        final response = await repo_by_id.onRequest(context, "0");
        expect(response.statusCode, equals(HttpStatus.ok));
        expect(
          response.json(),
          completion(equals({'message': 'Repo 0 successfully deleted.'})),
        );
      });
    });
  });
}
