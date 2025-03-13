// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sign_in_anonymous_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignInAnonymousResponse _$PostSignInAnonymousResponseFromJson(
  Map<String, dynamic> json,
) => PostSignInAnonymousResponse(
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  session: Session.fromJson(json['session'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PostSignInAnonymousResponseToJson(
  PostSignInAnonymousResponse instance,
) => <String, dynamic>{'user': instance.user, 'session': instance.session};
