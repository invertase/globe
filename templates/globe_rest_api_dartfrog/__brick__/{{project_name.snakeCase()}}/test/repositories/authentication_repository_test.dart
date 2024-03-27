// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:{{project_name.snakeCase()}}/repositories/repositories.dart';

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
