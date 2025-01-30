import 'package:functions/models.dart';
import 'package:functions/rpc.client.dart';

void main() async {
  final client = RpcClient.api(uri: Uri.parse('http://localhost:8080'));

  final r0 = await client.params(User(name: 'John'), name: 'John');
  final r1 = await client.nested.sub1();
  final r2 = await client.nested.sub2.sub3();
}

