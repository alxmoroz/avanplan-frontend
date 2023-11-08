import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksNotesApi
void main() {
  final instance = Openapi().getTasksNotesApi();

  group(TasksNotesApi, () {
    // Delete
    //
    //Future<bool> deleteNote(int noteId, int wsId, int taskId, { int permissionTaskId }) async
    test('test deleteNote', () async {
      // TODO
    });

    // Upsert
    //
    //Future<NoteGet> upsertNote(int wsId, int taskId, NoteUpsert noteUpsert, { int permissionTaskId }) async
    test('test upsertNote', () async {
      // TODO
    });
  });
}
