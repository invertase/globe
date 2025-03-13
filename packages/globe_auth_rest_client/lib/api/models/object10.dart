// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object10.g.dart';

@JsonSerializable()
class Object10 {
  const Object10({
    required this.token,
  });
  
  factory Object10.fromJson(Map<String, Object?> json) => _$Object10FromJson(json);
  
  final String token;

  Map<String, Object?> toJson() => _$Object10ToJson(this);
}
