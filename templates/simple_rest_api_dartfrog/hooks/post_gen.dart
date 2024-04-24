import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Setting up Globe for workspace');

  final p = await Process.run('globe', ['--version']);
  if (p.pid != 0) {
    await Process.run('dart', ['pub', 'global', 'activate', 'globe_cli']);
  }

  final directoryName = context.vars['project_name'] as String;
  final actualPath = path.join(Directory.current.path, directoryName);

  await Process.run(
    'dart',
    ["pub", "global", "run", "globe", "--version"],
    workingDirectory: actualPath,
  );

  progress.complete('Globe setup completed');
}
