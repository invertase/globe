# Globe Auth Rest Client

A HTTP REST client for interacting with the Globe Auth API.

## Usage

Create a new `GlobeAuthRestClient` instance:

```dart
import 'package:globe_auth_rest_client/globe_auth_rest_client.dart';
import 'package:http/http.dart' as http;

void main() async {
  final client = GlobeAuthRestClient(
    baseUrl: 'https://auth.globe.dev', // optional base url of the auth instance (e.g. change to localhost for testing)
    client: GlobeHttpClient(
      http.Client(), // base http client to use
      projectId: '...', // globe project id for the auth instance
      publicKey: '...', // public JWT for the auth instance from the dashboard
      getAccessToken: () async {
        // custom implementation to get the user's access token
        // e.g. on Flutter, use shared prefs / key-chain etc
        // on web, it will use cookies by default
      },
      setAccessToken: (token) async {
        // store the access token
      }
    ),
  );

  // Call the Auth API
  await client.ok();
}
```