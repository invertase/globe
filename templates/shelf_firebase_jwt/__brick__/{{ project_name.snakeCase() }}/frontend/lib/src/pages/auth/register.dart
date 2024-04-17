import 'package:flutter/material.dart';
import 'package:frontend/src/utils/misc.dart';

import '_layout.dart';
import 'login.dart';

const _spacing = SizedBox(height: 24);

class RegisterPage extends StatefulWidget {
  static const String route = '/register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;

  void goto(BuildContext context, String route) {}

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BaseAuthLayout(
      child: (auth, layout) {
        void registerAction(String email, String password) async {
          layout.setLoading(true);

          final success = await auth.register(email, password);
          if (!success) {
            layout
              ..setLoading(false)
              ..handleErrors(auth.lastEvent!);
            return;
          }

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacementNamed(LoginPage.route);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: themeData.textTheme.headlineSmall,
            ),
            _spacing,
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
              onChanged: (value) => setState(() => email = value.trim()),
            ),
            _spacing,
            TextField(
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
              onChanged: (value) => setState(() => password = value),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                const Expanded(child: SizedBox.shrink()),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: [email, password].contains(null)
                      ? null
                      : () => registerAction(email!, password!),
                  child: const Text('Register'),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
