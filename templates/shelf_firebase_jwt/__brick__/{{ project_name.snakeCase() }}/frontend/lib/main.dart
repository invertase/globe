import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'src/data/api_service.dart';
import 'src/data/auth_provider.dart';

import 'src/env.dart';
import 'src/pages/auth/login_page.dart';
import 'src/pages/auth/register_page.dart';
import 'src/pages/home.dart';

const primaryColor = Color(0xff0078d4);

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static AuthProvider? _authProviderCache;
  static AuthProvider get authProvider {
    if (_authProviderCache != null) return _authProviderCache!;
    final apiSvc = ApiService(Uri.parse(Env.apiURL));
    return _authProviderCache = AuthProvider(FirebaseAuth.instance, apiSvc);
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserEvent?>(
      stream: authProvider.stream,
      initialData: authProvider.lastEvent,
      builder: (_, data) {
        return FluentApp(
          routes: {
            HomePage.route: (_) => const HomePage(),
            LoginPage.route: (_) => const LoginPage(),
            RegisterPage.route: (_) => const RegisterPage(),
          },
          title: 'Shelf Firebase Auth',
          theme: FluentThemeData(accentColor: Colors.green),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
