import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/src/data/note_provider.dart';

import '../utils/misc.dart';
import '../utils/state.dart';

import 'auth/login.dart';
import 'auth/register.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = MyApp.authProvider;
    final note = MyApp.noteProvider;

    return StreamBuilder<ProviderEvent<User>>(
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
              child: CircularProgressIndicator(),
            ),
          );
        }

        final user = event?.data;

        final navigator = Navigator.of(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Notes App',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: false,
            backgroundColor: Colors.red[800],
            actions: [
              if (user == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () => navigator.pushNamed(LoginPage.route),
                      child: const Text('Login '),
                    ),
                    const SizedBox(width: 24),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () => navigator.pushNamed(RegisterPage.route),
                      child: const Text('Register'),
                    ),
                  ],
                )
              else
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    auth.logout();

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      HomePage.route,
                      (_) => false,
                    );
                  },
                  child: const Text('Logout'),
                ),
              const SizedBox(width: 16),
            ],
          ),
          body: user == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Authenticate to\ncreate/view your notes',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : StreamBuilder<NoteEvent>(
                  stream: note.stream,
                  builder: (_, snap) {
                    final notesList = snap.data?.data ?? const [];
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (_, index) {
                        return Container();
                      },
                      shrinkWrap: true,
                      itemCount: notesList.length,
                    );
                  },
                ),
        );
      },
    );
  }
}
