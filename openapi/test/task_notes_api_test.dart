import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TaskNotesApi
void main() {
  final instance = Openapi().getTaskNotesApi();

  group(TaskNotesApi, () {
    // Delete
    //
    //Future<bool> deleteNote(int wsId, int noteId, int taskId) async
    test('test deleteNote', () async {
      // TODO
    });

    // Upload Attachment
    //
    //Future<AttachmentGet> uploadAttachment(int wsId, int taskId, int noteId, MultipartFile file) async
    test('test uploadAttachment', () async {
      // TODO
    });

    // Upsert
    //
    //Future<NoteGet> upsertNote(int wsId, int taskId, NoteUpsert noteUpsert) async
    test('test upsertNote', () async {
      // TODO
    });
  });
}
