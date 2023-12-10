// Executes a callback and returns the result or null if an exception occurs.
T? runOrNull<T>(T Function() cb) {
  try {
    return cb();
  } catch (e) {
    return null;
  }
}
