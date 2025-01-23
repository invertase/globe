abstract class GlobeFunction {
  const GlobeFunction();
}

class RpcFunction extends GlobeFunction {
  const RpcFunction();
}

class HttpFunction extends GlobeFunction {
  const HttpFunction();
}

enum GlobeFunctionType { rpc, http }
