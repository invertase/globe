import 'package:globe_env/globe_env.dart';

void main() {
  if (GlobeEnv.isGlobeRuntime) {
    print('Running in Globe environment');
  } else {
    print('Running in local environment');
  }
}
