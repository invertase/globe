# 🌍 GlobeKV - A Simple Key-Value Storage for Dart

GlobeKV is a lightweight and efficient key-value storage system for Dart applications. It supports storing various data types, including strings, numbers, booleans, and binary values, with optional expiration times.

## 📦 Installation

Add `globe_kv` to your `pubspec.yaml`:

```yaml
dependencies:
  globe_kv: latest
```

Then, run:

```sh
dart pub get
```

## 🚀 Features

- Store and retrieve **strings, numbers, booleans, and binary data**.
- **Delete** stored values.
- **List keys** with a specified prefix.
- Support for **TTL (time-to-live)** and **expiration timestamps**.

## 🔧 Usage

### 1️⃣ Initialize the Storage

```dart
import 'package:globe_kv/globe_kv.dart';

void main() async {
  final kv = GlobeKV('myStorage');
}
```

### 2️⃣ Store and Retrieve Values

```dart
await kv.set('username', 'JohnDoe');
print(await kv.getString('username')); // Output: JohnDoe
```

### 3️⃣ Store and Retrieve Different Data Types

```dart
await kv.set('age', 30);
print(await kv.getNumber('age')); // Output: 30

await kv.set('isAdmin', true);
print(await kv.getBool('isAdmin')); // Output: true

final binaryData = [1, 2, 3, 4, 5];
await kv.set('file', binaryData);
print(await kv.getBinary('file')); // Output: [1, 2, 3, 4, 5]
```

### 4️⃣ Delete a Value

```dart
await kv.set('session', 'active');
await kv.delete('session');
print(await kv.get('session')); // Output: null
```

### 5️⃣ List Stored Keys with a Prefix

```dart
await kv.set('user_1', 'Alice');
await kv.set('user_2', 'Bob');
await kv.set('admin', 'Charlie');

final users = await kv.list(prefix: 'user_');
print(users.results.map((e) => e.key)); // Output: ['user_1', 'user_2']
```

### 6️⃣ Set Values with Expiration (TTL)

```dart
await kv.set('temp_key', 'This will expire', ttl: 5);
await Future.delayed(const Duration(seconds: 6));
print(await kv.getString('temp_key')); // Output: null
```

### 7️⃣ Set Values to Expire at a Specific Time

```dart
final expireTime = DateTime.now().add(const Duration(seconds: 3));
await kv.set('session_token', 'secure_value', expires: expireTime);
await Future.delayed(const Duration(seconds: 4));
print(await kv.getString('session_token')); // Output: null
```

## 🧪 Running Tests

To run the test suite:

```sh
dart test
```

## 📜 License

MIT License. See `LICENSE` for details.

---

🚀 **GlobeKV** - Simple, efficient key-value storage for Dart!
