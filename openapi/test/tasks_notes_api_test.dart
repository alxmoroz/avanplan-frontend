import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksNotesApi
void main() {
  final instance = Openapi().getTasksNotesApi();

  group(TasksNotesApi, () {
    // Delete
    //
    //Future<bool> deleteV1TasksNotesNoteIdDelete(int noteId, int wsId, { int permissionTaskId }) async
    test('test deleteV1TasksNotesNoteIdDelete', () async {
      // TODO
    });

    // Upsert
    //
    //Future<NoteGet> upsertV1TasksNotesPost(int wsId, NoteUpsert noteUpsert, { int permissionTaskId }) async
    test('test upsertV1TasksNotesPost', () async {
      // TODO
    });
  });
}
