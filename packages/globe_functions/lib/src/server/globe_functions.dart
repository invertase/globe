import 'dart:convert';

import 'package:globe_functions/src/spec/serializer.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:globe_functions/src/build/sourced_function.dart';

final class GlobeFunctions {
  GlobeFunctions({required this.sourced, required this.handlers});

  final List<SourcedFunction> sourced;
  final Map<int, Function> handlers;

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

      final sourcedFunction = sourced.firstWhere(
        (e) => e.pathname == request.url.path,
        orElse:
            () => throw Exception('Function not found: ${request.url.path}'),
      );

      final handler = handlers[sourcedFunction.id]!;

      print(body);
      final positional =
          ((body['positional'] as List<dynamic>?) ?? [])
              .map(
                (e) =>
                    Serializer.fromJson(
                      e as Map<String, dynamic>,
                    ).deserialize(),
              )
              .toList();

      final named = (body['named'] as Map<String, dynamic>? ?? {}).map(
        (k, v) => MapEntry(Symbol(k), Serializer.fromJson(v).deserialize()),
      );

      // Convert named arguments to a map of Symbols to values.
      final namedArgs = <Symbol, dynamic>{};
      for (final param in named.entries) {
        namedArgs[param.key] = param.value;
      }

      final applied = Function.apply(handler, positional, namedArgs);

      final result = await applied;

      return json({
        'result': Serializer.serialize(
          sourcedFunction.returnType.serializerType,
          result,
        ),
      });
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
