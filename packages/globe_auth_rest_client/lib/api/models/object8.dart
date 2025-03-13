// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'object8.g.dart';

@JsonSerializable()
class Object8 {
  const Object8({
    required this.name,
    required this.image,
  });
  
  factory Object8.fromJson(Map<String, Object?> json) => _$Object8FromJson(json);
  
  /// The name of the user
  final String name;

  /// The image of the user
  final String image;

  Map<String, Object?> toJson() => _$Object8ToJson(this);
}
