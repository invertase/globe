/// A class for tracking the imports used in the generated code.
final class SourcedImports {
  /// The set of imports.
  final imports = <Uri>{};

  /// Registers a URI and returns its index in the imports set.
  /// If the URI is already registered, returns its existing index.
  int register(Uri uri) {
    final existingIndex = imports.lookup(uri);
    if (existingIndex != null) {
      return imports.toList().indexOf(uri);
    }
    imports.add(uri);
    return imports.length - 1;
  }

  /// Gets all registered imports
  Set<Uri> call() => Set.unmodifiable(imports);
}
