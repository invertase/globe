// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'notes_api_client.dart';

class NotePage extends StatefulWidget {
  final NotesAPIClient client;
  const NotePage({super.key, required this.client});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late String noteId = ModalRoute.of(context)!.settings.arguments as String;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  late Future<Note> noteFuture = widget.client.getNote(noteId).then((note) {
    titleController = TextEditingController(text: note.title);
    descriptionController = TextEditingController(text: note.description);

    return note;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Note')),
      body: FutureBuilder<Note>(
        future: noteFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final note = snapshot.requireData;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Title'),
                  TextField(
                    controller: titleController,
                    onSubmitted: (value) {
                      widget.client.updateNote(note.id, title: value);
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Description'),
                  TextField(
                    controller: descriptionController,
                    onSubmitted: (value) {
                      widget.client.updateNote(note.id, description: value);
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      widget.client.updateNote(
                        note.id,
                        title: titleController.text,
                        description: descriptionController.text,
                      );
                    },
                    child: const Text('Update'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await widget.client.deleteNote(note.id);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
