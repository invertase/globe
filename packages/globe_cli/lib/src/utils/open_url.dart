import 'dart:async';
import 'dart:io';

typedef OpenUrlOverride = Future<ProcessResult> Function(String url);

const openUrlZoneKey = #_openUrl;

/// Opens the given [url] in the default browser for the OS.
Future<ProcessResult> openUrl(String url) {
  final openUrlOverride = Zone.current[openUrlZoneKey] as OpenUrlOverride?;

  if (openUrlOverride != null) {
    return openUrlOverride(url);
  }

  return Process.run(_openUrlCommand, [url], runInShell: true);
}

String get _openUrlCommand {
  if (Platform.isWindows) {
    return 'start';
  } else if (Platform.isLinux) {
    return 'xdg-open';
  } else if (Platform.isMacOS) {
    return 'open';
  } else {
    throw UnsupportedError(
      'Operating system not supported by the open_url '
      'package: ${Platform.operatingSystem}',
    );
  }
}
