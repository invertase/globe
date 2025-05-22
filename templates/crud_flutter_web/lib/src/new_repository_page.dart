import 'package:crud_flutter_web/src/api_client.dart';
import 'package:crud_flutter_web/src/button.dart';
import 'package:flutter/material.dart';

class NewRepositoryPage extends StatefulWidget {
  const NewRepositoryPage({super.key, required this.client});

  final APIClient client;

  @override
  State<NewRepositoryPage> createState() => _NewRepositoryPageState();
}

class _NewRepositoryPageState extends State<NewRepositoryPage> {
  late final nameController = TextEditingController();
  late final urlController = TextEditingController();
  late final isLoading = ValueNotifier(false);

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
      appBar: AppBar(title: const Text('New Repository')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Name'),
              TextField(controller: nameController),
              const SizedBox(height: 16),
              const Text('Url'),
              TextField(controller: urlController),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: isLoading,
                builder:
                    (_, value, ___) => Button(
                      isBusy: value,
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final scaffoldMessenger = ScaffoldMessenger.of(context);

                        try {
                          isLoading.value = true;

                          await widget.client.createRepository(
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

                      label: 'Create',
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
