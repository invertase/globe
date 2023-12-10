import 'dart:io';

import 'package:cli_util/cli_util.dart';
import 'package:file/memory.dart';
import 'package:globe_cli/src/utils/auth.dart';
import 'package:path/path.dart' as p;

final appConfigHomePath = applicationConfigHome(GlobeAuth.applicationName);
final remoteAuthFilePath = p.join(appConfigHomePath, 'dart_globe_auth.json');

class TestWorkspace {
  TestWorkspace() {
    // Initialize basic folder structure
    fs.directory(Directory.current.path).createSync(recursive: true);
    fs.currentDirectory = Directory.current.path;
  }

  final MemoryFileSystem fs = MemoryFileSystem.test();

  File get remoteAuthFile => fs.file(remoteAuthFilePath);

  void setRemoteAuthFile(String content) {
    remoteAuthFile
      ..createSync(recursive: true)
      ..writeAsStringSync(content);
  }
}
