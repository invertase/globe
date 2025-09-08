import 'package:crud_flutter_web/src/api_client.dart';
import 'package:crud_flutter_web/src/button.dart';
import 'package:crud_flutter_web/src/repository.dart';
import 'package:flutter/material.dart';

class RepositoryPage extends StatefulWidget {
  const RepositoryPage({
    super.key,
    required this.client,
    required this.repositoryId,
  });

  final APIClient client;
  final int repositoryId;

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  late TextEditingController nameController;
  late TextEditingController urlController;
  late final isLoading = ValueNotifier(false);

  late Future<Repository> repoFuture = widget.client
      .getRepository(widget.repositoryId)
      .then((repository) {
        nameController = TextEditingController(text: repository.name);
        urlController = TextEditingController(text: repository.url);

        return repository;
      });

  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repository')),
      body: FutureBuilder<Repository>(
        future: repoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final repository = snapshot.requireData;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Title'),
                  TextField(controller: nameController),
                  const SizedBox(height: 16),
                  const Text('Description'),
                  TextField(controller: urlController),
                  const SizedBox(height: 16),
                  ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (_, value, __) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Button(
                            isBusy: value,
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              final scaffoldMessenger = ScaffoldMessenger.of(
                                context,
                              );

                              try {
                                isLoading.value = true;

                                await widget.client.updateRepository(
                                  repository.id,
                                  name: nameController.text,
                                  url: urlController.text,
                                );

                                isLoading.value = false;
                                navigator.pop();
                              } catch (e) {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              }
                            },
                            label: 'Update',
                          ),
                          const SizedBox(height: 16),
                          Button(
                            isBusy: value,
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              final scaffoldMessenger = ScaffoldMessenger.of(
                                context,
                              );

                              try {
                                isLoading.value = true;

                                await widget.client.deleteRepository(
                                  repository.id,
                                );

                                isLoading.value = false;
                                navigator.pop();
                              } catch (e) {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              }
                            },
                            label: 'Delete',
                          ),
                        ],
                      );
                    },
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
