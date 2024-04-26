import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../../routes/session.dart' as route;

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

void main() {
  group('Profile', () {
    const user = User(
      id: '1',
      name: 'Test User',
      username: '',
    );

    final session = Session(
      id: 'id',
      token: 'token',
      userId: 'userId',
      expiryDate: DateTime(2021),
      createdAt: DateTime(2021).subtract(
        const Duration(days: 1),
      ),
    );

    final apiSession = ApiSession(user: user, session: session);

    group('GET /session', () {
      test('returns 200 with the signed session', () async {
        final context = _MockRequestContext();
        final request = _MockRequest();
        final authenticationRepository = _MockAuthenticationRepository();

        when(() => context.request).thenReturn(request);
        when(() => request.method).thenReturn(HttpMethod.get);
        when(() => context.read<ApiSession>()).thenReturn(apiSession);
        when(() => context.read<AuthenticationRepository>())
            .thenReturn(authenticationRepository);

        when(
          () => authenticationRepository.sign(
            session.toJson(),
          ),
        ).thenReturn('super secured session token');

        final response = await route.onRequest(context);

        expect(response.statusCode, equals(200));
        expect(
          await response.json(),
          equals(
            {'token': 'super secured session token'},
          ),
        );
      });

      test('returns method not allowed when not GET', () async {
        final context = _MockRequestContext();
        final request = _MockRequest();

        when(() => context.request).thenReturn(request);
        when(() => request.method).thenReturn(HttpMethod.post);

        final response = await route.onRequest(context);

        expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
      });
    });
  });
}
