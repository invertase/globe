import 'dart:io';

import 'package:globe_ai/globe_ai.dart';
import 'package:luthor/luthor.dart';

void main() async {
  final result1 = await generateText(
    model: openai.chat('gpt-4o', reasoningEffort: ReasoningEffort.high),
    prompt: 'Who is the president of the United States?',
  );
  stdout.writeln(result1);

  final schema = l.schema({
    'recipe': l.schema({
      'name': l.string().required(),
      'ingredients': l.list(validators: [
        l.schema({
          'name': l.string().required(),
          'amount': l.string().required(),
        }).required(),
      ]).required(),
      'steps': l.list(validators: [l.string()]).required(),
    }).required()
  });

  final result2 = await generateObject<Map<dynamic, dynamic>>(
    model: openai('gpt-4.1', structuredOutputs: true),
    prompt: 'Generate a lasagna recipe.',
    schema: ObjectSchema(
      name: 'recipe',
      description: 'A recipe for lasagna.',
      schema: schema,
    ),
  );
  print(result2);

  exit(0);
}
