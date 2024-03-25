import 'package:api_domain/api_domain.dart';
import 'package:test/test.dart';

void main() {
  group('Session', () {
    final now = DateTime.now();
    test('can instantiate', () {
      expect(
        Session(
          id: '',
          token: '',
          userId: '',
          expiryDate: now,
          createdAt: now,
        ),
        isNotNull,
      );
    });

    test('supports equality', () {
      expect(
        Session(
          id: '',
          token: '',
          userId: '',
          expiryDate: now,
          createdAt: now,
        ),
        equals(
          Session(
            id: '',
            token: '',
            userId: '',
            expiryDate: now,
            createdAt: now,
          ),
        ),
      );

      expect(
        Session(
          id: '',
          token: '',
          userId: '',
          expiryDate: now,
          createdAt: now,
        ),
        equals(
          isNot(
            Session(
              id: 'a',
              token: '',
              userId: '',
              expiryDate: now,
              createdAt: now,
            ),
          ),
        ),
      );

      expect(
        Session(
          id: '',
          token: '',
          userId: '',
          expiryDate: now,
          createdAt: now,
        ),
        equals(
          isNot(
            Session(
              id: '',
              token: 'a',
              userId: '',
              expiryDate: now,
              createdAt: now,
            ),
          ),
        ),
      );

      expect(
        Session(
          id: '',
          token: '',
          userId: '',
          expiryDate: now,
          createdAt: now,
        ),
        equals(
          isNot(
            Session(
              id: '',
              token: '',
              userId: 'a',
              expiryDate: now,
              createdAt: now,
            ),
          ),
        ),
      );

      expect(
        Session(
          id: '',
          token: '',
          userId: '',
          expiryDate: now,
          createdAt: now,
        ),
        equals(
          isNot(
            Session(
              id: '',
              token: '',
              userId: '',
              expiryDate: now,
              createdAt: now.add(const Duration(days: 1)),
            ),
          ),
        ),
      );
    });

    test('fromJson correctly deserialize from a json', () {
      expect(
        Session.fromJson(
          {
            'id': '',
            'token': '',
            'userId': '',
            'expiryDate': now.toIso8601String(),
            'createdAt': now.toIso8601String(),
          },
        ),
        equals(
          Session(
            id: '',
            token: '',
            userId: '',
            expiryDate: now,
            createdAt: now,
          ),
        ),
      );
    });

    test('toJson returns the correct json', () {
      expect(
        Session(
          id: '',
          token: '',
          userId: '',
          expiryDate: now,
          createdAt: now,
        ).toJson(),
        equals(
          {
            'id': '',
            'token': '',
            'userId': '',
            'expiryDate': now.toIso8601String(),
            'createdAt': now.toIso8601String(),
          },
        ),
      );
    });
  });
}
