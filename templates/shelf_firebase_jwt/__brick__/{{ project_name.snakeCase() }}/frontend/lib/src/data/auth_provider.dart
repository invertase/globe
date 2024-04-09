import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../utils/state.dart';
import 'api_service.dart';
import 'models/user.dart';

typedef UserEvent = ProviderEvent<AuthUser>;

class AuthProvider extends BaseProvider<AuthUser> {
  final FirebaseAuth _fireAuth;
  final ApiService _apiService;

  AuthUser? _customer;
  AuthUser? get customer => _customer;

  AuthProvider(this._fireAuth, this._apiService) {
    final user = _fireAuth.currentUser;
    if (user != null) _resolveToken(user);
  }

  Future<void> getUser() async {
    final user = await safeRun(() => _apiService.getUser());
    if (user == null) return;

    addEvent(ProviderEvent.success(data: user));
  }

  Future<void> _resolveToken(User user) async {
    addEvent(const ProviderEvent.loading());

    final token = await user.getIdToken();
    _apiService.setToken(token!);
    await getUser();
  }

  Future<void> login(String email, String password) async {
    try {
      final result = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _resolveToken(result.user!);
    } on FirebaseAuthException catch (e) {
      return addEvent(ProviderEvent.error(errorMessage: e.message));
    } catch (e) {
      addError('An error occurred while signin in');
      return;
    }

    final user = await safeRun(() => _apiService.getUser());
    if (user == null) {
      logout();
      addError('An error occurred while fetching user');
      return;
    }

    addEvent(ProviderEvent.success(data: user));
  }

  Future<bool> register(
    String displayName,
    String email,
    String password,
  ) async {
    final success = await safeRun(
        () => _apiService.registerUser(displayName, email, password));
    if (success != true) return false;

    addEvent(const ProviderEvent.idle());
    return true;
  }

  void logout() async {
    _apiService.setToken(null);
    await _fireAuth.signOut();
    addEvent(const ProviderEvent.idle());
  }
}
