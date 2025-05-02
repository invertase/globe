import 'dart:async';
import 'dart:convert';

import 'package:globe_ai/generated/openai.pbserver.dart';
import 'package:globe_runtime/globe_runtime.dart';

sealed class AiProvider {
  static const String moduleName = 'GlobeAISdk';
  static const String codeURL = "dist/globe_ai.js";

  final String apiKey;

  const AiProvider(this.apiKey);

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

sealed class OpenAiModel<T, Z> {
  Future<T> generateText({required String prompt});

  Stream<Z> streamText({required String prompt});
}

class ChatModel extends OpenAiModel<String, ChatCompletionChunk> {
  final OpenAI _openAI;
  final String model;

  ChatModel._(this._openAI, this.model);

  @override
  Future<String> generateText({
    required String prompt,
  }) async {
    await _openAI._registerModuleIfNotAlready();

    final completer = Completer<String>();

    _openAI._runtime.callFunction(
      AiProvider.moduleName,
      function: 'openai_chat_generate_text',
      args: [model.toFFIType, prompt.toFFIType, ''.toFFIType],
      onData: (data) {
        if (data.hasError()) {
          completer.completeError(data.error);
          return true;
        }

        completer.complete(utf8.decode(data.data));
        return true;
      },
    );

    return completer.future;
  }

  @override
  Stream<ChatCompletionChunk> streamText({
    required String prompt,
  }) async* {
    await _openAI._registerModuleIfNotAlready();

    final streamController = StreamController<ChatCompletionChunk>();

    _openAI._runtime.callFunction(
      AiProvider.moduleName,
      function: 'openai_chat_stream_text',
      args: [model.toFFIType, prompt.toFFIType, ''.toFFIType],
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

class OpenAI extends AiProvider {
  final OpenAIConfig config;
  OpenAI(this.config) : super(config.apiKey);

  ChatModel chat(String model) => ChatModel._(this, model);
}
