import 'package:fluent_ui/fluent_ui.dart';

import '_auth_layout.dart';
import 'login_page.dart';

const _spacing = SizedBox(height: 24);

class RegisterPage extends StatefulWidget {
  static const String route = '/register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? name;
  String? email;
  String? password;

  void goto(BuildContext context, String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = FluentTheme.of(context);

    return BaseAuthLayout(
      child: (auth, layout) {
        void registerAction(String name, String email, String password) async {
          layout.setLoading(true);
          final success = await auth.register(name, email, password);

          // ignore: use_build_context_synchronously
          goto(context, success ? LoginPage.route : RegisterPage.route);

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
