// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:test/test.dart';

void main() {
  group('AuthenticationRepository', () {
    test('can be instantiated', () {
      expect(
        AuthenticationRepository(
          secret: 'two is not equals to four, neither one',
          issuer: 'https://the-issuer.com',
        ),
        isNotNull,
      );
    });
  });
}
