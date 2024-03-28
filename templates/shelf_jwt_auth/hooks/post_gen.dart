import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mason/mason.dart';

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

  const buildRunnerCmds = ['build_runner', 'build'];

  /// Generate code
  await Future.wait([
    Process.run(
      'flutter',
      ['pub', 'run', ...buildRunnerCmds],
      workingDirectory: path.join(actualPath, 'frontend'),
    ),
    Process.run(
      'dart',
      ['run', ...buildRunnerCmds],
      workingDirectory: path.join(actualPath, 'server'),
    ),
  ]);

  progress.complete('$directoryName is ready 🔥');
}
