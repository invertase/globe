import 'package:build/build.dart';
import 'package:shelf_rpc/src/build/shelf_rpc_builder.dart';

Builder shelfRpcBuilder([BuilderOptions? options]) {
  return ShelfRpcBuilder(options);
}
