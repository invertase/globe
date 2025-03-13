// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sign_up_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignUpEmailResponse _$PostSignUpEmailResponseFromJson(
  Map<String, dynamic> json,
) => PostSignUpEmailResponse(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  image: json['image'] as String,
  emailVerified: json['emailVerified'] as bool,
);

Map<String, dynamic> _$PostSignUpEmailResponseToJson(
  PostSignUpEmailResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'image': instance.image,
  'emailVerified': instance.emailVerified,
};
