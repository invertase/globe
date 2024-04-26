import 'package:uuid/uuid.dart';

/// {@template db_client}
/// Database client.
/// {@endtemplate}
class DbClient {
  /// {@macro db_client}
  DbClient();

  late final Map<String, Map<String, Map<String, dynamic>>> _memory = {};

  /// Add a document in the given [entity], returning its id.
  Future<String> add(
    String entity,
    Map<String, dynamic> value,
  ) async {
    final id = const Uuid().v4();

    _memory[entity] = {
      ..._memory[entity] ?? {},
      id: value,
    };

    return id;
  }

  /// Returns a document by its [id] in the given [entity].
  Future<Map<String, dynamic>?> getById(String entity, String id) async {
    final data = _memory[entity]?[id];

    if (data != null) {
      return {
        'id': id,
        ...data,
      };
    }

    return null;
  }

  /// Deletes the document by its [id] in the given [entity].
  Future<void> deleteById(String entity, String id) async {
    _memory[entity]?.remove(id);
  }

  /// Finds all documents in an [entity] that matches the given [predicate].
  Future<List<Map<String, dynamic>>> find(
    String entity,
    bool Function(Map<String, dynamic>) predicate,
  ) async {
    return _memory[entity]
            ?.entries
            .map(
              (entry) => {
                'id': entry.key,
                ...entry.value,
              },
            )
            .where(predicate)
            .toList() ??
        [];
  }

  /// Finds all documents in an [entity] that the given [field] matchs the given
  /// [value].
  Future<List<Map<String, dynamic>>> findByField(
    String entity,
    String field,
    dynamic value,
  ) async {
    return find(
      entity,
      (data) => data[field] == value,
    );
  }

  /// Updates a document by its [id] in the given [entity].
  Future<void> updateById(
    String entity,
    String id,
    Map<String, dynamic> value,
  ) async {
    _memory[entity]?[id] = value;
  }
}
