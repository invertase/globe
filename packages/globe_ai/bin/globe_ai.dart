import 'dart:io';

import 'package:globe_ai/globe_ai.dart';

void main() async {
  print('Method: :generateText\n');
  final textResponse = await generateText(
    model: openai.chat('gpt-4o', user: 'Chima'),
    prompt: 'In a single line, tell me who Tim Cook is?',
  );
  print(textResponse);

  print('\nMethod: :generateText with Messages and File Input\n');
  final textWithPdf = await generateText(
    model: openai.chat('gpt-4o', user: 'Chima'),
    messages: [
      OpenAIMessage(
        role: 'user',
        content: [
          OpenAIInput(text: 'What is the title of this book?'),
          OpenAIInput(
            file: FileInput(
              data: File('bin/test_doc.pdf').readAsBytesSync(),
              mimeType: 'application/pdf',
              name: 'ai.pdf',
            ),
          ),
        ],
      ),
    ],
  );
  print(textWithPdf);

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

  print('\nMethod: :streamText with Messages and File Input\n');
  final streamTextWithPdf = streamText(
    model: openai.chat('gpt-4o', user: 'Chima'),
    messages: [
      OpenAIMessage(
        role: 'user',
        content: [
          OpenAIInput(text: 'Mention all the chapters and title in this book'),
          OpenAIInput(
            file: FileInput(
              data: File('bin/test_doc.pdf').readAsBytesSync(),
              mimeType: 'application/pdf',
              name: 'ai.pdf',
            ),
          ),
        ],
      ),
    ],
  );
  final buffer2 = StringBuffer();
  await for (final chunk in streamTextWithPdf) {
    buffer2.write(chunk);
  }
  print(buffer2.toString());

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

  print('\nMethod:streamObject with Schema\n');
  final schema2 = l.schema({
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
  final result4 = streamObject<Map<dynamic, dynamic>>(
    model: openai('gpt-4.1'),
    prompt: 'Generate a lasagna recipe.',
    schema: schema2,
  );
  await for (final chunk in result4) {
    print(chunk);
  }

  exit(0);
}
