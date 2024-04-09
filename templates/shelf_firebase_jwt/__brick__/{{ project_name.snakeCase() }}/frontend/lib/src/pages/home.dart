import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/user.dart';
import '../data/providers/auth_provider.dart';
import '../utils/state.dart';

import 'auth/login_page.dart';
import 'auth/register_page.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    const spacing = SizedBox(width: 24);

    return StreamBuilder<ProviderEvent<AuthUser>>(
      stream: auth.stream,
      initialData: auth.lastEvent,
      builder: (_, data) {
        final event = data.data;
        final isLoading = event?.state == ProviderState.loading;

        if (isLoading) {
          return const Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        final user = event?.data;
        final navigator = Navigator.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              child: Icon(Icons.account_box_outlined, size: 30),
            ),
            const SizedBox(height: 50),
            if (user != null) ...[
              Text('Welcome, ${user.name.split(' ').first}'),
              spacing,
              OutlinedButton(
                child: const Text('Logout'),
                onPressed: () {
                  auth.logout();
                  navigator.pushNamedAndRemoveUntil(
                      HomePage.route, (_) => _.isFirst);
                },
              ),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Login '),
                    onPressed: () => navigator.pushNamed(LoginPage.route),
                  ),
                  spacing,
                  ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () => navigator.pushNamed(RegisterPage.route),
                  ),
                ],
              )
            ],
          ],
        );
      },
    );
  }
}
