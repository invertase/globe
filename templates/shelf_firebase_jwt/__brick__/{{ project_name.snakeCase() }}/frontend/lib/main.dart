import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/data/note_provider.dart';
import 'firebase_options.dart';

import 'src/data/api_service.dart';
import 'src/data/auth_provider.dart';

import 'src/env.dart';
import 'src/pages/auth/login.dart';
import 'src/pages/auth/register.dart';
import 'src/pages/home.dart';

final _apiSvc = ApiService(Uri.parse(Env.apiURL));

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static AuthProvider? _authProviderCache;
  static AuthProvider get authProvider {
    if (_authProviderCache != null) return _authProviderCache!;
    return _authProviderCache = AuthProvider(FirebaseAuth.instance, _apiSvc);
  }

  static NoteProvider? _noteProviderCache;
  static NoteProvider get noteProvider {
    if (_noteProviderCache != null) return _noteProviderCache!;
    return _noteProviderCache = NoteProvider(_apiSvc);
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.route: (_) => const HomePage(),
        LoginPage.route: (_) => const LoginPage(),
        RegisterPage.route: (_) => const RegisterPage(),
      },
      title: 'Notes App',
      theme: ThemeData(
        primaryColor: Colors.red,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
