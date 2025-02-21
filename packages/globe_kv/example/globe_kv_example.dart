// ignore_for_file: unused_local_variable

import 'package:globe_kv/globe_kv.dart';

void main() async {
  final kv = GlobeKV.inmemory();

  final untyped = await kv.get('test');

  switch (untyped) {
    case KvString r:
      print('key is string');
      print(r.value);
      break;
    case KvNumber r:
      print('key is number');
      print(r.value);
      break;
    case KvBoolean r:
      print('key is boolean');
      print(r.value);
      break;
    case KvBinary r:
      print('key is binary');
      print(r.value);
      break;
    case null:
      print('key is null');
      break;
  }
  final value = await kv.get<int>('test');
  final str = await kv.getString('test');
  final number = await kv.getNumber('test');
  final bool = await kv.getBool('test');
  final binary = await kv.getBinary('test');
  await kv.set('test', 'test');
  await kv.delete('test');
  await kv.list();
}
