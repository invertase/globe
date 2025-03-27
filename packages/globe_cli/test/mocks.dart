import 'dart:io';

import 'package:globe_cli/src/utils/api.dart';
import 'package:globe_cli/src/utils/http_server.dart';
import 'package:globe_cli/src/utils/open_url.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mockito/mockito.dart';
import 'package:pub_updater/pub_updater.dart';

import 'mock_helpers.dart';

class OpenUrlMock extends Mock {
  OpenUrlMock({OpenUrlOverride? openUrl}) {
    if (openUrl != null) {
      when(call(any)).thenAnswer(
        (i) => openUrl(i.positionalArguments[0] as String),
      );
    }
  }

  Future<ProcessResult> call(String? url) {
    return mockFuture(
      Invocation.method(#call, [url]),
    );
  }
}

class PubUpdaterMock extends Mock implements PubUpdater {
  PubUpdaterMock({
    Future<bool> Function()? isUpToDate,
    Future<String> Function(String packageName)? getLatestVersion,
  }) {
    if (isUpToDate != null) {
      when(this.isUpToDate()).thenAnswer((_) => isUpToDate());
    }
    if (getLatestVersion != null) {
      when(this.getLatestVersion(any)).thenAnswer(
        (i) => getLatestVersion(i.positionalArguments[0] as String),
      );
    }
  }

  @override
  Future<bool> isUpToDate({String? packageName, String? currentVersion}) {
    return mockFuture(
      Invocation.method(#isUpToDate, [], {
        #packageName: packageName,
        #currentVersion: currentVersion,
      }),
    );
  }

  @override
  Future<String> getLatestVersion(String? packageName) {
    return mockFuture(Invocation.method(#getLatestVersion, [packageName]));
  }
}

class GlobeHttpServerMock extends Mock implements GlobeHttpServer {
  GlobeHttpServerMock({
    Future<String?> Function({
      void Function(int port)? onConnected,
      Logger? logger,
    })? getSessionToken,
  }) {
    if (getSessionToken != null) {
      when(
        this.getSessionToken(
          onConnected: anyNamed('onConnected'),
          logger: anyNamed('logger'),
        ),
      ).thenAnswer(
        (i) async => getSessionToken(
          onConnected: i.namedArguments[#onConnected] as void Function(
            int port,
          )?,
          logger: i.namedArguments[#logger] as Logger?,
        ),
      );
    }
  }

  @override
  Future<String?> getSessionToken({
    void Function(int port)? onConnected,
    Logger? logger,
  }) {
    return mockFuture(
      Invocation.method(#getSessionToken, [], {
        #onConnected: onConnected,
        #logger: logger,
      }),
    );
  }
}

class HttpClientMock extends Mock implements HttpClient {
  @override
  Future<HttpClientRequest> openUrl(String? method, Uri? url) {
    return mockFuture(Invocation.method(#openUrl, [method, url]));
  }
}

class MockHTTPHeaders extends Mock implements HttpHeaders {
  final capturedHeaders = <String, dynamic>{};

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    capturedHeaders[name] = value;
  }
}

class HttpClientRequestMock extends Mock implements HttpClientRequest {
  final _headers = MockHTTPHeaders();

  @override
  HttpHeaders get headers => _headers;

  @override
  Future<HttpClientResponse> close() {
    return nsm(
      Invocation.method(#close, []),
      Future.value(HttpClientResponseMock()),
    );
  }
}

class HttpClientResponseMock extends Mock implements HttpClientResponse {
  @override
  HttpHeaders get headers =>
      nsm(Invocation.getter(#headers), MockHTTPHeaders());

  @override
  int get statusCode => nsm(Invocation.getter(#statusCode), 200);
}

class GlobeApiMock extends Mock implements GlobeApi {
  @override
  Future<List<Organization>> getOrganizations() {
    return mockFuture(Invocation.method(#getOrganizations, []));
  }

  @override
  Future<List<Project>> getProjects({required String? org}) {
    return mockFuture(Invocation.method(#getProjects, [], {#org: org}));
  }

  @override
  Future<void> resumeProject({
    required String? orgId,
    required String? projectId,
  }) {
    return mockFuture(
      Invocation.method(#resumeProject, [], {
        #orgId: orgId,
        #projectId: projectId,
      }),
    );
  }
}
