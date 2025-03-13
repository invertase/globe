// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sign_in_social_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignInSocialResponse _$PostSignInSocialResponseFromJson(
  Map<String, dynamic> json,
) => PostSignInSocialResponse(
  session: json['session'] as String,
  user: json['user'],
  url: json['url'] as String,
  redirect: json['redirect'] as bool,
);

Map<String, dynamic> _$PostSignInSocialResponseToJson(
  PostSignInSocialResponse instance,
) => <String, dynamic>{
  'session': instance.session,
  'user': instance.user,
  'url': instance.url,
  'redirect': instance.redirect,
};
