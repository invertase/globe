import 'package:crud_flutter_web/src/api_client.dart';
import 'package:crud_flutter_web/src/home_page.dart';
import 'package:crud_flutter_web/src/new_repository_page.dart';
import 'package:crud_flutter_web/src/repository_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const apiUrl = !kReleaseMode
      ? 'http://localhost:3000'
      : 'https://your-shelf-api.globeapp.dev';

  final client = APIClient(apiUrl);

  runApp(MainApp(client: client));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.client});

  final APIClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => HomePage(client: client),
            );
          case '/repo':
            return MaterialPageRoute(
              builder: (context) => RepositoryPage(
                client: client,
                repositoryId: settings.arguments as int,
              ),
            );
          case '/new':
            return MaterialPageRoute(
              builder: (context) => NewRepositoryPage(client: client),
            );
          default:
            return MaterialPageRoute(builder: (context) => Scaffold());
        }
      },
    );
  }
}
