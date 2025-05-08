import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;

import '../../command.dart';
import '../../utils/api.dart';

String get dylibName {
  final currentAbi = Abi.current();

  return switch (currentAbi) {
    Abi.macosX64 => 'libglobe_runtime-x86_64-apple-darwin.dylib',
    Abi.macosArm64 => 'libglobe_runtime-aarch64-apple-darwin.dylib',
    Abi.linuxX64 => 'libglobe_runtime-x86_64-unknown-linux-gnu.so',
    Abi.linuxArm64 => 'libglobe_runtime-aarch64-unknown-linux-gnu.so',
    Abi.windowsX64 => 'globe_runtime-x86_64-pc-windows-msvc.dll',
    _ => throw UnsupportedError('Unsupported ABI: $currentAbi'),
  };
}

String get globeRuntimeInstallDirectory {
  return path.join(userHomeDirectory, '.globe', 'runtime');
}

String get userHomeDirectory {
  if (Platform.isWindows) {
    return Platform.environment['USERPROFILE'] ?? r'C:\Users\Default';
  } else {
    return Platform.environment['HOME'] ?? '/';
  }
}

final class RuntimeVersion {
  final String name;
  final String version;
  final String releaseUrl;
  final String binaryUrl;

  const RuntimeVersion({
    required this.name,
    required this.version,
    required this.binaryUrl,
    required this.releaseUrl,
  });

  factory RuntimeVersion.fromJson(Map<String, dynamic> json) {
    final assets = json['assets'] as Iterable;
    if (assets.isEmpty) throw Exception('No assets found in release');

    final asset = assets.firstWhereOrNull(
      (asset) => (asset as Map<dynamic, dynamic>)['name'] == dylibName,
    ) as Map<dynamic, dynamic>;

    return RuntimeVersion(
      version: json['tag_name'] as String,
      releaseUrl: json['html_url'] as String,
      binaryUrl: asset['browser_download_url'] as String,
      name: asset['name'] as String,
    );
  }

  Future<void> download() async {
    final url = Uri.parse(binaryUrl);
    final response = await http.readBytes(url);

    final directory = Directory(globeRuntimeInstallDirectory);
    await directory.create(recursive: true);
    await File(path.join(directory.path, name)).writeAsBytes(response);
  }
}

Future<RuntimeVersion> getLatestVersion() async {
  final url = Uri.parse(
    'https://api.github.com/repos/invertase/globe_runtime/releases/latest',
  );
  final response = await http.get(url);
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch release info');
  }
  return RuntimeVersion.fromJson(
    jsonDecode(response.body) as Map<String, dynamic>,
  );
}

class RuntimeInstallCommand extends BaseGlobeCommand {
  RuntimeInstallCommand();

  @override
  String get description => 'Pause the current globe project';

  @override
  String get name => 'install';

  @override
  FutureOr<int> run() async {
    final runtimeDownloadProgress =
        logger.progress('Fetching Globe Runtime latest version');

    try {
      final release = await getLatestVersion();

      runtimeDownloadProgress.update(
        'Installing ${cyan.wrap('Globe Runtime')} @ ${cyan.wrap(release.version)}',
      );

      await release.download();

      runtimeDownloadProgress.complete('Globe Runtime installed.');
      return ExitCode.success.code;
    } on ApiException catch (e) {
      runtimeDownloadProgress.fail('✗ Failed to pause project: ${e.message}');
      return ExitCode.software.code;
    } catch (e, s) {
      runtimeDownloadProgress.fail('✗ Failed to pause project: $e');
      logger.detail(s.toString());
      return ExitCode.software.code;
    }
  }
}
