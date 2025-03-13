# Globe Auth Rest Client

This is a generated HTTP rest client for Globe.

This client is not intended to be used standalone.

## Generating

To regenerate the library, run:

```
./generate
```

## Usage

Import the client and call a method.

```dart
import 'package:globe_auth_rest_client/globe_auth_rest_client.dart';
import 'package:dio/dio.dart';

void main() async {
  final client = GlobeAuthRestClient(Dio(
    BaseOptions(baseUrl: 'https://auth-server.com'),
  ));
  final response = await client.root.getOk();
  print(response.ok);
}
```