import 'package:globe_auth_rest_client/globe_auth_rest_client.dart';
import 'package:http/http.dart' as http;

void main() async {
  final client = GlobeAuthRestClient(
    baseUrl: 'https://auth.globe.dev',
    client: GlobeHttpClient(
      http.Client(),
      projectId: '123456789',
      publicKey: 'todo-jwt',
      getAccessToken: () async {
        // if android, get from shared preferences
        // if ios, get from keychain
        // if web, ignore as its session cookie
        return null;
      },
      setAccessToken: (token) async {
        // if android, save to shared preferences
        // if ios, save to keychain
        // if web, ignore as we use a session cookie
      },
    ),
  );

  await client.getOk(); 
}
