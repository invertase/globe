import 'package:file_testing/file_testing.dart';
import 'package:get_it/get_it.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';

import '../bin/globe.dart' as globe;
import 'mocks.dart';
import 'test_utils.dart';
import 'workspace.dart';

void main() {
  setUp(() => GetIt.I.reset());

  test('Does nothing if already logged out', () async {
    final workspace = TestWorkspace();
    final pubUpdater = PubUpdaterMock(isUpToDate: () async => true);

    final result = runWithIOOverrides(
      fs: workspace.fs,
      () => globe.main(['logout'], pubUpdater: pubUpdater),
    );

    await expectLater(
      result.testOutputByLines,
      emitsInOrder(['You are already logged out.', emitsDone]),
    );

    await expectLater(
      result.exitCode,
      completion(ExitCode.success.code),
    );

    expect(
      workspace.remoteAuthFile,
      isNot(exists),
    );
  });

  test('If logged in, delete the token file', () async {
    final workspace = TestWorkspace()..setRemoteAuthFile('{"jwt":"123"}');
    final pubUpdater = PubUpdaterMock(isUpToDate: () async => true);

    final result = runWithIOOverrides(
      fs: workspace.fs,
      () => globe.main(['logout'], pubUpdater: pubUpdater),
    );

    await expectLater(
      result.testOutputByLines,
      emitsInOrder(['✓ Logging out.', emitsDone]),
    );

    await expectLater(
      result.exitCode,
      completion(ExitCode.success.code),
    );

    expect(
      workspace.remoteAuthFile,
      isNot(exists),
    );
  });
}
