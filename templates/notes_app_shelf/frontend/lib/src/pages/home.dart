import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/src/data/note_provider.dart';

import '../data/models/note.dart';
import '../utils/misc.dart';
import '../utils/state.dart';

import 'auth/login.dart';
import 'auth/register.dart';
import 'note_view.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? _authStreamSub;

  @override
  void initState() {
    super.initState();

    _authStreamSub = MyApp.authProvider.stream.listen((event) async {
      if (event.data == null) return;

      await MyApp.noteProvider.fetchNotes();
      _authStreamSub?.cancel();
      _authStreamSub = null;
    });
  }

  @override
  void dispose() {
    _authStreamSub?.cancel();
    super.dispose();
  }

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
          return loadingView;
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
                    final themeData = Theme.of(context);

                    if (notesList.isEmpty &&
                        snap.data?.state == ProviderState.loading) {
                      return loadingView;
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                      ),
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (_, index) {
                        final note = notesList[index];

                        return Card(
                          key: ValueKey(note.id),
                          child: InkWell(
                            onTap: () => showNoteView(note: note),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: themeData.textTheme.headlineSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                  ),
                                  Text(
                                    note.description,
                                    style: themeData.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: notesList.length,
                    );
                  },
                ),
          floatingActionButton: user == null
              ? null
              : FloatingActionButton(
                  onPressed: showNoteView,
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }

  void showNoteView({Note? note}) {
    showDialog(
      context: context,
      builder: (_) => Center(child: NoteView(note: note)),
    );
  }
}
