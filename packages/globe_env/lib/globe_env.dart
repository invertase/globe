library;

import 'dart:io';

import 'package:meta/meta.dart';

/// Environment variables available in Globe server environment
final class GlobeEnv {
  /// For testing purposes only
  static Map<String, String>? _testEnv;

  /// For testing purposes only
  @visibleForTesting
  static void setEnv(Map<String, String> env) {
    _testEnv = env;
  }

  /// For testing purposes only
  @visibleForTesting
  static void clearEnv() {
    _testEnv = null;
  }

  /// The environment variables
  static Map<String, String> get _env => _testEnv ?? Platform.environment;

  /// The port that the application should listen on
  static int get port => int.tryParse(_env['PORT'] ?? '8080') ?? 8080;

  /// Indicates if the application is running in Globe Runtime environment.
  static bool get isGlobeRuntime => _env['GLOBE'] == '1';

  /// The hostname of the deployed application in Globe
  static String? get hostname => _env['HOSTNAME'];

  /// Name of the cron job provided in the globe.yaml file
  static String? get cronName => _env['CRON_NAME'];

  /// The cron schedule code (e.g. * * * * *)
  static String? get cronSchedule => _env['CRON_SCHEDULE'];

  /// Unique identifier for the defined cron job
  static String? get cronId => _env['CRON_ID'];

  /// Unique identifier for the current running cron job
  static String? get cronEventId => _env['CRON_EVENT_ID'];

  /// The datasource API [Uri].
  static Uri? get datasource =>
      _env['GLOBE_DS_API'] != null ? Uri.parse(_env['GLOBE_DS_API']!) : null;
}
