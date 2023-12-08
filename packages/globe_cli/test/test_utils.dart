import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:globe_cli/src/exit.dart';
import 'package:globe_cli/src/utils/open_url.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'io_overrides.dart';

class FakeProcessResult {
  FakeProcessResult._({
    required this.exitCode,
    required this.logs,
    required this.stdout,
    required this.stderr,
  });

  /// The exit code of the process.
  final Future<int> exitCode;

  /// A stream containing both stdout and stderr.
  final Stream<LogEntry> logs;

  /// A stream containing only stdout.
  final Stream<String> stdout;

  /// A stream containing only stderr.
  final Stream<String> stderr;

  /// The output of the process, split by lines.
  ///
  /// It contains both stdout and stderr.
  /// Stderrs have their lines prefixed with `err: `.
  ///
  /// This enables easy testing of the output of a process.
  late final testOutputByLines = logs.map((event) {
    return switch (event) {
      StdoutLogEntry() => event.message,
      StderrLogEntry() => 'err: ${event.message}',
    };
  }).transform(const LineSplitter());
}

class _HttpOverrides extends Fake implements HttpOverrides {}

/// Replaces the implementation of [exit] while executing [testFn].
///
/// The replacement will instead throw an [ExitException] and call
/// [onExit] with the exit code.
FakeProcessResult runWithIOOverrides(
  FutureOr<void> Function() testFn, {
  FileSystem? fs,
  // Disable ANSI by default to disable things like spinners & such, we are
  // hell to test.
  bool? supportaAnsiEscapes = false,
  // By default, we assume we are running in a terminal.
  bool? hasTerminal = true,
  void Function(int exitCode)? onExit,
  OpenUrlOverride? openUrl,
}) {
  Future<int> runProcess() async {
    final previousOnExit = onExit;
    var exitCodeResult = 0;
    try {
      exitOverride = (exitCode) {
        exitCodeResult = exitCode;
        onExit?.call(exitCode);
        throw ExitException();
      };
      await testFn();

      return exitCodeResult;
    } on ExitException {
      // Voluntary abort, not an actual error.
      return exitCodeResult;
    } finally {
      onExit = previousOnExit;
    }
  }

  final ioOverride = TestIOOverride(
    fs ?? MemoryFileSystem.test(),
    hasTerminal: hasTerminal,
    supportsAnsiEscapes: supportaAnsiEscapes,
  );
  addTearDown(ioOverride.close);
  final httpOverride = _HttpOverrides();

  return runZoned(
    zoneValues: {
      if (openUrl != null) openUrlZoneKey: openUrl,
    },
    () {
      return IOOverrides.runWithIOOverrides(
        () {
          return HttpOverrides.runWithHttpOverrides(
            () {
              final exitCode = runProcess();

              // Clean-up temporary streams once the process is done.
              exitCode.then((_) => ioOverride.close());

              return FakeProcessResult._(
                exitCode: exitCode,
                logs: ioOverride.logOverride,
                stdout: ioOverride.stdoutOverride,
                stderr: ioOverride.stderrOverride,
              );
            },
            httpOverride,
          );
        },
        ioOverride,
      );
    },
  );
}
