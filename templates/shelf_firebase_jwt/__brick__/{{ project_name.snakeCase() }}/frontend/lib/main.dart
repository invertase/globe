import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'src/data/api_service.dart';
import 'src/data/providers/auth_provider.dart';

import 'src/env.dart';
import 'src/pages/auth/login_page.dart';
import 'src/pages/auth/register_page.dart';
import 'src/pages/home.dart';

const primaryColor = Color(0xff0078d4);

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final apiSvc = ApiService(Uri.parse(Env.apiURL));
  final authProvider = AuthProvider(FirebaseAuth.instance, apiSvc);

  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => authProvider,
      child: FluentApp(
        routes: {
          HomePage.route: (_) => const HomePage(),
          LoginPage.route: (_) => const LoginPage(),
          RegisterPage.route: (_) => const RegisterPage(),
        },
        title: 'Shelf Firebase Auth',
        theme: FluentThemeData(accentColor: Colors.green),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
