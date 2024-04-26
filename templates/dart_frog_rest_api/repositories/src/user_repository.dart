import 'dart:convert';

import 'package:crypto/crypto.dart';
import '../../services/db_client.dart';
import '../../models/models.dart';

/// Exception thrown when a user tries to sign up with a username
class UserAlreadyExistsException implements Exception {}

/// {@template user_repository}
/// API's user repository.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  const UserRepository({required DbClient dbClient}) : _dbClient = dbClient;

  final DbClient _dbClient;

  static const _tableName = 'users';

  String _hashValue(String value) {
    return sha256.convert(utf8.encode(value)).toString();
  }

  /// Creates a new user with the provided [username] and [password].
  ///
  /// Password should be informed in a raw state, it will be hashed
  /// before being stored.
  ///
  /// Throws a [UserAlreadyExistsException] if a user with the
  /// provided [username] already exists.
  Future<User> createUser({
    required String username,
    required String name,
    required String password,
  }) async {
    final existingUser = await findByUsername(username);

    if (existingUser != null) {
      throw UserAlreadyExistsException();
    }

    final data = {
      'username': username,
      'name': name,
      'password': _hashValue(password),
    };

    final id = await _dbClient.add(_tableName, data);

    return User(
      id: id,
      username: username,
      name: name,
    );
  }

  /// Returns a [User] with the provided [username].
  Future<User?> findByUsername(String username) async {
    final result = await _dbClient.findByField(
      _tableName,
      'username',
      username,
    );

    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    }

    return null;
  }

  /// Returns a [User] that matches the provided [username] and plain
  /// [password].
  ///
  /// Password will be hashed before being compared to the stored value.
  Future<User?> findByUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    final hash = _hashValue(password);
    final result = await _dbClient.findByField(
      _tableName,
      'username',
      username,
    );

    if (result.isNotEmpty && result.first['password'] == hash) {
      return User.fromJson(result.first);
    }

    return null;
  }

  /// Returns a [User] that matches the provided [id].
  Future<User?> findUserById(String id) async {
    final data = await _dbClient.getById(_tableName, id);

    if (data != null) {
      return User.fromJson(data);
    }

    return null;
  }
}
