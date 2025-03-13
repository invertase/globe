// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/object13.dart';
import '../models/post_sign_in_username_response.dart';

part 'username_client.g.dart';

@RestApi()
abstract class UsernameClient {
  factory UsernameClient(Dio dio, {String? baseUrl}) = _UsernameClient;

  /// Sign in with username.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/sign-in/username')
  Future<PostSignInUsernameResponse> postSignInUsername({
    @Body() required Object13 body,
  });
}
