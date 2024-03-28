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

  progress.update('Generating frontend code');

  /// Generate code
  await Process.run(
    'flutter',
    ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    workingDirectory: path.join(actualPath, 'frontend'),
  );

  progress.complete('$directoryName is ready 🔥');
}
