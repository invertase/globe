// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/post_sign_in_anonymous_response.dart';

part 'anonymous_client.g.dart';

@RestApi()
abstract class AnonymousClient {
  factory AnonymousClient(Dio dio, {String? baseUrl}) = _AnonymousClient;

  /// Sign in anonymously
  @POST('/sign-in/anonymous')
  Future<PostSignInAnonymousResponse> postSignInAnonymous();
}
