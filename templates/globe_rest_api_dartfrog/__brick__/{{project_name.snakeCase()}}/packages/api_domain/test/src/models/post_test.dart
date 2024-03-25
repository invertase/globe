// ignore_for_file: prefer_const_constructors

import 'package:api_domain/api_domain.dart';
import 'package:test/test.dart';

void main() {
  group('Post', () {
    test('can be instantiated', () {
      expect(
        Post(
          id: '',
          userId: '',
          message: '',
        ),
        isA<Post>(),
      );
    });

    test('support equality', () {
      expect(
        Post(
          id: '',
          userId: '',
          message: '',
        ),
        equals(
          Post(
            id: '',
            userId: '',
            message: '',
          ),
        ),
      );

      expect(
        Post(
          id: '',
          userId: '',
          message: '',
        ),
        isNot(
          equals(
            Post(
              id: 'different',
              userId: '',
              message: 'different',
            ),
          ),
        ),
      );

      expect(
        Post(
          id: '',
          userId: '',
          message: '',
        ),
        isNot(
          equals(
            Post(
              id: '',
              userId: '',
              message: 'different',
            ),
          ),
        ),
      );

      expect(
        Post(
          id: '',
          userId: '',
          message: '',
        ),
        isNot(
          equals(
            Post(
              id: '',
              userId: 'different',
              message: '',
            ),
          ),
        ),
      );
    });

    test('serializes to JSON', () {
      expect(
        Post(
          id: 'id',
          userId: 'userId',
          message: 'message',
        ).toJson(),
        equals(
          {
            'id': 'id',
            'userId': 'userId',
            'message': 'message',
          },
        ),
      );
    });

    test('deserializes from JSON', () {
      expect(
        Post.fromJson(
          const {
            'id': 'id',
            'userId': 'userId',
            'message': 'message',
          },
        ),
        equals(
          Post(
            id: 'id',
            userId: 'userId',
            message: 'message',
          ),
        ),
      );
    });
  });
}
