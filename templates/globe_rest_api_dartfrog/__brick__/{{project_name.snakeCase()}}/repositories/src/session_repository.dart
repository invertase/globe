import 'dart:convert';

import 'package:crypto/crypto.dart';
import '../../services/db_client.dart';
import '../models/models.dart';

/// {@template session_repository}
/// Repository which manages sessions.
/// {@endtemplate}
class SessionRepository {
  /// {@macro session_repository}
  ///
  /// The [now] function is used to get the current date and time.
  const SessionRepository({
    required DbClient dbClient,
    DateTime Function()? now,
  })  : _dbClient = dbClient,
        _now = now ?? DateTime.now;

  final DateTime Function() _now;

  final DbClient _dbClient;

  String _hashValue(String value) {
    return sha256.convert(utf8.encode(value)).toString();
  }

  /// Creates a new session for the user with the given [userId].
  Future<Session> createSession(String userId) async {
    final now = _now();
    final token = _hashValue('${userId}_${now.toIso8601String()}');
    final expiryDate = now.add(const Duration(days: 1));
    final createdAt = now;

    final id = await _dbClient.add('sessions', {
      'token': token,
      'userId': userId,
      'expiryDate': expiryDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    });

    final session = Session(
      id: id,
      token: _hashValue('${userId}_${now.toIso8601String()}'),
      userId: userId,
      expiryDate: now.add(const Duration(days: 1)),
      createdAt: now,
    );

    return session;
  }

  /// Searches and return a session by its [token].
  ///
  /// If the session is not found or is expired, returns `null`.
  Future<Session?> sessionFromToken(String token) async {
    final sessions = await _dbClient.findByField('sessions', 'token', token);

    if (sessions.isNotEmpty) {
      final session = Session.fromJson(sessions.first);
      if (session.expiryDate.isBefore(_now())) {
        await _dbClient.deleteById('sessions', session.id);
      } else {
        return session;
      }
    }

    return null;
  }
}
