import 'dart:async';

import 'package:globe_auth_rest_client/src/state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'http_client.dart';
import 'models/session.dart';
import 'models/user.dart';

// TODO: Do records work for this? Or at least typedefs?

class GlobeAuthRestClient {
  GlobeAuthRestClient({required this.baseUrl, required this.client}) {
    // Sync the state as soon as we can.
    this
        .getSession()
        .then((result) {
          this._stateController.add(
            GlobeAuthStateAuthenticated(
              session: result.session,
              user: result.user,
            ),
          );
        })
        .catchError((_) {
          this._stateController.add(GlobeAuthStateUnauthenticated());
        });
  }

  final GlobeHttpClient client;
  final String baseUrl;

  /// Stream of the current state of the client.
  final StreamController<GlobeAuthState> _stateController =
      StreamController<GlobeAuthState>.broadcast()
        ..add(GlobeAuthStateLoading());

  Stream<GlobeAuthState> get state => _stateController.stream;

  /// Internal method to make a request to the API and return the JSON response.
  Future<Map<String, dynamic>> _request(
    Future<http.Response> Function() request,
  ) async {
    final response = await request();
    final json = jsonDecode(response.body);
    return Map<String, dynamic>.from(json);
  }

  Future<({bool redirect, String? url, String? token, User? user})>
  signInWithProvider() async {
    // TODO: body
    final json = await _request(
      () => client.post(
        Uri.parse('$baseUrl/sign-in/social'),
        // TODO
        body: jsonEncode({'provider': 'google'}),
      ),
    );

    return (
      redirect: json['redirect'] as bool,
      url: json['url'] == null ? null : json['url'] as String,
      token: json['token'] == null ? null : json['token'] as String,
      user: json['user'] == null ? null : User.fromJson(json['user']),
    );
  }

  Future<({Session session, User user})> getSession() async {
    final json = await _request(
      () => client.get(Uri.parse('$baseUrl/get-session')),
    );

    return (
      session: Session.fromJson(json['session']),
      user: User.fromJson(json['user']),
    );
  }

  Future<void> signOut() async {
    await _request(
      () => client.post(Uri.parse('$baseUrl/sign-out'), body: jsonEncode({})),
    );
  }

  Future<
    ({String id, String email, String name, String image, bool emailVerified})
  >
  signUpWithEmail({
    required String name,
    required String email,
    required String password,
    String? username,
  }) async {
    final json = await _request(
      () => client.post(
        Uri.parse('$baseUrl/sign-up/email'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          if (username != null) 'username': username,
        }),
      ),
    );

    return (
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      emailVerified: json['emailVerified'] as bool,
    );
  }

  Future<({bool redirect, String? url, User? user})> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final json = await _request(
      () => client.post(
        Uri.parse('$baseUrl/sign-in/email'),
        body: jsonEncode({'email': email, 'password': password}),
      ),
    );

    return (
      user: User.fromJson(json['user']),
      url: json['url'] == null ? null : json['url'] as String,
      redirect: json['redirect'] as bool,
    );
  }

  Future<void> ok() async {
    await _request(() => client.get(Uri.parse('$baseUrl/ok')));
  }
}
