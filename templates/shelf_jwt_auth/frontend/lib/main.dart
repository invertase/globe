import 'package:fluent_ui/fluent_ui.dart';
import 'package:frontend/data/services.dart';
import 'package:frontend/pages/auth/auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'data/providers/auth_provider.dart';

const primaryColor = Color.fromARGB(255, 226, 30, 16);

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (_, __) => const SizedBox()),
    GoRoute(path: '/login', builder: (_, state) => const LoginPage()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
  ],
);

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: FluentApp.router(
        routerConfig: router,
        title: 'Shelf Firebase Auth',
        debugShowCheckedModeBanner: false,
        builder: (_, child) {
          return _AppLayout(
            child: child!,
          );
        },
      ),
    );
  }
}

class _AppLayout extends StatelessWidget {
  final Widget child;

  const _AppLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FluentTheme(
          data: FluentThemeData.dark(),
          child: Container(
            decoration: BoxDecoration(color: Colors.blue.dark),
            padding: const EdgeInsets.only(top: 12),
            alignment: Alignment.center,
            child: PageHeader(
              title: GestureDetector(
                onTap: () => router.pushReplacement('/'),
                child: const Text(
                  'Shelf Firebase Auth',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                ),
              ),
              commandBar: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AuthHeaderOptions(),
                  SizedBox(width: 24),
                  Tooltip(
                    message: 'View on Github',
                    displayHorizontally: true,
                    useMousePosition: false,
                    style: TooltipThemeData(preferBelow: true),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
