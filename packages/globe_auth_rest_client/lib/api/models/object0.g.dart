// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object0.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Object0 _$Object0FromJson(Map<String, dynamic> json) => Object0(
  callbackUrl: json['callbackURL'] as String,
  newUserCallbackUrl: json['newUserCallbackURL'] as String,
  errorCallbackUrl: json['errorCallbackURL'] as String,
  provider: json['provider'] as String,
  disableRedirect: json['disableRedirect'] as String,
  idToken: json['idToken'] as String,
  scopes: json['scopes'] as String,
  requestSignUp: json['requestSignUp'] as String,
);

Map<String, dynamic> _$Object0ToJson(Object0 instance) => <String, dynamic>{
  'callbackURL': instance.callbackUrl,
  'newUserCallbackURL': instance.newUserCallbackUrl,
  'errorCallbackURL': instance.errorCallbackUrl,
  'provider': instance.provider,
  'disableRedirect': instance.disableRedirect,
  'idToken': instance.idToken,
  'scopes': instance.scopes,
  'requestSignUp': instance.requestSignUp,
};
