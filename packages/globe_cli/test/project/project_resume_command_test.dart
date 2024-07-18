import 'package:get_it/get_it.dart';
import 'package:globe_cli/src/utils/api.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks.dart';
import '../test_utils.dart';
import '../workspace.dart';
import '../../bin/globe.dart' as globe;

void main() {
  setUp(() => GetIt.I.reset());

  group('ProjectResumeCommand', () {
    test('supports --project/--org', () async {
      final workspace = TestWorkspace()..setRemoteAuthFile('{"jwt": "foo"}');
      final pubUpdater = PubUpdaterMock(isUpToDate: () async => true);
      final api = GlobeApiMock();

      when(api.getOrganizations()).thenAnswer((i) async {
        return [
          Organization(
            createdAt: DateTime.now(),
            id: 'bar',
            name: 'bar',
            slug: 'bar',
            updatedAt: DateTime.now(),
            type: OrganizationType.personal,
          )
        ];
      });
      when(api.getProjects(org: 'bar')).thenAnswer((i) async {
        return [
          Project(
            createdAt: DateTime.now(),
            id: 'foo',
            slug: 'foo',
            paused: false,
            orgId: 'bar',
            updatedAt: DateTime.now(),
          )
        ];
      });

      GetIt.I.registerSingleton<GlobeApi>(api);

      final result = runWithIOOverrides(
        fs: workspace.fs,
        () => globe.main(
          ['project', 'resume', '--project=foo', '--org=bar'],
          pubUpdater: pubUpdater,
        ),
      );

      await result.exitCode;

      await expectLater(
        result.exitCode,
        completion(ExitCode.success.code),
      );
    });
  });
}
