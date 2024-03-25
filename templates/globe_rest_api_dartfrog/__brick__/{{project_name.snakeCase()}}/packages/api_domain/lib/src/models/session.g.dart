// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as String,
      token: json['token'] as String,
      userId: json['userId'] as String,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'userId': instance.userId,
      'expiryDate': instance.expiryDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
