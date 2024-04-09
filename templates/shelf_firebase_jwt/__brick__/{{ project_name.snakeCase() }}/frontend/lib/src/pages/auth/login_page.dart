import 'package:fluent_ui/fluent_ui.dart';

import '../home.dart';
import '_auth_layout.dart';
import 'register_page.dart';

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

  void goto(BuildContext context, String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      route,
      (route) => route.isFirst,
    );
  }

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
            // ignore: use_build_context_synchronously
            goto(context, HomePage.route);

            return;
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
              onTap: () => Navigator.of(context).pushNamed(RegisterPage.route),
              child: Text.rich(
                TextSpan(
                  text: 'No account? ',
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Create one!',
                      style: themeData.typography.body
                          ?.apply(color: themeData.accentColor.dark),
                    ),
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
                    shape: ButtonState.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
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
