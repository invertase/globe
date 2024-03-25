// ignore_for_file: prefer_const_constructors
import 'package:db_client/db_client.dart';
import 'package:api_domain/api_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:session_repository/session_repository.dart';
import 'package:test/test.dart';

class _MockDbClient extends Mock implements DbClient {}

void main() {
  group('SessionRepository', () {
    late DbClient dbClient;
    late SessionRepository sessionRepository;
    late DateTime now;

    setUp(() {
      dbClient = _MockDbClient();
      sessionRepository = SessionRepository(
        dbClient: dbClient,
        now: () => now,
      );
    });

    test('can be instantiated', () {
      expect(
        SessionRepository(
          dbClient: _MockDbClient(),
        ),
        isNotNull,
      );
    });

    test('create and return a new session', () async {
      now = DateTime(2021);
      when(
        () => dbClient.add(
          'sessions',
          {
            'token': '95c08686abf0b97f7a251c6a9b45801eea'
                '6f80bf82b157b71784401071e59cd2',
            'userId': 'user-id',
            'expiryDate': DateTime(2021, 1, 2).toIso8601String(),
            'createdAt': DateTime(2021).toIso8601String(),
          },
        ),
      ).thenAnswer((_) async => 'id');
      final session = await sessionRepository.createSession('user-id');

      expect(
        session,
        equals(
          Session(
            id: 'id',
            token: '95c08686abf0b97f7a251c6a9b45801eea'
                '6f80bf82b157b71784401071e59cd2',
            userId: 'user-id',
            expiryDate: DateTime(2021, 1, 2),
            createdAt: DateTime(2021),
          ),
        ),
      );
    });

    test(
      'returns the session via its token when it exists and is valid',
      () async {
        now = DateTime(2021);

        when(() => dbClient.findByField('sessions', 'token', 'my_token'))
            .thenAnswer(
          (_) async => [
            {
              'id': 'id',
              'userId': 'userId',
              'token': 'my_token',
              'expiryDate': DateTime(2021, 1, 2).toIso8601String(),
              'createdAt': DateTime(2021).toIso8601String(),
            },
          ],
        );

        final session = await sessionRepository.sessionFromToken('my_token');
        expect(
          session,
          equals(
            Session(
              id: 'id',
              userId: 'userId',
              expiryDate: DateTime(2021, 1, 2),
              createdAt: DateTime(2021),
              token: 'my_token',
            ),
          ),
        );
      },
    );

    test('returns null when there is no session for the token', () async {
      now = DateTime(2021);

      when(() => dbClient.findByField('sessions', 'token', 'my_token'))
          .thenAnswer(
        (_) async => [],
      );

      final session = await sessionRepository.sessionFromToken('my_token');
      expect(session, isNull);
    });

    test(
      'returns null and delete the token if it has expired',
      () async {
        now = DateTime(2021);

        when(() => dbClient.deleteById('sessions', 'id')).thenAnswer(
          (_) async {},
        );

        when(() => dbClient.findByField('sessions', 'token', 'my_token'))
            .thenAnswer(
          (_) async => [
            {
              'id': 'id',
              'userId': 'userId',
              'token': 'my_token',
              'expiryDate': DateTime(2021, 1, 2)
                  .subtract(Duration(days: 4))
                  .toIso8601String(),
              'createdAt':
                  DateTime(2021).subtract(Duration(days: 4)).toIso8601String(),
            },
          ],
        );

        final session = await sessionRepository.sessionFromToken('my_token');
        expect(session, isNull);

        verify(() => dbClient.deleteById('sessions', 'id')).called(1);
      },
    );
  });
}
