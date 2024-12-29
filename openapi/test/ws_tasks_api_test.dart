import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for WSTasksApi
void main() {
  final instance = Openapi().getWSTasksApi();

  group(WSTasksApi, () {
    // Assign Project Member Roles
    //
    //Future<BuiltList<MemberGet>> assignProjectMemberRoles_0(int taskId, int memberId, int wsId, BuiltList<int> requestBody) async
    test('test assignProjectMemberRoles_0', () async {
      // TODO
    });

    // Create
    //
    //Future<InvitationGet> createInvitation_0(int wsId, int taskId, Invitation invitation) async
    test('test createInvitation_0', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteNote_0(int wsId, int noteId, int taskId) async
    test('test deleteNote_0', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteRepeat_0(int wsId, int taskId, int repeatId) async
    test('test deleteRepeat_0', () async {
      // TODO
    });

    // Delete
    //
    //Future<bool> deleteStatus_0(int statusId, int wsId, int taskId) async
    test('test deleteStatus_0', () async {
      // TODO
    });

    // Delete
    //
    //Future<TasksChanges> deleteTask_0(int wsId, int taskId) async
    test('test deleteTask_0', () async {
      // TODO
    });

    // Delete
    //
    //Future<TasksChanges> deleteTransaction_0(int wsId, int taskId, int transactionId) async
    test('test deleteTransaction_0', () async {
      // TODO
    });

    // Duplicate
    //
    //Future<TasksChanges> duplicateTask_0(int wsId, int taskId, int srcWsId, { int srcTaskId }) async
    test('test duplicateTask_0', () async {
      // TODO
    });

    // Invitations
    //
    //Future<BuiltList<InvitationGet>> getInvitations_0(int taskId, int wsId, int roleId) async
    test('test getInvitations_0', () async {
      // TODO
    });

    // Move
    //
    //Future<TasksChanges> moveTask_0(int wsId, int taskId, int srcTaskId, int srcWsId) async
    test('test moveTask_0', () async {
      // TODO
    });

    // Project Member Contacts
    //
    // Способы связи участника РП в проекте
    //
    //Future<BuiltList<MemberContactGet>> projectMemberContacts_0(int memberId, int wsId, int taskId) async
    test('test projectMemberContacts_0', () async {
      // TODO
    });

    // Repeat
    //
    //Future<TasksChanges> repeatTask_0(int wsId, int taskId, int srcWsId, { int srcTaskId }) async
    test('test repeatTask_0', () async {
      // TODO
    });

    // Status Tasks Count
    //
    //Future<int> statusTasksCount_0(int wsId, int taskId, int projectStatusId) async
    test('test statusTasksCount_0', () async {
      // TODO
    });

    // Task Node
    //
    //Future<TaskNode> taskNode_0(int taskId, int wsId, { bool closed, bool fullTree }) async
    test('test taskNode_0', () async {
      // TODO
    });

    // Tasks List
    //
    //Future<BuiltList<TaskGet>> tasksList_0(int wsId, BuiltList<int> requestBody, { int taskId }) async
    test('test tasksList_0', () async {
      // TODO
    });

    // Unlink
    //
    //Future<bool> unlinkTask_0(int taskId, int wsId) async
    test('test unlinkTask_0', () async {
      // TODO
    });

    // Upload Attachment
    //
    //Future<AttachmentGet> uploadAttachment_0(int wsId, int taskId, int noteId, MultipartFile file) async
    test('test uploadAttachment_0', () async {
      // TODO
    });

    // Upsert
    //
    //Future<NoteGet> upsertNote_0(int wsId, int taskId, NoteUpsert noteUpsert) async
    test('test upsertNote_0', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TaskRepeatGet> upsertRepeat_0(int wsId, int taskId, TaskRepeatUpsert taskRepeatUpsert) async
    test('test upsertRepeat_0', () async {
      // TODO
    });

    // Upsert
    //
    //Future<ProjectStatusGet> upsertStatus_0(int wsId, int taskId, ProjectStatusUpsert projectStatusUpsert) async
    test('test upsertStatus_0', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TasksChanges> upsertTask_0(int wsId, TaskUpsert taskUpsert, { String prevPosition, String nextPosition, int taskId }) async
    test('test upsertTask_0', () async {
      // TODO
    });

    // Upsert
    //
    //Future<TasksChanges> upsertTransaction_0(int wsId, int taskId, TaskTransactionUpsert taskTransactionUpsert) async
    test('test upsertTransaction_0', () async {
      // TODO
    });
  });
}
