import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final items = const [_Login()];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (_, i) => items[i],
      itemCount: items.length,
    );
  }
}

class _Login extends StatefulWidget {
  const _Login({super.key});

  @override
  State<_Login> createState() => __LoginState();
}

class __LoginState extends State<_Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 340,
        height: 300,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
