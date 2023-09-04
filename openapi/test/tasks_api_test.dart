import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TasksApi
void main() {
  final instance = Openapi().getTasksApi();

  group(TasksApi, () {
    // Assign
    //
    //Future<BuiltList<MemberGet>> assignV1TasksRolesPost(int taskId, int memberId, int wsId, BuiltList<int> requestBody, { int permissionTaskId }) async
    test('test assignV1TasksRolesPost', () async {
      // TODO
    });

    // Create
    //
    //Future<InvitationGet> createV1TasksInvitationsPost(int wsId, Invitation invitation) async
    test('test createV1TasksInvitationsPost', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteV1TasksNotesNoteIdDelete(int noteId, int wsId, { int permissionTaskId }) async
    test('test deleteV1TasksNotesNoteIdDelete', () async {
      // TODO
    });

    // Delete
    //
    //Future<TasksChanges> deleteV1TasksTaskIdDelete(int taskId, int wsId, { int permissionTaskId }) async
    test('test deleteV1TasksTaskIdDelete', () async {
      // TODO
    });

    // Invitations
    //
    //Future<BuiltList<InvitationGet>> invitationsV1TasksInvitationsGet(int taskId, int roleId, int wsId, { int permissionTaskId }) async
    test('test invitationsV1TasksInvitationsGet', () async {
      // TODO
    });

    // Setup Feature Sets
    //
    //Future<BuiltList<ProjectFeatureSetGet>> setupFeatureSetsV1TasksFeatureSetsPost(int projectId, int wsId, BuiltList<int> requestBody, { int permissionTaskId }) async
    test('test setupFeatureSetsV1TasksFeatureSetsPost', () async {
      // TODO
    });

    // Task Upsert
    //
    //Future<TasksChanges> taskUpsertV1TasksPost(int wsId, TaskUpsert taskUpsert, { int permissionTaskId }) async
    test('test taskUpsertV1TasksPost', () async {
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
