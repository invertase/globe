import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'FIREBASE_PROJECT_ID')
  static const String firebaseProjectId = _Env.firebaseProjectId;

  @EnviedField(varName: 'FIREBASE_CLIENT_ID')
  static const String firebaseClientId = _Env.firebaseClientId;

  @EnviedField(varName: 'FIREBASE_PRIVATE_KEY')
  static const String firebasePrivateKey = _Env.firebasePrivateKey;

  @EnviedField(varName: 'FIREBASE_CLIENT_EMAIL')
  static const String firebasePrivateEmail = _Env.firebasePrivateEmail;
}
