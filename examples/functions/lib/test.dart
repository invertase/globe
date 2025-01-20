import 'rpc_client.g.dart';

void main() async {
  final client = RpcClient('https://example.com');

  final r5 = await client.users.details();
  final r6 = await client.users.details.get();
}
