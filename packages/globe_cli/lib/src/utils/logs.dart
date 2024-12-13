import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';

import 'api.dart';
import 'rpc.dart';

enum BuildLogEventType {
  error,
  logs,
  unknown,
}

class GetBuildLogsParams {
  final String buildId;

  const GetBuildLogsParams(this.buildId);

  Map<String, dynamic> toJson() {
    return {
      'buildId': buildId,
    };
  }
}

class GetBuildLogs extends MethodCall<GetBuildLogsParams> with JsonParams {
  @override
  final String method = 'getBuildLogs';
  @override
  final GetBuildLogsParams params;

  GetBuildLogs(this.params);
}

sealed class BuildLogEvent {
  const BuildLogEvent();

  factory BuildLogEvent.fromRPCResponse(RPCResponse response) {
    switch (response) {
      case SuccessResponseWithResult(result: final result):
        return BuildLogs.fromJson(result as List);
      case DoneResponse():
        return BuildLogs([], done: true);
      case ErrorResponse(error: final error):
        return BuildLogsError(error: '[${error.code}]: ${error.message}');
    }
  }
  BuildLogEventType get type;
}

class BuildLogsError extends BuildLogEvent {
  BuildLogsError({
    required this.error,
  });

  factory BuildLogsError.fromJson(Map<String, dynamic> json) {
    return BuildLogsError(
      error: json['error'] as String,
    );
  }
  @override
  final BuildLogEventType type = BuildLogEventType.error;
  final String error;
}

class BuildLogs extends BuildLogEvent {
  BuildLogs(this.items, {this.done = false});

  factory BuildLogs.fromJson(List<dynamic> json) {
    return BuildLogs(
      json.map((e) => BuildLog.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
  @override
  final BuildLogEventType type = BuildLogEventType.logs;
  final List<BuildLog> items;
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
  required String buildId,
}) async {
  final host = Uri.parse(api.metadata.endpoint).host;
  final ctrl = StreamController<BuildLogEvent>.broadcast();

  final ws = await WebSocket.connect(
    'wss://$host/api/realtime/$orgId',
    headers: api.headers,
  );

  ws.listen((e) {
    final json = jsonDecode(e as String) as Map<String, dynamic>;
    final res = RPCResponse.fromJson(json);
    final event = BuildLogEvent.fromRPCResponse(res);

    ctrl.add(event);
  });

  final params = GetBuildLogsParams(buildId);
  final method = GetBuildLogs(params);
  final message = jsonEncode(method.toJson());

  ws.add(message);

  unawaited(ws.done.then((_) => ctrl.close()));

  ctrl.onCancel = () {
    ws.close();
    ctrl.close();
  };

  return ctrl.stream;
}

Future<void> printLogs(Logger logger, Stream<BuildLogEvent> logs) async {
  await for (final event in logs) {
    printLog(logger, event);

    if (event case BuildLogs(done: final done)) {
      if (done) {
        break;
      }
    }
  }
}

void printLog(Logger logger, BuildLogEvent log) {
  switch (log) {
    case BuildLogsError(error: final error):
      logger.err(error);
    case BuildLogs(items: final logs):
      for (final log in logs) {
        logger.info(log.toString());
      }

    case UnknownBuildLogEvent(payload: final payload):
      logger.err('Unknown build log event: $payload');
  }
}
