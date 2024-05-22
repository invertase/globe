import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/src/notes_api_client.dart';

import 'src/home_page.dart';
import 'src/login_page.dart';
import 'src/new_note_page.dart';
import 'src/note_page.dart';

const apiUrl = !kReleaseMode
    ? 'http://localhost:3000'
    : 'https://your-project.globeapp.dev';

late NotesAPIClient client;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kReleaseMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  client = NotesAPIClient(apiUrl);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final initialRoute = switch (user) {
      null => '/login',
      _ => '/',
    };

    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/': (_) => HomePage(client: client),
        '/login': (_) => const LoginPage(),
        '/notes': (_) => NotePage(client: client),
        '/new': (_) => NewNotePage(client: client),
      },
    );
  }
}
