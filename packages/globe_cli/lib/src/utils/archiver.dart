import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

/// Creates a zip archive of the given [directory].
Future<List<int>> zipDir(Directory directory) async {
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
      gitignores += '${await file.readAsString()}\n';
    }
  }

  final exclude = gitignores
      .split('\n')
      .where((line) => line.isNotEmpty && !line.startsWith('#'))
      .map((line) => line.startsWith('/') ? line.substring(1) : line)
      .map((line) => '**$line**')
      .toList();

  // Exclude common files.
  exclude.addAll([
    '**.map',
    '**.git**',
    '**.dart_tool**',
    '**.packages**',
    '**.idea**',
    '**.vscode**',
    '**build**',
    '**android**',
    '**ios**',
    '**linux**',
    '**macos**',
    '**windows**',
  ]);

  final pool = Pool(10);

  Future<void> addEntityToArchive(FileSystemEntity entity) async {
    if (entity is! File) return;

    // Exclude files that match the patterns in the `.gitignore` file.
    for (final pattern in exclude) {
      final glob = Glob(pattern);
      final match = glob.matches(entity.path.replaceFirst(directoryPath, ''));

      if (match) {
        return;
      }
    }

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
        'Archive appears to be empty. This may be a bug, please report on GitHub.');
  }

  final encoded = TarEncoder().encode(archive);

  if (encoded.isEmpty) {
    throw Exception('Failed to encode archive.');
  }

  return encoded;
}
