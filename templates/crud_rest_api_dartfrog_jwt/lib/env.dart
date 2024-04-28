import 'package:envied/envied.dart';

part 'env.g.dart';

@envied
abstract class Env {
  @EnviedField(varName: 'SECRET_KEY')
  static const String secretKey = _Env.secretKey;
}
