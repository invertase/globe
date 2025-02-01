import 'package:shelf_rpc/shelf_rpc.dart';

final r = ShelfRpc();

@RpcEntrypoint()
final example = r.router({
  #sayHello: r.procedure().exec((String name) => 'Hello, $name!'),
});
