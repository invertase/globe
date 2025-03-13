// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'post_sign_out_response.g.dart';

@JsonSerializable()
class PostSignOutResponse {
  const PostSignOutResponse({
    required this.success,
  });
  
  factory PostSignOutResponse.fromJson(Map<String, Object?> json) => _$PostSignOutResponseFromJson(json);
  
  final bool success;

  Map<String, Object?> toJson() => _$PostSignOutResponseToJson(this);
}
