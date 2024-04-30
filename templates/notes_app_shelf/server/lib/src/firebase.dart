import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';

late CollectionReference notesCollection;

void init() {
  final cred = Credential.fromApplicationDefaultCredentials();
  final admin = FirebaseAdminApp.initializeApp('', cred);

  notesCollection = Firestore(admin).collection('notes');
}
