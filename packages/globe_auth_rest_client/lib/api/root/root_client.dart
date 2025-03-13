// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/get_get_session_response.dart';
import '../models/get_list_accounts_response.dart';
import '../models/get_list_sessions_response.dart';
import '../models/get_ok_response.dart';
import '../models/get_reset_password_token_response.dart';
import '../models/get_verify_email_response.dart';
import '../models/object0.dart';
import '../models/object1.dart';
import '../models/object10.dart';
import '../models/object11.dart';
import '../models/object12.dart';
import '../models/object2.dart';
import '../models/object3.dart';
import '../models/object4.dart';
import '../models/object5.dart';
import '../models/object6.dart';
import '../models/object7.dart';
import '../models/object8.dart';
import '../models/object9.dart';
import '../models/post_change_email_response.dart';
import '../models/post_change_password_response.dart';
import '../models/post_forget_password_response.dart';
import '../models/post_link_social_response.dart';
import '../models/post_reset_password_response.dart';
import '../models/post_revoke_other_sessions_response.dart';
import '../models/post_revoke_sessions_response.dart';
import '../models/post_send_verification_email_response.dart';
import '../models/post_sign_in_email_response.dart';
import '../models/post_sign_in_social_response.dart';
import '../models/post_sign_out_response.dart';
import '../models/post_sign_up_email_response.dart';
import '../models/post_update_user_response.dart';

part 'root_client.g.dart';

@RestApi()
abstract class RootClient {
  factory RootClient(Dio dio, {String? baseUrl}) = _RootClient;

  /// Sign in with a social provider.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/sign-in/social')
  Future<PostSignInSocialResponse> postSignInSocial({
    @Body() required Object0 body,
  });

  /// Get the current session
  @GET('/get-session')
  Future<GetGetSessionResponse> getGetSession();

  /// Sign out the current user
  @POST('/sign-out')
  Future<PostSignOutResponse> postSignOut({
    @Body() dynamic body,
  });

  /// Sign up a user using email and password.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/sign-up/email')
  Future<PostSignUpEmailResponse> postSignUpEmail({
    @Body() Object1? body,
  });

  /// Sign in with email and password.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/sign-in/email')
  Future<PostSignInEmailResponse> postSignInEmail({
    @Body() required Object2 body,
  });

  /// Send a password reset email to the user.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/forget-password')
  Future<PostForgetPasswordResponse> postForgetPassword({
    @Body() required Object3 body,
  });

  /// Reset the password for a user.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/reset-password')
  Future<PostResetPasswordResponse> postResetPassword({
    @Body() required Object4 body,
  });

  /// Verify the email of the user
  @GET('/verify-email')
  Future<GetVerifyEmailResponse> getVerifyEmail({
    @Query('token') String? token,
    @Query('callbackURL') String? callbackUrl,
  });

  /// Send a verification email to the user.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/send-verification-email')
  Future<PostSendVerificationEmailResponse> postSendVerificationEmail({
    @Body() Object5? body,
  });

  /// [body] - Name not received and was auto-generated.
  @POST('/change-email')
  Future<PostChangeEmailResponse> postChangeEmail({
    @Body() required Object6 body,
  });

  /// Change the password of the user.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/change-password')
  Future<PostChangePasswordResponse> postChangePassword({
    @Body() required Object7 body,
  });

  /// Update the current user.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/update-user')
  Future<PostUpdateUserResponse> postUpdateUser({
    @Body() Object8? body,
  });

  /// Delete the user.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/delete-user')
  Future<dynamic> postDeleteUser({
    @Body() required Object9 body,
  });

  /// Redirects the user to the callback URL with the token
  @GET('/reset-password/{token}')
  Future<GetResetPasswordTokenResponse> getResetPasswordToken({
    @Query('callbackURL') String? callbackUrl,
  });

  /// List all active sessions for the user
  @GET('/list-sessions')
  Future<List<GetListSessionsResponse>> getListSessions();

  /// Revoke a single session.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/revoke-session')
  Future<void> postRevokeSession({
    @Body() Object10? body,
  });

  /// Revoke all sessions for the user
  @POST('/revoke-sessions')
  Future<PostRevokeSessionsResponse> postRevokeSessions({
    @Body() dynamic body,
  });

  /// Revoke all other sessions for the user except the current one
  @POST('/revoke-other-sessions')
  Future<PostRevokeOtherSessionsResponse> postRevokeOtherSessions({
    @Body() dynamic body,
  });

  /// Link a social account to the user.
  ///
  /// [body] - Name not received and was auto-generated.
  @POST('/link-social')
  Future<PostLinkSocialResponse> postLinkSocial({
    @Body() required Object11 body,
  });

  /// List all accounts linked to the user
  @GET('/list-accounts')
  Future<List<GetListAccountsResponse>> getListAccounts();

  @GET('/delete-user/callback')
  Future<void> getDeleteUserCallback({
    @Query('token') String? token,
    @Query('callbackURL') String? callbackUrl,
  });

  /// [body] - Name not received and was auto-generated.
  @POST('/unlink-account')
  Future<void> postUnlinkAccount({
    @Body() required Object12 body,
  });

  /// Check if the API is working
  @GET('/ok')
  Future<GetOkResponse> getOk();

  /// Displays an error page
  @GET('/error')
  Future<String> getError();
}
