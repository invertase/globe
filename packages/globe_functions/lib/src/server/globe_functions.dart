import 'dart:convert';

import 'package:shelf/shelf.dart' as shelf;
import 'package:globe_functions/src/build/sourced_function.dart';

final class GlobeFunctions {
  GlobeFunctions({required this.sourced, required this.handlers});

  final List<SourcedFunction> sourced;
  final Map<String, Function> handlers;

  shelf.Handler getShelfHandler() {
    return const shelf.Pipeline().addHandler((request) async {
      if (request.method != 'POST') {
        return json({'error': 'Method not allowed'}, 405);
      }

      Map<String, dynamic> body;

      try {
        body = jsonDecode(await request.readAsString());
      } catch (e) {
        return json({'error': 'Invalid JSON body'}, 400);
      }

      final function = handlers[request.url.path];

      if (function == null) {
        print('Function not found: ${request.url.path}');
        return json({'error': 'Function not found'}, 404);
      }

      final positional = body['positional'] as List<dynamic>? ?? [];
      final named = body['named'] as Map<String, dynamic>? ?? {};

      // Convert named arguments to a map of Symbols to values.
      final namedArgs = <Symbol, dynamic>{};
      for (final param in named.entries) {
        namedArgs[Symbol(param.key)] = param.value;
      }

      final applied = Function.apply(function, positional, namedArgs);

      final result = await applied;
      return json(result);
    });
  }
}

shelf.Response json(Object body, [int status = 200]) {
  return shelf.Response(
    status,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
}
