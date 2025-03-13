// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_sessions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListSessionsResponse _$GetListSessionsResponseFromJson(
  Map<String, dynamic> json,
) => GetListSessionsResponse(
  token: json['token'] as String,
  userId: json['userId'] as String,
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$GetListSessionsResponseToJson(
  GetListSessionsResponse instance,
) => <String, dynamic>{
  'token': instance.token,
  'userId': instance.userId,
  'expiresAt': instance.expiresAt,
};
