import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'utils.dart';

final dotEnv = DotEnv(includePlatformEnvironment: true, quiet: true)..load();

String get _globeAPIToken => dotEnv['GLOBE_API_TOKEN']!;
String get _githubToken => dotEnv['GITHUB_API_TOKEN']!;

typedef Task = Future<void> Function();

// Configure routes.
final _router = Router()
  ..post('/tasks/check-dart-version', _checkDartVersion)
  ..post('/tasks/check-flutter-version', _checkFlutterVersion);

void main(List<String> args) async {
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('Server listening on port ${server.port}');
}

Future<Response> _checkDartVersion(Request request) async {
  final (globeImages, dartReleases) = await (
    getLatestSdkFromGlobe(_globeAPIToken, 'dart'),
    getLatestDartReleases(),
  ).wait;

  final tasks = <Task>[];

  if (globeImages.stable != dartReleases.stable) {
    tasks.add(() => _triggerDartWorkflow(dartReleases.stable));
  }

  if (globeImages.beta != dartReleases.beta) {
    tasks.add(() => _triggerDartWorkflow(dartReleases.beta));
  }

  final devRelease = dartReleases.dev;
  if (devRelease != null && globeImages.dev != devRelease) {
    tasks.add(() => _triggerDartWorkflow(devRelease));
  }

  return await _execTasks(tasks);
}

Future<Response> _checkFlutterVersion(Request request) async {
  final (globeImages, flutterReleases) = await (
    getLatestSdkFromGlobe(_globeAPIToken, 'flutter'),
    getLatestFlutterRelease(),
  ).wait;

  final tasks = <Task>[];

  if (globeImages.stable != flutterReleases.stable) {
    print('Add Flutter ${flutterReleases.stable}');
    tasks.add(() => _triggerFlutterWorkflow(flutterReleases.stable));
  }

  if (globeImages.beta != flutterReleases.beta) {
    print('Add Flutter ${flutterReleases.beta}');
    tasks.add(() => _triggerFlutterWorkflow(flutterReleases.beta));
  }

  return await _execTasks(tasks);
}

Future<void> _triggerDartWorkflow(SdkRelease release) => triggerWorkflow(
      _githubToken,
      Workflow.dart,
      release,
    );
Future<void> _triggerFlutterWorkflow(SdkRelease release) => triggerWorkflow(
      _githubToken,
      Workflow.flutter,
      release,
    );

Future<Response> _execTasks(List<Task> tasks) async {
  if (tasks.isEmpty) {
    return Response.ok('Already has latest images.');
  }

  try {
    await tasks.map((task) => task.call()).wait;

    return Response.ok(
      'Completed.',
      headers: {HttpHeaders.contentTypeHeader: 'text/plain'},
    );
  } catch (e, trace) {
    print(e);
    print(trace);
    return Response.ok(
      'An error occurred while triggering tasks',
      headers: {HttpHeaders.contentTypeHeader: 'text/plain'},
    );
  }
}
