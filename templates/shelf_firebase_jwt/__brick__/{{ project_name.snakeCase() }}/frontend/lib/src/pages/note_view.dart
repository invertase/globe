import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/src/data/note_provider.dart';
import 'package:frontend/src/utils/state.dart';

import '../data/models/note.dart';
import '../utils/misc.dart';

class NoteView extends StatefulWidget {
  final Note? note;

  const NoteView({super.key, this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  String? title, description;

  @override
  void initState() {
    super.initState();
    title = widget.note?.title;
    description = widget.note?.description;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final notes = MyApp.noteProvider;
    return SizedBox(
      height: 320,
      width: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.note == null ? 'Create New Note' : 'Update Note',
                style: themeData.textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              TextFormField(
                initialValue: title,
                onChanged: (value) => setState(() => title = value),
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: description,
                onChanged: (value) => setState(() => description = value),
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              const SizedBox(height: 32),
              StreamBuilder<NoteEvent>(
                stream: notes.stream,
                initialData: notes.lastEvent,
                builder: (_, snap) {
                  if (snap.data?.state == ProviderState.loading) {
                    return const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Row(
                    children: [
                      if (widget.note != null) ...[
                        ElevatedButton(
                          style: buttonStyle.copyWith(
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.red),
                              foregroundColor:
                                  const MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {
                            notes.deleteNote(widget.note!.id);

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          },
                          child: const Text('Delete Note'),
                        ),
                      ],
                      const Expanded(child: SizedBox.shrink()),
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: [title, description].contains(null)
                            ? null
                            : () async {
                                final currentNote = widget.note;
                                if (currentNote == null) {
                                  await notes.addNote(title!, description!);
                                } else {
                                  await notes.updateNote(
                                    currentNote.id,
                                    title: title!,
                                    description: description!,
                                  );
                                }

                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              },
                        child: const Text('Save Note'),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
