// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_change_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostChangePasswordResponse _$PostChangePasswordResponseFromJson(
  Map<String, dynamic> json,
) => PostChangePasswordResponse(
  user: User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PostChangePasswordResponseToJson(
  PostChangePasswordResponse instance,
) => <String, dynamic>{'user': instance.user};
