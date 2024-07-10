import 'dart:async';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import '../command.dart';

class CreateProjectFromTemplate extends BaseGlobeCommand {
  CreateProjectFromTemplate() {
    argParser.addOption(
      'template',
      abbr: 't',
      mandatory: true,
      help: 'Specify template to use for the project.',
    );
  }

  @override
  String get description => 'Create new project using a template';

  @override
  String get name => 'create';

  Future<ProcessResult> _runGitCommand(
    List<String> args, {
    String? processWorkingDir,
  }) async {
    final result = await Process.run(
      'git',
      args,
      workingDirectory: processWorkingDir,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      throw ProcessException('git', args, result.stderr.toString());
    }

    return result;
  }

  Future<void> _copyPath(String from, String to) async {
    await Directory(to).create(recursive: true);
    await for (final file in Directory(from).list(recursive: true)) {
      final copyTo = p.join(to, p.relative(file.path, from: from));
      if (file is Directory) {
        await Directory(copyTo).create(recursive: true);
      } else if (file is File) {
        await File(file.path).copy(copyTo);
      }
    }
  }

  @override
  FutureOr<int>? run() async {
    final template = argResults!['template'].toString();
    final projectDirName = argResults?.rest.firstOrNull ?? template;
    const ref = 'main';

    final directory = Directory.systemTemp.createTempSync();

    final progress = logger.progress(
      'Creating project using template: ${cyan.wrap(template)}',
    );

    try {
      // Initialize a new Git repository
      await _runGitCommand(['init'], processWorkingDir: directory.path);
      await _runGitCommand(
        const ['remote', 'add', 'origin', 'https://github.com/invertase/globe'],
        processWorkingDir: directory.path,
      );

      // Configure sparse checkout
      await _runGitCommand(
        const ['config', 'core.sparseCheckout', 'true'],
        processWorkingDir: directory.path,
      );

      // Define the sparse checkout paths
      final sparseCheckoutFile = File(
        p.join(directory.path, '.git', 'info', 'sparse-checkout'),
      );
      if (!sparseCheckoutFile.existsSync()) {
        sparseCheckoutFile.createSync(recursive: true);
      }
      sparseCheckoutFile.writeAsStringSync('templates/$template/');

      // Pull the specific branch or commit
      await _runGitCommand(
        ['pull', 'origin', ref],
        processWorkingDir: directory.path,
      );

      final clonedRepoPath = directory.path;
      final templateDir = Directory(
        p.join(clonedRepoPath, 'templates', template),
      );
      if (!templateDir.existsSync()) {
        throw Exception('Template: $template does not exist');
      }

      await _copyPath(
        templateDir.path,
        p.join(Directory.current.path, projectDirName),
      );

      return ExitCode.success.code;
    } on ProcessException catch (e) {
      progress.fail('Failed to create project from template.');
      logger.err(e.message);
      return ExitCode.software.code;
    } catch (e, s) {
      progress.fail('Failed to create project from template.');
      logger.err(e.toString());
      logger.detail(s.toString());
      return ExitCode.software.code;
    }
  }
}
