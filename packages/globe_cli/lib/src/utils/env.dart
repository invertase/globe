import 'dart:io';
import 'package:meta/meta.dart';

Map<String, String> getEnvironmentVariables(File file) {
  if (!file.existsSync()) {
    return {};
  }

  const parser = Parser();
  final vars = <String, String>{};
  final lines = file.readAsLinesSync();

  vars.addAll(parser.parse(lines));
  return vars;
}

// https://github.com/mockturtl/dotenv/blob/master/lib/src/parser.dart
/// Creates key-value pairs from strings formatted as environment
/// variable definitions.
class Parser {
  /// [Parser] methods are pure functions.
  const Parser();

  static const _singleQuot = "'";
  static const _keyword = 'export';

  static final _comment = RegExp(r'''#.*(?:[^'"])$''');
  static final _surroundQuotes = RegExp(r'''^(['"])(.*)\1$''');
  static final _bashVar = RegExp(r'(?:\\)?(\$)(?:{)?([a-zA-Z_][\w]*)+(?:})?');

  /// Substitutes $bash_vars in [val] with values from [env].
  @visibleForTesting
  String interpolate(String val, Map<String, String> env) =>
      val.replaceAllMapped(_bashVar, (m) {
        final k = m.group(2)!;
        return (!_has(env, k)) ? _tryPlatformEnv(k) ?? '' : env[k] ?? '';
      });

  /// Creates a [Map] suitable for merging with [Platform.environment].
  /// Duplicate keys are silently discarded.
  Map<String, String> parse(Iterable<String> lines) {
    final out = <String, String>{};
    for (final line in lines) {
      final kv = parseOne(line, env: out);
      if (kv.isEmpty) continue;
      out[kv.keys.single] = kv.values.single;
    }
    return out;
  }

  /// Parses a single line into a key-value pair.
  @visibleForTesting
  Map<String, String> parseOne(
    String line, {
    Map<String, String> env = const {},
  }) {
    final stripped = strip(line);
    if (!_isValid(stripped)) return {};

    final idx = stripped.indexOf('=');
    final lhs = stripped.substring(0, idx);
    final k = swallow(lhs);
    if (k.isEmpty) return {};

    final rhs = stripped.substring(idx + 1, stripped.length).trim();
    final quotChar = surroundingQuote(rhs);
    final v = unquote(rhs);

    if (quotChar == _singleQuot) {
      // skip substitution in single-quoted values
      return {k: v};
    }

    return {k: interpolate(v, env)};
  }

  /// Strips comments (trailing or whole-line).
  @visibleForTesting
  String strip(String line) => line.replaceAll(_comment, '').trim();

  /// If [val] is wrapped in single or double quotes, returns the quote character.
  /// Otherwise, returns the empty string.
  @visibleForTesting
  String surroundingQuote(String val) {
    if (!_surroundQuotes.hasMatch(val)) return '';
    return _surroundQuotes.firstMatch(val)!.group(1)!;
  }

  /// Omits 'export' keyword.
  @visibleForTesting
  String swallow(String line) => line.replaceAll(_keyword, '').trim();

  /// Removes quotes (single or double) surrounding a value.
  @visibleForTesting
  String unquote(String val) =>
      val.replaceFirstMapped(_surroundQuotes, (m) => m[2]!).trim();

  /// null is a valid value in a Dart map, but the env var representation is empty string, not the string 'null'
  bool _has(Map<String, String> map, String key) =>
      map.containsKey(key) && map[key] != null;

  bool _isValid(String s) => s.isNotEmpty && s.contains('=');

  String? _tryPlatformEnv(String key) {
    if (!_has(Platform.environment, key)) return '';
    return Platform.environment[key];
  }
}
