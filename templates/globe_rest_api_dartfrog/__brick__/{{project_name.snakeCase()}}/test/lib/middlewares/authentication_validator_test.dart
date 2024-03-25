import 'package:authentication_repository/authentication_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:api_domain/api_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';
import 'package:{{project_name.snakeCase()}}/middlewares/middlewares.dart';

class _MockContext extends Mock implements RequestContext {
  @override
  RequestContext provide<T extends Object?>(T Function() create) {
    return this;
  }
}

class _MockRequest extends Mock implements Request {}

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('authenticationValidator', () {
    late _MockContext context;
    late _MockRequest request;
    late _MockAuthenticationRepository authenticationRepository;
    late _MockUserRepository userRepository;

    setUp(() {
      context = _MockContext();
      request = _MockRequest();
      authenticationRepository = _MockAuthenticationRepository();
      userRepository = _MockUserRepository();

      when(() => context.read<AuthenticationRepository>())
          .thenReturn(authenticationRepository);
      when(() => context.read<UserRepository>()).thenReturn(userRepository);

      when(() => context.request).thenReturn(request);
    });

    test('returns the user when the session is valid', () async {
      final session = Session(
        id: 'id',
        userId: 'userId',
        token: '',
        createdAt: DateTime.now(),
        expiryDate: DateTime.now(),
      );

      const user = User(
        id: 'userId',
        username: 'username',
        name: 'name',
      );

      when(() => authenticationRepository.verify('TOKEN'))
          .thenReturn(session.toJson());

      when(() => userRepository.findUserById('userId')).thenAnswer(
        (_) async => user,
      );

      when(() => request.headers).thenReturn(
        {
          'Authorization': 'Bearer TOKEN',
        },
      );

      final middleware = authenticationValidator();

      var called = false;
      await middleware((_) {
        called = true;
        return Response();
      })(context);

      expect(called, isTrue);
    });

    test(
      "don't call the handler when there is no authorization token",
      () async {
        when(() => request.headers).thenReturn(
          {},
        );

        final middleware = authenticationValidator();

        var called = false;
        await middleware((_) {
          called = true;
          return Response();
        })(context);

        expect(called, isFalse);
      },
    );

    test("don't call the handler when the token is not valid", () async {
      when(() => authenticationRepository.verify('TOKEN'))
          .thenThrow(Exception());

      when(() => request.headers).thenReturn(
        {
          'Authorization': 'Bearer TOKEN',
        },
      );

      final middleware = authenticationValidator();

      var called = false;
      try {
        await middleware((_) {
          called = true;
          return Response();
        })(context);
      } catch (_) {
        // Expected
      }

      expect(called, isFalse);
    });

    test("returns null when the user don't exists", () async {
      final session = Session(
        id: 'id',
        userId: 'userId',
        token: '',
        createdAt: DateTime.now(),
        expiryDate: DateTime.now(),
      );

      when(() => authenticationRepository.verify('TOKEN'))
          .thenReturn(session.toJson());

      when(() => userRepository.findUserById('userId')).thenAnswer(
        (_) async => null,
      );

      when(() => request.headers).thenReturn(
        {
          'Authorization': 'Bearer TOKEN',
        },
      );

      final middleware = authenticationValidator();

      var called = false;
      await middleware((_) {
        called = true;
        return Response();
      })(context);

      expect(called, isFalse);
    });
  });
}
