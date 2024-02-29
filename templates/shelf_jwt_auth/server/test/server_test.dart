import 'dart:io';

import 'package:spookie/spookie.dart';

void main() {
  final url = Uri(port: 8080, scheme: 'http', host: '0.0.0.0');
  final Spookie apiAgent = Spookie.uri(url);

  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': url.port.toString()},
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('404', () async {
    await apiAgent.get('/me').expectStatus(HttpStatus.unauthorized).test();
  });

  test('/signin', () async {
    await apiAgent
        .token('Hello WOrld')
        .post('/signin', {})
        .expectStatus(200)
        .expectBody('Hello, World!')
        .test();
  });

  test('/signup', () async {
    await apiAgent.post('/signup', {'hello': 'hello'}).expectStatus(200).test();
  });
}
