// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'get_list_accounts_response.g.dart';

@JsonSerializable()
class GetListAccountsResponse {
  const GetListAccountsResponse({
    required this.id,
    required this.provider,
  });
  
  factory GetListAccountsResponse.fromJson(Map<String, Object?> json) => _$GetListAccountsResponseFromJson(json);
  
  final String id;
  final String provider;

  Map<String, Object?> toJson() => _$GetListAccountsResponseToJson(this);
}
