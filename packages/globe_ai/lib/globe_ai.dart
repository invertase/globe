library;

import 'dart:io';

import 'package:globe_ai/generated/openai.pbserver.dart';
import 'package:globe_ai/src/globe_ai_base.dart';

export 'src/globe_ai_base.dart';

final openai = OpenAI(OpenAIConfig(apiKey: Platform.environment['OPENAI_API_KEY']));
