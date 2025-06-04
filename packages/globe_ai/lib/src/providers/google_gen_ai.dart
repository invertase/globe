import 'dart:io';

import '../globe_ai_base.dart';

class GoogleGenAi extends AiProvider {
  GoogleGenAi({String? apiKey}) : super('google_gen_ai', apiKey: apiKey);

  AiModel call(String model, {String? user, bool structuredOutputs = false}) {
    return GoogleGenAiModel(this, model);
  }

  @override
  String get apiKey =>
      super.apiKey ??
      Platform.environment['GOOGLE_GENERATIVE_AI_API_KEY'] ??
      (throw StateError(
        'Please set your Google Generative AI key -> `GOOGLE_GENERATIVE_AI_API_KEY`',
      ));
}

class GoogleGenAiModel extends AiModel<GoogleGenAi> {
  final String model;

  GoogleGenAiModel(GoogleGenAi genAi, this.model)
      : super(id: model, type: Model.chat, provider: genAi);

  @override
  Map<String, dynamic> get options => {};
}
