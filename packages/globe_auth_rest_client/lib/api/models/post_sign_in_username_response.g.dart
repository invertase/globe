// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sign_in_username_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignInUsernameResponse _$PostSignInUsernameResponseFromJson(
  Map<String, dynamic> json,
) => PostSignInUsernameResponse(
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  session: Session.fromJson(json['session'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PostSignInUsernameResponseToJson(
  PostSignInUsernameResponse instance,
) => <String, dynamic>{'user': instance.user, 'session': instance.session};
