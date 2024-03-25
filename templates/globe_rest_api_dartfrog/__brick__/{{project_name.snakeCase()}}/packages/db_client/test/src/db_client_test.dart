// ignore_for_file: prefer_const_constructors
import 'package:db_client/db_client.dart';
import 'package:test/test.dart';

void main() {
  group('DbClient', () {
    late DbClient dbClient;

    setUp(() {
      dbClient = DbClient();
    });

    test('can be instantiated', () {
      expect(DbClient(), isNotNull);
    });

    test('returns the id when adding a new document', () async {
      final id = await dbClient.add('users', {'name': 'John Doe'});

      expect(id, isA<String>());
    });

    test('can get a document by its id', () async {
      final id = await dbClient.add('users', {'name': 'John Doe'});

      final user = await dbClient.getById('users', id);

      expect(user, equals({'id': id, 'name': 'John Doe'}));
    });

    test('can delete a document by its id', () async {
      final id = await dbClient.add('users', {'name': 'John Doe'});

      await dbClient.deleteById('users', id);

      final user = await dbClient.getById('users', id);

      expect(user, isNull);
    });

    test('can find a document by its name', () async {
      final id = await dbClient.add('users', {'name': 'John Doe'});
      await dbClient.add('users', {'name': 'Jane Doe'});

      final users = await dbClient.find(
        'users',
        (user) => user['name'] == 'John Doe',
      );

      expect(
        users,
        equals(
          [
            {
              'id': id,
              'name': 'John Doe',
            }
          ],
        ),
      );
    });

    test('can find a document by its name', () async {
      final id = await dbClient.add('users', {'name': 'John Doe'});
      await dbClient.add('users', {'name': 'Jane Doe'});

      final users = await dbClient.findByField('users', 'name', 'John Doe');

      expect(
        users,
        equals(
          [
            {
              'id': id,
              'name': 'John Doe',
            }
          ],
        ),
      );
    });

    test('returns empty array when searching a non existent table', () async {
      final users = await dbClient.findByField('users', 'name', 'John Doe');

      expect(users, isEmpty);
    });

    test('can update document by its id', () async {
      final id = await dbClient.add('users', {'name': 'John Doe'});

      await dbClient.updateById('users', id, {'name': 'Jane Doe'});

      final user = await dbClient.getById('users', id);

      expect(user, equals({'id': id, 'name': 'Jane Doe'}));
    });
  });
}
