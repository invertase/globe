import 'dart:async';

import 'package:globe_ai/generated/openai.pbserver.dart';
import 'package:globe_runtime/globe_runtime.dart';

abstract class AiProvider {
  final String? baseUrl;
  final String name;
  final String apiKey;

  const AiProvider({this.baseUrl, required this.name, required this.apiKey});
}

class OpenAIProvider extends AiProvider {
  const OpenAIProvider({super.baseUrl, required super.apiKey})
      : super(name: 'OpenAI');
}

class GeminiAIProvider extends AiProvider {
  const GeminiAIProvider({required super.apiKey}) : super(name: 'Gemini');
}

final class GlobeAISdk {
  static const String _moduleName = 'GlobeAISdk';
  static const String _codeURL = "packages/globe_ai/dist/globe_ai.js";

  final GlobeRuntime _runtime;
  final AiProvider provider;

  GlobeAISdk._(this.provider, this._runtime);

  Future<void> _registerModuleIfNotAlready() async {
    final instance = GlobeRuntime.instance;
    if (instance.isModuleRegistered(_moduleName)) return;
    return GlobeRuntime.instance.registerModule(
      _moduleName,
      _codeURL,
      args: [provider.apiKey.toFFIType],
    );
  }

  static GlobeAISdk create(AiProvider provider) => GlobeAISdk._(
        provider,
        GlobeRuntime.instance,
      );

  Future<ChatCompletion> complete({
    required String query,
    required String model,
  }) async {
    await _registerModuleIfNotAlready();

    final completer = Completer<ChatCompletion>();

    _runtime.callFunction(
      _moduleName,
      function: "${provider.name.toLowerCase()}_chat_complete",
      args: [model.toFFIType, query.toFFIType],
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

  Stream<ChatCompletionChunk> stream({
    required String query,
    required String model,
  }) async* {
    await _registerModuleIfNotAlready();

    final streamController = StreamController<ChatCompletionChunk>();

    _runtime.callFunction(
      _moduleName,
      function: "${provider.name.toLowerCase()}_chat_complete_stream",
      args: [model.toFFIType, query.toFFIType],
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
