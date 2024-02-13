import 'dart:async';
import 'dart:convert';

import 'package:eventsource/eventsource.dart';
import 'package:mason_logger/mason_logger.dart';

import 'api.dart';

enum BuildLogEventType {
  error,
  logs,
  unknown,
}

sealed class BuildLogEvent {
  const BuildLogEvent();

  factory BuildLogEvent.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'error':
        return ErrorBuildLogEvent.fromJson(json);
      case 'logs':
        return LogsBuildLogEvent.fromJson(json);
      default:
        return UnknownBuildLogEvent(json);
    }
  }
  BuildLogEventType get type;
}

class ErrorBuildLogEvent extends BuildLogEvent {
  ErrorBuildLogEvent({
    required this.error,
  });

  factory ErrorBuildLogEvent.fromJson(Map<String, dynamic> json) {
    return ErrorBuildLogEvent(
      error: json['error'] as String,
    );
  }
  @override
  final BuildLogEventType type = BuildLogEventType.error;
  final String error;
}

class LogsBuildLogEvent extends BuildLogEvent {
  LogsBuildLogEvent({
    required this.logs,
    this.done = false,
  });

  factory LogsBuildLogEvent.fromJson(Map<String, dynamic> json) {
    return LogsBuildLogEvent(
      done: json['done'] as bool? ?? false,
      logs: (json['logs'] as List<dynamic>)
          .map((e) => BuildLog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  @override
  final BuildLogEventType type = BuildLogEventType.logs;
  final List<BuildLog> logs;
  final bool done;
}

class UnknownBuildLogEvent extends BuildLogEvent {
  UnknownBuildLogEvent(this.payload);
  final Object payload;

  @override
  BuildLogEventType get type => BuildLogEventType.unknown;
}

class BuildLog {
  BuildLog({
    required this.stepId,
    required this.type,
    required this.state,
    required this.timestamp,
    required this.payload,
  });

  factory BuildLog.fromJson(Map<String, dynamic> json) {
    return BuildLog(
      stepId: json['stepId'] as String,
      type: json['type'] as String,
      state: json['state'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      payload: json['payload'] as String,
    );
  }

  final String stepId;
  final String type;
  final String state;
  final DateTime timestamp;
  final String payload;

  @override
  String toString() {
    return switch ((type, state)) {
      ('STATUS', 'START') => 'Starting $stepId',
      ('STATUS', 'SUCCESS') => '✅ $stepId',
      ('STATUS', 'FAILURE') => '❌ $stepId',
      ('PERF', _) => '🏁 $stepId took ${payload}ms\n${'=' * 40}',
      _ => payload,
    };
  }
}

Future<Stream<BuildLogEvent>> streamBuildLogs({
  required GlobeApi api,
  required String orgId,
  required String projectId,
  required String deploymentId,
}) async {
  final ctrl = StreamController<BuildLogEvent>.broadcast();

  final es = await EventSource.connect(
    '${api.metadata.endpoint}/api/orgs/$orgId/projects/$projectId/deployments/$deploymentId/build-logs',
    headers: api.headers,
  );

  es.listen((e) {
    if (e.data == null) {
      return;
    }

    final json = jsonDecode(e.data!) as Map<String, dynamic>;

    // The server emits a status event when a connection is established.
    if (json['status'] != null) {
      return;
    }

    final event = BuildLogEvent.fromJson(json);
    ctrl.add(event);
  });

  es.onError.listen((e) {
    ctrl.add(ErrorBuildLogEvent(error: e.toString()));
    ctrl.close();
  });

  return ctrl.stream;
}

Future<void> printLogs(Logger logger, Stream<BuildLogEvent> logs) async {
  await for (final event in logs) {
    printLog(logger, event);

    if (event case LogsBuildLogEvent(done: final done)) {
      if (done) {
        break;
      }
    }
  }
}

void printLog(Logger logger, BuildLogEvent log) {
  switch (log) {
    case ErrorBuildLogEvent(error: final error):
      logger.err(error);
    case LogsBuildLogEvent(logs: final logs):
      for (final log in logs) {
        logger.info(log.toString());
      }

    case UnknownBuildLogEvent(payload: final payload):
      logger.err('Unknown build log event: $payload');
  }
}
