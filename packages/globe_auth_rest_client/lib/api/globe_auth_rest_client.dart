// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';

import 'root/root_client.dart';
import 'username/username_client.dart';
import 'anonymous/anonymous_client.dart';

/// Globe Auth `v1.1.0`.
///
/// API Reference for your Globe Auth.
class GlobeAuthRestClient {
  GlobeAuthRestClient(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '1.1.0';

  RootClient? _root;
  UsernameClient? _username;
  AnonymousClient? _anonymous;

  RootClient get root => _root ??= RootClient(_dio, baseUrl: _baseUrl);

  UsernameClient get username => _username ??= UsernameClient(_dio, baseUrl: _baseUrl);

  AnonymousClient get anonymous => _anonymous ??= AnonymousClient(_dio, baseUrl: _baseUrl);
}
