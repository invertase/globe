// ignore_for_file: prefer_const_constructors

import 'package:api_domain/api_domain.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('can be instantiated', () {
      expect(
        User(id: 'id', username: 'username', name: 'name'),
        isNotNull,
      );
    });

    test('supports equality', () {
      expect(
        User(id: 'id', username: 'username', name: 'name'),
        equals(
          User(id: 'id', username: 'username', name: 'name'),
        ),
      );

      expect(
        User(id: 'id', username: 'username', name: 'name1'),
        isNot(
          equals(
            User(id: 'id', username: 'username', name: 'name'),
          ),
        ),
      );

      expect(
        User(id: 'id', username: 'username1', name: 'name'),
        isNot(
          equals(
            User(id: 'id', username: 'username', name: 'name'),
          ),
        ),
      );

      expect(
        User(id: 'id1', username: 'username', name: 'name'),
        isNot(
          equals(
            User(id: 'id', username: 'username', name: 'name'),
          ),
        ),
      );
    });

    test('can serialize to json', () {
      expect(
        User(id: 'id', username: 'username', name: 'name').toJson(),
        equals(
          <String, dynamic>{
            'id': 'id',
            'username': 'username',
            'name': 'name',
          },
        ),
      );
    });

    test('can deserialize from json', () {
      expect(
        User.fromJson(const {
          'id': 'id',
          'username': 'username',
          'name': 'name',
        }),
        equals(
          User(id: 'id', username: 'username', name: 'name'),
        ),
      );
    });
  });
}
