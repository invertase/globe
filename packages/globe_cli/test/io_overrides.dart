import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file/file.dart';

sealed class LogEntry {}

class StdoutLogEntry implements LogEntry {
  StdoutLogEntry(this.message);

  final String message;

  @override
  String toString() => message;
}

class StderrLogEntry implements LogEntry {
  StderrLogEntry(this.message);

  final String message;

  @override
  String toString() => message;
}

final class TestIOOverride extends IOOverrides {
  TestIOOverride(
    this.fs, {
    required this.supportsAnsiEscapes,
    required this.hasTerminal,
  });

  final FileSystem fs;

  final bool? hasTerminal;
  final bool? supportsAnsiEscapes;

  @override
  late final stdout = _StdoutOverride(
    this,
    supportsAnsiEscapes: supportsAnsiEscapes,
    hasTerminal: hasTerminal,
    (msg) {
      _logController.add(StdoutLogEntry(msg));
      _stdoutController.add(msg);
    },
  );

  @override
  late final stderr = _StdoutOverride(
    this,
    supportsAnsiEscapes: supportsAnsiEscapes,
    hasTerminal: hasTerminal,
    (msg) {
      _logController.add(StderrLogEntry(msg));
      _stderrController.add(msg);
    },
  );

  Stream<LogEntry> get logOverride => _logController.stream;
  Stream<String> get stdoutOverride => _stdoutController.stream;
  Stream<String> get stderrOverride => _stderrController.stream;

  final _logController = StreamController<LogEntry>.broadcast();
  final _stdoutController = StreamController<String>.broadcast();
  final _stderrController = StreamController<String>.broadcast();

  @override
  Directory createDirectory(String path) => fs.directory(path);

  @override
  Directory getCurrentDirectory() => fs.currentDirectory;

  @override
  void setCurrentDirectory(String path) =>
      fs.currentDirectory = fs.directory(path);

  @override
  Directory getSystemTempDirectory() => fs.systemTempDirectory;

  @override
  File createFile(String path) => fs.file(path);

  @override
  Future<FileStat> stat(String path) {
    throw UnimplementedError();
  }

  @override
  FileStat statSync(String path) {
    throw UnimplementedError();
  }

  @override
  Future<bool> fseIdentical(String path1, String path2) {
    throw UnimplementedError();
  }

  @override
  bool fseIdenticalSync(String path1, String path2) {
    throw UnimplementedError();
  }

  @override
  Future<FileSystemEntityType> fseGetType(String path, bool followLinks) {
    throw UnimplementedError();
  }

  @override
  FileSystemEntityType fseGetTypeSync(String path, bool followLinks) {
    throw UnimplementedError();
  }

  @override
  Stream<FileSystemEvent> fsWatch(String path, int events, bool recursive) {
    throw UnimplementedError();
  }

  @override
  bool fsWatchIsSupported() => fs.isWatchSupported;

  @override
  Link createLink(String path) => fs.link(path);

  @override
  Future<ServerSocket> serverSocketBind(
    Object? address,
    int port, {
    int backlog = 0,
    bool v6Only = false,
    bool shared = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Socket> socketConnect(
    Object? host,
    int port, {
    Object? sourceAddress,
    int sourcePort = 0,
    Duration? timeout,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<ConnectionTask<Socket>> socketStartConnect(
    Object? host,
    int port, {
    Object? sourceAddress,
    int sourcePort = 0,
  }) {
    throw UnimplementedError();
  }

  void close() {
    stdout.close();
    stderr.close();
    _logController.close();
    _stdoutController.close();
    _stderrController.close();
  }
}

class _StdoutOverride implements Stdout {
  _StdoutOverride(
    this.ioOverride,
    this.onMsg, {
    required bool? supportsAnsiEscapes,
    required bool? hasTerminal,
  })  : _supportsAnsiEscapes = supportsAnsiEscapes,
        _hasTerminal = hasTerminal;

  final TestIOOverride ioOverride;
  final void Function(String msg) onMsg;

  @override
  Encoding get encoding => utf8;

  @override
  set encoding(Encoding e) => throw UnimplementedError();

  @override
  Future<void> get done => throw UnimplementedError();

  final bool? _hasTerminal;
  @override
  bool get hasTerminal {
    if (_hasTerminal != null) return _hasTerminal!;
    throw UnimplementedError();
  }

  @override
  IOSink get nonBlocking => throw UnimplementedError();

  final bool? _supportsAnsiEscapes;
  @override
  bool get supportsAnsiEscapes {
    if (_supportsAnsiEscapes != null) return _supportsAnsiEscapes!;
    throw UnimplementedError();
  }

  @override
  int get terminalColumns => throw UnimplementedError();

  @override
  int get terminalLines => throw UnimplementedError();

  @override
  void add(List<int> data) => throw UnimplementedError();

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    throw UnimplementedError();
  }

  @override
  Future<void> addStream(Stream<List<int>> stream) =>
      throw UnimplementedError();

  @override
  Future<void> flush() => throw UnimplementedError();

  @override
  void write(Object? object) {
    onMsg(object.toString());
  }

  @override
  void writeAll(Iterable<Object?> objects, [String sep = '']) {
    onMsg(objects.join(sep));
  }

  @override
  void writeCharCode(int charCode) => throw UnimplementedError();

  @override
  void writeln([Object? object = '']) {
    onMsg('$object\n');
  }

  @override
  Future<void> close() => Future.value();

  @override
  String lineTerminator = Platform.lineTerminator;
}
