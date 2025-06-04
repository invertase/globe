library;

import 'src/globe_ai_data.dart';
import 'src/providers/google_gen_ai.dart';
import 'src/providers/openai.dart';

export 'src/globe_ai_base.dart';
export 'src/globe_ai_data.dart';
export 'package:luthor/luthor.dart';

final openai = OpenAI(OpenAIConfig());

final google = GoogleGenAi(apiKey: 'AIzaSyCYzKkGgvzI2snmm2rQ5uR924NYxIGSO0E');
