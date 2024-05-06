import 'dart:convert';

import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:server/env.dart';

late Firestore firestore;
const kReleaseMode = bool.fromEnvironment('dart.vm.product');

void init(String projectId) {
  late Credential cred;

  if (kReleaseMode) {
    // GOOGLE_APPLICATION_CREDENTIALS is defined on Platform.environment
    cred = Credential.fromApplicationDefaultCredentials();
  } else {
    // GOOGLE_APPLICATION_CREDENTIALS is defined in .env
    final serviceAccountString = env['GOOGLE_APPLICATION_CREDENTIALS'];

    if (serviceAccountString == null) {
      throw Exception('GOOGLE_APPLICATION_CREDENTIALS not found');
    }

    final json = jsonDecode(serviceAccountString);

    cred = Credential.fromServiceAccountParams(
      clientId: json['client_id'],
      privateKey: json['private_key'],
      email: json['client_email'],
    );
  }

  final admin = FirebaseAdminApp.initializeApp(projectId, cred);

  firestore = Firestore(admin);
}
