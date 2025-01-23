// import 'package:functions/models.dart';

// import 'rpc_client.g.dart';

// void main() async {
//   final client = RpcClient('http://localhost:8080');
//   final r6 = await client.users.details.get('hello', user: User(name: 'world'));
// }
import 'dart:convert';
import 'package:globe_functions/src/spec/serializer.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:functions/functions.dart' as i0;
import 'package:functions/api/users/details.dart' as i1;
import 'package:functions/api/users.dart' as i2;
import 'package:functions/models.dart' as i3;

void main() async {
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(_onRequest);
  final server = await shelf_io.serve(handler, 'localhost', 8080);
  print('Serving at http://${server.address.host}:${server.port}');
}

Future<Response> _onRequest(Request request) async {
  if (request.method == 'POST' && request.url.path == '_rpc') {
    return _onRpcRequest(request);
  }

  return Response.ok('Not found...');
}

Future<Response> _onRpcRequest(Request request) async {
  final body = jsonDecode(await request.readAsString());
  final id = body['id'] as String;
  final named = body['named'] as Map<String, dynamic>;
  final positional = body['positional'] as List<dynamic>;

  if (id == 'users.details.get') {
    final param0 = Serializers.instance.deserialize<String>(positional[0]);
    final userParam = named['user'] == null ? null : i0.Person.fromJson(named['user'] as Map<String, dynamic>);
    final result = await i1.get(
      param0,
      user: userParam
    );
    final serializedResult = result.toJson();
    return Response.ok(
      jsonEncode({'result': serializedResult, 'error': null}),
      headers: {'content-type': 'application/json'},
    );
  }

  if (id == 'users.example1') {
    final param0 = positional[0] == null ? null : Serializers.instance.deserialize<String>(positional[0]);
    final result = await i2.example1(
      param0
    );
    final serializedResult = result == null ? null : result.toJson();
    return Response.ok(
      jsonEncode({'result': serializedResult, 'error': null}),
      headers: {'content-type': 'application/json'},
    );
  }

  if (id == 'users.example2') {
    final result = await i2.example2(

    );
    final serializedResult = result.toJson();
    return Response.ok(
      jsonEncode({'result': serializedResult, 'error': null}),
      headers: {'content-type': 'application/json'},
    );
  }

  if (id == 'users.example3') {
    final result = await i2.example3(

    );
    final serializedResult = Serializers.instance.serialize<DateTime>(result);
    return Response.ok(
      jsonEncode({'result': serializedResult, 'error': null}),
      headers: {'content-type': 'application/json'},
    );
  }

  if (id == 'users.example4') {
    final result = await i2.example4(

    );
    final serializedResult = Serializers.instance.serialize<String>(result);
    return Response.ok(
      jsonEncode({'result': serializedResult, 'error': null}),
      headers: {'content-type': 'application/json'},
    );
  }


  // No matching function found
  return Response.notFound(
    jsonEncode({
      'result': null,
      'error': 'Function not found: $id'
    }),
    headers: {'content-type': 'application/json'},
  );
}

