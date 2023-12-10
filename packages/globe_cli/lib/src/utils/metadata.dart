import 'package:meta/meta.dart';

/// A data class containing the current project metadata.
@immutable
class GlobeMetadata {
  /// Creates a new [GlobeMetadata] instance.
  const GlobeMetadata({
    required this.endpoint,
    required bool isLocal,
  }) : _isLocal = isLocal;

  static const remote = GlobeMetadata(
    endpoint: 'https://globe.dev',
    isLocal: false,
  );

  static const local = GlobeMetadata(
    endpoint: 'http://127.0.0.1:8788',
    isLocal: true,
  );

  String get projectFileName =>
      _isLocal ? 'project.local.json' : 'project.json';

  String get sessionFileName =>
      _isLocal ? 'dart_globe_auth.local.json' : 'dart_globe_auth.json';

  /// The endpoint the CLI is currently used for API calls, links etc.
  final String endpoint;

  /// Whether the CLI is currently using a local API.
  final bool _isLocal;
}
