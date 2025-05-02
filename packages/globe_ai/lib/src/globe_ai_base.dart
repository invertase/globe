import 'dart:async';

import 'package:globe_ai/generated/openai.pbserver.dart';
import 'package:globe_runtime/globe_runtime.dart';

sealed class AiProvider {
  static const String moduleName = 'GlobeAISdk';
  static const String codeURL = "dist/globe_ai.js";

  final String name;
  final String apiKey;

  const AiProvider({required this.name, required this.apiKey});

  GlobeRuntime get _runtime => GlobeRuntime.instance;

  Future<void> _registerModuleIfNotAlready() async {
    if (_runtime.isModuleRegistered(moduleName)) return;
    return _runtime.registerModule(
      moduleName,
      codeURL,
      args: [apiKey.toFFIType],
    );
  }
}

class OpenAI extends AiProvider {
  final OpenAIConfig config;
  OpenAI(this.config) : super(name: 'OpenAI', apiKey: config.apiKey);

  Future<ChatCompletion> generateText(
    String model, {
    required String prompt,
    String? user,
  }) async {
    await _registerModuleIfNotAlready();

    final completer = Completer<ChatCompletion>();

    _runtime.callFunction(
      AiProvider.moduleName,
      function: 'openai_generate_text',
      args: [model.toFFIType, prompt.toFFIType],
      onData: (data) {
        if (data.hasError()) {
          completer.completeError(data.error);
          return true;
        }

        final response = ChatCompletion.fromBuffer(data.data);
        completer.complete(response);
        return true;
      },
    );

    return completer.future;
  }

  Stream<ChatCompletionChunk> streamText(
    String model, {
    required String prompt,
    String? user,
  }) async* {
    await _registerModuleIfNotAlready();

    final streamController = StreamController<ChatCompletionChunk>();

    _runtime.callFunction(
      AiProvider.moduleName,
      function: 'openai_stream_text',
      args: [model.toFFIType, prompt.toFFIType],
      onData: (data) {
        if (data.hasError()) {
          streamController
            ..addError(data.error)
            ..close();
          return true;
        }

        if (data.hasData()) {
          final chunk = ChatCompletionChunk.fromBuffer(data.data);
          streamController.add(chunk);
        }

        if (data.done) {
          streamController.close();
          return true;
        }

        return false;
      },
    );

    yield* streamController.stream;
  }
}
