import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();
final _secretKeyString = env['JWT_SECRET_KEY'] ??
    (throw StateError('JWT_SECRET_KEY environment variable not provided'));
final jwtSecretKey = SecretKey(_secretKeyString);

typedef UserData = ({
  String id,
  String passwordHash,
  DateTime createdAt,
});

final fauxUserDB = <String, UserData>{};
