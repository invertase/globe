// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sign_in_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignInEmailResponse _$PostSignInEmailResponseFromJson(
  Map<String, dynamic> json,
) => PostSignInEmailResponse(
  user: json['user'],
  url: json['url'] as String,
  redirect: json['redirect'] as bool,
);

Map<String, dynamic> _$PostSignInEmailResponseToJson(
  PostSignInEmailResponse instance,
) => <String, dynamic>{
  'user': instance.user,
  'url': instance.url,
  'redirect': instance.redirect,
};
