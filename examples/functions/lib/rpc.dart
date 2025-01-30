import 'dart:async';

import 'package:functions/models.dart';
import 'package:globe_functions/globe_functions.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

Future<List<User?>> hello(String arg, {required User user}) async {
  return [];
}

extension on String {
  int getStringLength() => length;
}

class Bar {
  factory Bar() => Bar._();
  factory Bar.baz(String foo) => Bar._();
  static Bar foo() => Bar._();
  Bar._();

  String hello(String arg, {required User user}) {
    return 'hello';
  }

  Map<String, dynamic> toJson() => {};

  factory Bar.fromJson(Map<String, dynamic> json) {
    return Bar._();
  }
}

Null neverFunction() => null;

Future<User> dynamicFunction() async => User(name: 'Bob');

// Use shelf middleware directly
final r = ShelfRpc().use(logRequests());
final publicProcedure = r.procedure().use(corsHeaders());
@registerRpcEntry
final api = r.router({
  // #voidReturn: r.procedure().exec(() {}),
  // #nullReturn: r.procedure().exec(method: ProcedureMethod.get, () => null),
  // // #neverReturn: r.procedure().exec(neverFunction),
  // #sayHello: r.procedure().exec(hello),
  // #fnTearOff: r.procedure().exec(() => 123),
  // // Method tear off
  // #methodTearOff: r.procedure().exec(Bar().hello),
  // // Factory tear off
  // #factoryTearOff: r.procedure().exec(Bar.baz),
  // // Static method tear off
  // #staticMethodTearOff: r.procedure().exec(Bar.foo),
  // // Extension method tear off
  // #extensionMethodTearOff: r.procedure().exec('hello'.getStringLength),
  // // Basic procedure with no middleware
  // #basic: r.procedure().exec(() => 'hello world'),
  // // Procedure with typed parameters
  // #typed: r.procedure().exec(
  //   (int num, String text, [List<String> list = const []]) async =>
  //       '$text: $num',
  // ),
  // // Procedure with named parameters
  // #named: r.procedure().exec(({required String name}) => 'Hello $name'),
  // // Procedure with both positional and named parameters
  // #mixed: r.procedure().exec(hello),
  // // Async procedure returning Future
  // #chained: publicProcedure.exec(hello),
  // #optional: publicProcedure.exec((String foo, [String bar = 'bar']) => ['']),
  // #async: r.procedure().exec(() async => 'async result'),
  // #dynamic: r.procedure().exec(dynamicFunction),
  // // Stream response

  // #stream: r.procedure().exec(
  //   () async => Stream<User?>.periodic(
  //     Duration(seconds: 1),
  //     (i) => User(name: 'tick $i'),
  //   ),
  // ),
  // #iterable: r.procedure().exec(() => Iterable<User?>.empty()),
  // #async2: r.procedure().exec(() async => List<Object?>.empty()),
  // #datetime: r.procedure().exec(
  //   ({required RequestContext ctx, RequestContext? ctx2, String? foo}) =>
  //       DateTime.now(),
  // ),
  // #innerRecursionCustom: r.procedure().exec(
  //   () => <List<List<List<User?>>>>[
  //     [
  //       [
  //         [User(name: 'Alice')],
  //         [null],
  //       ],
  //       [
  //         [User(name: 'Alice')],
  //         [User(name: 'Alice')],
  //       ],
  //     ],
  //   ],
  // ),
  // #innerRecursion: r.procedure().exec(
  //   () => <List<List<List<String?>>>>[
  //     [
  //       [
  //         [null, 'foooooo'],
  //       ],
  //     ],
  //   ],
  // ),
  // #innerMap: r.procedure().exec(
  //   () async => <String, Map<String, List<User?>>>{
  //     'foo': {
  //       'bar': [User(name: 'Alice')],
  //     },
  //   },
  // ),
  // #type: r.procedure().exec(() => User(name: 'Bob')),
  #params: r.procedure().exec(
    (
      User? user, {
      required String name,
      int age = 10,
      String email = 'test@test.com',
      Map<String, String?> meta = const {},
    }) => 'hello',
  ),

  #nested: r.router({
    #sub1: r.procedure().exec(() => 'nested 1'),
    #sub2: r.router({#sub3: r.procedure().exec(() => 'nested 3')}),
  }),

  // #ctx: r.procedure().exec((String foo, RequestContext ctx) => foo),
  // #record: r.procedure().exec(() => (user: User(name: 'Bob'))), // invalid
  // #function: r.procedure().exec(() => () => 'hello'), // invalid
  // #asyncParam: r.procedure().exec((Future<User> user) => 'hello'), // invalid
  // // Using custom types
  // #user: r.procedure().exec(() => User(name: 'Bob')),
  // // Nested router example
  // #nested: r.router({
  //   #sub1: r.procedure().exec(() => 'nested 1'),
  //   #sub2: r.procedure().exec(() => 'nested 2'),
  // }),

  // // Complex example combining multiple features
  // #complex: publicProcedure.exec((int id, {required User user}) async {
  //   // req.put<DbService>(DbService()); // in middleware
  //   // final db = req.get<DbService>();
  //   return User(name: 'User $id: ${user.name}');
  // }),
});

// @registerRpcEntry
// final foo = r.router({
//   #nest1: r.router({
//     #done: publicProcedure.exec(() => ['user1', 'user2']),
//     #nest2: r.router({
//       #done: publicProcedure.exec(() => ['user1', 'user2']),
//     }),
//   }),
// });
