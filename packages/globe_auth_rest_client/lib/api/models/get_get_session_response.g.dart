// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_get_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGetSessionResponse _$GetGetSessionResponseFromJson(
  Map<String, dynamic> json,
) => GetGetSessionResponse(
  session: Session.fromJson(json['session'] as Map<String, dynamic>),
  user: User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetGetSessionResponseToJson(
  GetGetSessionResponse instance,
) => <String, dynamic>{'session': instance.session, 'user': instance.user};
