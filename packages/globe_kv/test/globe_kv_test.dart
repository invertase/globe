import 'package:globe_kv/globe_kv.dart';
import 'package:test/test.dart';

void main() {
  group('GlobeKV Memory Storage', () {
    late GlobeKV kv;

    setUp(() => kv = GlobeKV('test'));

    test('set and get string value', () async {
      await kv.set('key1', 'value1');
      expect(await kv.getString('key1'), equals('value1'));
    });

    test('set and get number value', () async {
      await kv.set('key2', 42);
      expect(await kv.getNumber('key2'), equals(42));
    });

    test('set and get boolean value', () async {
      await kv.set('key3', true);
      expect(await kv.getBool('key3'), equals(true));
    });

    test('set and get binary value', () async {
      final bytes = [1, 2, 3, 4, 5];
      await kv.set('key4', bytes);
      expect(await kv.getBinary('key4'), equals(bytes));
    });

    test('delete value', () async {
      await kv.set('key5', 'value5');

      final result = await kv.get('key5');
      expect(
        result,
        isA<KvValue<String>>().having((v) => v.value, 'having value', 'value5'),
      );

      await kv.delete('key5');
      expect(await kv.get('key5'), isNull);
    });

    test('list values', () async {
      await kv.set('prefix1_a', 'value1');
      await kv.set('prefix1_b', 'value2');
      await kv.set('prefix2_a', 'value3');

      final result = await kv.list(prefix: 'prefix1_');
      expect(result.results.length, equals(2));
      expect(result.results.map((e) => e.key),
          containsAll(['prefix1_a', 'prefix1_b']));
    });

    test('value expires after ttl', () async {
      await kv.set('key6', 'value6', ttl: 1);
      expect(await kv.getString('key6'), equals('value6'));

      await Future.delayed(const Duration(seconds: 2));
      expect(await kv.getString('key6'), isNull);
    });

    test('value expires at specific time', () async {
      final expireTime = DateTime.now().add(const Duration(seconds: 1));
      await kv.set('key7', 'value7', expires: expireTime);
      expect(await kv.getString('key7'), equals('value7'));

      await Future.delayed(const Duration(seconds: 2));
      expect(await kv.getString('key7'), isNull);
    });
  });
}
