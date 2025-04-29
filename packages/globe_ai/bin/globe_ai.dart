import 'dart:io';

import 'package:globe_ai/globe_ai.dart';

// ignore: constant_identifier_names
final String openAIKey = (throw StateError(
    'Please set your OpenAI API key in the OpenAIKey constant.'));

void main() async {
  final globeAI = GlobeAISdk.create(OpenAIProvider(apiKey: openAIKey));

  final result = await globeAI.complete(
    model: 'gpt-4o',
    query: 'Who is the president of the United States?',
  );
  stdout.writeln(result.choices[0].message.content);

  // stream
  final stream = globeAI.stream(
    model: 'gpt-4o',
    query: 'Tell me short 5 line story',
  );
  await for (final data in stream) {
    stdout.write(data.choices[0].delta.content);
  }

  exit(0);
}
