import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:{{project_name.snakeCase()}}/repositories/repositories.dart';
import 'package:{{project_name.snakeCase()}}/models/models.dart';

import '../../../routes/auth/sign_up.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('POST /auth/sign_up', () {
    late RequestContext context;
    late Request request;
    late UserRepository userRepository;

    setUp(() {
      context = _MockRequestContext();
      request = _MockRequest();
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => context.request).thenReturn(request);
      userRepository = _MockUserRepository();
      when(() => context.read<UserRepository>()).thenReturn(userRepository);
    });

    test('returns no content when everything works', () async {
      when(() => request.json()).thenAnswer(
        (_) async => {
          'name': 'John Doe',
          'username': 'john.doe',
          'password': 'password',
        },
      );

      when(
        () => userRepository.createUser(
          username: 'john.doe',
          name: 'John Doe',
          password: 'password',
        ),
      ).thenAnswer(
        (_) async => const User(
          id: '1',
          username: 'john.doe',
          name: 'John Doe',
        ),
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.noContent));
    });

    test(
      'returns conflict when a user with the same username already exists',
      () async {
        when(() => request.json()).thenAnswer(
          (_) async => {
            'name': 'John Doe',
            'username': 'john.doe',
            'password': 'password',
          },
        );

        when(
          () => userRepository.createUser(
            username: 'john.doe',
            name: 'John Doe',
            password: 'password',
          ),
        ).thenThrow(UserAlreadyExistsException());

        final response = await route.onRequest(context);
        expect(response.statusCode, equals(HttpStatus.conflict));
      },
    );

    test('returns 400 when username is missing', () async {
      when(() => request.json()).thenAnswer(
        (_) async => {
          'name': 'John Doe',
          'password': 'password',
        },
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.badRequest));
    });

    test('returns 400 when name is missing', () async {
      when(() => request.json()).thenAnswer(
        (_) async => {
          'username': 'john.doe',
          'password': 'password',
        },
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.badRequest));
    });

    test('returns 400 when password is missing', () async {
      when(() => request.json()).thenAnswer(
        (_) async => {
          'name': 'John Doe',
          'username': 'john.doe',
        },
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.badRequest));
    });

    test('returns method not allowed when is not a post', () async {
      when(() => request.method).thenReturn(HttpMethod.get);

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });
  });
}
