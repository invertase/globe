// import 'package:functions/models.dart';
// import 'package:globe_functions/globe_functions.dart';

import 'package:functions/functions.dart';
import 'package:globe_functions/globe_functions.dart';

@RpcFunction()
Future<Person> get(String name, {Person? user}) async {
  return Person('elliot', 30);
}

// @HttpFunction()
// Future<int> getNumer(String name, {User? user, DateTime? date}) async {
//   return 3;
// }

// @HttpFunction()
// Future<User> updateUserDetails(
//   String userId,
//   List<String> roles, [
//   String? department = 'General',
//   int accessLevel = 1,
// ]) async {
//   return User(name: userId);
// }

// @HttpFunction()
// Future<User> createUserProfile(
//   String name, {
//   required List<String> permissions,
//   String? title,
//   Map<String, dynamic> metadata = const {},
//   bool isActive = true,
//   int priority = 0,
// }) async {
//   return User(name: name);
// }
