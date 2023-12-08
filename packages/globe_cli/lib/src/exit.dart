import 'dart:io';

/// An overridable implementation of [exit], for test purpose.
///
/// Tests should throw [ExitException] when mocking [exit].
Never Function(int exitCode) exitOverride = exit;

/// An exception thrown during tests to simulate an exit.
class ExitException implements Exception {}
