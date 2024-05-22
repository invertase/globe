import 'package:flutter/material.dart';

import 'notes_api_client.dart';

class HomePage extends StatefulWidget {
  final NotesAPIClient client;
  const HomePage({super.key, required this.client});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Note>> notesFuture = widget.client.getNotes();

  void refreshNotes() {
    setState(() {
      notesFuture = widget.client.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: FutureBuilder<List<Note>>(
        future: notesFuture,
        key: ValueKey(notesFuture),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final notes = snapshot.requireData;

          if (notes.isEmpty) {
            return const Center(
              child: Text(
                'You have no notes. Create one by tapping the "+" button.',
              ),
            );
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];

              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.description),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/notes', arguments: note.id)
                      .whenComplete(refreshNotes);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/new').whenComplete(refreshNotes);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
