// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'get_ok_response.g.dart';

@JsonSerializable()
class GetOkResponse {
  const GetOkResponse({
    required this.ok,
  });
  
  factory GetOkResponse.fromJson(Map<String, Object?> json) => _$GetOkResponseFromJson(json);
  
  final bool ok;

  Map<String, Object?> toJson() => _$GetOkResponseToJson(this);
}
