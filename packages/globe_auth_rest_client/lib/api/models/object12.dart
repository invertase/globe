// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object12.g.dart';

@JsonSerializable()
class Object12 {
  const Object12({
    required this.providerId,
  });
  
  factory Object12.fromJson(Map<String, Object?> json) => _$Object12FromJson(json);
  
  final String providerId;

  Map<String, Object?> toJson() => _$Object12ToJson(this);
}
