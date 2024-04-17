import 'package:flutter/material.dart';

import '../../utils/misc.dart';
import '_layout.dart';

import '../home.dart';
import 'register.dart';

const _spacing = SizedBox(height: 18);

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  void goto(BuildContext context, String route) {}

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BaseAuthLayout(
      child: (auth, layout) {
        loginAction(String email, String password) async {
          layout.setLoading(true);
          await auth.login(email, password);

          final lastEvent = auth.lastEvent!;

          if (lastEvent.data == null) {
            layout
              ..setLoading(false)
              ..handleErrors(lastEvent);
            return;
          }

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomePage.route,
            (_) => false,
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: themeData.textTheme.headlineSmall,
            ),
            _spacing,
            _spacing,
            TextField(
              onChanged: (value) => setState(() => email = value),
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            _spacing,
            TextField(
              onChanged: (value) => setState(() => password = value),
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            _spacing,
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(RegisterPage.route),
              child: Text.rich(
                TextSpan(
                  text: 'No account? ',
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Create one!',
                      style: themeData.typography.black.bodySmall
                          ?.apply(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Expanded(child: SizedBox.shrink()),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: [email, password].contains(null)
                      ? null
                      : () => loginAction(email!, password!),
                  child: const Text('Sign in'),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
