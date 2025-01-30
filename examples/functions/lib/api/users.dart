// import 'package:functions/models.dart';
// import 'package:globe_functions/globe_functions.dart';
// import 'package:shelf/shelf.dart';
// import 'package:shelf_cors_headers/shelf_cors_headers.dart';

// const corsMiddleware = corsHeaders();

// final p = Pipeline();
// final withCors = p.addMiddleware(corsMiddleware);
// final withAuth = p.addMiddleware(authMiddleware);

// @RpcFunction()
// User? example1(String name, {Address? address}) {
//   return User(name: 'John', address: address);
// }

// @HttpFunction('/users')
// Future<User> example2() async {
//   return User(name: 'John');
// }

// @HttpFunction('/users/me')
// DateTime example3() {
//   return DateTime.now();
// }

// @HttpFunction('/users/me2')
// Future<String> example4() async {
//   return 'Hello';
// }

// const Register {
//   const Register();
// }

// const register = Register();


// // api/users.dart

// // Some middleware pipelines.
// final p = Pipeline();
// final withCors = p.addMiddleware(corsMiddleware);
// final withAuth = p.addMiddleware(authMiddleware);

// @register
// final app = Functions()
//     .rpc(example1, pipeline: withCors)
//     .cron('* * * * *', example2)
//     .get('/users', example2)
//     .post('/users/me', example3)
//     .patch('/users/me2', example4)
//     .any('/users/me3', example5);

// // client generated from this
// // void main() async {
// //   final client = Client('https://localhost:8080');
// //   await client.rpc.example1('John'); // Future<User>
// //   await client.users.example2.invoke(); // Future<void>
// //   await client.http.get('/users'); // Future<Response>
// //   // etc
// // }



