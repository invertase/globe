import 'dart:io';

import 'package:globe_cli/src/command_runner.dart';
import 'package:globe_cli/src/exit.dart';
import 'package:globe_cli/src/utils/http_server.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

Future<void> main(
  List<String> args, {
  PubUpdater? pubUpdater,
  GlobeHttpServer? httpServer,
}) async {
  await _flushThenExit(
    await GlobeCliCommandRunner(
      pubUpdater: pubUpdater,
      httpServer: httpServer,
    ).run(args),
  );
}

Future<void> _flushThenExit(int status) async {
  try {
    await Future.wait<void>([stdout.close(), stderr.close()]);
    exitOverride(status);
  } on ExitException {
    rethrow;
  } catch (_) {
    exitOverride(ExitCode.software.code);
  }
}
