import 'dart:io';

import 'package:globe_ai/generated/openai.pbserver.dart' as openai_gen;

export 'package:globe_ai/generated/openai.pbserver.dart'
    show OpenAIConfig, AIMessage;

final class AIContent {
  const AIContent._();

  static openai_gen.AIInput text(String text) {
    return openai_gen.AIInput(text: text);
  }

  static openai_gen.AIInput file(File file, {required String? mimeType}) {
    return openai_gen.AIInput(
      file: openai_gen.FileInput(
        data: file.readAsBytesSync(),
        name: file.path.split(Platform.pathSeparator).last,
        mimeType: mimeType,
      ),
    );
  }
}
