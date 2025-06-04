import 'dart:io';

import 'package:globe_ai/generated/openai.pb.dart';

import '../globe_ai_base.dart';

enum ReasoningEffort {
  low,
  medium,
  high,
}

class OpenAI extends AiProvider {
  final OpenAIConfig config;

  OpenAI(this.config) : super('openai', apiKey: config.apiKey);

  ChatModel chat(
    String model, {
    String? user,
    Map<int, int>? logitBias,
    bool? downloadImages,
    bool? parallelToolCalls,
    bool? structuredOutputs,
    ReasoningEffort? reasoningEffort,
  }) =>
      ChatModel._(this, model, options: {
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

class ChatModel extends AiModel<OpenAI> {
  final String model;

  @override
  final Map<String, dynamic> options;

  ChatModel._(OpenAI openAI, this.model, {this.options = const {}})
      : super(type: Model.chat, id: model, provider: openAI);
}
