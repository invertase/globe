import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../utils/state.dart';
import 'api_service.dart';
import 'models/note.dart';

typedef UserEvent = ProviderEvent<User>;

class AuthProvider extends BaseProvider<User> {
  final FirebaseAuth _fireAuth;
  final ApiService _apiService;

  Note? _customer;
  Note? get customer => _customer;

  AuthProvider(this._fireAuth, this._apiService) {
    final user = _fireAuth.currentUser;
    if (user != null) _setUserToken(user);
  }

  Future<void> _setUserToken(User user) async {
    final userToken = await user.getIdToken();
    _apiService.setToken(userToken);

    addEvent(ProviderEvent.success(data: user));
  }

  Future<void> login(String email, String password) async {
    try {
      final result = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _setUserToken(result.user!);
    } on FirebaseAuthException catch (e) {
      addError(e.message!);
    } catch (e) {
      addError('An error occurred while signin in');
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final errMsg = e.message ?? 'An error occurred while creating account';
      addEvent(ProviderEvent.error(errorMessage: errMsg));
      return false;
    }

    addEvent(const ProviderEvent.idle());
    return true;
  }

  void logout() async {
    _apiService.setToken(null);
    await _fireAuth.signOut();
    addEvent(const ProviderEvent.idle());
  }
}
