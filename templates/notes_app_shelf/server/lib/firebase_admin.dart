import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:server/env.dart';

late Firestore firestore;
const kReleaseMode = bool.fromEnvironment('dart.vm.product');

void init() {
  final cred = Credential.fromApplicationDefaultCredentials();

  // ignore: invalid_use_of_internal_member
  if (cred.serviceAccountCredentials == null) {
    throw Exception(
      'Please provide GOOGLE_SERVICE_ACCOUNT variable in environment.',
    );
  }

  final projectId = env['FIREBASE_PROJECT_ID'];
  if (projectId == null) {
    throw Exception('Please provide FIREBASE_PROJECT_ID in environment,');
  }

  final admin = FirebaseAdminApp.initializeApp(projectId, cred);
  if (!kReleaseMode) admin.useEmulator();

  firestore = Firestore(admin);
}
