import 'package:build/build.dart';
import 'package:globe_functions/src/build/entrypoint_builder.dart';
import 'package:globe_functions/src/build/rpc_client_builder.dart';
import 'package:globe_functions/src/build/source_functions_builder.dart';

Builder sourceFunctionsBuilder([BuilderOptions? options]) {
  return SourceFunctionsBuilder();
}

Builder createEntrypointBuilder([BuilderOptions? options]) {
  return EntrypointBuilder();
}

Builder createRpcClientBuilder([BuilderOptions? options]) {
  return RpcClientBuilder();
}
