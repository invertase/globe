import 'package:fluent_ui/fluent_ui.dart';
import 'package:frontend/main.dart';

import 'auth_layout.dart';

const _spacing = SizedBox(height: 18);

class LoginPage extends StatefulWidget {
  final String? returnUrl;

  const LoginPage({super.key, this.returnUrl});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    final themeData = FluentTheme.of(context);

    return BaseAuthLayout(
      child: (auth, layout) {
        loginAction(String email, String password) async {
          layout.setLoading(true);
          await auth.login(email, password);

          final lastEvent = auth.lastEvent!;
          if (lastEvent.data != null) {
            return router.pushReplacement(widget.returnUrl ?? '/');
          } else {
            router.pushReplacement('/login');
          }

          layout
            ..setLoading(false)
            ..handleErrors(lastEvent);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: themeData.typography.subtitle,
            ),
            _spacing,
            _spacing,
            InfoLabel(
              label: 'Email',
              child:
                  TextBox(onChanged: (value) => setState(() => email = value)),
            ),
            _spacing,
            InfoLabel(
              label: 'Password',
              child: PasswordBox(
                  onChanged: (value) => setState(() => password = value)),
            ),
            _spacing,
            GestureDetector(
              onTap: () => router.push('/register'),
              child: Text.rich(
                TextSpan(
                  text: 'No account? ',
                  children: <InlineSpan>[
                    TextSpan(
                        text: 'Create one!',
                        style: themeData.typography.body
                            ?.apply(color: themeData.accentColor.dark)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Expanded(child: SizedBox.shrink()),
                FilledButton(
                  style: ButtonStyle(
                    shape: ButtonState.all(const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                  ),
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
