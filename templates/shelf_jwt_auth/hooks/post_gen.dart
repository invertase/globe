import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

const _serverEnvVars = '''
FIREBASE_PROJECT_ID=""
FIREBASE_CLIENT_ID=""
FIREBASE_PRIVATE_KEY=""
FIREBASE_CLIENT_EMAIL=""
''';

const _frontendEnvVars = '''
API_URL="http://localhost:8080"
''';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Setting up melos for workspace');

  final p = await Process.run('melos', ['--version']);
  if (p.pid != 0) {
    await Process.run('dart', ['pub', 'global', 'activate', 'melos']);
  }

  final directoryName = context.vars['project_name'] as String;
  final actualPath = path.join(Directory.current.path, directoryName);

  /// bootstrap workspace
  await Process.run(
    'dart',
    ["pub", "global", "run", "melos", "bootstrap"],
    workingDirectory: actualPath,
  );

  progress.update('Generating project code');

  final frontendPath = path.join(actualPath, 'frontend');
  final serverPath = path.join(actualPath, 'server');

  /// Create .env files for local dev
  File(path.join(frontendPath, '.env')).writeAsStringSync(_frontendEnvVars);
  File(path.join(serverPath, '.env')).writeAsStringSync(_serverEnvVars);

  const buildRunnerCmds = ['build_runner', 'build'];

  /// Generate code
  await Future.wait([
    Process.run(
      'flutter',
      ['pub', 'run', ...buildRunnerCmds],
      workingDirectory: frontendPath,
    ),
    Process.run(
      'dart',
      ['run', ...buildRunnerCmds],
      workingDirectory: serverPath,
    ),
  ]);

  progress.complete('$directoryName is ready 🔥');
}
