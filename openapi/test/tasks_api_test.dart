import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksApi
void main() {
  final instance = Openapi().getTasksApi();

  group(TasksApi, () {
    // Assign
    //
    //Future<BuiltList<MemberGet>> assignRole(int taskId, int wsId, int memberId, BuiltList<int> requestBody) async
    test('test assignRole', () async {
      // TODO
    });

    // Create
    //
    //Future<InvitationGet> createInvitation(int wsId, int taskId, Invitation invitation) async
    test('test createInvitation', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteNote(int noteId, int wsId, int taskId) async
    test('test deleteNote', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteStatus(int statusId, int wsId, int taskId) async
    test('test deleteStatus', () async {
      // TODO
    });

    // Delete
    //
    //Future<TasksChanges> deleteTask(int wsId, int taskId) async
    test('test deleteTask', () async {
      // TODO
    });

    // Duplicate Task
    //
    //Future<TasksChanges> duplicateTask(int wsId, int taskId) async
    test('test duplicateTask', () async {
      // TODO
    });

    // Invitations
    //
    //Future<BuiltList<InvitationGet>> getInvitations(int taskId, int wsId, int roleId) async
    test('test getInvitations', () async {
      // TODO
    });

    // Setup Feature Sets
    //
    //Future<BuiltList<ProjectFeatureSetGet>> setupFeatureSets(int taskId, int wsId, BuiltList<int> requestBody) async
    test('test setupFeatureSets', () async {
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

    // Upsert
    //
    //Future<ProjectStatusGet> upsertStatus(int wsId, int taskId, ProjectStatusUpsert projectStatusUpsert) async
    test('test upsertStatus', () async {
      // TODO
    });

    // Upsert Task
    //
    //Future<TasksChanges> upsertTask(int wsId, TaskUpsert taskUpsert, { int taskId }) async
    test('test upsertTask', () async {
      // TODO
    });
  });
}
