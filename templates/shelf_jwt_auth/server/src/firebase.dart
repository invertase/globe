import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:dotenv/dotenv.dart';

final class Firebase {
  static late FirebaseAdminApp _admin;

  static void init() {
    final dotenv = DotEnv()..load();

    _admin = FirebaseAdminApp.initializeApp(
      'yaroo-example',
      Credential.fromServiceAccountParams(
        clientId: dotenv['FIREBASE_CLIENT_ID']!,
        privateKey: dotenv['FIREBASE_PRIVATE_KEY']!.replaceAll(r'\n', '\n'),
        email: dotenv['FIREBASE_CLIENT_EMAIL']!,
      ),
    );
  }

  static Firestore? _fstcache;
  static Firestore get firestore => _fstcache ??= Firestore(_admin);

  static Auth? _fauthCache;
  static Auth get auth => _fauthCache ??= Auth(_admin);

  static Future<void> close() => _admin.close();
}
