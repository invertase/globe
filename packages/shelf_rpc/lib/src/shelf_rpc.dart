import 'package:shelf/shelf.dart' show Middleware;

/// A class which is used to define the entrypoint for the RPC routes.
///
/// Define this in files exposing one or more [ShelfRpc] instances. The build
/// pipeline will detect this and generate a client for each entrypoint and
/// a Shelf [Pipeline] to expose the RPC routes to the client.
final class RpcEntrypoint {
  /// Creates a new [RpcEntrypoint] instance.
  const RpcEntrypoint();
}

/// Defines the type of route which can be defined in the ShelfRpc instance.
///
/// This can either be a [ExecutedRpcProcedure] or a (nested) [RpcRoutes]
sealed class RpcRouterDefinition {}

/// A map of routes which can be used to define the RPC routes.
///
/// The key is a [Symbol] which is used to define the RPC identifier. Identifiers
/// starting with a `_` are ignored. Duplicate identifiers are ignored.
///
/// The [RpcRouteDefinition] allows for returning a [RpcProcedure] or a (nested)
/// [RpcRoutes].
typedef RpcRoutes = Map<Symbol, RpcRouterDefinition>;

/// The Shelf RPC class for defining the RPC routes and middleware.
///
/// ```dart
/// final rpc = ShelfRpc()
///   .use(someShelfMiddleware())
///
/// rpc.router({
///   #hello: rpc.procedure().exec((req) => 'world'),
/// });
/// ```
final class ShelfRpc {
  /// Keeps track of the middleware which is applied to all routes.
  final List<Middleware> _middleware;

  /// Creates a new [ShelfRpc] instance.
  const ShelfRpc([this._middleware = const []]);

  /// Applies middleware to all routes defined in the [ShelfRpc] instance.
  ShelfRpc use(Middleware middleware) {
    return ShelfRpc([..._middleware, middleware]);
  }

  /// Creates a new [RpcRouter] instance with the given [RpcRoutes] and middleware.
  ///
  /// The [RpcRouter] is used to define the routes and middleware for the Shelf RPC
  /// instance.
  RpcRouter router(RpcRoutes routes) {
    return RpcRouter._(routes, _middleware);
  }

  /// Creates a new [RpcProcedure] with any middleware applied from the parent
  /// [ShelfRpc] or [RpcProcedure]s.
  RpcProcedure procedure() => RpcProcedure._(_middleware);
}

/// Represents a router for the RPC routes.
final class RpcRouter implements RpcRouterDefinition {
  /// The routes which are defined in the [RpcRouter] instance.
  final RpcRoutes routes;

  /// The middleware which is applied to all routes defined in the [RpcRouter].
  final List<Middleware> middleware;

  /// Creates a new [RpcRouter] instance.
  const RpcRouter._(this.routes, [this.middleware = const []]);
}

/// Represents an executed RPC procedure, created when the user calls [RpcProcedure.exec].
class ExecutedRpcProcedure implements RpcRouterDefinition {
  /// The middleware which is applied to the [ExecutedRpcProcedure].
  final List<Middleware> middleware;

  /// The function which is executed when the [ExecutedRpcProcedure] is called.
  final Function fn;

  /// Creates a new [ExecutedRpcProcedure] instance.
  const ExecutedRpcProcedure(
    this.middleware, {
    required this.fn,
  });
}

/// Represents a procedure for the RPC routes.
class RpcProcedure implements RpcRouterDefinition {
  /// The middleware which is applied to the [RpcProcedure].
  final List<Middleware> middleware;

  /// Creates a new [RpcProcedure] instance.
  const RpcProcedure._([this.middleware = const []]);

  /// Applies middleware to the [RpcProcedure].
  RpcProcedure use(Middleware middleware) {
    return RpcProcedure._([...this.middleware, middleware]);
  }

  /// Executes the [RpcProcedure] with the given function.
  ///
  /// The function is executed when the [RpcProcedure] is called.
  ExecutedRpcProcedure exec(Function fn) {
    return ExecutedRpcProcedure(middleware, fn: fn);
  }
}
