import 'package:http/http.dart' as http;

abstract class RpcBaseClient {
  final String baseUrl;
  final http.Client _client;
  final String path;

  RpcBaseClient(this.baseUrl, this._client, this.path);

  String get fullPath => '$baseUrl/$path';
}

class UsersSegment extends RpcBaseClient {
  UsersSegment(String baseUrl, http.Client client) 
      : super(baseUrl, client, 'users');

  UsersDetailsSegment get details => UsersDetailsSegment(baseUrl, _client);

}

class UsersDetailsSegment extends RpcBaseClient {
  UsersDetailsSegment(String baseUrl, http.Client client) 
      : super(baseUrl, client, 'users/details');

  Future<String> call() async {
    final response = await _client.get(Uri.parse(fullPath));
    return response.body as String;
  }

  Future<String> get() async {
    final response = await _client.get(Uri.parse('$fullPath/get'));
    return response.body as String;
  }

}

class RpcClient {
  final String baseUrl;
  final http.Client _client;

  RpcClient(this.baseUrl, [http.Client? client]) 
      : _client = client ?? http.Client();

  UsersSegment get users => UsersSegment(baseUrl, _client);
}
