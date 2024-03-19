import 'package:fluent_ui/fluent_ui.dart';
import 'package:frontend/main.dart';

import 'auth_layout.dart';

const _spacing = SizedBox(height: 24);

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? name;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    final themeData = FluentTheme.of(context);

    return BaseAuthLayout(
      child: (auth, layout) {
        registerAction(String name, String email, String password) async {
          layout.setLoading(true);
          final success = await auth.register(name, email, password);
          router.pushReplacement(success ? '/login' : '/register');

          layout
            ..setLoading(false)
            ..handleErrors(auth.lastEvent!);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: themeData.typography.subtitle,
            ),
            _spacing,
            InfoLabel(
              label: 'Display Name',
              child: TextBox(
                  keyboardType: TextInputType.name,
                  onChanged: (value) => setState(() => name = value.trim())),
            ),
            _spacing,
            InfoLabel(
              label: 'Email',
              child: TextBox(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => setState(() => email = value.trim())),
            ),
            _spacing,
            InfoLabel(
              label: 'Password',
              child: PasswordBox(
                  onChanged: (value) => setState(() => password = value)),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                const Expanded(child: SizedBox.shrink()),
                FilledButton(
                  style: ButtonStyle(
                    shape: ButtonState.all(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                  ),
                  onPressed: [name, email, password].contains(null)
                      ? null
                      : () => registerAction(name!, email!, password!),
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
