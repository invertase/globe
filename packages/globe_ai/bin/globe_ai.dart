import 'dart:io';

import 'package:globe_ai/globe_ai.dart';
import 'package:luthor/luthor.dart';

void main() async {
  print('Method: :generateText\n');
  final result1 = await generateText(
    model: openai.chat('gpt-4o', user: 'Chima'),
    prompt: 'Who is the president of Ghana?',
  );
  print(result1);

  print('\nMethod:generateObject with Schema\n');
  final schema = l.schema({
    'recipe': l.schema({
      'name': l.string(),
      'ingredients': l.list(validators: [
        l.schema({
          'name': l.string(),
          'amount': l.string(),
        }),
      ]),
      'steps': l.list(validators: [l.string()]),
    })
  });
  final result2 = await generateObject<Map<dynamic, dynamic>>(
    model: openai('gpt-4.1'),
    prompt: 'Generate a lasagna recipe.',
    schema: schema,
  );
  print(result2);

  print('\nMethod:streamText\n');
  final result3 = streamText(
    model: openai('o4-mini'),
    prompt: 'Tell me about the Mission burrito debate in San Francisco.',
  );

  final buffer = StringBuffer();
  await for (final chunk in result3) {
    buffer.write(chunk);
  }

  print(buffer.toString());

  exit(0);
}
