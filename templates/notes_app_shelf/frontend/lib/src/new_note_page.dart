import 'package:flutter/material.dart';

import 'notes_api_client.dart';

class NewNotePage extends StatefulWidget {
  final NotesAPIClient client;
  const NewNotePage({super.key, required this.client});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Note')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Title'),
              TextField(controller: titleController),
              const SizedBox(height: 16),
              const Text('Description'),
              TextField(controller: descriptionController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    widget.client.createNote(
                      title: titleController.text,
                      description: descriptionController.text,
                    );

                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
