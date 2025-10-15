import 'package:dart_frog/dart_frog.dart';
import 'package:notes_api_dartfrog_globedb/database.dart';

final _db = AppDatabase();

Handler middleware(Handler handler) {
  return handler.use(provider<AppDatabase>((_) => _db));
}
