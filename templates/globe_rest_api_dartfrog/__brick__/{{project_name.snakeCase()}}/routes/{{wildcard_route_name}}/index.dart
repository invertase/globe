import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:api_domain/api_domain.dart';
import 'package:{{project_name.snakeCase()}}/models/models.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    HttpMethod.get => _onGet(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _onGet(RequestContext context) async {
  final postRepository = context.read<PostRepository>();

  final posts = await postRepository.listHomePosts();
  return Response.json(
    body: posts.map((post) => post.toJson()).toList(),
  );
}

Future<Response> _onPost(RequestContext context) async {
  final apiSession = context.read<ApiSession>();
  final postRepository = context.read<PostRepository>();

  final body = await context.request.json() as Map<String, dynamic>;

  final userId = body['userId'] as String?;
  final postMessage = body['message'] as String?;

  if (postMessage == null || userId == null) {
    return Response(statusCode: HttpStatus.badRequest);
  } else if (userId != apiSession.user.id) {
    return Response(statusCode: HttpStatus.forbidden);
  } else {
    try {
      final post = await postRepository.createPost(
        userId: apiSession.user.id,
        message: postMessage,
      );

      return Response.json(
        statusCode: HttpStatus.created,
        body: post.toJson(),
      );
    } on PostCreationFailure catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': e.reason.name},
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: {'error': 'unknown'},
      );
    }
  }
}
