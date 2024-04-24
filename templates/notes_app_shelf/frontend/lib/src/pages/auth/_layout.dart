import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

import '../../data/auth_provider.dart';
import '../../utils/misc.dart';
import '../../utils/state.dart';

class BaseAuthLayout extends StatefulWidget {
  final Widget Function(AuthProvider auth, BaseAuthLayoutState layout) child;

  const BaseAuthLayout({super.key, required this.child});

  @override
  State<BaseAuthLayout> createState() => BaseAuthLayoutState();
}

class BaseAuthLayoutState extends State<BaseAuthLayout> {
  bool _showingLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProv = MyApp.authProvider;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 320,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_showingLoading)
                  const SizedBox(
                    width: double.maxFinite,
                    child: LinearProgressIndicator(),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: widget.child(authProv, this),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setLoading(bool show) => setState(() => _showingLoading = show);

  void handleErrors(ProviderEvent<User> event) {
    if (event.state != ProviderState.error) return;
    showError(context, event.errorMessage!);
  }
}
