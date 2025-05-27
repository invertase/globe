import 'dart:io';

import 'package:globe_ai/generated/openai.pbserver.dart' as openai_gen;

export 'package:globe_ai/generated/openai.pbserver.dart'
    show OpenAIConfig, OpenAIMessage;

final class OpenAIContent {
  const OpenAIContent._();

  static openai_gen.OpenAIInput text(String text) {
    return openai_gen.OpenAIInput(text: text);
  }

  static openai_gen.OpenAIInput file(File file, {required String? mimeType}) {
    return openai_gen.OpenAIInput(
      file: openai_gen.FileInput(
        data: file.readAsBytesSync(),
        name: file.path.split(Platform.pathSeparator).last,
        mimeType: mimeType,
      ),
    );
  }
}
