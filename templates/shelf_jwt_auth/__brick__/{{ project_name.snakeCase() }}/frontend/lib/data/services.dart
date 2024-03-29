import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/data/api_service.dart';
import 'package:frontend/env.dart';
import 'package:get_it/get_it.dart';

export 'api_service.dart';

final getIt = GetIt.instance;

void setupServices() {
  getIt.registerSingleton<ApiService>(ApiService(Uri.parse(Env.apiURL)));
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
}
