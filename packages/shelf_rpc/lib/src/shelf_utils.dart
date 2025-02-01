import 'package:shelf/shelf.dart';

/// Extension on [Request] to provide dependency injection capabilities
extension RequestDependencyInjection on Request {
  static const _dependencyKey = '_shelf_rpc_dependencies';

  /// Internal method to get or create the dependency map
  Map<Type, Object> _getDependencyMap() {
    final ctx = context;
    final deps = ctx[_dependencyKey];
    if (deps is Map<Type, Object>) {
      return deps;
    }
    return <Type, Object>{};
  }

  /// Sets a dependency of type [T] in the request context
  Request set<T extends Object>(T value) {
    final deps = _getDependencyMap();
    return change(context: {
      _dependencyKey: {
        ...deps,
        T: value,
      },
    });
  }

  /// Sets an async dependency of type [T] in the request context
  Request setAsync<T extends Object>(Future<T> value) {
    final deps = _getDependencyMap();
    return change(context: {
      ...context,
      _dependencyKey: {
        ...deps,
        Future<T>: value,
      },
    });
  }

  /// Gets a dependency of type [T] from the request context
  ///
  /// Example:
  /// ```dart
  /// final userService = request.get<UserService>();
  /// ```
  T get<T extends Object>() {
    final deps = _getDependencyMap();
    final value = deps[T];

    if (value == null) {
      throw StateError('No dependency found for type $T');
    }

    return value as T;
  }

  /// Tries to get a dependency of type [T] from the request context
  /// Returns null if not found
  ///
  /// Example:
  /// ```dart
  /// final userService = request.tryGet<UserService>();
  /// ```
  T? tryGet<T extends Object>() {
    final deps = _getDependencyMap();
    final value = deps[T];
    return value as T?;
  }

  /// Gets an async dependency of type [T] from the request context
  ///
  /// Example:
  /// ```dart
  /// final db = await request.getAsync<Database>();
  /// ```
  Future<T> getAsync<T extends Object>() async {
    final deps = _getDependencyMap();
    final value = deps[Future<T>];

    if (value == null) {
      throw StateError('No async dependency found for type $T');
    }

    return (value as Future<T>);
  }
}
