import 'package:crud_flutter_web/src/api_client.dart';
import 'package:crud_flutter_web/src/repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.client});

  final APIClient client;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Repository>> reposFuture = widget.client.getRepositories();

  void refreshRepositories() {
    setState(() {
      reposFuture = widget.client.getRepositories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repositories')),
      body: FutureBuilder<List<Repository>>(
        future: reposFuture,
        key: ValueKey(reposFuture),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final repositories = snapshot.requireData;

          if (repositories.isEmpty) {
            return const Center(
              child: Text(
                'You have no repositories. Create one by tapping the "+" button.',
              ),
            );
          }

          return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              final repository = repositories[index];

              return ListTile(
                title: Text(repository.name),
                subtitle: Text(repository.url),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/repo', arguments: repository.id)
                      .whenComplete(refreshRepositories);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).pushNamed('/new').whenComplete(refreshRepositories);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
