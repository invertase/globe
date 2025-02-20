// ignore_for_file: unused_local_variable

import 'package:globe_kv/globe_kv.dart';

void main() async {
  final kv = GlobeKV.inmemory('test');

  final value = await kv.get<int>('test');
  final str = await kv.getString('test');
  final number = await kv.getNumber('test');
  final bool = await kv.getBool('test');
  final binary = await kv.getBinary('test');
  await kv.set('test', 'test');
  await kv.delete('test');
  await kv.list();
}
