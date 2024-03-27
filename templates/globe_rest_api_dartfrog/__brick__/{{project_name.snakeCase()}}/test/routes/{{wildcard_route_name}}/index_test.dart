import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:api_domain/api_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:{{project_name.snakeCase()}}/models/models.dart';

import '../../../routes/posts/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockPostRepository extends Mock implements PostRepository {}

class _MockRequest extends Mock implements Request {}

void main() {
  group('Posts', () {
    late RequestContext requestContext;
    late PostRepository postRepository;
    late Request request;

    setUp(() {
      requestContext = _MockRequestContext();
      postRepository = _MockPostRepository();

      request = _MockRequest();

      when(() => requestContext.request).thenReturn(request);

      when(() => requestContext.read<PostRepository>())
          .thenReturn(postRepository);
    });

    group('POST', () {
      setUp(() {
        when(() => request.method).thenReturn(HttpMethod.post);
      });

      test('can create a post', () async {
        final now = DateTime.now();
        final session = ApiSession(
          user: const User(
            id: 'id',
            username: 'username',
            name: 'name',
          ),
          session: Session(
            id: '',
            token: '',
            userId: '',
            expiryDate: now,
            createdAt: now,
          ),
        );
        when(
          () => postRepository.createPost(
            userId: 'id',
            message: 'message',
          ),
        ).thenAnswer(
          (_) async => const Post(
            id: 'id',
            userId: 'id',
            message: 'message',
          ),
        );

        when(() => requestContext.read<ApiSession>()).thenReturn(session);
        when(() => request.json()).thenAnswer(
          (_) async => {
            'message': 'message',
            'userId': 'id',
          },
        );

        final response = await route.onRequest(requestContext);

        expect(
          response.json(),
          completion(
            equals(
              {
                'id': 'id',
                'userId': 'id',
                'message': 'message',
              },
            ),
          ),
        );
      });

      test(
        'returns bad request with the error when it is an expected one',
        () async {
          final now = DateTime.now();
          final session = ApiSession(
            user: const User(
              id: 'id',
              username: 'username',
              name: 'name',
            ),
            session: Session(
              id: '',
              token: '',
              userId: '',
              expiryDate: now,
              createdAt: now,
            ),
          );
          when(
            () => postRepository.createPost(
              userId: 'id',
              message: 'message',
            ),
          ).thenThrow(
            const PostCreationFailure(
              CreatePostFailure.tooLong,
              StackTrace.empty,
            ),
          );

          when(() => requestContext.read<ApiSession>()).thenReturn(session);
          when(() => request.json()).thenAnswer(
            (_) async => {
              'message': 'message',
              'userId': 'id',
            },
          );

          final response = await route.onRequest(requestContext);

          expect(response.statusCode, equals(HttpStatus.badRequest));
          expect(
            response.json(),
            completion(
              equals(
                {
                  'error': 'tooLong',
                },
              ),
            ),
          );
        },
      );

      test(
        'returns bad request when no message is provided',
        () async {
          final now = DateTime.now();
          final session = ApiSession(
            user: const User(
              id: 'id',
              username: 'username',
              name: 'name',
            ),
            session: Session(
              id: '',
              token: '',
              userId: '',
              expiryDate: now,
              createdAt: now,
            ),
          );

          when(() => requestContext.read<ApiSession>()).thenReturn(session);
          when(() => request.json()).thenAnswer(
            (_) async => <String, dynamic>{
              'userId': 'id',
            },
          );

          final response = await route.onRequest(requestContext);

          expect(response.statusCode, equals(HttpStatus.badRequest));
        },
      );

      test(
        'returns bad request when no user id is provided',
        () async {
          final now = DateTime.now();
          final session = ApiSession(
            user: const User(
              id: 'id',
              username: 'username',
              name: 'name',
            ),
            session: Session(
              id: '',
              token: '',
              userId: '',
              expiryDate: now,
              createdAt: now,
            ),
          );

          when(() => requestContext.read<ApiSession>()).thenReturn(session);
          when(() => request.json()).thenAnswer(
            (_) async => <String, dynamic>{
              'message': 'message',
            },
          );

          final response = await route.onRequest(requestContext);

          expect(response.statusCode, equals(HttpStatus.badRequest));
        },
      );

      test(
        'returns forbidden when the user id is not the same of the session',
        () async {
          final now = DateTime.now();
          final session = ApiSession(
            user: const User(
              id: 'id',
              username: 'username',
              name: 'name',
            ),
            session: Session(
              id: '',
              token: '',
              userId: '',
              expiryDate: now,
              createdAt: now,
            ),
          );

          when(() => requestContext.read<ApiSession>()).thenReturn(session);
          when(() => request.json()).thenAnswer(
            (_) async => <String, dynamic>{
              'message': 'message',
              'userId': 'otherId',
            },
          );

          final response = await route.onRequest(requestContext);

          expect(response.statusCode, equals(HttpStatus.forbidden));
        },
      );

      test(
        'returns internal server error when it is an unknow error',
        () async {
          final now = DateTime.now();
          final session = ApiSession(
            user: const User(
              id: 'id',
              username: 'username',
              name: 'name',
            ),
            session: Session(
              id: '',
              token: '',
              userId: '',
              expiryDate: now,
              createdAt: now,
            ),
          );
          when(
            () => postRepository.createPost(
              userId: 'id',
              message: 'message',
            ),
          ).thenThrow(Exception('Error'));

          when(() => requestContext.read<ApiSession>()).thenReturn(session);
          when(() => request.json()).thenAnswer(
            (_) async => {
              'message': 'message',
              'userId': 'id',
            },
          );

          final response = await route.onRequest(requestContext);

          expect(response.statusCode, equals(HttpStatus.internalServerError));
          expect(
            response.json(),
            completion(
              equals(
                {
                  'error': 'unknown',
                },
              ),
            ),
          );
        },
      );
    });

    group('GET', () {
      setUp(() {
        when(() => request.method).thenReturn(HttpMethod.get);
      });

      test('returns a list of home posts', () async {
        final posts = List.generate(
          10,
          (index) => Post(
            id: 'id$index',
            userId: 'userId$index',
            message: 'message$index',
          ),
        );
        when(postRepository.listHomePosts).thenAnswer((_) async => posts);
        when(postRepository.listHomePosts).thenAnswer(
          (_) async => posts,
        );

        final response = await route.onRequest(requestContext);
        expect(
          response.json(),
          completion(
            equals(
              posts.map((e) => e.toJson()).toList(),
            ),
          ),
        );
      });
    });

    test(
      'returns 405 when the method is not allowed',
      () async {
        when(() => request.method).thenReturn(HttpMethod.put);
        final response = await route.onRequest(requestContext);

        expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
      },
    );
  });
}
