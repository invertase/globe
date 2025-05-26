// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:globe_ai/generated/openai.pbserver.dart';
import 'package:globe_runtime/globe_runtime.dart';
import 'package:luthor/luthor.dart';
import 'package:version/version.dart';

import 'globe_ai_source.dart';
import 'object_schema.dart';

const _module = InlinedModule(name: 'GlobeAISdk', sourceCode: packageSource);

sealed class AiProvider {
  final String? apiKey;

  const AiProvider(this.apiKey);

  static AiProvider? _aiProviderInstance;
  static AiProvider _getInstance(String apiKey) {
    if (_aiProviderInstance != null) return _aiProviderInstance!;
    return _aiProviderInstance = OpenAI(OpenAIConfig(apiKey: apiKey));
  }

  Future<void> _registerModule() async {
    final currentVersion = Version.parse(GlobeRuntime.instance.version);
    if (currentVersion < Version(0, 0, 6)) {
      throw StateError(
        'Globe Runtime version $currentVersion is not supported. '
        'Please update runtime version.',
      );
    }

    await _module.register(args: [apiKey?.toFFIType]);
  }
}

abstract mixin class AiModel<T, Z> {
  String get apiKey;

  String get name;

  Map<String, dynamic> get options;
}

class ChatModel extends AiModel<String, String> {
  final OpenAI _openAI;
  final String model;

  @override
  final Map<String, dynamic> options;

  ChatModel._(this._openAI, this.model, {this.options = const {}});

  @override
  String get apiKey => _openAI.apiKey;

  @override
  String get name => model;
}

enum ReasoningEffort {
  low,
  medium,
  high,
}

class OpenAI extends AiProvider {
  final OpenAIConfig config;

  OpenAI(this.config) : super(config.apiKey);

  ChatModel chat(
    String model, {
    String? instance,
    String? user,
    Map<int, int>? logitBias,
    bool? downloadImages,
    bool? parallelToolCalls,
    bool? structuredOutputs,
    ReasoningEffort? reasoningEffort,
  }) =>
      ChatModel._(this, model, options: {
        'instance': instance ?? 'chat',
        if (user != null) 'user': user,
        if (logitBias != null) 'logitBias': logitBias,
        if (downloadImages != null) 'downloadImages': downloadImages,
        if (parallelToolCalls != null) 'parallelToolCalls': parallelToolCalls,
        if (structuredOutputs != null) 'structuredOutputs': structuredOutputs,
        if (reasoningEffort != null) 'reasoningEffort': reasoningEffort.name,
      });

  // defaults to chat model
  AiModel call(
    String model, {
    String? user,
    bool structuredOutputs = false,
    ReasoningEffort reasoningEffort = ReasoningEffort.medium,
  }) {
    return chat(
      model,
      instance: 'default',
      user: user,
      structuredOutputs: structuredOutputs,
      reasoningEffort: reasoningEffort,
    );
  }

  @override
  String get apiKey => config.hasApiKey()
      ? config.apiKey
      : Platform.environment['OPENAI_API_KEY'] ??
          (throw StateError(
            'Please set your OpenAI API key in the OpenAIKey constant.',
          ));
}

Future<String> generateText({
  required AiModel model,
  String? prompt,
  List<OpenAIMessage>? messages,
}) async {
  if ((prompt == null && messages == null) ||
      (prompt != null && messages != null)) {
    throw ArgumentError('Either prompt or messages must be provided.');
  }

  final openAiMessage = EitherMessagesOrPrompt(
    prompt: prompt,
    messages: messages == null ? null : OpenAIMessages(messages: messages),
  );

  final aiProvider = AiProvider._getInstance(model.apiKey);
  await aiProvider._registerModule();

  final completer = Completer<String>();

  _module.callFunction(
    'openai_chat_generate_text',
    args: [
      model.options.toFFIType,
      model.name.toFFIType,
      openAiMessage.writeToBuffer().toFFIType,
    ],
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

Future<T> generateObject<T>({
  required AiModel model,
  required String prompt,
  required Validator schema,
}) async {
  final aiProvider = AiProvider._getInstance(model.apiKey);
  await aiProvider._registerModule();

  final completer = Completer<T>();

  _module.callFunction(
    'openai_chat_generate_object',
    args: [
      model.name.toFFIType,
      prompt.toFFIType,
      schema.toJson().toFFIType,
    ],
    onData: (data) {
      if (data.hasError()) {
        completer.completeError(data.error);
        return true;
      }

      completer.complete(data.data.unpack());
      return true;
    },
  );

  return completer.future;
}

Stream<String> streamText({
  required AiModel model,
  String? prompt,
  List<OpenAIMessage>? messages,
}) async* {
  if ((prompt == null && messages == null) ||
      (prompt != null && messages != null)) {
    throw ArgumentError('Either prompt or messages must be provided.');
  }

  final openAiMessage = EitherMessagesOrPrompt(
    prompt: prompt,
    messages: messages == null ? null : OpenAIMessages(messages: messages),
  );

  final aiProvider = AiProvider._getInstance(model.apiKey);
  await aiProvider._registerModule();

  final streamController = StreamController<String>();

  _module.callFunction(
    'openai_chat_stream_text',
    args: [
      model.name.toFFIType,
      openAiMessage.writeToBuffer().toFFIType,
    ],
    onData: (data) {
      if (data.hasError()) {
        streamController
          ..addError(data.error)
          ..close();
        return true;
      }

      if (data.hasData()) {
        streamController.add(utf8.decode(data.data));
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

Stream<T> streamObject<T>({
  required AiModel model,
  required String prompt,
  required Validator schema,
}) async* {
  final aiProvider = AiProvider._getInstance(model.apiKey);
  await aiProvider._registerModule();

  final streamController = StreamController<T>();

  _module.callFunction(
    'openai_chat_stream_object',
    args: [
      model.name.toFFIType,
      prompt.toFFIType,
      schema.toJson().toFFIType,
    ],
    onData: (data) {
      if (data.hasError()) {
        streamController
          ..addError(data.error)
          ..close();
        return true;
      }

      if (data.hasData()) {
        streamController.add(data.data.unpack());
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
