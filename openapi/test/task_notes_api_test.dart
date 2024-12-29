import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TaskNotesApi
void main() {
  final instance = Openapi().getTaskNotesApi();

  group(TaskNotesApi, () {
    // Delete
    //
    //Future<bool> deleteNote_1(int wsId, int noteId, int taskId) async
    test('test deleteNote_1', () async {
      // TODO
    });

    // Upload Attachment
    //
    //Future<AttachmentGet> uploadAttachment_1(int wsId, int taskId, int noteId, MultipartFile file) async
    test('test uploadAttachment_1', () async {
      // TODO
    });

    // Upsert
    //
    //Future<NoteGet> upsertNote_1(int wsId, int taskId, NoteUpsert noteUpsert) async
    test('test upsertNote_1', () async {
      // TODO
    });
  });
}
