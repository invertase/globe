// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';

import 'package:globe_ai/generated/openai.pbserver.dart';
import 'package:globe_runtime/globe_runtime.dart';
import 'package:luthor/luthor.dart';
import 'package:version/version.dart';

import 'globe_ai_source.dart';
import 'object_schema.dart';

Future<Module> _registerModule(String provider, {String? apiKey}) async {
  final module = InlinedModule(
    name: '${provider.toUpperCase()}AISdk',
    sourceCode: packageSource,
  );

  final currentVersion = Version.parse(GlobeRuntime.instance.version);
  if (currentVersion < Version(0, 0, 6)) {
    throw StateError(
      'Globe Runtime version $currentVersion is not supported. '
      'Please update runtime version.',
    );
  }

  await module.register(args: [provider.toFFIType, apiKey?.toFFIType]);

  return module;
}

abstract class AiProvider {
  final String? apiKey;
  final String name;

  const AiProvider(this.name, {this.apiKey});
}

enum Model { chat, language, completion }

abstract class AiModel<T extends AiProvider> {
  final Model type;
  final String id;
  final T provider;

  const AiModel({
    required this.type,
    required this.id,
    required this.provider,
  });

  Map<String, dynamic> get options;
}

Future<String> generateText({
  required AiModel model,
  String? prompt,
  List<AIMessage>? messages,
}) async {
  if ((prompt == null && messages == null) ||
      (prompt != null && messages != null)) {
    throw ArgumentError('Either prompt or messages must be provided.');
  }

  final provider = model.provider;
  final module = await _registerModule(provider.name, apiKey: provider.apiKey);

  final openAiMessage = EitherMessagesOrPrompt(
    prompt: prompt,
    messages: messages == null ? null : AIMessages(messages: messages),
  );

  final completer = Completer<String>();

  module.callFunction(
    '${model.provider.name}_${model.type.name}_generate_text',
    args: [
      model.options.toFFIType,
      model.id.toFFIType,
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
  final provider = model.provider;
  final module = await _registerModule(provider.name, apiKey: provider.apiKey);

  final completer = Completer<T>();

  module.callFunction(
    '${model.provider.name}_${model.type.name}_generate_object',
    args: [
      model.id.toFFIType,
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
  List<AIMessage>? messages,
}) async* {
  if ((prompt == null && messages == null) ||
      (prompt != null && messages != null)) {
    throw ArgumentError('Either prompt or messages must be provided.');
  }

  final provider = model.provider;
  final module = await _registerModule(provider.name, apiKey: provider.apiKey);

  final openAiMessage = EitherMessagesOrPrompt(
    prompt: prompt,
    messages: messages == null ? null : AIMessages(messages: messages),
  );

  final streamController = StreamController<String>();

  module.callFunction(
    '${model.provider.name}_${model.type.name}_stream_text',
    args: [
      model.id.toFFIType,
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
  final provider = model.provider;
  final module = await _registerModule(provider.name, apiKey: provider.apiKey);

  final streamController = StreamController<T>();

  module.callFunction(
    '${model.provider.name}_${model.type.name}_stream_object',
    args: [
      model.id.toFFIType,
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
