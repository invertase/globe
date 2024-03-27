import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:get_it/get_it.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

import 'ignore.dart';

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

  final ignorePatterns = <String>[
    '*.map',
    '.git/**',
    '.dart_tool/**',
    '.packages',
    '.idea/**',
    '.vscode/**',
    'build/**',
    'android/**',
    'ios/**',
    'linux/**',
    'macos/**',
    'windows/**',
  ];

  for (final file in gitignoreFiles) {
    if (file.existsSync()) {
      logger.detail('Found .gitignore file: ${file.path}');
      final patterns = (await file.readAsLines()).where(
        (e) => e.trim().isNotEmpty && !e.startsWith('#') && !e.startsWith('!'),
      );
      final dirname = p.dirname(file.path);
      ignorePatterns.addAll(
        patterns.map((pattern) {
          pattern = pattern.startsWith('/')
              ? dirname + pattern
              : dirname + p.separator + pattern;
          return pattern.replaceFirst(directoryPath, '');
        }),
      );
    }
  }

  final pool = Pool(10);
  final ignore = Ignore(ignorePatterns);

  Future<void> addEntityToArchive(FileSystemEntity entity) async {
    if (entity is! File) return;

    final shortPath = entity.path.replaceFirst(directoryPath, '');
    if (ignore.ignores(shortPath)) {
      logger.detail('Excluding file from archive: ${entity.path}');
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
