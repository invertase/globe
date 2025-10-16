import 'package:dart_frog/dart_frog.dart';
import 'package:notes_api_dartfrog_globedb/database.dart';
import 'package:notes_api_dartfrog_globedb/notes_repository.dart';

final _db = AppDatabase();
final _repository = DriftNotesRepository(_db);

Handler middleware(Handler handler) {
  return handler.use(provider<NotesRepository>((_) => _repository));
}
