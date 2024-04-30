import '../utils/state.dart';
import 'api_service.dart';
import 'note.dart';

typedef NoteEvent = ProviderEvent<List<Note>>;

class NoteProvider extends BaseProvider<List<Note>> {
  final ApiService _apiService;

  NoteProvider(this._apiService);

  Future<void> fetchNotes() async {
    final notes = await safeRun(() => _apiService.getNotes());

    addEvent(ProviderEvent.success(data: notes));
  }

  Future<void> addNote(String title, String description) async {
    final note =
        await safeRun(() => _apiService.createNote(title, description));
    if (note == null) return;

    fetchNotes();
  }

  Future<void> updateNote(
    String noteId, {
    required String title,
    required String description,
  }) async {
    final note =
        await safeRun(() => _apiService.updateNote(noteId, title, description));
    if (note == null) return;

    fetchNotes();
  }

  Future<void> deleteNote(String noteId) async {
    await safeRun(() => _apiService.deleteNote(noteId));

    fetchNotes();
  }
}
