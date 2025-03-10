# 🌍 GlobeKV - Key-Value Storage for Dart Applications, backed by [Globe](https://globe.dev).

GlobeKV is an eventually-consistent data storage system for storing and retrieving data from a global datastore, designed for high-reads at low latency. 

GlobeKV features:

- 🌍 Low-latency global key-value storage.
- 🎯 Strictly typed data for Dart.
- ⏰ TTL (time-to-live) expiration.
- 💻 Local development with in-memory or file-based storage.

Key-Value storage is useful for:

- Caching external data from slow APIs.
- Session data for Flutter applications.
- Feature flags and configuration data.
- User preferences and settings.

## Getting Started

To use GlobeKV in production, you need to have a Globe account, and a KV namespace to store your data.

In development, GlobeKV will use in-memory or file-based storage.

## 📦 Installation

Add `globe_kv` to your `pubspec.yaml`:

```yaml
dependencies:
  globe_kv: latest
```

Then install the dependencies with `dart pub get`.

## 🔧 Usage

Create a new `GlobeKV` instance, passing in your KV namespace.

```dart
import 'package:globe_kv/globe_kv.dart';

final kv = GlobeKV('namespace-id');
```

In development, GlobeKV will use in-memory storage so your data will be lost when the Dart app is restarted. To persist data to your local filesystem, use the `GlobeFileStore` instance:

```dart
final kv = GlobeKV('namespace-id', store: GlobeFileStore());
```

In production, the `store` will be ignored and fallback to the production GlobeKV datastore.

### Storing and Retrieving Data

```dart
// Set a value in KV
await kv.set('user:123', 'User 123');

// Get a value from KV
print(await kv.getString('user:123')); // Output: User 123
```

### Deleting Data

```dart
// Delete a value from KV
await kv.delete('user:123');
```

### Listing Keys

```dart
// List all keys with a prefix
final result = await kv.list(prefix: 'user:');
print(result.results.map((e) => e.key)); // Output: ['user:123']
```

Additionally, you can use the `list` method to paginate through all keys in the KV namespace in lexicographical order.

```dart
final result = await kv.list(prefix: 'user:', limit: 10); 

if (!result.complete) {
  // Fetch the next page
  final nextResult = await kv.list(prefix: 'user:', limit: 10, cursor: result.cursor!);
}
```

The maximum limit is 1000 keys per page.

## Expiring Data

You can set a value which will expire after a certain amount of time.

```dart
// Set a value that expires in 5 seconds
await kv.set('user:123', 'User 123', ttl: 5);

// Wait for the value to expire
await Future.delayed(const Duration(seconds: 6));

// Get the value after it has expired
print(await kv.getString('user:123')); // Output: null
```

Alternatively, you can set an absolute expiration date.

```dart
// Set a value that expires at a specific date
await kv.set('user:123', 'User 123', expires: DateTime.now().add(const Duration(seconds: 60)));
```

If providing both an expiration time and a TTL, the expiration time will take precedence.

## Data Types

The SDK supports fetching typed data from KV:

```dart
await kv.getString('...'); // String?
await kv.getInt('...'); // int?
await kv.getBool('...'); // bool?
await kv.getBinary('...'); // List<int>?
```

Alternatively, you can fetch and pattern match on the type:

```dart
final result = await kv.get('test');

switch (result) {
  case KvString r:
    // string
  case KvNumber r:
    // number
  case KvBoolean r:
    // boolean
  case KvBinary r:
    // binary
  case null:
    // null
}
```

## Hot vs Cold Reads

When reading data from KV, the [POP](https://en.wikipedia.org/wiki/Point_of_presence) (edge location) handling your request may not have this data cached locally, and has to read the value from the closest global datastore. This adds a small amount of latency to reading the data, also called a "cold read". 

Once that POP has read your data, by defaut it will cache it for 60 seconds. Subsequent reads from that same POP will result in a fast, low-latency read - a "hot read".

## Eventual Consistency

When updating a KV value, it may take up to 60 seconds for all users of your application to see these changes globally. This makes KV perfect for reading data which does not need to be fully consistent, such as caching, but not suitable for data which requires integtrity, such as financial transactions.

If your data is not updated frequently, you can instruct KV to cache the data on a POP for a longer duration resulting in more hot reads. This can be achived by providing the `ttl` argument to the `get` method, where `ttl` is the number of seconds to cache on a POP. This value can not be less than the default of `60`:

```dart
await kv.get('user:123', 'User 123', ttl: 60 * 60 * 24); // Cache for 24 hours
``` 

In this example, subsequent requests within the 24 hour period on the same POP will be served as a "hot" read with very-low latency.

If you set a long `ttl`, but later realise you require fresher data with a lower `ttl`, you can use call `get` with a new `ttl` value to override the previous value.

## 🧪 Running Tests

To run the test suite:

```sh
dart test
```

---

🚀 **GlobeKV** - Simple, efficient key-value storage for Dart!
