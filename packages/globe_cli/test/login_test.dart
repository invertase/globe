import 'dart:io';

import 'package:file_testing/file_testing.dart';
import 'package:get_it/get_it.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../bin/globe.dart' as globe;
import 'mocks.dart';
import 'test_utils.dart';
import 'workspace.dart';

void main() {
  setUp(() => GetIt.I.reset());

  test('Does nothing if already logged in', () async {
    final workspace = TestWorkspace()..setRemoteAuthFile('{"jwt":"123"}');
    final pubUpdater = PubUpdaterMock(isUpToDate: () async => true);

    final result = runWithIOOverrides(
      fs: workspace.fs,
      () => globe.main(['login'], pubUpdater: pubUpdater),
    );

    await expectLater(
      result.testOutputByLines,
      emitsInOrder(['You are already logged in.', emitsDone]),
    );

    await expectLater(
      result.exitCode,
      completion(ExitCode.success.code),
    );
  });

  group('If logged out, opens a tab in the browser to login', () {
    test('if login succeeds, save token in file', () async {
      final workspace = TestWorkspace();
      final pubUpdater = PubUpdaterMock(isUpToDate: () async => true);
      final openUrlMock = OpenUrlMock(
        openUrl: (url) async => Process.run('ls', []),
      );
      final globeHttpServer = GlobeHttpServerMock(
        getSessionToken: ({onConnected, logger}) async {
          onConnected?.call(4242);
          return 'my-token';
        },
      );

      final result = runWithIOOverrides(
        fs: workspace.fs,
        openUrl: openUrlMock.call,
        () => globe.main(
          ['login'],
          pubUpdater: pubUpdater,
          httpServer: globeHttpServer,
        ),
      );

      await expectLater(
        result.testOutputByLines,
        emitsInOrder([
          'Please authenticate via the opened browser window.',
          'Successfully logged in.',
          emitsDone,
        ]),
      );

      verify(
        openUrlMock(
          'https://globe.dev/login/cli?callback=http://localhost:4242/callback?strategy=redirect',
        ),
      ).called(1);
      verifyNoMoreInteractions(openUrlMock);

      await expectLater(
        result.exitCode,
        completion(ExitCode.success.code),
      );

      expect(
        workspace.remoteAuthFile.readAsStringSync(),
        '{"jwt":"my-token"}',
      );
    });

    test('if login fails, print error message', () async {
      final workspace = TestWorkspace();
      final pubUpdater = PubUpdaterMock(isUpToDate: () async => true);
      final openUrlMock = OpenUrlMock(
        openUrl: (url) async => Process.run('ls', []),
      );
      final globeHttpServer = GlobeHttpServerMock(
        // Return null because login failed
        getSessionToken: ({onConnected, logger}) async {
          onConnected?.call(4242);
          return null;
        },
      );

      final result = runWithIOOverrides(
        fs: workspace.fs,
        openUrl: openUrlMock.call,
        () => globe.main(
          ['login'],
          pubUpdater: pubUpdater,
          httpServer: globeHttpServer,
        ),
      );

      await expectLater(
        result.testOutputByLines,
        emitsInOrder([
          'Please authenticate via the opened browser window.',
          'err: Failed to login.',
          emitsDone,
        ]),
      );

      verify(
        openUrlMock(
          'https://globe.dev/login/cli?callback=http://localhost:4242/callback?strategy=redirect',
        ),
      ).called(1);
      verifyNoMoreInteractions(openUrlMock);

      await expectLater(
        result.exitCode,
        completion(ExitCode.software.code),
      );

      expect(
        workspace.remoteAuthFile,
        isNot(exists),
      );
    });
  });
}
