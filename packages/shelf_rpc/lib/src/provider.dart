import 'package:shelf/shelf.dart';
import 'shelf_utils.dart';

/// Creates a middleware that provides a dependency of type [T]
Middleware provider<T extends Object>(T Function(Request request) create) {
  return (Handler innerHandler) {
    return (Request request) {
      final newRequest = request.set<T>(create(request));
      return innerHandler(newRequest);
    };
  };
}

/// Creates a middleware that provides an async dependency of type [T]
Middleware asyncProvider<T extends Object>(
    Future<T> Function(Request request) create) {
  return (Handler innerHandler) {
    return (Request request) {
      final newRequest = request.setAsync<T>(create(request));
      return innerHandler(newRequest);
    };
  };
}
