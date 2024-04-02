import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../data/models/user.dart';
import '../data/providers/auth_provider.dart';
import '../utils/state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    final typography = FluentTheme.of(context).typography;

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

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FluentIcons.account_management, size: 40),
            const SizedBox(height: 10),
            Text(
              event?.data != null
                  ? 'You are logged in ✅'
                  : 'You are not logged in',
              style: typography.body,
            ),
          ],
        );
      },
    );
  }
}
