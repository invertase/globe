import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../routes/repos/index.dart' as repos;
import '../routes/repos/[repo].dart' as repo_by_id;
import '../routes/login.dart' as login;
import '../routes/repos/_middleware.dart' as auth;

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
            {'id': 0, 'name': 'express', 'url': 'github.com/expressjs/express'},
            {'id': 1, 'name': 'stylus', 'url': 'github.com/learnboost/stylus'},
            {'id': 2, 'name': 'cluster', 'url': 'github.com/learnboost/cluster'}
          ])),
        );

        /// Verify getting repos for :username
        request = Request.get(path.replace(query: 'username=jane'));
        when(() => context.request).thenReturn(request);
        response = await repos.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.ok));
        expect(
          response.json(),
          completion(equals([
            {"id": 2, 'name': 'cluster', 'url': 'github.com/learnboost/cluster'}
          ])),
        );
      });

      group('when authenticated', () {
        late String authToken;
        late auth.AuthData authData;

        setUpAll(() async {
          final context = _MockRequestContext();
          final path = Uri.parse('http://localhost/login');

          final request = Request.post(path,
              body: jsonEncode({"username": 'jane', "password": "admin101"}));
          when(() => context.request).thenReturn(request);

          final response = await login.onRequest(context);
          final respBody = await response.json();
          expect(response.statusCode, equals(HttpStatus.ok));
          expect(respBody, contains('token'));

          authToken = respBody['token'];
          authData = auth.AuthData('jane');
        });

        test('should check for token in header', () async {
          auth.AuthData? result;
          final handler = auth.middleware((context) {
            result = context.read<auth.AuthData>();
            return Response();
          });

          final path = Uri.parse('http://localhost/repos');

          final context = _MockRequestContext();
          when(() => context.request).thenReturn(Request.post(path, headers: {
            HttpHeaders.authorizationHeader: authToken,
          }));

          when(() => context.provide<auth.AuthData>(any())).thenReturn(context);
          when(() => context.read<auth.AuthData>()).thenReturn(authData);

          await handler(context);

          expect(result, isNotNull);
        });

        test('should create repo', () async {
          final context = _MockRequestContext();
          when(() => context.read<auth.AuthData>()).thenReturn(authData);

          final path = Uri.parse('http://localhost/repos');

          final request = Request.post(path,
              body: jsonEncode({
                "name": "Dart Sdk",
                "url": "github.com/dart-lang/sdk",
              }));

          when(() => context.request).thenReturn(request);
          final response = await repos.onRequest(context);

          expect(response.statusCode, equals(HttpStatus.ok));
          expect(
            response.json(),
            completion(equals([
              {
                'id': 2,
                'name': 'cluster',
                'url': 'github.com/learnboost/cluster'
              },
              {'id': 3, 'name': 'Dart Sdk', 'url': 'github.com/dart-lang/sdk'},
            ])),
          );
        });

        test('should update repo', () async {
          final context = _MockRequestContext();
          when(() => context.read<auth.AuthData>()).thenReturn(authData);

          const repoId = "2";

          final path = Uri.parse('http://localhost/repos/$repoId');

          final request = Request.put(path,
              body: jsonEncode(
                  {"name": "flask", "url": "flask.palletsprojects.com"}));

          when(() => context.request).thenReturn(request);
          final response = await repo_by_id.onRequest(context, repoId);

          expect(response.statusCode, equals(HttpStatus.ok));
          expect(
            response.json(),
            completion(equals({
              'id': 2,
              'name': 'flask',
              'url': 'flask.palletsprojects.com'
            })),
          );
        });

        test('should delete repo', () async {
          final context = _MockRequestContext();
          when(() => context.read<auth.AuthData>()).thenReturn(authData);

          final path =
              Uri.parse('http://localhost/repos?username=${authData.username}');
          final request = Request.get(path);

          when(() => context.request).thenReturn(request);
          var response = await repos.onRequest(context);

          /// Verify Existing Repos
          expect(response.statusCode, equals(HttpStatus.ok));
          expect(
            response.json(),
            completion(equals([
              {'id': 2, 'name': 'flask', 'url': 'flask.palletsprojects.com'},
              {'id': 3, 'name': 'Dart Sdk', 'url': 'github.com/dart-lang/sdk'}
            ])),
          );

          /// Verify Repo Deleted
          when(() => context.request).thenReturn(Request.delete(path));
          response = await repo_by_id.onRequest(context, "3");
          expect(response.statusCode, equals(HttpStatus.ok));
          expect(
            response.json(),
            completion(equals([
              {'id': 2, 'name': 'flask', 'url': 'flask.palletsprojects.com'},
            ])),
          );
        });
      });
    });
  });
}
