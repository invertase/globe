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

  await Process.run(
    'dart',
    ["pub", "global", "run", "melos", "bootstrap"],
    workingDirectory: actualPath,
  );

  progress.complete('Workspace setup completed');
}
