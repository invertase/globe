// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object0.g.dart';

@JsonSerializable()
class Object0 {
  const Object0({
    required this.callbackUrl,
    required this.newUserCallbackUrl,
    required this.errorCallbackUrl,
    required this.provider,
    required this.disableRedirect,
    required this.idToken,
    required this.scopes,
    required this.requestSignUp,
  });
  
  factory Object0.fromJson(Map<String, Object?> json) => _$Object0FromJson(json);
  
  /// Callback URL to redirect to after the user has signed in
  @JsonKey(name: 'callbackURL')
  final String callbackUrl;
  @JsonKey(name: 'newUserCallbackURL')
  final String newUserCallbackUrl;

  /// Callback URL to redirect to if an error happens
  @JsonKey(name: 'errorCallbackURL')
  final String errorCallbackUrl;

  /// OAuth2 provider to use
  final String provider;

  /// Disable automatic redirection to the provider. Useful for handling the redirection yourself
  final String disableRedirect;

  /// ID token from the provider to sign in the user with id token
  final String idToken;

  /// Array of scopes to request from the provider. This will override the default scopes passed.
  final String scopes;

  /// Explicitly request sign-up. Useful when disableImplicitSignUp is true for this provider
  final String requestSignUp;

  Map<String, Object?> toJson() => _$Object0ToJson(this);
}
