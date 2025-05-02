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

  final chat = OpenAI(config).chat('gpt-4o');
  // final result = await chat.generateText(
  //   prompt: 'Who is the president of the United States?',
  // );
  // stdout.writeln(result);

  final stream = chat.streamText(prompt: 'Tell me short 5 line story');
  await for (final data in stream) {
    stdout.write(data.choices[0].delta.content);
  }

  exit(0);
}
