import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';
import '../../../routes/auth/sign_in.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockUserRepository extends Mock implements UserRepository {}

class _MockSessionRepository extends Mock implements SessionRepository {}

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('POST /auth/sign_in', () {
    late RequestContext context;
    late Request request;
    late UserRepository userRepository;
    late SessionRepository sessionRepository;
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      context = _MockRequestContext();
      request = _MockRequest();
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => context.request).thenReturn(request);
      userRepository = _MockUserRepository();
      when(() => context.read<UserRepository>()).thenReturn(userRepository);
      sessionRepository = _MockSessionRepository();
      when(() => context.read<SessionRepository>())
          .thenReturn(sessionRepository);
      authenticationRepository = _MockAuthenticationRepository();
      when(() => context.read<AuthenticationRepository>())
          .thenReturn(authenticationRepository);
    });

    test('returns the signed session when everything passes', () async {
      when(() => request.json()).thenAnswer(
        (_) async => {
          'username': 'john.doe',
          'password': 'password',
        },
      );

      when(
        () => userRepository.findByUsernameAndPassword(
          username: 'john.doe',
          password: 'password',
        ),
      ).thenAnswer(
        (_) async => const User(
          id: '1',
          username: 'john.doe',
          name: 'John Doe',
        ),
      );

      final now = DateTime.now();
      final session = Session(
        id: '1',
        userId: '1',
        token: 'abc',
        expiryDate: now.add(const Duration(days: 1)),
        createdAt: now,
      );

      when(() => authenticationRepository.sign(session.toJson()))
          .thenReturn('super secured token');

      when(() => sessionRepository.createSession('1'))
          .thenAnswer((_) async => session);

      final response = await route.onRequest(context);
      final json = await response.json();
      expect(json, equals({'token': 'super secured token'}));
    });

    test('returns 400 when username is missing', () async {
      when(() => request.json()).thenAnswer(
        (_) async => {
          'password': 'password',
        },
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.badRequest));
    });

    test('returns 400 when password is missing', () async {
      when(() => request.json()).thenAnswer(
        (_) async => {
          'username': 'john.doe',
        },
      );

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.badRequest));
    });

    test(
      'returns 401 when the user is not found with the given credentials',
      () async {
        when(() => request.json()).thenAnswer(
          (_) async => {
            'username': 'john.doe',
            'password': 'password',
          },
        );

        when(
          () => userRepository.findByUsernameAndPassword(
            username: 'john.doe',
            password: 'password',
          ),
        ).thenAnswer((_) async => null);

        final response = await route.onRequest(context);
        expect(response.statusCode, equals(HttpStatus.unauthorized));
      },
    );

    test('returns method not allowed when not a post', () async {
      when(() => request.method).thenReturn(HttpMethod.get);

      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });
  });
}
