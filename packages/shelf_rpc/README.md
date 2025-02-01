# Shelf RPC

A type-safe server-client RPC (Remote Procedure Call) library for Dart, built on-top of [Shelf](https://pub.dev/packages/shelf). 

Shelf RPC handles the complexity of building a server side APIs in Dart, without having to worry about the complexities such as routing, middleware, serialization etc, and also provides a client to call your procedures from your client (e.g. Flutter app) with full type safety.

## Features

- 🚀 **Type-safe**: Full end-to-end type safety between client and server, with custom class support
- 🛠️ **Easy Integration**: Seamlessly integrates with existing Shelf applications and middleware
- 🔌 **Dependency Injection**: Built-in DI integration with Shelf
- 📡 **Server-Sent Events**: Built-in support for real-time streaming using SSE

## How it works

Create a file within your project which defines your RPC procedures:

```dart
// lib/rpc.dart
import 'package:shelf_rpc/shelf_rpc.dart';

final r = ShelfRpc();

@RpcEndpoint()
final api = r.router({
  /// Say hello to the given name
  #sayHello: r.procedure().exec((String name) => 'Hello, $name!'),
});
```

Using build_runner, this will generate two files:

- `rpc.client.dart`: An RPC client to call your procedures from your client (e.g. Flutter app). See [RPC Client](#rpc-client) for more details.
- `rpc.server.dart`: A file containing Shelf [Pipeline](https://pub.dev/documentation/shelf/latest/shelf/Pipeline-class.html)s to hook up to your Shelf server. See [RPC Server](#rpc-server) for more details.

Within your client, you can call your procedures like so:

```dart
final client = RpcClient.api(Uri.parse('http://localhost:8080'));
final result = await client.sayHello('John');
print(result); // Hello, John!
```

## Getting Started

### Installation

Firstly install the `shelf_rpc` package, and additionally `shelf` and `build_runner` if you haven't already:

```sh
dart pub add shelf_rpc shelf
dart pub add dev:build_runner
```

### Define RPC endpoints

You can define one or more RPC endpoints in a file, and use the `@RpcEndpoint()` annotation to mark the file as an RPC endpoint. This must annotate a public top-level variable which returns a `RpcRouter`. Create a file in your project, e.g. `rpc.dart`, and define your endpoints like so:

```dart
final r = ShelfRpc();

@RpcEndpoint()
final api = r.router({
  // ...
});
```

### Define RPC Procedures

Once you have defined an entrypoint with a router, you can define procedures on that router (or nest routers).

A procedure is a function which accepts parameters, and returns a value. What happens within this function is up to you, but the key part is that the functionality is server-side only, meaning you can communicate with databases, other services etc.

Shelf RPC automatically handles the serialization and deserialization of parameters and return values, so you can pass in and out many Dart types, including custom classes. Below is an example of some procedures to give you an idea of how they work.

```dart
import 'models.dart' show User;

User getUser(String name) => User(name: name);

@RpcEndpoint()
final api = r.router({
  // Tear off the function reference to getUser.
  #getUser: r.procedure().exec(getUser),

  // Procedure which returns a DatTime object (not serializable by default, but handled by Shelf RPC)
  #getTime: r.procedure().exec(() => DateTime.now()),

  // Procedure which returns a Future<List<User>>
  #getUsers: r.procedure().exec(() async {
    // Fetch users from a database (e.g. Postgres)
    final users = await queryDatabase('SELECT * FROM users');
    return users.map((e) => User.fromJson(e)).toList();
  }),

  // Procedure which streams the results back to the client
  #listUsers: r.procedure().exec(() async* {
    // Stream results from a database query
    final stream = queryDatabaseAsStream('SELECT * FROM users');
    
    // As the stream sends events, yield them to the client
    await for (final row in stream) {
      yield User.fromJson(row);
    }
  }),

  // Procedure which accepts complex parameters
  #createUser: r.procedure().exec((User user, {String? address}) async {
    await insertUser(user.toJson(), address);
  }),

  // A nested router (can be many levels deep)
  #users: r.router({
    #get: r.procedure().exec((String id) => [User(name: id)]),
  }),
});
```

### Generate RPC Client and Server

To generate the RPC client and server, run `dart pub run build_runner build` within your project.

Two files will be generated next to your file containing the entrypoints, with `.client.dart` and `.server.dart` suffixes.

## RPC Client

The `.client.dart` file contains a `RpcClient` class which you can use to call your RPC endpoints from your client. Import this file in your client code, for example a Flutter application. The class exposes static methods for each endpoint defined in your server file, for example:

```dart
// lib/client.dart
import 'rpc.client.dart';

void main() async {
  // Create a client instance pointing to your server
  final client = RpcClient.api(Uri.parse('http://localhost:8080'));

  await client.sayHello('John'); // Hello, John!
  await client.getUser('123'); // User(name: 'John')
  await client.getUsers(); // List<User>
  await client.listUsers(); // Stream<User>
  await client.createUser(User(name: 'John'), address: '123 Main St'); // null
  await client.users.get('123'); // [User(name: 'John')]
}
```

### RPC Server

The `.server.dart` file contains a `Pipeline` for each endpoint defined in your file. Shelf RPC is designed to be plugged into your existing Shelf application, rather than being a standalone server. You can easily mount a generated `Pipeline` into your existing Shelf application like so:

```dart
// lib/server.dart
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

// Import the generated server file
import 'rpc.server.dart' as rpc;

void main() async {
  // Mount the generated pipeline into your existing Shelf application at the root.
  // Alternatively, you can mount the pipeline at a specific path, e.g. '/api'.
  var server = await shelf_io.serve(rpc.api, 'localhost', 8080);
  print('Serving at http://${server.address.host}:${server.port}');
}
```

## Middleware

Shelf RPC is designed to be used with Shelf middleware. You can easily add middleware to your RPC endpoints by using the `use` method on the `ShelfRpc` instance or a procedure. This allows you to build composable middleware for your RPC endpoints. 

### Global Middleware

You can add global middleware to your RPC endpoints by using the `use` method on the `ShelfRpc` instance. This middleware will be applied to all RPC procedures using the instance.

```dart
import 'package:shelf_rpc/shelf_rpc.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

final r = ShelfRpc().use(corsHeaders());

@RpcEndpoint()
final api = r.router({
  // ...
});
```

### Procedure Middleware

You can also add middleware to a specific procedure by using the `use` method on the procedure. This middleware will only be applied to the procedure it is called on. This allows you to compose middleware for specific procedures, for example you may want to have "authentcated" procedures, or "admin" procedures, for example:

```dart
import 'package:shelf_rpc/shelf_rpc.dart';

final r = ShelfRpc();
// Attach some middleware to the procedure which checks for some auth token (e.g. JWT in the header).
final authenticated = r.procedure().use(jwtAuth());

// Attach some middleware to the procedure which checks if the JWT token from the authenticated procedure is for an admin user.
final admin = authenticated.use(isAdmin());

@RpcEndpoint()
final api = r.router({
  // Only authenticated users can access this endpoint
  #getPosts: authenticated.exec(...),
  // Only admin users can access this endpoint
  #deletePost: admin.exec(...),
});
```

## Server vs Client code

Any code defined within your RPC file is server-side only (an `io` environment). This means that you cannot define client-side code within your RPC file, and you cannot define server-side code within your client file.

It is however common to define types which are shared between the client and server, such as `User` or `Post` classes. Shelf RPC imports these types from their source file in both generated the server and client code, therefore your shared types should be defined in a separate file which has no reference to client or server code.

A typical filename for shared types is `models.dart`.

## Serialization

Shelf RPC supports the following types out of the box:

- `String`
- `int`
- `double`
- `bool`
- `List`
- `Map`
- `Iterable`
- `Stream`
- `DateTime`
- `Duration`
- `RegExp`
- `Uri`
- `UriData`
- `Uint8List`
- `BigInt`

Note that `dynamic` and `Object` are not supported, you must provide concrete types.

### Custom Types

When providing custom types, such as a `User` class, you must enure that the class is serializable, by ensuring that the class has a `toJson` method and a `fromJson` factory constructor, e.g.

```dart
class User {
  final String name;

  User({required this.name});

  Map<String, dynamic> toJson() => {'name': name};

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
    );
  }
}
```

Alternatively, you can use 3rd party packages such as [json_serializable](https://pub.dev/packages/json_serializable) to automatically generate the `toJson` and `fromJson` methods for your class.

## Rules of RPC

There's a number of rules to follow whilst using Shelf RPC:

1. Entrypoints must be public top-level variables.
2. Router keys (Symbols) must not start with an `_` and can only contain alphanumeric characters.
3. Duplicate router keys are not allowed and will be skipped,
4. All entrypoints must return a `RpcRouter` instance.
5. Any types which are not listed above must be serializable, see [Serialization](#serialization) for more details.

TODO: Explain that functions, records, param futures, nested async types, etc are not supported.

