import 'package:firebase_auth/firebase_auth.dart';

import 'package:get_it/get_it.dart';

import '../env.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupServices() {
  getIt.registerSingleton<ApiService>(ApiService(Uri.parse(Env.apiURL)));
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
}
