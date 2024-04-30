import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';

final class Firebase {
  static late FirebaseAdminApp _admin;

  static void init() {
    _admin = FirebaseAdminApp.initializeApp(
      '',
      Credential.fromApplicationDefaultCredentials(),
    );
  }

  static Firestore? _fstcache;
  static Firestore get firestore => _fstcache ??= Firestore(_admin);

  static Auth? _fauthCache;
  static Auth get auth => _fauthCache ??= Auth(_admin);

  static Future<void> close() => _admin.close();
}

CollectionReference get notesCollection =>
    Firebase.firestore.collection('notes');
