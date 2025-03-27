import 'package:get_it/get_it.dart';
import 'package:globe_cli/src/utils/api.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../bin/globe.dart' as globe;
import 'mocks.dart';
import 'test_utils.dart';
import 'workspace.dart';

void main() async {
  final pubUpdater = PubUpdaterMock(isUpToDate: () async => true);

  setUp(() => GetIt.I.reset());

  test('should send jwt token along with GraphQL request', () async {
    final workspace = TestWorkspace()..setRemoteAuthFile('{"jwt":"123"}');
    final httpClientMock = HttpClientMock();

    final requestMock = HttpClientRequestMock();
    final responseMock = HttpClientResponseMock();

    when(responseMock.statusCode).thenReturn(200);
    when(requestMock.close()).thenAnswer((_) async => responseMock);

    when(httpClientMock.openUrl('POST', any)).thenAnswer(
      (_) => Future.value(requestMock),
    );

    final whoami = runWithIOOverrides(
      fs: workspace.fs,
      client: httpClientMock,
      () => globe.main(['whoami'], pubUpdater: pubUpdater),
    );

    await whoami.testOutputByLines.join();

    verify(
      httpClientMock.openUrl(
        'POST',
        argThat(
          predicate((uri) => uri.toString() == 'https://globe.dev/graphql'),
        ),
      ),
    ).called(1);

    expect(
      (requestMock.headers as MockHTTPHeaders).capturedHeaders,
      allOf(
        containsPair('content-type', 'application/json'),
        containsPair('Authorization', 'Bearer 123'),
      ),
    );
  });

  test('should send api token along with GraphQL request', () async {
    final workspace = TestWorkspace();

    final httpClientMock = HttpClientMock();

    final requestMock = HttpClientRequestMock();
    final responseMock = HttpClientResponseMock();

    when(responseMock.statusCode).thenReturn(200);
    when(requestMock.close()).thenAnswer((_) async => responseMock);

    when(httpClientMock.openUrl('POST', any)).thenAnswer(
      (_) => Future.value(requestMock),
    );

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
        ),
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
        ),
      ];
    });

    GetIt.I.registerSingleton<GlobeApi>(api);

    final whoami = runWithIOOverrides(
      fs: workspace.fs,
      client: httpClientMock,
      () => globe.main(['whoami', '--token=SomeToken'], pubUpdater: pubUpdater),
    );

    await whoami.testOutputByLines.join();

    expect(
      (requestMock.headers as MockHTTPHeaders).capturedHeaders,
      allOf(
        containsPair('content-type', 'application/json'),
        containsPair('x-api-token', 'SomeToken'),
      ),
    );
  });
}
