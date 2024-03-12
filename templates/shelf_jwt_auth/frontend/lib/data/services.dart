import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/data/api_service.dart';
import 'package:get_it/get_it.dart';

export 'api_service.dart';

final getIt = GetIt.instance;

void setupServices() {
  var apiEndpoint = const String.fromEnvironment('Endpoint');
  if (apiEndpoint.trim().isEmpty) apiEndpoint = 'http://localhost:8080';

  getIt.registerSingleton<ApiService>(ApiService(Uri.parse(apiEndpoint)));
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
}
