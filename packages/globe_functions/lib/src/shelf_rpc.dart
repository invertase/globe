import 'package:shelf/shelf.dart';

sealed class RouteDefinition {}

// Update type to use Symbol instead of String
typedef ProcedureRoutes = Map<Symbol, RouteDefinition>;

class ShelfRpc {
  final List<Middleware> _middleware;
  const ShelfRpc([this._middleware = const []]);

  // Add middleware at the root level
  ShelfRpc use(Middleware middleware) {
    return ShelfRpc([..._middleware, middleware]);
  }

  Router router(ProcedureRoutes routes) {
    return Router(routes, _middleware);
  }

  // Pass root middleware to new procedures
  Procedure procedure() => Procedure(_middleware);
}

// Implement RouteDefinition
class Router implements RouteDefinition {
  final ProcedureRoutes routes;
  final List<Middleware> middleware;
  const Router(this.routes, [this.middleware = const []]);
}

// Implement RouteDefinition
class ExecutedProcedure implements RouteDefinition {
  final List<Middleware> middleware;
  final Function fn;
  final ProcedureMethod method;
  const ExecutedProcedure(
    this.middleware, {
    required this.fn,
    required this.method,
  });
}

// Implement RouteDefinition
class Procedure implements RouteDefinition {
  final List<Middleware> middleware;
  const Procedure([this.middleware = const []]);

  Procedure use(Middleware middleware) {
    return Procedure([...this.middleware, middleware]);
  }

  // Now returns ExecutedProcedure instead of Procedure
  ExecutedProcedure exec(
    Function fn, {
    ProcedureMethod method = ProcedureMethod.post,
  }) {
    return ExecutedProcedure(middleware, fn: fn, method: method);
  }
}

enum ProcedureMethod { get, post }
