import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import 'error.dart';
import 'metadata.dart';

/// A utility class for managing the user's authentication session.
class GlobeAuth {
  GlobeAuth(this._metadata);

  @visibleForTesting
  static const applicationName = 'dart_globe';

  File? get _sessionFile {
    final localConfigDir = _localConfigDir;
    if (localConfigDir == null) return null;

    return File(p.join(localConfigDir, _metadata.sessionFileName));
  }

  /// The current session, or `null` if the user is not logged in.
  GlobeSession? get currentSession => _session;
  GlobeSession? _session;

  /// The path to the local configuration directory.
  late final String? _localConfigDir = runOrNull(
    () => applicationConfigHome(applicationName),
  );

  final GlobeMetadata _metadata;

  /// Logs the user in with the given [jwt].
  ///
  /// Note this is still validated on the server side.
  void login({required String jwt}) {
    final session = _session = GlobeSession(jwt: jwt);
    _flushSession(session);
  }

  /// Clears the local session.
  void logout() {
    _session = null;

    final sessionFile = _sessionFile;
    if (sessionFile != null && sessionFile.existsSync()) {
      sessionFile.deleteSync(recursive: true);
    }
  }

  /// Attempts to load the session from the local configuration directory.
  void loadSession() {
    final sessionFile = _sessionFile;
    if (sessionFile != null && sessionFile.existsSync()) {
      try {
        final contents = sessionFile.readAsStringSync();
        _session = GlobeSession.fromJson(
          json.decode(contents) as Map<String, dynamic>,
        );
      } catch (_) {}
    }
  }

  /// Flushes the given [session] to the local configuration directory.
  void _flushSession(GlobeSession session) {
    _sessionFile
      ?..createSync(recursive: true)
      ..writeAsStringSync(json.encode(session.toJson()));
  }
}

/// A data class representing a user's authentication session.
class GlobeSession {
  /// Creates a session with the given [jwt].
  const GlobeSession({required this.jwt});

  /// Creates a session from the given [json] object.
  factory GlobeSession.fromJson(Map<String, Object?> json) {
    return switch (json) {
      {'jwt': final String jwt} => GlobeSession(jwt: jwt),
      _ => throw ArgumentError(),
    };
  }

  /// The users JWT token, used for authentication via the API.
  final String jwt;

  /// Converts this session to a JSON object.
  Map<String, dynamic> toJson() => {'jwt': jwt};
}
