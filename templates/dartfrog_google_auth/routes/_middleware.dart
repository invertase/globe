import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';

// Create a single, top-level instance of DotEnv and load the file.
final _env = DotEnv(includePlatformEnvironment: true)..load();

Handler middleware(Handler handler) {
  // Provide the DotEnv instance to all routes.
  return handler.use(provider<DotEnv>((_) => _env));
}
