// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../../services/db_client.dart';

class _MockDbClient extends Mock implements DbClient {}

void main() {
  group('UserRepository', () {
    late DbClient dbClient;
    late UserRepository userRepository;

    setUp(() {
      dbClient = _MockDbClient();
      userRepository = UserRepository(dbClient: dbClient);
    });

    test('can be instantiated', () {
      expect(
        UserRepository(dbClient: _MockDbClient()),
        isNotNull,
      );
    });

    test('can create an user', () async {
      when(() => dbClient.findByField(any(), any(), any<String>())).thenAnswer(
        (_) async => [],
      );

      when(() => dbClient.add(any(), any())).thenAnswer(
        (_) async => '1',
      );

      final user = await userRepository.createUser(
        username: 'test',
        name: 'Test',
        password: 'password',
      );

      expect(
        user,
        equals(
          User(id: '1', username: 'test', name: 'Test'),
        ),
      );
    });

    test('password is stored in a hash format', () async {
      when(() => dbClient.findByField(any(), any(), any<String>())).thenAnswer(
        (_) async => [],
      );

      when(() => dbClient.add(any(), any())).thenAnswer(
        (_) async => '1',
      );

      await userRepository.createUser(
        username: 'test',
        name: 'Test',
        password: 'password',
      );
      const hashedPassword = '5e884898da28047151d0e56f8dc6292773'
          '603d0d6aabbdd62a11ef721d1542d8';

      verify(
        () => dbClient.add(
          any(),
          {
            'username': 'test',
            'name': 'Test',
            'password': hashedPassword,
          },
        ),
      );
    });

    test(
      'throws UserAlreadyExistsException when an user with the username '
      'already exists',
      () async {
        when(() => dbClient.findByField(any(), any(), any<String>()))
            .thenAnswer(
          (_) async => [
            {
              'id': '1',
              'username': 'test',
              'name': 'Test',
              'password': 'password',
            },
          ],
        );

        when(() => dbClient.add(any(), any())).thenAnswer(
          (_) async => '1',
        );

        await expectLater(
          () => userRepository.createUser(
            username: 'test',
            name: 'Test',
            password: 'password',
          ),
          throwsA(isA<UserAlreadyExistsException>()),
        );
      },
    );

    test('findByUsername returns the user when one is found', () async {
      when(() => dbClient.findByField(any(), any(), any<String>())).thenAnswer(
        (_) async => [
          {
            'id': '1',
            'username': 'test',
            'name': 'Test',
            'password': 'password',
          },
        ],
      );

      final foundUser = await userRepository.findByUsername('test');
      expect(
        foundUser,
        equals(
          User(id: '1', username: 'test', name: 'Test'),
        ),
      );
    });

    test('findByUsername returns null when no one', () async {
      when(() => dbClient.findByField(any(), any(), any<String>())).thenAnswer(
        (_) async => [],
      );

      final foundUser = await userRepository.findByUsername('test');
      expect(foundUser, isNull);
    });

    test('findByUsernameAndPassword return the user when one is found',
        () async {
      when(() => dbClient.findByField(any(), any(), any<String>())).thenAnswer(
        (_) async => [
          {
            'id': '1',
            'username': 'test',
            'name': 'Test',
            'password': '5e884898da28047151d0e56f8dc6292773'
                '603d0d6aabbdd62a11ef721d1542d8',
          },
        ],
      );

      final foundUser = await userRepository.findByUsernameAndPassword(
        username: 'test',
        password: 'password',
      );
      expect(
        foundUser,
        equals(
          User(id: '1', username: 'test', name: 'Test'),
        ),
      );
    });

    test('findByUsernameAndPassword return null when none is found', () async {
      when(() => dbClient.findByField(any(), any(), any<String>())).thenAnswer(
        (_) async => [],
      );

      final foundUser = await userRepository.findByUsernameAndPassword(
        username: 'test',
        password: 'pass',
      );
      expect(foundUser, isNull);
    });

    test(
      'findByUsernameAndPassword return null when the user exists but the '
      'password is wrong',
      () async {
        when(() => dbClient.findByField(any(), any(), any<String>()))
            .thenAnswer(
          (_) async => [
            {
              'id': '1',
              'username': 'test',
              'name': 'Test',
              'password': '5e884898da28047151d0e56f8dc6292773'
                  '603d0d6aabbdd62a11ef721d1542d8',
            },
          ],
        );

        final foundUser = await userRepository.findByUsernameAndPassword(
          username: 'test',
          password: 'wrong',
        );
        expect(foundUser, isNull);
      },
    );

    test('findUserById returns the user found', () async {
      when(() => dbClient.getById(any(), any())).thenAnswer(
        (_) async => {
          'id': '1',
          'username': 'test',
          'name': 'Test',
        },
      );

      final user = await userRepository.findUserById('1');
      expect(
        user,
        equals(
          User(id: '1', username: 'test', name: 'Test'),
        ),
      );
    });

    test('findUserById returns null when no user is found', () async {
      when(() => dbClient.getById(any(), any())).thenAnswer(
        (_) async => null,
      );

      final user = await userRepository.findUserById('1');
      expect(user, isNull);
    });
  });
}
