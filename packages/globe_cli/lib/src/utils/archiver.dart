import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:get_it/get_it.dart';
import 'package:glob/glob.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

/// Creates a zip archive of the given [directory].
Future<List<int>> zipDir(Directory directory) async {
  final logger = GetIt.I<Logger>();

  logger.detail('Archiving directory: ${directory.path}');

  // NOTE: We can't use p.join here due to https://github.com/dart-lang/path/issues/37
  // being present on Windows.
  final directoryPath = directory.path + p.separator;

  final archive = Archive();
  final files = directory.listSync(recursive: true);

  // Find all nested .gitignore files in the project.
  final gitignoreFiles = files
      .where((entity) => entity is File && entity.path.endsWith('.gitignore'))
      .map((entity) => File(entity.path));

  var gitignores = '';

  for (final file in gitignoreFiles) {
    if (file.existsSync()) {
      logger.detail('Found .gitignore file: ${file.path}');
      gitignores += '${await file.readAsString()}\n';
    }
  }

  // Initialize two lists to hold exclusion and inclusion patterns
  final excludePatterns = <String>[];
  final includePatterns = <String>[];

  gitignores
      .split('\n')
      .where((line) => line.isNotEmpty && !line.startsWith('#'))
      .forEach((line) {
    // Check if the line is an inclusion pattern (negation pattern)
    final isInclusionPattern = line.startsWith('!');

    if (isInclusionPattern) {
      // Remove the leading '!' and process the line
      line = line.substring(1);
    }

    // Process directory patterns by adding `**/` at the start if not already rooted and `/**` at the end
    final isDirectory = line.endsWith('/');

    // Remove leading `/` from the line if present.
    var processedLine = line.startsWith('/') ? line.substring(1) : line;

    if (isDirectory) {
      // If a directory, prepend with `**/` and append with `/**` if it doesn't end with `/`.
      processedLine =
          "**/$processedLine${processedLine.endsWith('/') ? '' : '/**'}";
    } else {
      // For files, add `**/` at the start unless the pattern already starts with a specific directory
      processedLine = '**/$processedLine';
    }

    // Add the processed line to the appropriate list
    if (isInclusionPattern) {
      includePatterns.add(processedLine);
    } else {
      excludePatterns.add(processedLine);
    }
  });

  // Exclude common files.
  excludePatterns.addAll([
    '**/*.map',
    '**/.git/**',
    '**/.dart_tool/**',
    '**/.packages',
    '**/.idea/**',
    '**/.vscode/**',
    '**/build/**',
    '**/android/**',
    '**/ios/**',
    '**/linux/**',
    '**/macos/**',
    '**/windows/**',
  ]);

  logger.detail('Excluding patterns: $excludePatterns');
  logger.detail('Including patterns: $includePatterns');

  final pool = Pool(10);

  Future<void> addEntityToArchive(FileSystemEntity entity) async {
    if (entity is! File) return;

    // By default, don't exclude the entity.
    var excludeEntity = false;

    // Exclude files that match the patterns in the exclude list.
    for (final pattern in excludePatterns) {
      final glob = Glob(pattern);
      final match = glob.matches(entity.path.replaceFirst(directoryPath, ''));
      if (match) {
        excludeEntity = true;
        break;
      }
    }

    // If the entity was marked for exclusion, check if it should be included again.
    if (excludeEntity) {
      for (final pattern in includePatterns) {
        final glob = Glob(pattern);
        final match = glob.matches(entity.path.replaceFirst(directoryPath, ''));
        if (match) {
          excludeEntity = false;
          break;
        }
      }
    }

    // If excludeEntity is true after checking both lists, the entity should be excluded.
    if (excludeEntity) {
      logger.detail('Excluding file from archiving: ${entity.path}');
      return; // Skip this entity, move to the next one
    }

    // Archive the file
    await pool.withResource(() async {
      final length = await entity.length();
      final bytes = await entity.readAsBytes();

      archive.addFile(
        ArchiveFile(
          // Store the files within a `project` directory.
          entity.path.replaceFirst(directoryPath, 'project/'),
          length,
          bytes,
        ),
      );
    });
  }

  // Add all files to the archive in parallel.
  await Future.wait(files.map(addEntityToArchive).toList());

  if (archive.isEmpty) {
    throw Exception(
      'Archive appears to be empty. This may be a bug, please report on GitHub.',
    );
  }

  final encoded = TarEncoder().encode(archive);

  if (encoded.isEmpty) {
    throw Exception('Failed to encode archive.');
  }

  logger.detail('Archive size: ${encoded.length} bytes');

  return encoded;
}
