import 'dart:io';

import 'package:globe_ai/globe_ai.dart';

void main() async {
  print('Method: :generateText\n');
  final textResponse = await generateText(
    model: google('gemini-2.0-flash', user: 'Chima'),
    prompt: 'In a single line, tell me who Tim Cook is?',
  );
  print(textResponse);

  print('\nMethod: :generateText with Messages and File Input\n');
  final textWithPdf = await generateText(
    model: google('gemini-2.0-flash', user: 'Chima'),
    messages: [
      AIMessage(
        role: 'user',
        content: [
          AIContent.text('What is the title of this book?'),
          AIContent.file(
            File('bin/test_doc.pdf'),
            mimeType: 'application/pdf',
          ),
        ],
      ),
    ],
  );
  print(textWithPdf);

  print('\nMethod:streamText\n');
  final result3 = streamText(
    model: google('gemini-2.0-flash'),
    prompt: 'Tell me about the Mission burrito debate in San Francisco.',
  );

  final buffer = StringBuffer();
  await for (final chunk in result3) {
    buffer.write(chunk);
  }
  print(buffer.toString());

  print('\nMethod: :streamText with Messages and File Input\n');
  final streamTextWithPdf = streamText(
    model: google('gemini-2.0-flash'),
    messages: [
      AIMessage(
        role: 'user',
        content: [
          AIContent.text('Mention all the chapters and title in this book'),
          AIContent.file(
            File('bin/test_doc.pdf'),
            mimeType: 'application/pdf',
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
    model: google('gemini-2.0-flash'),
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
    model: google('gemini-2.0-flash'),
    prompt: 'Generate a lasagna recipe.',
    schema: schema2,
  );
  await for (final chunk in result4) {
    print(chunk);
  }

  exit(0);
}
