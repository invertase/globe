import 'dart:io';

import 'package:globe_ai/generated/openai.pbserver.dart';
import 'package:globe_ai/globe_ai.dart';

// ignore: constant_identifier_names
final String openAIKey = (throw StateError(
    'Please set your OpenAI API key in the OpenAIKey constant.'));

void main() async {
  final config = OpenAIConfig(
    apiKey: openAIKey,
    compatibility: Compatibility.STRICT,
  );

  final openAi = OpenAI(config);
  final result = await openAi.generateText(
    'gpt-4o',
    prompt: 'Who is the president of the United States?',
  );
  stdout.writeln(result.choices[0].message.content);

  // stream
  final stream = openAi.generateTextStream(
    'gpt-4o',
    prompt: 'Tell me short 5 line story',
  );
  await for (final data in stream) {
    stdout.write(data.choices[0].delta.content);
  }

  exit(0);
}
