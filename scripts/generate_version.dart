// ignore_for_file: avoid_print

import 'dart:io' show Directory, File;

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

const template = '''
// GENERATED CODE. DO NOT EDIT BY HAND.

const name = 'PACKAGE_NAME';
const version = 'PACKAGE_VERSION';
const description = 'PACKAGE_DESCRIPTION';
const executable = 'PACKAGE_EXECUTABLE';
''';

Future<void> main() async {
  final outputPath = p.joinAll(
    [
      Directory.current.path,
      'packages',
      'globe_cli',
      'lib',
      'src',
      'package_info.dart'
    ],
  );
  print('Updating generated file $outputPath');
  final melosPubspecPath = p.joinAll(
      [Directory.current.path, 'packages', 'globe_cli', 'pubspec.yaml']);
  final yamlMap =
      loadYaml(File(melosPubspecPath).readAsStringSync()) as YamlMap;
  final fileContents = template
      .replaceAll('PACKAGE_NAME', yamlMap['name'] as String)
      .replaceAll('PACKAGE_VERSION', yamlMap['version'] as String)
      .replaceAll('PACKAGE_DESCRIPTION', yamlMap['description'] as String)
      .replaceAll('PACKAGE_EXECUTABLE',
          (yamlMap['executables'] as Map).entries.first.key as String);
  await File(outputPath).writeAsString(fileContents);
  print(
      'Updated version to ${yamlMap['version'] as String} in generated file $outputPath');
}
