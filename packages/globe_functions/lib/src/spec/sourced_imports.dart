class SourcedImports {
  final _imports = <Uri>{};

  /// Registers a URI and returns its index in the imports set.
  /// If the URI is already registered, returns its existing index.
  int register(Uri uri) {
    final existingIndex = _imports.lookup(uri);
    if (existingIndex != null) {
      return _imports.toList().indexOf(uri);
    }
    _imports.add(uri);
    return _imports.length - 1;
  }

  /// Gets all registered imports
  Set<Uri> call() => Set.unmodifiable(_imports);

  List<String> toJson() {
    return [
      for (final uri in _imports) uri.toString(),
    ];
  }

  static SourcedImports fromJson(List<dynamic> json) {
    final imports = SourcedImports();
    for (final uri in json) {
      imports.register(Uri.parse(uri as String));
    }
    return imports;
  }
}
