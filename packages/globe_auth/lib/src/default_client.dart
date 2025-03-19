import 'package:flutter/foundation.dart';
import 'package:globe_auth_rest_client/globe_auth_rest_client.dart';
import 'package:native_storage/native_storage.dart';
import 'http_client/http_client.dart'
    if (dart.library.js_interop) 'http_client/http_client.web.dart';

final _storage = NativeStorage().secure.isolated;

const _tokenKey = 'globe_auth_token';

GlobeAuthRestClient getDefaultRestClient(
  String projectId, {
  required String publicKey,
  String? baseUrl,
}) {
  return GlobeAuthRestClient(
    baseUrl: baseUrl ?? 'https://auth.globe.dev',
    client: GlobeHttpClient(
      getHttpClient(),
      projectId: projectId,
      publicKey: publicKey,
      getAccessToken: () async {
        if (kIsWeb) {
          // ignore - web uses cookies by default.
          return null;
        } else {
          return await _storage.read(_tokenKey);
        }
      },
      setAccessToken: (token) async {
        if (kIsWeb) {
          // ignore - web uses cookies by default.
        } else {
          await _storage.write(_tokenKey, token);
        }
      },
      getUserAgent: () async {
        if (kIsWeb) {
          return null;
        } else {
          // TODO: Get a good user agent for the platforms
          // Android 12.3 Pixel 6
          // iOS 15.5 iPhone 13 Pro
          return 'Native Device';
        }
      },
    ),
  );
}
