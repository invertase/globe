import 'package:functions/models.dart';
import 'package:globe_functions/globe_functions.dart';

@RpcFunction()
User? example1(String? name) {
  return User(name: 'John');
}

@HttpFunction()
Future<User> example2() async {
  return User(name: 'John');
}

@HttpFunction()
DateTime example3() {
  return DateTime.now();
}

@HttpFunction()
Future<String> example4() async {
  return 'Hello';
}
