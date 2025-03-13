// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
  token: json['token'] as String,
  userId: json['userId'] as String,
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
  'token': instance.token,
  'userId': instance.userId,
  'expiresAt': instance.expiresAt,
};
