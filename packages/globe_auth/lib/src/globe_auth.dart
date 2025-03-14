import 'dart:async';
import 'dart:convert';

import 'package:globe_auth_rest_client/globe_auth_rest_client.dart';
import 'package:dio/dio.dart';

class GlobeAuthTokenInterceptor extends Interceptor {
  final StreamController<String> _token = StreamController<String>.broadcast();
  Stream<String> get token => _token.stream;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final authToken = response.headers['set-auth-token'];

    if (authToken != null && authToken.isNotEmpty && authToken.length == 1) {
      _token.add(authToken[0]);
    }

    handler.next(response);
  }
}

final class GlobeAuth {
  final GlobeAuthRestClient _client;

  final StreamController<GlobeAuthSession> _session =
      StreamController<GlobeAuthSession>.broadcast();

  GlobeAuth({required Dio client}) : _client = GlobeAuthRestClient(client) {
    // Attempt to load the session ASAP when the client is created.
    _syncSession();
  }

  void _syncNullSession() {
    _session.add(GlobeAuthSessionLoaded(null));
  }

  void _syncSession([Session? session]) {
    if (session != null) {
      _session.add(GlobeAuthSessionLoaded(session));
      return;
    }

    _client.root
        .getGetSession()
        .then((response) {
          _session.add(GlobeAuthSessionLoaded(response.session));
        })
        .catchError((_) {
          // Probably no session is available.
          // TODO: Makes sense to check for a specific error here.
          _session.add(GlobeAuthSessionLoaded(null));
        });
  }

  Future<({Session session, User user})> getSession() async {
    final result = await guard(() => _client.root.getGetSession());
    _syncSession(result.session);
    return (session: result.session, user: result.user);
  }

  Future<void> signOut() async {
    await guard(() => _client.root.postSignOut());
    _syncNullSession();
  }

  Future<({String token, User user, bool redirect, String? url})>
  signInWithEmail({required String email, required String password}) async {
    final result = await guard(
      () => _client.root.postSignInEmail(
        body: Object2(
          email: email,
          password: password,
          callbackUrl: '',
          rememberMe: 'false',
        ),
      ),
    );

    throw UnimplementedError();
  }
}

sealed class GlobeAuthSession {
  const GlobeAuthSession();
}

final class GlobeAuthSessionLoading extends GlobeAuthSession {
  const GlobeAuthSessionLoading();
}

final class GlobeAuthSessionLoaded extends GlobeAuthSession {
  const GlobeAuthSessionLoaded(this.session);
  final Session? session;
}

// Generic guard function that catches any errors that might occur.
Future<T> guard<T>(Future<T> Function() fn) async {
  try {
    return await fn();
  } on DioException catch (e) {
    if (e.response == null) {
      rethrow;
    }

    final json = jsonDecode(e.response!.data);
    throw GlobeAuthError(json['message'], json['code']);
  } catch (e) {
    print(e);
    rethrow;
  }
}

// TODO: Probs need to be a sealed class.
final class GlobeAuthError extends Error {
  GlobeAuthError(this.message, this.code);
  final String message;
  final String code;
}
